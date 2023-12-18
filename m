Return-Path: <stable+bounces-7581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775EF81732C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DA9B23C6F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BCB1D12F;
	Mon, 18 Dec 2023 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JtRyPI4f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9937129ED2;
	Mon, 18 Dec 2023 14:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4033DC433C8;
	Mon, 18 Dec 2023 14:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908855;
	bh=xtIpELvaLB2xAzwEN/VJW0yw/mu36jQQx0siD/KDN14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JtRyPI4fat+DtgfF0ofe5ALwm51030dqir+zSrwcSsvRQMdepv1XdEDBOb3HsrfNN
	 5XGqoZREfvM/RqdGaP/ebJhkH62YpbW0AIHhRv6tHOtukzhKZq1YvFWt3dw4k7au7i
	 72vYU/5V1z55NqhQCOxAcYAb5R1m+u+SnbEZPnFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 57/83] HID: hid-asus: reset the backlight brightness level on resume
Date: Mon, 18 Dec 2023 14:52:18 +0100
Message-ID: <20231218135052.255310755@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Benato <benato.denis96@gmail.com>

[ Upstream commit 546edbd26cff7ae990e480a59150e801a06f77b1 ]

Some devices managed by this driver automatically set brightness to 0
before entering a suspended state and reset it back to a default
brightness level after the resume:
this has the effect of having the kernel report wrong brightness
status after a sleep, and on some devices (like the Asus RC71L) that
brightness is the intensity of LEDs directly facing the user.

Fix the above issue by setting back brightness to the level it had
before entering a sleep state.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-asus.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 16832e79f6a87..8c16995105043 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1014,6 +1014,24 @@ static int asus_start_multitouch(struct hid_device *hdev)
 	return 0;
 }
 
+static int __maybe_unused asus_resume(struct hid_device *hdev) {
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret = 0;
+
+	if (drvdata->kbd_backlight) {
+		const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4,
+				drvdata->kbd_backlight->cdev.brightness };
+		ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
+		if (ret < 0) {
+			hid_err(hdev, "Asus failed to set keyboard backlight: %d\n", ret);
+			goto asus_resume_err;
+		}
+	}
+
+asus_resume_err:
+	return ret;
+}
+
 static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -1305,6 +1323,7 @@ static struct hid_driver asus_driver = {
 	.input_configured       = asus_input_configured,
 #ifdef CONFIG_PM
 	.reset_resume           = asus_reset_resume,
+	.resume					= asus_resume,
 #endif
 	.event			= asus_event,
 	.raw_event		= asus_raw_event
-- 
2.43.0




