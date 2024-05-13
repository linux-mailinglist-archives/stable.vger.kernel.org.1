Return-Path: <stable+bounces-43727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE5D8C4451
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E861F21E68
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4396153589;
	Mon, 13 May 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HKejdGrz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3558213
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614442; cv=none; b=rUo7HZLWvixpBnV/qFoRNwb+siJzdeVup3AzfptCNodRjgaOhbbHoJnQPqglKj6Wmc8lthHtjDg9p8v/2+mTqg8w+2PI9jsBvEYz836h31ZV+YaviqM2ta0/QbgCdLdhPyXVlKAvc58WL0GojU3XP+QpfgA6XkSr09Yvravd0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614442; c=relaxed/simple;
	bh=anHXxswPePOiI+N4JMNdvLuZqdiAPtaPiortqDnJxEQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EGF1kkHEKBnVZ6Bw8J6jKk3lqEmPAexsRnfwWxnUVT0nhgkjnDoTrzkroZKpF+xWMPwX2lkFxFwolCtqzXgHf40kDneQlyr4216JMBwTiGl/r9Z8Mn1PXzcVGbhplpZGe0a/GrFuyRLnw5ANES1GReLndYk3jYZWwr8jp+J0mQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HKejdGrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C24C4AF0A;
	Mon, 13 May 2024 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715614442;
	bh=anHXxswPePOiI+N4JMNdvLuZqdiAPtaPiortqDnJxEQ=;
	h=Subject:To:Cc:From:Date:From;
	b=HKejdGrz6J8pdH99Tb75T8sDEYvTJTDeZlVBkWw61LQ91Gu9cy+2NdVZyzPtOfKoC
	 Jim/q3jqCbY5xnykSnbp422X79EkcxhJp6ukCqNzzszvh4iEfFFvZnycgNxA49SJzh
	 DrI0+qUsWi4DXV4AuCYnaSS+plbm/WClBxGnh2BU=
Subject: FAILED: patch "[PATCH] Bluetooth: qca: fix NVM configuration parsing" failed to apply to 5.10-stable tree
To: johan+linaro@kernel.org,luiz.von.dentz@intel.com,mka@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:33:58 +0200
Message-ID: <2024051358-overplant-spent-f520@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a112d3c72a227f2edbb6d8094472cc6e503e52af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051358-overplant-spent-f520@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

a112d3c72a22 ("Bluetooth: qca: fix NVM configuration parsing")
2e4edfa1e2bd ("Bluetooth: qca: add missing firmware sanity checks")
ecf6b2d95666 ("Bluetooth: btqca: Add support for firmware image with mbn type for WCN6750")
d8f97da1b92d ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750")
b43ca511178e ("Bluetooth: btqca: Don't modify firmware contents in-place")
c1a74160eaf1 ("Bluetooth: hci_qca: Add device_may_wakeup support")
eaf19b0c47d1 ("Bluetooth: btqca: Enable MSFT extension for Qualcomm WCN399x")
c0187b0bd3e9 ("Bluetooth: btqca: Add support to read FW build version for WCN3991 BTSoC")
99719449a4a6 ("Bluetooth: hci_qca: resolve various warnings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a112d3c72a227f2edbb6d8094472cc6e503e52af Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Tue, 30 Apr 2024 19:07:40 +0200
Subject: [PATCH] Bluetooth: qca: fix NVM configuration parsing

The NVM configuration files used by WCN3988 and WCN3990/1/8 have two
sets of configuration tags that are enclosed by a type-length header of
type four which the current parser fails to account for.

Instead the driver happily parses random data as if it were valid tags,
something which can lead to the configuration data being corrupted if it
ever encounters the words 0x0011 or 0x001b.

As is clear from commit b63882549b2b ("Bluetooth: btqca: Fix the NVM
baudrate tag offcet for wcn3991") the intention has always been to
process the configuration data also for WCN3991 and WCN3998 which
encodes the baud rate at a different offset.

Fix the parser so that it can handle the WCN3xxx configuration files,
which has an enclosing type-length header of type four and two sets of
TLV tags enclosed by a type-length header of type two and three,
respectively.

Note that only the first set, which contains the tags the driver is
currently looking for, will be parsed for now.

With the parser fixed, the software in-band sleep bit will now be set
for WCN3991 and WCN3998 (as it is for later controllers) and the default
baud rate 3200000 may be updated by the driver also for WCN3xxx
controllers.

Notably the deep-sleep feature bit is already set by default in all
configuration files in linux-firmware.

Fixes: 4219d4686875 ("Bluetooth: btqca: Add wcn3990 firmware download support.")
Cc: stable@vger.kernel.org	# 4.19
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 6743b0a79d7a..f6c9f89a6311 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -281,6 +281,7 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
 	struct tlv_type_patch *tlv_patch;
 	struct tlv_type_nvm *tlv_nvm;
 	uint8_t nvm_baud_rate = config->user_baud_rate;
+	u8 type;
 
 	config->dnld_mode = QCA_SKIP_EVT_NONE;
 	config->dnld_type = QCA_SKIP_EVT_NONE;
@@ -346,11 +347,30 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
 		tlv = (struct tlv_type_hdr *)fw_data;
 
 		type_len = le32_to_cpu(tlv->type_len);
-		length = (type_len >> 8) & 0x00ffffff;
+		length = type_len >> 8;
+		type = type_len & 0xff;
 
-		BT_DBG("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
+		/* Some NVM files have more than one set of tags, only parse
+		 * the first set when it has type 2 for now. When there is
+		 * more than one set there is an enclosing header of type 4.
+		 */
+		if (type == 4) {
+			if (fw_size < 2 * sizeof(struct tlv_type_hdr))
+				return -EINVAL;
+
+			tlv++;
+
+			type_len = le32_to_cpu(tlv->type_len);
+			length = type_len >> 8;
+			type = type_len & 0xff;
+		}
+
+		BT_DBG("TLV Type\t\t : 0x%x", type);
 		BT_DBG("Length\t\t : %d bytes", length);
 
+		if (type != 2)
+			break;
+
 		if (fw_size < length + (tlv->data - fw_data))
 			return -EINVAL;
 


