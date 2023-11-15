Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C5D7ECD3F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjKOTfT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjKOTfT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9E130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB85AC433CB;
        Wed, 15 Nov 2023 19:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076915;
        bh=hIgM5YpSxYnYCGRDlrI2I99J7bRoqIjhYHyyE4Bos+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FpG+IiFRFeGYqoJcSQqpiPaWPm5IuQf197eeNoE8MQYWFPC+0AN0klvbqAMYb8kow
         3q1uO1PudrCzJhPVeYzV9Q2LfBnNf9rrPqj2aSJsT1CqZ61A4B3HkzzmQjMTcjEx+r
         5UJgZQABpShhXvO945rq42YmuznZXi/DEKLBHAOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 462/550] cxl/region: Calculate a target position in a region interleave
Date:   Wed, 15 Nov 2023 14:17:26 -0500
Message-ID: <20231115191632.894664523@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alison Schofield <alison.schofield@intel.com>

[ Upstream commit a3e00c964fb943934af916f48f0dd43b5110c866 ]

Introduce a calculation to find a target's position in a region
interleave. Perform a self-test of the calculation on user-defined
regions.

The region driver uses the kernel sort() function to put region
targets in relative order. Positions are assigned based on each
target's index in that sorted list. That relative sort doesn't
consider the offset of a port into its parent port which causes
some auto-discovered regions to fail creation. In one failure case,
a 2 + 2 config (2 host bridges each with 2 endpoints), the sort
puts all the targets of one port ahead of another port when they
were expected to be interleaved.

In preparation for repairing the autodiscovery region assembly,
introduce a new method for discovering a target position in the
region interleave.

cxl_calc_interleave_pos() adds a method to find the target position by
ascending from an endpoint to a root decoder. The calculation starts
with the endpoint's local position and position in the parent port. It
traverses towards the root decoder and examines both position and ways
in order to allow the position to be refined all the way to the root
decoder.

This calculation: position = position * parent_ways + parent_pos;
applied iteratively yields the correct position.

Include a self-test that exercises this new position calculation against
every successfully configured user-defined region.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Link: https://lore.kernel.org/r/0ac32c75cf81dd8b86bf07d70ff139d33c2300bc.1698263080.git.alison.schofield@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Stable-dep-of: 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for auto-discovery")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 127 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 123474d6c475a..01210e45a21ff 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1498,6 +1498,113 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
 	return (r1->start == r2->start && r1->end == r2->end);
 }
 
+static int find_pos_and_ways(struct cxl_port *port, struct range *range,
+			     int *pos, int *ways)
+{
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_port *parent;
+	struct device *dev;
+	int rc = -ENXIO;
+
+	parent = next_port(port);
+	if (!parent)
+		return rc;
+
+	dev = device_find_child(&parent->dev, range,
+				match_switch_decoder_by_range);
+	if (!dev) {
+		dev_err(port->uport_dev,
+			"failed to find decoder mapping %#llx-%#llx\n",
+			range->start, range->end);
+		return rc;
+	}
+	cxlsd = to_cxl_switch_decoder(dev);
+	*ways = cxlsd->cxld.interleave_ways;
+
+	for (int i = 0; i < *ways; i++) {
+		if (cxlsd->target[i] == port->parent_dport) {
+			*pos = i;
+			rc = 0;
+			break;
+		}
+	}
+	put_device(dev);
+
+	return rc;
+}
+
+/**
+ * cxl_calc_interleave_pos() - calculate an endpoint position in a region
+ * @cxled: endpoint decoder member of given region
+ *
+ * The endpoint position is calculated by traversing the topology from
+ * the endpoint to the root decoder and iteratively applying this
+ * calculation:
+ *
+ *    position = position * parent_ways + parent_pos;
+ *
+ * ...where @position is inferred from switch and root decoder target lists.
+ *
+ * Return: position >= 0 on success
+ *	   -ENXIO on failure
+ */
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *iter, *port = cxled_to_port(cxled);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *range = &cxled->cxld.hpa_range;
+	int parent_ways = 0, parent_pos = 0, pos = 0;
+	int rc;
+
+	/*
+	 * Example: the expected interleave order of the 4-way region shown
+	 * below is: mem0, mem2, mem1, mem3
+	 *
+	 *		  root_port
+	 *                 /      \
+	 *      host_bridge_0    host_bridge_1
+	 *        |    |           |    |
+	 *       mem0 mem1        mem2 mem3
+	 *
+	 * In the example the calculator will iterate twice. The first iteration
+	 * uses the mem position in the host-bridge and the ways of the host-
+	 * bridge to generate the first, or local, position. The second
+	 * iteration uses the host-bridge position in the root_port and the ways
+	 * of the root_port to refine the position.
+	 *
+	 * A trace of the calculation per endpoint looks like this:
+	 * mem0: pos = 0 * 2 + 0    mem2: pos = 0 * 2 + 0
+	 *       pos = 0 * 2 + 0          pos = 0 * 2 + 1
+	 *       pos: 0                   pos: 1
+	 *
+	 * mem1: pos = 0 * 2 + 1    mem3: pos = 0 * 2 + 1
+	 *       pos = 1 * 2 + 0          pos = 1 * 2 + 1
+	 *       pos: 2                   pos = 3
+	 *
+	 * Note that while this example is simple, the method applies to more
+	 * complex topologies, including those with switches.
+	 */
+
+	/* Iterate from endpoint to root_port refining the position */
+	for (iter = port; iter; iter = next_port(iter)) {
+		if (is_cxl_root(iter))
+			break;
+
+		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		if (rc)
+			return rc;
+
+		pos = pos * parent_ways + parent_pos;
+	}
+
+	dev_dbg(&cxlmd->dev,
+		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
+		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
+		dev_name(&port->dev), range->start, range->end, pos);
+
+	return pos;
+}
+
 static void find_positions(const struct cxl_switch_decoder *cxlsd,
 			   const struct cxl_port *iter_a,
 			   const struct cxl_port *iter_b, int *a_pos,
@@ -1761,6 +1868,26 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		.end = p->res->end,
 	};
 
+	if (p->nr_targets != p->interleave_ways)
+		return 0;
+
+	/*
+	 * Test the auto-discovery position calculator function
+	 * against this successfully created user-defined region.
+	 * A fail message here means that this interleave config
+	 * will fail when presented as CXL_REGION_F_AUTO.
+	 */
+	for (int i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		int test_pos;
+
+		test_pos = cxl_calc_interleave_pos(cxled);
+		dev_dbg(&cxled->cxld.dev,
+			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
+			(test_pos == cxled->pos) ? "success" : "fail",
+			test_pos, cxled->pos);
+	}
+
 	return 0;
 
 err_decrement:
-- 
2.42.0



