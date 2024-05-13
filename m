Return-Path: <stable+bounces-43729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E654A8C4453
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C18A2821E4
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17830154430;
	Mon, 13 May 2024 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t3jGuVps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD015153BFD
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614454; cv=none; b=YSDY9XApEc9v1iXes8NEGtxJYuSCIeJFNFWniOj/RzFifp+bjCikBGfN2xMFi4HmWFdcd3ImINAqk6GpJLGGc1vHDfEgHHpjUhANhF9quZOAWpp5GgTFkZ2kdOwOdpcUE8sJ3SjSoGMQbQmGSOcKH8zweuaqxGc0KyiQ1gXzJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614454; c=relaxed/simple;
	bh=in/2XHQCIeMV9gJCWA60HPOBge5iQIu3CChaUJuLQuo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B4wrgvG6pcYQ1CeeWJ+HonR/r0yLUFPtODxup/MpDGYV2dO8VxRrd4Puj9gN0mRDEwbIDOZ9MRQNuPlPbqBIQa7yaxPHUmP4YzgkokiThnt8wfosGi76DRRat6vBkVZj2WrP7wk9po7IBpanS8g1IhIpVRgAEVXXwEjBT0YCYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t3jGuVps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FAEC4AF09;
	Mon, 13 May 2024 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715614454;
	bh=in/2XHQCIeMV9gJCWA60HPOBge5iQIu3CChaUJuLQuo=;
	h=Subject:To:Cc:From:Date:From;
	b=t3jGuVpsmssF2BQzfNARyZ1Pn/2zREsgI2YEwPUd/d3qCPTrapKzkv9tbDiqInhe+
	 a6HtFQkb2ERsGNHtDnAQ2TqlcNviCnQgdAI67gPwqMzhMKdDTrEILVxMsjBlnogTg/
	 KvQVGTzQdtbtRKRJOcX6HykpttKyo+8tKJXmWXjY=
Subject: FAILED: patch "[PATCH] Bluetooth: qca: fix NVM configuration parsing" failed to apply to 4.19-stable tree
To: johan+linaro@kernel.org,luiz.von.dentz@intel.com,mka@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:34:01 +0200
Message-ID: <2024051301-untwist-vertical-ba65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x a112d3c72a227f2edbb6d8094472cc6e503e52af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051301-untwist-vertical-ba65@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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
054ec5e94a46 ("Bluetooth: hci_qca: Remove duplicate power off in proto close")
590deccf4c06 ("Bluetooth: hci_qca: Disable SoC debug logging for WCN3991")
37aee136f8c4 ("Bluetooth: hci_qca: allow max-speed to be set for QCA9377 devices")
e5d6468fe9d8 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA6390")
77131dfec6af ("Bluetooth: hci_qca: Replace devm_gpiod_get() with devm_gpiod_get_optional()")
8a208b24d770 ("Bluetooth: hci_qca: Make bt_en and susclk not mandatory for QCA Rome")
b63882549b2b ("Bluetooth: btqca: Fix the NVM baudrate tag offcet for wcn3991")
4f9ed5bd63dc ("Bluetooth: hci_qca: Not send vendor pre-shutdown command for QCA Rome")
66cb70513564 ("Bluetooth: hci_qca: Enable clocks required for BT SOC")
ae563183b647 ("Bluetooth: hci_qca: Enable power off/on support during hci down/up for QCA Rome")
5559904ccc08 ("Bluetooth: hci_qca: Add QCA Rome power off support to the qca_power_shutdown()")

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
 


