Return-Path: <stable+bounces-127925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67627A7AD45
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156701886965
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0334F2BE7D5;
	Thu,  3 Apr 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6zpEs0O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935925A346;
	Thu,  3 Apr 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707401; cv=none; b=EB6WxjsGa9BeXbFygv6Me4xhYPrjvX/7K41pAEumd6ytipxoo2mJZqDQSnl9ykzjPI9HDnEVd9NhgzrRrghKn3WpSf8JpGS9To4gMok7z9cg4EZy75M0H1yaVEZFfAwaTdwoZtyJLV6X6S/rOGfWyd+3OuG7ukl/T7/qzkQWado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707401; c=relaxed/simple;
	bh=akN3gPfvOXKk+2v94TGQKZAVvPyKGYp1GkvgfiTqnVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EI7B4qzpteT1Rv59fX1u8Cen0KB/bQJM5CBsSWMYWs8iU/rfbgZ38ETLxx0i0LpZHXAHVHDU6cl1bFgkiCJy5K6jUCVfKDr0STR5Nx5s0BP/15Zh8+i5FLvymXFrhgVJjFF28b2YAK86kyckaVrUwDLfq3aVmZrVMvqdCoMXoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6zpEs0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBCBC4CEE3;
	Thu,  3 Apr 2025 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707401;
	bh=akN3gPfvOXKk+2v94TGQKZAVvPyKGYp1GkvgfiTqnVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6zpEs0OXWDn6cc4saSEIOefrTLIfgx8B3ImHpcTnkshoqJ08/6ujtvsY6TopxmUw
	 X+rYQqEgo9JGyrCEMxl8PEEwtwlRhYlTK1vHuIvrqDKJNg0pddE/y/2GBG3xtAewrE
	 VhzKmVoITwFmONlD6Q1CVRx9cE6+sCCWJCCvDhvHZu/Fx1yLgZmNx81k2lADLXJ0RA
	 zMH7/zQlvrMl8SzfCG8/k0Ok5xcbBG7zAXmyQMw8k99YesRhA0u+HT/8dqEpfuCNk2
	 bvkP/CWtgrh3ebZ5DCe4iss54kaFelEAodTmpArLmnYTbufaJggUjzyw65fP0mQESU
	 E/w6WHB2bRU6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 16/16] Bluetooth: hci_uart: fix race during initialization
Date: Thu,  3 Apr 2025 15:09:24 -0400
Message-Id: <20250403190924.2678291-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190924.2678291-1-sashal@kernel.org>
References: <20250403190924.2678291-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Arseniy Krasnov <avkrasnov@salutedevices.com>

[ Upstream commit 366ceff495f902182d42b6f41525c2474caf3f9a ]

'hci_register_dev()' calls power up function, which is executed by
kworker - 'hci_power_on()'. This function does access to bluetooth chip
using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
be executed before setting this bit. In that case HCI init logic fails.

Patch moves setting of 'HCI_UART_PROTO_READY' before calling function
'hci_uart_register_dev()'.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_ldisc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index be51528afed9d..fbbd832e4def1 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -706,12 +706,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
 	}
 
-	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 	return 0;
 }
 
-- 
2.39.5


