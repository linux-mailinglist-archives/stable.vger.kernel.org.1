Return-Path: <stable+bounces-63628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD49419E1
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49671F2776C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145ED189514;
	Tue, 30 Jul 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Elcq4Tml"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC1184535;
	Tue, 30 Jul 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357440; cv=none; b=CSbPGtIDKM8HjGZKx6YU1iyL9RIDz0Xey6tgWCYDZdhuMvUJi5ohePBNc8pPgfll5lYfNmW/z/4g9YrNjYHGDLUuHO7NZqOAXv/h3wFWPk6g3GLYEmzpnInwG7nAONDjtUfqPiKrVQYohpXpiyFu0Ir1BZvP8vNINld+HYeYlXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357440; c=relaxed/simple;
	bh=RbPf29au8m2VZIUu6dE4sehpTOELpLudf31zHxsUg3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7rMgHXcRsU1nbFic3MigfkxQ0lkBz8qNpY/djCdDla+96AcEdP5ixgEEoZWgorTAxlcrK9QdqVmlnwdHZYumUvxF4ynPRa/XiA8QLuli1UumwCKOmTCzFx6Wiu/TL4Bebz3AK+xLeOfV7j94RODDJdVi1BWmAW8tdrfEV/hgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Elcq4Tml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412C6C4AF0A;
	Tue, 30 Jul 2024 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357440;
	bh=RbPf29au8m2VZIUu6dE4sehpTOELpLudf31zHxsUg3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Elcq4TmlDpKmdesCopdUDq0DUfvlbqA7GMsOGWbi0mbc0NChEWZoeMwoqsIYFQrd8
	 RexXzgp3Fi+AL3f143aUyDx5Hey1IwGNal5+djR8wFlH4ukv4Y2yoAUFBsx4PcoWG/
	 1KG082ZCRUDzuOyQf44bOx39CVnQcsEAQaewRztc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kiran K <kiran.k@intel.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 254/809] Bluetooth: btintel: Refactor btintel_set_ppag()
Date: Tue, 30 Jul 2024 17:42:10 +0200
Message-ID: <20240730151734.627588630@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kiran K <kiran.k@intel.com>

[ Upstream commit 0a3e2eca1daa5627c8ecd1554e3146de82d61dd2 ]

Current flow iterates the ACPI table associated with Bluetooth
controller looking for PPAG method. Method name can be directly passed
to acpi_evaluate_object function instead of iterating the table.

Fixes: c585a92b2f9c ("Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)")
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel.c | 119 +++++++++++-------------------------
 1 file changed, 34 insertions(+), 85 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0c855c3ee1c1c..7ecc67deecb09 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -26,21 +26,11 @@
 #define ECDSA_OFFSET		644
 #define ECDSA_HEADER_LEN	320
 
-#define BTINTEL_PPAG_NAME   "PPAG"
-
 enum {
 	DSM_SET_WDISABLE2_DELAY = 1,
 	DSM_SET_RESET_METHOD = 3,
 };
 
-/* structure to store the PPAG data read from ACPI table */
-struct btintel_ppag {
-	u32	domain;
-	u32     mode;
-	acpi_status status;
-	struct hci_dev *hdev;
-};
-
 #define CMD_WRITE_BOOT_PARAMS	0xfc0e
 struct cmd_write_boot_params {
 	__le32 boot_addr;
@@ -1324,65 +1314,6 @@ static int btintel_read_debug_features(struct hci_dev *hdev,
 	return 0;
 }
 
-static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, void *data,
-					 void **ret)
-{
-	acpi_status status;
-	size_t len;
-	struct btintel_ppag *ppag = data;
-	union acpi_object *p, *elements;
-	struct acpi_buffer string = {ACPI_ALLOCATE_BUFFER, NULL};
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	struct hci_dev *hdev = ppag->hdev;
-
-	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
-	if (ACPI_FAILURE(status)) {
-		bt_dev_warn(hdev, "PPAG-BT: ACPI Failure: %s", acpi_format_exception(status));
-		return status;
-	}
-
-	len = strlen(string.pointer);
-	if (len < strlen(BTINTEL_PPAG_NAME)) {
-		kfree(string.pointer);
-		return AE_OK;
-	}
-
-	if (strncmp((char *)string.pointer + len - 4, BTINTEL_PPAG_NAME, 4)) {
-		kfree(string.pointer);
-		return AE_OK;
-	}
-	kfree(string.pointer);
-
-	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		ppag->status = status;
-		bt_dev_warn(hdev, "PPAG-BT: ACPI Failure: %s", acpi_format_exception(status));
-		return status;
-	}
-
-	p = buffer.pointer;
-	ppag = (struct btintel_ppag *)data;
-
-	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
-		kfree(buffer.pointer);
-		bt_dev_warn(hdev, "PPAG-BT: Invalid object type: %d or package count: %d",
-			    p->type, p->package.count);
-		ppag->status = AE_ERROR;
-		return AE_ERROR;
-	}
-
-	elements = p->package.elements;
-
-	/* PPAG table is located at element[1] */
-	p = &elements[1];
-
-	ppag->domain = (u32)p->package.elements[0].integer.value;
-	ppag->mode = (u32)p->package.elements[1].integer.value;
-	ppag->status = AE_OK;
-	kfree(buffer.pointer);
-	return AE_CTRL_TERMINATE;
-}
-
 static int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
