Return-Path: <stable+bounces-105456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D179F97DD
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3F3188B60D
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE54229135;
	Fri, 20 Dec 2024 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds3rm6Vl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561A227575;
	Fri, 20 Dec 2024 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714745; cv=none; b=OLYzxjoAA7IPA13gEgoohbVAR79WuVUK7XWamRRhXwNeGIEozVw0p51I36YJ9K8xivYY1tcWkcsyBSjsNCBW+bsfQPG8wgMgQyAFNXv+eiKPSFmCa5tCCfEtwiGre3iN1ZLWa2gf3E5sclS884QvzbgFI70gmAaSprg5DW52BrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714745; c=relaxed/simple;
	bh=weqdi9M3ibXM2P6TX1FkJMBTUDWaZmyGU2K6jFRFvFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQ5GdGvKUKXbtxxcjmje6jwWp0ccopIm+ibA3H0eKtJJ20wlVcNph6up01DCEq3V2I7v3X/758hGWQaaP24MjS8oKhwgUCGgdu4UumRKZ1qqBw8HXFmKyyA4p6k0uG7JjBnKJ8KnRZ8Khr+2GmtpuunH1FEUJV9Ke6sn7DrWsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds3rm6Vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B4AC4CECD;
	Fri, 20 Dec 2024 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714745;
	bh=weqdi9M3ibXM2P6TX1FkJMBTUDWaZmyGU2K6jFRFvFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ds3rm6VlaVhTlUTF+AslpAx84XdgJjSMjjffpSBbc+kA8JkToyPdhFUyl7bUCouKn
	 w+gn7nJoGPMZzXy2HKzQtCGfQNxBPwODvLz3e34wR/NObq3gdRxyMQLTTLVbmYTyPq
	 1uKQE45jQjxsIShWIFlwdNBzmLiFINC7t/Ksld8ffOApMc2CMqfspBjXmFVedr2LMN
	 SPd8TIopMLZF92JUj91ePUDXMcCnx6vTQuQFptotelfi4F3YIIamuu3PzCPpiI+Cmb
	 fkoJfuo8wueHhP5Qwu/H0Sb416giX1dDhcCPIYvDi1HGj5rPNvno9LHPkWCM5t4hvG
	 pYSJXasBiKhzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniele Palmas <dnlplm@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bjorn@mork.no,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 24/29] net: usb: qmi_wwan: add Telit FE910C04 compositions
Date: Fri, 20 Dec 2024 12:11:25 -0500
Message-Id: <20241220171130.511389-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Daniele Palmas <dnlplm@gmail.com>

[ Upstream commit 3b58b53a26598209a7ad8259a5114ce71f7c3d64 ]

Add the following Telit FE910C04 compositions:

0x10c0: rmnet + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=02 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 13 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c0 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10c4: rmnet + tty (AT) + tty (AT) + tty (diag)
T:  Bus=02 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 14 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c4 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10c8: rmnet + tty (AT) + tty (diag) + DPL (data packet logging) + adb
T:  Bus=02 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 17 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c8 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Link: https://patch.msgid.link/20241209151821.3688829-1-dnlplm@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 0c011d8f5d4d..9fe7f704a2f7 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1365,6 +1365,9 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c0, 0)}, /* Telit FE910C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c4, 0)}, /* Telit FE910C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c8, 0)}, /* Telit FE910C04 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
-- 
2.39.5


