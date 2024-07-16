Return-Path: <stable+bounces-59424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A1932870
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF701C2222A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F241A00E5;
	Tue, 16 Jul 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF/djpBY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D419D8A9;
	Tue, 16 Jul 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139939; cv=none; b=alTMi9juOhjEwgalWYxmyg1F75aoit0ekAlkKu1NIMrVjDp08tlXnBw/UoMKrD/u+IAPZI5Py0NuNbD7fCt4d8jvs+pAGmJFfcVjruiyXyjrhlXL6FcCjDadIJuNvJEOvW9t1wiSjs8vWuaIM5CXnEMsZC2wXCulKM9S2vuq55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139939; c=relaxed/simple;
	bh=w/UvLPdQ3frwqZbgm7HZIfRLu7AqiiUKg4e/uLSXwJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/yd7Form3CaARdJaaaucGJ8d7AW0IH+E496wliwTH5NMwq+oeBOwjIcorp8Qh64UkdjRJ6Bc5Pfb6+kwLIW4N7mOpB8y40c0+iQE6dNo3UPcAJaMwjNX3eS4VOGudXbeAwkHFcd4jHaZ1iwR8A4K3Zb5CFAUIZhtJTT8XzMsBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF/djpBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68521C4AF0E;
	Tue, 16 Jul 2024 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139939;
	bh=w/UvLPdQ3frwqZbgm7HZIfRLu7AqiiUKg4e/uLSXwJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RF/djpBY452jsF7rAf/nKhTUH55DjFbaaaALGQbKIl3/Am3GggZoINuK1QXzCDHdT
	 QxkxMFawaOjtaGJ3IVgwqnFJuGCyxXyaclADYO2bx9vQ967Wlz+8wHl8Wxv1vy4tOq
	 /XIgBHD4KCUYSinRNhV4OcBw/b1O97gMGlW8knpmEfQp9nYe2NygI3sGHvNwjNjJVR
	 WnzJL76muiMCi+5hiSTyaLUpKTUNUo5Gl78EBoHHM1b6XakZQhXUUzUB/1ou60wRNh
	 0FmqidgwOqcR8rd9p0wkw306XU+YqDyBgbZEE6gtDovxhmxFtjmustVqiQKh24Leem
	 6eqXWUryyGPbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	amitkumar.karwar@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 08/22] Bluetooth: btnxpuart: Enable Power Save feature on startup
Date: Tue, 16 Jul 2024 10:24:15 -0400
Message-ID: <20240716142519.2712487-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
Content-Transfer-Encoding: 8bit

From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

[ Upstream commit 4183a7be77009fc31c5760429fe095f163bf96a9 ]

This sets the default power save mode setting to enabled.

The power save feature is now stable and stress test issues, such as the
TX timeout error, have been resolved.
commit c7ee0bc8db32 ("Bluetooth: btnxpuart: Resolve TX timeout error in
power save stress test")

With this setting, the driver will send the vendor command to FW at
startup, to enable power save feature.

User can disable this feature using the following vendor command:
hcitool cmd 3f 23 03 00 00 (HCI_NXP_AUTO_SLEEP_MODE)

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btnxpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 9d0c7e278114b..9bfa9a6ad56c8 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -281,7 +281,7 @@ static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
 #define DEFAULT_H2C_WAKEUP_MODE	WAKEUP_METHOD_BREAK
-#define DEFAULT_PS_MODE		PS_MODE_DISABLE
+#define DEFAULT_PS_MODE		PS_MODE_ENABLE
 #define FW_INIT_BAUDRATE	HCI_NXP_PRI_BAUDRATE
 
 static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,
-- 
2.43.0


