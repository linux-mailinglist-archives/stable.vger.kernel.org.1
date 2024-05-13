Return-Path: <stable+bounces-43733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D898C445A
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC96281D34
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EF257CA9;
	Mon, 13 May 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZuXfBVJb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314363C1
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614535; cv=none; b=h2RlvbOR6MTyfcU9+j8iaNmSwAgJVHPHl1DKt4wxTFbt4zrwRZY4RLMoFZD5Rtpoh8rcUr2Kfu9xoRtMe3bHoqX+E35gkohosoqM7BGVVuDY7nJKN28nfkEzRHVSnayC+Aprfp3Q5mo3LgeNMjPv5/aVLy77ql7sU5PcaZArdlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614535; c=relaxed/simple;
	bh=kDn1qSDmq6cPC3FEE463YIWmf81oUMw4jHurH++8+JA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KtkPXGFFxm8Qszf+lNbekfOSfbY+w3wrrAJ1UyvYP1myUCDUERxdhVB3B5o9P3lylZXjZYGTtbe99AmKZSUQNbe09nMrvNRs5OiMI2dlF6ZwzbdxQ0Ip8SfZyJcWReTsd97JsuEXsa2QXgtKSetDHSQFxHM+vS577ygRFyIGZlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZuXfBVJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8175AC4AF07;
	Mon, 13 May 2024 15:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715614534;
	bh=kDn1qSDmq6cPC3FEE463YIWmf81oUMw4jHurH++8+JA=;
	h=Subject:To:Cc:From:Date:From;
	b=ZuXfBVJbfNoGYiZ7JdLWqPxApL0C+hONMOGUTefB2hfFK8Rc/sShZ3eBMjELyZiYW
	 iDcbCTPShLnFXuJZ1Uq5p8VVj11be+U4AsGx7ocZ3rlLRgnKn0fY9byQyvCvqTh0V4
	 VQ+gSPPpo8FSEISrYXeyR4hNxLaFKiFid3n0WMP0=
Subject: FAILED: patch "[PATCH] Bluetooth: qca: fix firmware check error path" failed to apply to 4.19-stable tree
To: johan+linaro@kernel.org,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:35:22 +0200
Message-ID: <2024051321-refutable-qualified-fe5c@gregkh>
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
git cherry-pick -x 40d442f969fb1e871da6fca73d3f8aef1f888558
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051321-refutable-qualified-fe5c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

40d442f969fb ("Bluetooth: qca: fix firmware check error path")
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

From 40d442f969fb1e871da6fca73d3f8aef1f888558 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 1 May 2024 08:37:40 +0200
Subject: [PATCH] Bluetooth: qca: fix firmware check error path

A recent commit fixed the code that parses the firmware files before
downloading them to the controller but introduced a memory leak in case
the sanity checks ever fail.

Make sure to free the firmware buffer before returning on errors.

Fixes: f905ae0be4b7 ("Bluetooth: qca: add missing firmware sanity checks")
Cc: stable@vger.kernel.org      # 4.19
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 8d8a664620a3..638074992c82 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -605,7 +605,7 @@ static int qca_download_firmware(struct hci_dev *hdev,
 
 	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
 	if (ret)
-		return ret;
+		goto out;
 
 	segment = data;
 	remain = size;


