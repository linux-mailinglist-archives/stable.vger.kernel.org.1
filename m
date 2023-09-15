Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B127A20FE
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 16:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjIOOah (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 10:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjIOOaa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 10:30:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B42271D;
        Fri, 15 Sep 2023 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694788205; x=1726324205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Twaa+I9J7E+qi1waH9WvJrsoz3TE/A+bOsXnZ0lAD0=;
  b=BfiKHJ5OzN2A6nExLqaJpb2W2YkDw5MaHf7aZMKuqv36Zj2sBirId1v3
   C+I4jXA+hoXQmMDzhey83fYx8OcsEznA6v/69FKq/cjGO4W8CevdODAZl
   /7JtRS/a5o1zWR6r1Al6FmtRWdk4tmeO4u52bthYeKmLNyQKimsZSz09Z
   8QMj87PwbKbbpaw5kqUoucnRCGfBW6wT5fL9o+cwLHYM66Q+iKMe3u5Nj
   mT0kaGJjtPs7W2F/E64oUPdfNRqeSAll1jRThe1jK+PpG/nx2jwcRNwxO
   iDQcQRw66tIgu88ZR9HzN4BpBbNj9sOh2GcDw+xW98bms8zJhabSi0srQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="378171624"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="378171624"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="888252663"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="888252663"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2023 07:29:21 -0700
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
To:     <gregkh@linuxfoundation.org>
Cc:     <linux-usb@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4/4] xhci: Preserve RsvdP bits in ERSTBA register correctly
Date:   Fri, 15 Sep 2023 17:31:08 +0300
Message-Id: <20230915143108.1532163-5-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915143108.1532163-1-mathias.nyman@linux.intel.com>
References: <20230915143108.1532163-1-mathias.nyman@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

xhci_add_interrupter() erroneously preserves only the lowest 4 bits when
writing the ERSTBA register, not the lowest 6 bits.  Fix it.

Migrate the ERST_BASE_RSVDP macro to the modern GENMASK_ULL() syntax to
avoid a u64 cast.

This was previously fixed by commit 8c1cbec9db1a ("xhci: fix event ring
segment table related masks and variables in header"), but immediately
undone by commit b17a57f89f69 ("xhci: Refactor interrupter code for
initial multi interrupter support.").

Fixes: b17a57f89f69 ("xhci: Refactor interrupter code for initial multi interrupter support.")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.3+
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 4 ++--
 drivers/usb/host/xhci.h     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 8714ab5bf04d..0a37f0d511cf 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2285,8 +2285,8 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
 	writel(erst_size, &ir->ir_set->erst_size);
 
 	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
-	erst_base &= ERST_PTR_MASK;
-	erst_base |= (ir->erst.erst_dma_addr & (u64) ~ERST_PTR_MASK);
+	erst_base &= ERST_BASE_RSVDP;
+	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
 	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
 
 	/* Set the event ring dequeue address of this interrupter */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7e282b4522c0..5df370482521 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -514,7 +514,7 @@ struct xhci_intr_reg {
 #define	ERST_SIZE_MASK		(0xffff << 16)
 
 /* erst_base bitmasks */
-#define ERST_BASE_RSVDP		(0x3f)
+#define ERST_BASE_RSVDP		(GENMASK_ULL(5, 0))
 
 /* erst_dequeue bitmasks */
 /* Dequeue ERST Segment Index (DESI) - Segment number (or alias)
-- 
2.25.1

