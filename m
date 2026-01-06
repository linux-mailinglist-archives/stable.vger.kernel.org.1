Return-Path: <stable+bounces-205036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6703DCF6CB7
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 06:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70EF43019E15
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 05:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782082D9792;
	Tue,  6 Jan 2026 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="dPEwKXVa";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="XE3dY9hu"
X-Original-To: stable@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9912A2DA77E;
	Tue,  6 Jan 2026 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767678021; cv=none; b=ZnS/uukvR6bhlhsZAIPGY6JfswuLY3J39nS2sTGjYxd1NwIRxO0kHCPF/2x+Q5fw+pBeN5RjzZVD6iOubLLc8UovRJDLcIC0zHeMS8pDC0Hk8RYAOkjA3E2q3zrsoCH8osY+SLtYMpIb/T8Un/D2LXVq8sqJpmbfsy2IJViV8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767678021; c=relaxed/simple;
	bh=nlZeKx/WsdUVRencZTnNcZrTLH/ONVDy/mFGibneVQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i4xoYMhkLqMohTRFEUoBFmAoK8f4vAaYO9FKFMQacRJOMZETzu6WKOE4hSPz8Fr0dNM48jKivr2WLxLjVqoccasy4OHN24Iz8On2eJXdEyEj4pdtVu4k1WVZNhg8BhLyQpZ9SMauZbNVm9jzuBiv2qcKpZsvjQQCKWlvXRL5EEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=dPEwKXVa; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=XE3dY9hu; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1767678006;
	bh=jAXQypJwkEBdsBc3burggqz+vq2Lgfm2waHWJh0qX4c=; l=1676;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dPEwKXVaCmWDG1H4OFNnhaSeqO4HDLD4DB1/X7R+b7tquCSIkYOjdeE30BKCZvFon
	 ahkD2Tob7CNNiKiMySlifjLvfyCTN4enbt3dRfoH0jve/VKQym1T6sXfCJYyYtMo7J
	 96HaZiVA5LmXIVHkTSxVQc2hg3Dsj7eawFUtmR9l1me+JA1JU2/fb6DV32ofdMYK+D
	 MFxL4uMc9YGwzRunpWTS1G72EsRI54qifnh/qIfaHq4yoJRFErcGhlvduvhH3FmD/b
	 THqR+bg0G9RL07E10K5Irj9sSFgmzED4Iv5OelaxNkDaOCFoSqpEvIDVUOWV0w23uX
	 BceGXMT2NR5zw==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128079:0:AUTH_RELAY)
	(envelope-from <prvs=1464629B15=cy_huang@richtek.com>); Tue, 06 Jan 2026 13:40:04 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1767678004;
	bh=jAXQypJwkEBdsBc3burggqz+vq2Lgfm2waHWJh0qX4c=; l=1676;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XE3dY9huV1amArTOzVo1/bjGXctaqZK/i4k32D9VDoeTlt6IUQ7MIrNz+ZauCl5WB
	 t+rq8ibcxbyfTONnLCcDzial0qEFYxV43rrN5qBUDHCBdu2QcQGuW8Ms2GoU4zw+V1
	 bBRnxR7iqEC0fHu624vk/xgBcuRoidn8TYYgDihJvgfxStLWHHupds+bmfkmC77WEm
	 YdQNz1bh9fgaNNSDCAb3w883/Y0KQ9evws+vQMjw18k8x2YkABxXRPQlBJC379j1Z8
	 DJHfxquzv0Trd5SMxygW7tVXN5wKAkLVYTB6NNxl6L2QWwpuNjcGiUZuuZYUandwzb
	 X9yoec/TNfOOg==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(2572460:1:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 06 Jan 2026 13:33:05 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 6 Jan
 2026 13:33:04 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Tue, 6 Jan 2026 13:33:04 +0800
From: <cy_huang@richtek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: ChiYuan Huang <cy_huang@richtek.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Roger Wang
	<roger-hy.wang@mediatek.com>
Subject: [PATCH] media: v4l2-flash: Enter LED off state after file handle closed
Date: Tue, 6 Jan 2026 13:32:59 +0800
Message-ID: <0e7005f10222b57f100b442a8b48bb5bc2747e78.1767674614.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

To make sure LED enter off state after file handle is closed, initiatively
configure LED_MODE to NONE. This can guarantee whatever the previous state
is torch or strobe mode, the final state will be off.

Cc: stable@vger.kernel.org
Fixes : 42bd6f59ae90 ("media: Add registration helpers for V4L2 flash sub-devices")
Reported-by: Roger Wang <roger-hy.wang@mediatek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,
  We encounter an issue. When the upper layer camera process is crashed,
if the new process did not reinit the LED,  it will keeps the previous
state whatever it's in torch or strobe mode

OS will handle the resource management. So when the process is crashed
or terminated, the 'close' API will be called to release resources.
That's why we add the initiative action to trigger LED off in file
handle close is called.
---
 drivers/media/v4l2-core/v4l2-flash-led-class.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-flash-led-class.c b/drivers/media/v4l2-core/v4l2-flash-led-class.c
index 355595a0fefa..347b37f3ef69 100644
--- a/drivers/media/v4l2-core/v4l2-flash-led-class.c
+++ b/drivers/media/v4l2-core/v4l2-flash-led-class.c
@@ -623,6 +623,12 @@ static int v4l2_flash_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 		return 0;
 
 	if (led_cdev) {
+		/* If file handle is released, make sure LED enter off state */
+		ret = v4l2_ctrl_s_ctrl(v4l2_flash->ctrls[LED_MODE],
+			V4L2_FLASH_LED_MODE_NONE);
+		if (ret)
+			return ret;
+
 		mutex_lock(&led_cdev->led_access);
 
 		if (v4l2_flash->ctrls[STROBE_SOURCE])
-- 
2.34.1