@@ -2427,10 +2358,13 @@ static int btintel_configure_offload(struct hci_dev *hdev)
 
 static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver)
 {
-	struct btintel_ppag ppag;
 	struct sk_buff *skb;
 	struct hci_ppag_enable_cmd ppag_cmd;
 	acpi_handle handle;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *p, *elements;
+	u32 domain, mode;
+	acpi_status status;
 
 	/* PPAG is not supported if CRF is HrP2, Jfp2, JfP1 */
 	switch (ver->cnvr_top & 0xFFF) {
@@ -2448,22 +2382,34 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 		return;
 	}
 
-	memset(&ppag, 0, sizeof(ppag));
-
-	ppag.hdev = hdev;
-	ppag.status = AE_NOT_FOUND;
-	acpi_walk_namespace(ACPI_TYPE_PACKAGE, handle, 1, NULL,
-			    btintel_ppag_callback, &ppag, NULL);
-
-	if (ACPI_FAILURE(ppag.status)) {
-		if (ppag.status == AE_NOT_FOUND) {
+	status = acpi_evaluate_object(handle, "PPAG", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		if (status == AE_NOT_FOUND) {
 			bt_dev_dbg(hdev, "PPAG-BT: ACPI entry not found");
 			return;
 		}
+		bt_dev_warn(hdev, "PPAG-BT: ACPI Failure: %s", acpi_format_exception(status));
+		return;
+	}
+
+	p = buffer.pointer;
+	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
+		bt_dev_warn(hdev, "PPAG-BT: Invalid object type: %d or package count: %d",
+			    p->type, p->package.count);
+		kfree(buffer.pointer);
 		return;
 	}
 
-	if (ppag.domain != 0x12) {
+	elements = p->package.elements;
+
+	/* PPAG table is located at element[1] */
+	p = &elements[1];
+
+	domain = (u32)p->package.elements[0].integer.value;
+	mode = (u32)p->package.elements[1].integer.value;
+	kfree(buffer.pointer);
+
+	if (domain != 0x12) {
 		bt_dev_dbg(hdev, "PPAG-BT: Bluetooth domain is disabled in ACPI firmware");
 		return;
 	}
@@ -2474,19 +2420,22 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	 * BIT 1 : 0 Disabled in China
 	 *         1 Enabled in China
 	 */
-	if ((ppag.mode & 0x01) != BIT(0) && (ppag.mode & 0x02) != BIT(1)) {
-		bt_dev_dbg(hdev, "PPAG-BT: EU, China mode are disabled in CB/BIOS");
+	mode &= 0x03;
+
+	if (!mode) {
+		bt_dev_dbg(hdev, "PPAG-BT: EU, China mode are disabled in BIOS");
 		return;
 	}
 
-	ppag_cmd.ppag_enable_flags = cpu_to_le32(ppag.mode);
+	ppag_cmd.ppag_enable_flags = cpu_to_le32(mode);
 
-	skb = __hci_cmd_sync(hdev, INTEL_OP_PPAG_CMD, sizeof(ppag_cmd), &ppag_cmd, HCI_CMD_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, INTEL_OP_PPAG_CMD, sizeof(ppag_cmd),
+			     &ppag_cmd, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_warn(hdev, "Failed to send PPAG Enable (%ld)", PTR_ERR(skb));
 		return;
 	}
-	bt_dev_info(hdev, "PPAG-BT: Enabled (Mode %d)", ppag.mode);
+	bt_dev_info(hdev, "PPAG-BT: Enabled (Mode %d)", mode);
 	kfree_skb(skb);
 }
 
-- 
2.43.0




