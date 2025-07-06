Return-Path: <stable+bounces-160301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E8CAFA4F0
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 13:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD3017E55D
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861142080C4;
	Sun,  6 Jul 2025 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LZPkrnq0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A551E8345
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802637; cv=none; b=OjUCe7JH95Hy1Vi4X+St6YT5gpDA17A6g+Ovh+bLffhuLjQTFyJVyVteELqs4ynYCKq5Kf1kgakfmMQVBaxVQl7xtzurqC1o6kC/SNyVh8a1HbGlGQgaIZFRK4YrCDhdlxuPpH1EpraXSsOw5s+gN/x+t349fq8sB7fsM7HiB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802637; c=relaxed/simple;
	bh=77+zRnLl57CWzwf49V1UREeI5ZOf6Ejc8RsfpskhtQA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LpNycLNOG7g0ZMOqhPD6KWmbXJw1Yv15XbjRq4JEFaLW1JqTgcfyZokXHHSOnqsFHJp+nNINB0zehpx+uwIxwmJ1bvl2WiNmI4D4wEY/ZBh/ytm5sjz+Xm4VKDyqLeSKYfLVavtNXNPKQlPJ6ATgUppVpxGHCUo9Tt6HViqYtRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LZPkrnq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81419C4CEED;
	Sun,  6 Jul 2025 11:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802636;
	bh=77+zRnLl57CWzwf49V1UREeI5ZOf6Ejc8RsfpskhtQA=;
	h=Subject:To:Cc:From:Date:From;
	b=LZPkrnq0pXkDE5xmmDLt0m2v/8hNwmlZXH9VGcrFofSIv1AKhK+aDf9DWxYmzpZzC
	 R1UufYAYNdZDgHx6BkAJVc7ZCCTxtoMkqmq6Le9AVUJHIbcrUu+BuK2v53a0Zgo49a
	 6fCurYVeZMeRVW8yAx7Km/+zTrGpsGkr0LcGaoLM=
Subject: FAILED: patch "[PATCH] Bluetooth: HCI: Set extended advertising data synchronously" failed to apply to 5.15-stable tree
To: ceggers@arri.de,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:50:26 +0200
Message-ID: <2025070626-yo-yo-osmosis-27dd@gregkh>
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
git cherry-pick -x 89fb8acc38852116d38d721ad394aad7f2871670
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070626-yo-yo-osmosis-27dd@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89fb8acc38852116d38d721ad394aad7f2871670 Mon Sep 17 00:00:00 2001
From: Christian Eggers <ceggers@arri.de>
Date: Fri, 27 Jun 2025 09:05:08 +0200
Subject: [PATCH] Bluetooth: HCI: Set extended advertising data synchronously

Currently, for controllers with extended advertising, the advertising
data is set in the asynchronous response handler for extended
adverstising params. As most advertising settings are performed in a
synchronous context, the (asynchronous) setting of the advertising data
is done too late (after enabling the advertising).

Move setting of adverstising data from asynchronous response handler
into synchronous context to fix ordering of HCI commands.

