Return-Path: <stable+bounces-59445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745E89328CB
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0B21F23296
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450481A3BB3;
	Tue, 16 Jul 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8d58MPI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25221A38D1;
	Tue, 16 Jul 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140051; cv=none; b=E7/HIDfWCdhLSrTabsNh3eqJkQLfaQZnkhvcEpec1Y0MVtlhKMSSzSfZKoE1p8R5krLYs1ZXVHVDCiUMwKWUTxtA1mKBfT/vbHtZ8B6ZYD3UKg4+pgdZKOC6Sy2+s+otYrym04i5WaeicvoL+2XhvnAtGxnlbujeGYOpdIFBNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140051; c=relaxed/simple;
	bh=kUvW7zqE2mpbxtmWfWo6THSrr66t4lHc9l31ki3t86k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIDqhp7m/yVgtZ/cSBQooVqwxjqiJ9tKvVBbZm0cw0s5FakcXgw0KvY8kpjyfdQUn8HXAvZPprKbCf4g8eMGrvPY6jFNSJNfs1Wxv6rgZHZ8q3GImupEDCNYKmh3OUdQDWsvJ5JTeIsegosK3VVlfEr3EQ9LBe4iyw8fx7NwRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8d58MPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DC8C4AF09;
	Tue, 16 Jul 2024 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140050;
	bh=kUvW7zqE2mpbxtmWfWo6THSrr66t4lHc9l31ki3t86k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8d58MPIusOTJopEasCC8O1sjRMzxgbTRFKsca4iiClxm1pS39P2coEHoAQ4ZPkBP
	 Nfhmsayc/iWio/DASQq8RWVlCtsukImIhu5oq1dof524ZUmP407GHlAs8GBGfxEvDD
	 yCBpHBnxMVASbJH2+/B9mXAWET8bcwdayS5t4EteUDM/tffAAaCnxfERd3N63G76vE
	 FBMNB2zoh8v+bfLyXdIv40u98l/+I6UpbyZrlMrjqiuaWd5le9EO48GdK5pkNY7Rod
	 7u6Y3kBW+1/YNDSNSgUg6NXHviunvpgKHGIZwjhKbpY2ido3DUpSG7oHFj4Sx19bVq
	 qN/55QXYCdXqg==
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
Subject: [PATCH AUTOSEL 6.6 07/18] Bluetooth: btnxpuart: Enable Power Save feature on startup
Date: Tue, 16 Jul 2024 10:26:42 -0400
Message-ID: <20240716142713.2712998-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142713.2712998-1-sashal@kernel.org>
References: <20240716142713.2712998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
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
index abccd571cf3ee..5c5a5b752419e 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -280,7 +280,7 @@ static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
 #define DEFAULT_H2C_WAKEUP_MODE	WAKEUP_METHOD_BREAK
-#define DEFAULT_PS_MODE		PS_MODE_DISABLE
+#define DEFAULT_PS_MODE		PS_MODE_ENABLE
 #define FW_INIT_BAUDRATE	HCI_NXP_PRI_BAUDRATE
 
 static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,
-- 
2.43.0


