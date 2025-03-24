Return-Path: <stable+bounces-125902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DACA6DEA9
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE633A63C5
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B7026137B;
	Mon, 24 Mar 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FHEErRt6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367F25FA3C
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830055; cv=none; b=kHzlRk0ruevHkMuYfoz60/y6AIX9tC1hl8+CFAHaxquBMEbmWg27v2gDJ7ggM3BEz6TmkmlUYFub5iHHoBB+4E27Pr2ZZfO7jYIveTUrAlY82RGD8EB6I9/VkXPAZ8GabtMJkSRukuUDsg4iAuRuXXaA12HN6R4OLSWUQuQk6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830055; c=relaxed/simple;
	bh=1a79mYVMnBFGop0vanfndvBm3vjaLD4NVCDDbWQfD7Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mQdJTamabrcnniqc8MSXcRnDAfTZdEg+3NbSVhNeLZ4+lWMgQs84bYOoef2d588s+GTrKcU0yUWFlSCOOS4R1fk7qwvy2eOPh3bEbdDYny31iNgvJlOPAj7Yn87iAqkyG+9I97DoBjGH9MT0fPz5wn09vyBOjxMhhVvQfgrl+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FHEErRt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0D8C4CEEA;
	Mon, 24 Mar 2025 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830054;
	bh=1a79mYVMnBFGop0vanfndvBm3vjaLD4NVCDDbWQfD7Y=;
	h=Subject:To:Cc:From:Date:From;
	b=FHEErRt6bFsNJT+t8z9xOLRaPpxkVO4MXx31d7fufSRlajUiy7y8HJkZt497g0JrQ
	 tDzMWIZJ2bIJECi3iNF43kaYh0/yAki5RGGN4WVXT4pqOrRhGGMkRv2W1hoG+TWOJg
	 P2T5JstuHLZEnndRSxEFTtdX7LgQ3i4wvPv+DQ70=
Subject: FAILED: patch "[PATCH] net: mana: Support holes in device list reply msg" failed to apply to 6.6-stable tree
To: haiyangz@microsoft.com,longli@microsoft.com,michal.swiatkowski@linux.intel.com,pabeni@redhat.com,shradhagupta@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:26:12 -0700
Message-ID: <2025032412-consonant-junkman-ebff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2fc8a346625eb1abfe202062c7e6a13d76cde5ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032412-consonant-junkman-ebff@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2fc8a346625eb1abfe202062c7e6a13d76cde5ea Mon Sep 17 00:00:00 2001
From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Tue, 11 Mar 2025 13:12:54 -0700
Subject: [PATCH] net: mana: Support holes in device list reply msg

According to GDMA protocol, holes (zeros) are allowed at the beginning
or middle of the gdma_list_devices_resp message. The existing code
cannot properly handle this, and may miss some devices in the list.

To fix, scan the entire list until the num_of_devs are found, or until
the end of the list.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@microsoft.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Link: https://patch.msgid.link/1741723974-1534-1-git-send-email-haiyangz@microsoft.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 11457b6296cc..638ef64d639f 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -134,9 +134,10 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
 	struct gdma_list_devices_resp resp = {};
 	struct gdma_general_req req = {};
 	struct gdma_dev_id dev;
-	u32 i, max_num_devs;
+	int found_dev = 0;
 	u16 dev_type;
 	int err;
+	u32 i;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_LIST_DEVICES, sizeof(req),
 			     sizeof(resp));
@@ -148,12 +149,17 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
 		return err ? err : -EPROTO;
 	}
 
-	max_num_devs = min_t(u32, MAX_NUM_GDMA_DEVICES, resp.num_of_devs);
-
-	for (i = 0; i < max_num_devs; i++) {
+	for (i = 0; i < GDMA_DEV_LIST_SIZE &&
+	     found_dev < resp.num_of_devs; i++) {
 		dev = resp.devs[i];
 		dev_type = dev.type;
 
+		/* Skip empty devices */
+		if (dev.as_uint32 == 0)
+			continue;
+
+		found_dev++;
+
 		/* HWC is already detected in mana_hwc_create_channel(). */
 		if (dev_type == GDMA_DEVICE_HWC)
 			continue;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 90f56656b572..62e9d7673862 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -408,8 +408,6 @@ struct gdma_context {
 	struct gdma_dev		mana_ib;
 };
 
-#define MAX_NUM_GDMA_DEVICES	4
-
 static inline bool mana_gd_is_mana(struct gdma_dev *gd)
 {
 	return gd->dev_id.type == GDMA_DEVICE_MANA;
@@ -556,11 +554,15 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
 #define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
 
+/* Driver can handle holes (zeros) in the device list */
+#define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
-	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT)
+	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
+	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
@@ -621,11 +623,12 @@ struct gdma_query_max_resources_resp {
 }; /* HW DATA */
 
 /* GDMA_LIST_DEVICES */
+#define GDMA_DEV_LIST_SIZE 64
 struct gdma_list_devices_resp {
 	struct gdma_resp_hdr hdr;
 	u32 num_of_devs;
 	u32 reserved;
-	struct gdma_dev_id devs[64];
+	struct gdma_dev_id devs[GDMA_DEV_LIST_SIZE];
 }; /* HW DATA */
 
 /* GDMA_REGISTER_DEVICE */


