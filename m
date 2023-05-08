Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED716FAA17
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjEHK66 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbjEHK6k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:58:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F2033FE2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C950B62988
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9121C433D2;
        Mon,  8 May 2023 10:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543449;
        bh=AD2xRkIY4Y2dpgkWAI0VXPb2dDUsrX4roensaFv6x9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cChyRnhrD0cYBBDSNS0BmNR1lzrmG+ZQYTL8AjmYsFLNPfbGm4NAiPhJKofvJhkyN
         5h7Qt1o2RNeyC3+OSvF4SP4G1aPY+N4RbzsR+t2QnrUivlsBanmEFBpAL/cJzly7rf
         dYwPvL0eNXvGMlLcRTWq5lHWdctlC5hIJVv1Ub9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 6.3 094/694] cxl/hdm: Use 4-byte reads to retrieve HDM decoder base+limit
Date:   Mon,  8 May 2023 11:38:49 +0200
Message-Id: <20230508094435.571336171@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

commit 1423885c84a5b3a53b79bcf241b18124d0d7cba6 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/core/hdm.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
-#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
@@ -785,8 +784,8 @@ static int init_hdm_decoder(struct cxl_p
 			    int *target_map, void __iomem *hdm, int which,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
+	u64 size, base, skip, dpa_size, lo, hi;
 	struct cxl_endpoint_decoder *cxled;
-	u64 size, base, skip, dpa_size;
 	bool committed;
 	u32 remainder;
 	int i, rc;
@@ -801,8 +800,12 @@ static int init_hdm_decoder(struct cxl_p
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
@@ -865,8 +868,9 @@ static int init_hdm_decoder(struct cxl_p
 		return rc;
 
 	if (!info) {
-		target_list.value =
-			ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
+		target_list.value = (hi << 32) + lo;
 		for (i = 0; i < cxld->interleave_ways; i++)
 			target_map[i] = target_list.target_id[i];
 
@@ -883,7 +887,9 @@ static int init_hdm_decoder(struct cxl_p
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


