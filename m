Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7527ECD70
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjKOTgg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjKOTgc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF06DD48
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54378C433C7;
        Wed, 15 Nov 2023 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076988;
        bh=7OsUxh6DjLXytMpuZ88EXUE2Dbd/so9o2J6vKHFY8Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVCsAkW9XmHQSN/AIvnSzCAwIp8y+JwNkSdE0BzkWMuOHFL+9t6W3oo9VwT5k/Ob+
         XOsJGtT/jvAT6jZnA9FRXRoS/vhgsZrWE/NEtd7w8iyYq8XqRSH5Qhou2gHtb6zbtQ
         6iblG0I1+RBr144ARf7a3XfmdajIFSoxXyeBpt1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 467/550] cxl/hdm: Remove broken error path
Date:   Wed, 15 Nov 2023 14:17:31 -0500
Message-ID: <20231115191633.243358540@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 5d09c63f11f083707b60c8ea0bb420651c47740f ]

Dan reports that cxl_decoder_commit() potentially leaks a hold of
cxl_dpa_rwsem. The potential error case is a "should not" happen
scenario, turn it into a "can not" happen scenario by adding the error
check to cxl_port_setup_targets() where other setting validation occurs.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: http://lore.kernel.org/r/63295673-5d63-4919-b851-3b06d48734c0@moroto.mountain
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/hdm.c    | 19 ++-----------------
 drivers/cxl/core/region.c |  8 ++++++++
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3ad0d39d3d3fa..64e86b786db52 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -575,17 +575,11 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
-static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
+static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 {
 	struct cxl_dport **t = &cxlsd->target[0];
 	int ways = cxlsd->cxld.interleave_ways;
 
-	if (dev_WARN_ONCE(&cxlsd->cxld.dev,
-			  ways > 8 || ways > cxlsd->nr_targets,
-			  "ways: %d overflows targets: %d\n", ways,
-			  cxlsd->nr_targets))
-		return -ENXIO;
-
 	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
 	if (ways > 1)
 		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
@@ -601,8 +595,6 @@ static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
 	if (ways > 7)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
-
-	return 0;
 }
 
 /*
@@ -689,13 +681,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
 		u64 targets;
 
-		rc = cxlsd_set_targets(cxlsd, &targets);
-		if (rc) {
-			dev_dbg(&port->dev, "%s: target configuration error\n",
-				dev_name(&cxld->dev));
-			goto err;
-		}
-
+		cxlsd_set_targets(cxlsd, &targets);
 		writel(upper_32_bits(targets), tl_hi);
 		writel(lower_32_bits(targets), tl_lo);
 	} else {
@@ -713,7 +699,6 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 
 	port->commit_end++;
 	rc = cxld_await_commit(hdm, cxld->id);
-err:
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7392206eb8699..a25f5deb3de51 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1190,6 +1190,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
+	if (iw > 8 || iw > cxlsd->nr_targets) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s:%s: ways: %d overflows targets: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
+		return -ENXIO;
+	}
+
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
 		    cxld->interleave_granularity != ig ||
-- 
2.42.0



