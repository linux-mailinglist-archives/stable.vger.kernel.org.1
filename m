Return-Path: <stable+bounces-7209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A88D81716D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8BD283737
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD581D15C;
	Mon, 18 Dec 2023 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d80taLcj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E61D14D;
	Mon, 18 Dec 2023 13:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D06DC433C7;
	Mon, 18 Dec 2023 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907856;
	bh=0ZbpjTPE5pPUWCdm9NYGKOnvfdKletxIG2DYTfyV5Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d80taLcjXP1UUcuDcpa86Q+cRvJpnNuHbbI/o1buKzsjU2fe7aGPAjpfhHTZoSX1l
	 8vJw1/n/jcZ4Z46r97YL1SmZyzXLCgzhcm6TwlhVSr3VnewonpetthX7F6601ve9+s
	 6j91OdB2UqNdfvmcBvtSwWbMJNk0KEX3nglbBJ/s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aoba K <nexp_0x17@outlook.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 072/106] HID: multitouch: Add quirk for HONOR GLO-GXXX touchpad
Date: Mon, 18 Dec 2023 14:51:26 +0100
Message-ID: <20231218135058.136148262@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aoba K <nexp_0x17@outlook.com>

[ Upstream commit 9ffccb691adb854e7b7f3ee57fbbda12ff70533f ]

Honor MagicBook 13 2023 has a touchpad which do not switch to the multitouch
mode until the input mode feature is written by the host.  The touchpad do
report the input mode at touchpad(3), while itself working under mouse mode. As
a workaround, it is possible to call MT_QUIRE_FORCE_GET_FEATURE to force set
feature in mt_set_input_mode for such device.

The touchpad reports as BLTP7853, which cannot retrive any useful manufacture
information on the internel by this string at present.  As the serial number of
the laptop is GLO-G52, while DMI info reports the laptop serial number as
GLO-GXXX, this workaround should applied to all models which has the GLO-GXXX.

Signed-off-by: Aoba K <nexp_0x17@outlook.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 8db4ae05febc8..5ec1f174127a3 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2048,6 +2048,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_HANVON_ALT,
 			USB_DEVICE_ID_HANVON_ALT_MULTITOUCH) },
 
+	/* HONOR GLO-GXXX panel */
+	{ .driver_data = MT_CLS_VTL,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			0x347d, 0x7853) },
+
 	/* Ilitek dual touch panel */
 	{  .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
-- 
2.43.0