Signed-off-by: Christian Eggers <ceggers@arri.de>
Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if controller supports")
Cc: stable@vger.kernel.org
v2: https://lore.kernel.org/linux-bluetooth/20250626115209.17839-1-ceggers@arri.de/
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 66052d6aaa1d..4d5ace9d245d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2150,40 +2150,6 @@ static u8 hci_cc_set_adv_param(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
-static u8 hci_cc_set_ext_adv_param(struct hci_dev *hdev, void *data,
-				   struct sk_buff *skb)
-{
-	struct hci_rp_le_set_ext_adv_params *rp = data;
-	struct hci_cp_le_set_ext_adv_params *cp;
-	struct adv_info *adv_instance;
-
-	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
-
-	if (rp->status)
-		return rp->status;
-
-	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS);
-	if (!cp)
-		return rp->status;
-
-	hci_dev_lock(hdev);
-	hdev->adv_addr_type = cp->own_addr_type;
-	if (!cp->handle) {
-		/* Store in hdev for instance 0 */
-		hdev->adv_tx_power = rp->tx_power;
-	} else {
-		adv_instance = hci_find_adv_instance(hdev, cp->handle);
-		if (adv_instance)
-			adv_instance->tx_power = rp->tx_power;
-	}
-	/* Update adv data as tx power is known now */
-	hci_update_adv_data(hdev, cp->handle);
-
-	hci_dev_unlock(hdev);
-
-	return rp->status;
-}
-
 static u8 hci_cc_read_rssi(struct hci_dev *hdev, void *data,
 			   struct sk_buff *skb)
 {
@@ -4164,8 +4130,6 @@ static const struct hci_cc {
 	HCI_CC(HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
 	       hci_cc_le_read_num_adv_sets,
 	       sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
-	HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
-	       sizeof(struct hci_rp_le_set_ext_adv_params)),
 	HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
 		      hci_cc_le_set_ext_adv_enable),
 	HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 106862d47964..77b3691f3423 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1205,9 +1205,126 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+static int
+hci_set_ext_adv_params_sync(struct hci_dev *hdev, struct adv_info *adv,
+			    const struct hci_cp_le_set_ext_adv_params *cp,
+			    struct hci_rp_le_set_ext_adv_params *rp)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(*cp),
+			     cp, HCI_CMD_TIMEOUT);
+
+	/* If command return a status event, skb will be set to -ENODATA */
+	if (skb == ERR_PTR(-ENODATA))
+		return 0;
+
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld",
+			   HCI_OP_LE_SET_EXT_ADV_PARAMS, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*rp)) {
+		bt_dev_err(hdev, "Invalid response length for 0x%4.4x: %u",
+			   HCI_OP_LE_SET_EXT_ADV_PARAMS, skb->len);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	memcpy(rp, skb->data, sizeof(*rp));
+	kfree_skb(skb);
+
+	if (!rp->status) {
+		hdev->adv_addr_type = cp->own_addr_type;
+		if (!cp->handle) {
+			/* Store in hdev for instance 0 */
+			hdev->adv_tx_power = rp->tx_power;
+		} else if (adv) {
+			adv->tx_power = rp->tx_power;
+		}
+	}
+
+	return rp->status;
+}
+
+static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
+		    HCI_MAX_EXT_AD_LENGTH);
+	u8 len;
+	struct adv_info *adv = NULL;
+	int err;
+
+	if (instance) {
+		adv = hci_find_adv_instance(hdev, instance);
+		if (!adv || !adv->adv_data_changed)
+			return 0;
+	}
+
+	len = eir_create_adv_data(hdev, instance, pdu->data,
+				  HCI_MAX_EXT_AD_LENGTH);
+
+	pdu->length = len;
+	pdu->handle = adv ? adv->handle : instance;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
+				    struct_size(pdu, data, len), pdu,
+				    HCI_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	/* Update data if the command succeed */
+	if (adv) {
+		adv->adv_data_changed = false;
+	} else {
+		memcpy(hdev->adv_data, pdu->data, len);
+		hdev->adv_data_len = len;
+	}
+
+	return 0;
+}
+
+static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	struct hci_cp_le_set_adv_data cp;
+	u8 len;
+
+	memset(&cp, 0, sizeof(cp));
+
+	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
+
+	/* There's nothing to do if the data hasn't changed */
+	if (hdev->adv_data_len == len &&
+	    memcmp(cp.data, hdev->adv_data, len) == 0)
+		return 0;
+
+	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
+	hdev->adv_data_len = len;
+
+	cp.length = len;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return 0;
+
+	if (ext_adv_capable(hdev))
+		return hci_set_ext_adv_data_sync(hdev, instance);
+
+	return hci_set_adv_data_sync(hdev, instance);
+}
+
 int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
+	struct hci_rp_le_set_ext_adv_params rp;
 	bool connectable;
 	u32 flags;
 	bdaddr_t random_addr;
@@ -1316,8 +1433,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 		cp.secondary_phy = HCI_ADV_PHY_1M;
 	}
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
-				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = hci_set_ext_adv_params_sync(hdev, adv, &cp, &rp);
+	if (err)
+		return err;
+
+	/* Update adv data as tx power is known now */
+	err = hci_set_ext_adv_data_sync(hdev, cp.handle);
 	if (err)
 		return err;
 
@@ -1822,79 +1943,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
-{
-	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
-		    HCI_MAX_EXT_AD_LENGTH);
-	u8 len;
-	struct adv_info *adv = NULL;
-	int err;
-
-	if (instance) {
-		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv || !adv->adv_data_changed)
-			return 0;
-	}
-
-	len = eir_create_adv_data(hdev, instance, pdu->data,
-				  HCI_MAX_EXT_AD_LENGTH);
-
-	pdu->length = len;
-	pdu->handle = adv ? adv->handle : instance;
-	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
-	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
-
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
-				    struct_size(pdu, data, len), pdu,
-				    HCI_CMD_TIMEOUT);
-	if (err)
-		return err;
-
-	/* Update data if the command succeed */
-	if (adv) {
-		adv->adv_data_changed = false;
-	} else {
-		memcpy(hdev->adv_data, pdu->data, len);
-		hdev->adv_data_len = len;
-	}
-
-	return 0;
-}
-
-static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
-{
-	struct hci_cp_le_set_adv_data cp;
-	u8 len;
-
-	memset(&cp, 0, sizeof(cp));
-
-	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
-
-	/* There's nothing to do if the data hasn't changed */
-	if (hdev->adv_data_len == len &&
-	    memcmp(cp.data, hdev->adv_data, len) == 0)
-		return 0;
-
-	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
-	hdev->adv_data_len = len;
-
-	cp.length = len;
-
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
-}
-
-int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
-{
-	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-		return 0;
-
-	if (ext_adv_capable(hdev))
-		return hci_set_ext_adv_data_sync(hdev, instance);
-
-	return hci_set_adv_data_sync(hdev, instance);
-}
-
 int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 				   bool force)
 {
@@ -6273,6 +6321,7 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 						struct hci_conn *conn)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
+	struct hci_rp_le_set_ext_adv_params rp;
 	int err;
 	bdaddr_t random_addr;
 	u8 own_addr_type;
@@ -6314,8 +6363,12 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 	if (err)
 		return err;
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
-				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = hci_set_ext_adv_params_sync(hdev, NULL, &cp, &rp);
+	if (err)
+		return err;
+
+	/* Update adv data as tx power is known now */
+	err = hci_set_ext_adv_data_sync(hdev, cp.handle);
 	if (err)
 		return err;
 


