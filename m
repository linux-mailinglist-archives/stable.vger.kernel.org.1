Return-Path: <stable+bounces-67598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9D951241
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F5B1C20D54
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596D4156F33;
	Wed, 14 Aug 2024 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B468Y7Bl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E82156C63;
	Wed, 14 Aug 2024 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601755; cv=none; b=DJAC1zv4RB8q6vX5T4ShmEAB5TXKxCW5dUaCa28Wg+ThyLh5MPqrZuvuMd8YO0ZVlclqBlX/5vKxEueODD9Mo7OxSJBkM23fCIQibUAHC2g2wJq8ZTHewwujKTyMhYLknpGNGZgz3t46tYss3A06macgBIvhUQDKYM7eA8NN1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601755; c=relaxed/simple;
	bh=3CYpWTy0eYkWTO6QAVU1YBJwanjVGWwSOBXP2QFH8yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeF7DlNPte58sRpMoU186findb+BT9JvGozdm83YOwgYIw5TnIIzJosUTk0p/WppLAKY+J2iZKANxFUEutjYyo2C2mG+7sPvfRtsOUWky0e+YcvupaFna4A3vxkO5p7id8yM1Zw76pAfk6+xpS0KNK63RGzRsN4bgWQnQjSGvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B468Y7Bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A71C4AF0F;
	Wed, 14 Aug 2024 02:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601754;
	bh=3CYpWTy0eYkWTO6QAVU1YBJwanjVGWwSOBXP2QFH8yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B468Y7BlN49cvG+HW0oA/nrBSyaT/8vGuGvoS3OL+6E2U8WLT1wzoo8WYxbStMiqe
	 BAee1UvNnBuCVoHN+fu9I9rY1rRbMw6E4yhrg5w/QVDxAEzIWRjqBtWG+f2jbemmuc
	 7/g2urZTFlatt8zuxne4kTw6gkkp+VfcwqtoCdDPmftBR1bcu7gLs6Sbyor5SSVWHS
	 kPik/tss8iWVA0RAHx/Y/M8A+DOu4LtwE5eJnZ85tNLXB1RjRqMg/HFyxfGi42sui6
	 r0/frBybZYTQ1gO9BITzdUa2By9WMOYEssOpL0pQ298Ex/3Y4AYS6WiseWiX3QGIec
	 Jemr+MrYEemLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ZHANG Yuntian <yt@radxa.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bjorn@mork.no,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/2] net: usb: qmi_wwan: add MeiG Smart SRM825L
Date: Tue, 13 Aug 2024 22:15:51 -0400
Message-ID: <20240814021551.4130652-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021551.4130652-1-sashal@kernel.org>
References: <20240814021551.4130652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: ZHANG Yuntian <yt@radxa.com>

[ Upstream commit 1ca645a2f74a4290527ae27130c8611391b07dbf ]

Add support for MeiG Smart SRM825L which is based on Qualcomm 315 chip.

T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2dee ProdID=4d22 Rev= 4.14
S:  Manufacturer=MEIG
S:  Product=LTE-A Module
S:  SerialNumber=6f345e48
C:* #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=896mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms

Signed-off-by: ZHANG Yuntian <yt@radxa.com>
Link: https://patch.msgid.link/D1EB81385E405DFE+20240803074656.567061-1-yt@radxa.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 17aa52ed892b5..3b5c01b67560a 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1386,6 +1386,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
 	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
+	{QMI_FIXED_INTF(0x2dee, 0x4d22, 5)},    /* MeiG Smart SRM825L */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
-- 
2.43.0


