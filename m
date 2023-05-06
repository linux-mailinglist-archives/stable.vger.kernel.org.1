Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982196F8FA7
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 09:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEFHKx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 03:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFHKw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 03:10:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5773E2D53
        for <stable@vger.kernel.org>; Sat,  6 May 2023 00:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8445616DD
        for <stable@vger.kernel.org>; Sat,  6 May 2023 07:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A20BC433D2;
        Sat,  6 May 2023 07:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683357050;
        bh=2HitnxnP/x6n3b92mVpXzEPpEmxQ/eU71kA1pnG3kxY=;
        h=Subject:To:Cc:From:Date:From;
        b=PfcaNBtcSxOduLdPvJAmIFRH2ydtoiXlAsuoK57LoUpeybemyL6LmSg9KgBfQt3kW
         z+i4rTLiUR+DIiJHn534SSZpDrfOET7KJgR4xCwXILTTjJzj9vxDwb2yHpgqQK40Ux
         TfgsMi3mjgnmrWVgK+Qbxm1/5YjFehS10E5UllgA=
Subject: FAILED: patch "[PATCH] cxl/hdm: Use 4-byte reads to retrieve HDM decoder base+limit" failed to apply to 6.1-stable tree
To:     dan.j.williams@intel.com, alison.schofield@intel.com,
        dave.jiang@intel.com, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 15:56:51 +0900
Message-ID: <2023050651-anywhere-showbiz-c066@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1423885c84a5b3a53b79bcf241b18124d0d7cba6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050651-anywhere-showbiz-c066@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

1423885c84a5 ("cxl/hdm: Use 4-byte reads to retrieve HDM decoder base+limit")
b70c2cf95ee1 ("cxl/hdm: Skip emulation when driver manages mem_enable")
a5fcd228ca1d ("Merge branch 'for-6.3/cxl-rr-emu' into cxl/next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1423885c84a5b3a53b79bcf241b18124d0d7cba6 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 14 Apr 2023 11:54:00 -0700
Subject: [PATCH] cxl/hdm: Use 4-byte reads to retrieve HDM decoder base+limit

The CXL specification mandates that 4-byte registers must be accessed
with 4-byte access cycles. CXL 3.0 8.2.3 "Component Register Layout and
Definition" states that the behavior is undefined if (2) 32-bit
registers are accessed as an 8-byte quantity. It turns out that at least
one hardware implementation is sensitive to this in practice. The @size
variable results in zero with:

    size = readq(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));

...and the correct size with:

    lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
    hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
    size = (hi << 32) + lo;

Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
Cc: <stable@vger.kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Link: https://lore.kernel.org/r/168149844056.792294.8224490474529733736.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 35b338b716fe..6fdf7981ddc7 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
-#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
@@ -785,8 +784,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
+	u64 size, base, skip, dpa_size, lo, hi;
 	struct cxl_endpoint_decoder *cxled;
-	u64 size, base, skip, dpa_size;
 	bool committed;
 	u32 remainder;
 	int i, rc;
@@ -801,8 +800,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 							which, info);
 
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
-	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
-	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
+	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
+	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(which));
+	base = (hi << 32) + lo;
+	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
+	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
+	size = (hi << 32) + lo;
 	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
 	cxld->commit = cxl_decoder_commit;
 	cxld->reset = cxl_decoder_reset;
@@ -865,8 +868,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		return rc;
 
 	if (!info) {
-		target_list.value =
-			ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
+		target_list.value = (hi << 32) + lo;
 		for (i = 0; i < cxld->interleave_ways; i++)
 			target_map[i] = target_list.target_id[i];
 
@@ -883,7 +887,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			port->id, cxld->id, size, cxld->interleave_ways);
 		return -ENXIO;
 	}
-	skip = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
+	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
+	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
+	skip = (hi << 32) + lo;
 	cxled = to_cxl_endpoint_decoder(&cxld->dev);
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
 	if (rc) {

