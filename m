Return-Path: <stable+bounces-43730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E688C4457
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A321C2346F
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7690957CB7;
	Mon, 13 May 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jC5bXmxT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3748557CA4
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614504; cv=none; b=p/ZJ2n/QNbbQT+Ehho6Tb5yW8uHLogc9U+BgWnXRZxaR1HfEwTp/0Mf1tvFVU07VLd7jAlGDIxZXEvlIiF28PzN1SfQqSbmwv0EkgfRKzz16DKLqur3gBpX738gS0VTEEcEWCTFJvuq59Ft1N1scCH0bj+d308ngxO61o/p1WaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614504; c=relaxed/simple;
	bh=/bFMkXquJ77F6dAQZ1ww2FIWdSqiYpl1wE494ZbfLUM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GxwxfMxJWgEr9/at07umpEbFhRJXazsxPQy6/gTIuCIykJBAx00PHJ7xP1TL1A+NXaTel8n05ZnNLubspWigMavaRO1THSfhxVup1Fojb7Maffximcp1nH9dzjPHERbbk6ukWtOaPE7g8XX7r7YNdLx7vC2RwX5Mjc6ton5iYeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jC5bXmxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023C1C2BD11;
	Mon, 13 May 2024 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715614503;
	bh=/bFMkXquJ77F6dAQZ1ww2FIWdSqiYpl1wE494ZbfLUM=;
	h=Subject:To:Cc:From:Date:From;
	b=jC5bXmxTx28bxAWtTu3jfk063BgxUs9nigpSH2KBFZs5RaOdrI0IUhCUISObKQZDc
	 4kXcvgwq/T53aNWnkOrl4Pxf+/tgOULDTHN2KZBi0GpHrQAV5efPvD2AwpNpqQxWth
	 3wwk7H/LcHNIl3zfhcneKqUVLAXWZs3wykw9YHn4=
Subject: FAILED: patch "[PATCH] Bluetooth: qca: fix info leak when fetching fw build id" failed to apply to 5.15-stable tree
To: johan+linaro@kernel.org,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:35:00 +0200
Message-ID: <2024051300-commute-overall-7fed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cda0d6a198e2a7ec6f176c36173a57bdd8af7af2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051300-commute-overall-7fed@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

cda0d6a198e2 ("Bluetooth: qca: fix info leak when fetching fw build id")
a7f8dedb4be2 ("Bluetooth: qca: add support for QCA2066")
691d54d0f7cb ("Bluetooth: qca: use switch case for soc type behavior")
f904feefe60c ("Bluetooth: btqca: Add WCN3988 support")
8153b738bc54 ("Bluetooth: btqca: use le32_to_cpu for ver.soc_id")
095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
44fac8a2fd2f ("Bluetooth: hci_qca: mark OF related data as maybe unused")
6845667146a2 ("Bluetooth: hci_qca: Fix NULL vs IS_ERR_OR_NULL check in qca_serdev_probe")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cda0d6a198e2a7ec6f176c36173a57bdd8af7af2 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 1 May 2024 14:34:52 +0200
Subject: [PATCH] Bluetooth: qca: fix info leak when fetching fw build id

Add the missing sanity checks and move the 255-byte build-id buffer off
the stack to avoid leaking stack data through debugfs in case the
build-info reply is malformed.

Fixes: c0187b0bd3e9 ("Bluetooth: btqca: Add support to read FW build version for WCN3991 BTSoC")
Cc: stable@vger.kernel.org	# 5.12
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index c6b2dd4d1716..664db524b1dd 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -99,7 +99,8 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	struct edl_event_hdr *edl;
-	char cmd, build_label[QCA_FW_BUILD_VER_LEN];
+	char *build_label;
+	char cmd;
 	int build_lbl_len, err = 0;
 
 	bt_dev_dbg(hdev, "QCA read fw build info");
@@ -114,6 +115,11 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 		return err;
 	}
 
+	if (skb->len < sizeof(*edl)) {
+		err = -EILSEQ;
+		goto out;
+	}
+
 	edl = (struct edl_event_hdr *)(skb->data);
 	if (!edl) {
 		bt_dev_err(hdev, "QCA read fw build info with no header");
@@ -129,14 +135,25 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 		goto out;
 	}
 
-	build_lbl_len = edl->data[0];
-	if (build_lbl_len <= QCA_FW_BUILD_VER_LEN - 1) {
-		memcpy(build_label, edl->data + 1, build_lbl_len);
-		*(build_label + build_lbl_len) = '\0';
+	if (skb->len < sizeof(*edl) + 1) {
+		err = -EILSEQ;
+		goto out;
 	}
 
+	build_lbl_len = edl->data[0];
+
+	if (skb->len < sizeof(*edl) + 1 + build_lbl_len) {
+		err = -EILSEQ;
+		goto out;
+	}
+
+	build_label = kstrndup(&edl->data[1], build_lbl_len, GFP_KERNEL);
+	if (!build_label)
+		goto out;
+
 	hci_set_fw_info(hdev, "%s", build_label);
 
+	kfree(build_label);
 out:
 	kfree_skb(skb);
 	return err;
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 49ad668d0d0b..215433fd76a1 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -48,7 +48,6 @@
 #define get_soc_ver(soc_id, rom_ver)	\
 	((le32_to_cpu(soc_id) << 16) | (le16_to_cpu(rom_ver)))
 
-#define QCA_FW_BUILD_VER_LEN		255
 #define QCA_HSP_GF_SOC_ID			0x1200
 #define QCA_HSP_GF_SOC_MASK			0x0000ff00
 


