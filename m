Return-Path: <stable+bounces-147476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B98AC57D0
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05582165240
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA96127D786;
	Tue, 27 May 2025 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SRyElMoe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750A024C07D;
	Tue, 27 May 2025 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367458; cv=none; b=BPcQI6l33LiODRlFd9EpY8VcxwyiITOEpjW9KScjgHfRtETuWhC0oLl6PylvW53BoE3ti3FdBvHbBHEF0yyGme278jtEWYrigD3YJYWa6p/l4n/RBuWb1mPQugtlQiU0HxUJ/KiuQbQKIDq4oprtSl5gY3mYJLhJUz9TV6B8+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367458; c=relaxed/simple;
	bh=RMxz4RATggAERmfSou06Bxx4ouMSwKkIh/RusWsdiW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzZG4++7FaDsf+bVocQ0OxVI1BomkoK2G8Tkkva3yO/ZxmyadM4605vyyarNYRqJxf4KiKDOVtRMr/9kf7zUK+cwwsRlpBvXRTml0/GdvWblUrqiknTCvOolA91csXAZbO07HU5dtZDzApLEmdaLbCXCImqXY5Irvt1aJgRhyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SRyElMoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF24DC4CEE9;
	Tue, 27 May 2025 17:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367458;
	bh=RMxz4RATggAERmfSou06Bxx4ouMSwKkIh/RusWsdiW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SRyElMoeBshPVkO/j3IISLJueT6olbaQgPGoVMJrhsfjvDdN4hrnDSeluRnsrJWZ4
	 zCydkLzbx/9y+0y13AAzJ/+WPcRKqOHzF9gZ22Y+tSApFA182gBu7TNbqhud8qQ2ZT
	 QsB4ol3ghqlyF7/SGRD6Nh5EraQ9ydMKPDEvJNs8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 395/783] wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
Date: Tue, 27 May 2025 18:23:12 +0200
Message-ID: <20250527162529.177804928@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit e66bca16638ee59e997f9d9a3711b3ae587d04d9 ]

rtw_mac_power_switch() checks bit 8 of REG_SYS_STATUS1 to see if the
chip is powered on. This bit appears to be always on in the RTL8814AU,
so ignore it.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/2f0fcffb-3067-4d95-a68c-f2f3a5a47921@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index cae9cca6dca3d..ea6406df42b3d 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -291,6 +291,7 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	if (rtw_read8(rtwdev, REG_CR) == 0xea)
 		cur_pwr = false;
 	else if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB &&
+		 chip->id != RTW_CHIP_TYPE_8814A &&
 		 (rtw_read8(rtwdev, REG_SYS_STATUS1 + 1) & BIT(0)))
 		cur_pwr = false;
 	else
-- 
2.39.5




