Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B17ECD3D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjKOTfQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjKOTfQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E699E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CF3C433CB;
        Wed, 15 Nov 2023 19:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076912;
        bh=uFJ6GuqmcdjuTVWVgdRNaACkxgvVqALSkVH5uWCkPYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrM3zpm1nQN0mB41m/vBkA034SIVhtuzSR1l7KNsWVGla4tqrpM/QfjDEDbvZOlKn
         HPOgv5qtiiyr/+V9B6M2e9Zte9NcFy9sg0kAfcUSePjLr5h/gomKsB2RX9+vFo37S3
         KFYjvX/rxfe3zdBx/mu86R75Iz6GAhaJ2kFBTpso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jim Harris <jim.harris@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 461/550] cxl/region: Prepare the decoder match range helper for reuse
Date:   Wed, 15 Nov 2023 14:17:25 -0500
Message-ID: <20231115191632.828983598@linuxfoundation.org>
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

[ Upstream commit 1110581412c7a223439bb3ecdcdd9f4432e08231 ]

match_decoder_by_range() and decoder_match_range() both determine
if an HPA range matches a decoder. The first does it for root
decoders and the second one operates on switch decoders.

Tidy these up with clear naming and make the switch helper more
like the root decoder helper in style and functionality. Make it
take the actual range, rather than an endpoint decoder from which
it extracts the range. Require an exact match on switch decoders,
because unlike a root decoder that maps an entire region, Linux
only supports 1:1 mapping of switch to endpoint decoders. Note that
root-decoders are a super-set of switch-decoders and the range they
cover is a super-set of a region, hence the use of range_contains() for
that case.

Aside from aesthetics and maintainability, this is in preparation
for reuse.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jim Harris <jim.harris@samsung.com>
Link: https://lore.kernel.org/r/011b1f498e1758bb8df17c5951be00bd8d489e3b.1698263080.git.alison.schofield@intel.com
[djbw: fixup root decoder vs switch decoder range checks]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Stable-dep-of: 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for auto-discovery")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8394cd96e1869..123474d6c475a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1482,16 +1482,20 @@ static struct cxl_port *next_port(struct cxl_port *port)
 	return port->parent_dport->port;
 }
 
-static int decoder_match_range(struct device *dev, void *data)
+static int match_switch_decoder_by_range(struct device *dev, void *data)
 {
-	struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_switch_decoder *cxlsd;
+	struct range *r1, *r2 = data;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 
 	cxlsd = to_cxl_switch_decoder(dev);
-	return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
+	r1 = &cxlsd->cxld.hpa_range;
+
+	if (is_root_decoder(dev))
+		return range_contains(r1, r2);
+	return (r1->start == r2->start && r1->end == r2->end);
 }
 
 static void find_positions(const struct cxl_switch_decoder *cxlsd,
@@ -1560,7 +1564,8 @@ static int cmp_decode_pos(const void *a, const void *b)
 		goto err;
 	}
 
-	dev = device_find_child(&port->dev, cxled_a, decoder_match_range);
+	dev = device_find_child(&port->dev, &cxled_a->cxld.hpa_range,
+				match_switch_decoder_by_range);
 	if (!dev) {
 		struct range *range = &cxled_a->cxld.hpa_range;
 
@@ -2691,7 +2696,7 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_decoder_by_range(struct device *dev, void *data)
+static int match_root_decoder_by_range(struct device *dev, void *data)
 {
 	struct range *r1, *r2 = data;
 	struct cxl_root_decoder *cxlrd;
@@ -2822,7 +2827,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	int rc;
 
 	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
-				      match_decoder_by_range);
+				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
-- 
2.42.0



