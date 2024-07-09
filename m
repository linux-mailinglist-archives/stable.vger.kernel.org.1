Return-Path: <stable+bounces-58893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1713892C143
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D981C227A0
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5A1A990A;
	Tue,  9 Jul 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNobw29Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B21A98FD;
	Tue,  9 Jul 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542404; cv=none; b=PJoXyYz9QUHoGG9cLJuQNI6PUam/r+yG4QqoZ0BURHWcmxl6Cxsx86nHBBjOIvDpGiP7wMWVI+VgzGfQ0Gd6VTIh4FvTyLB20Yvfb0NxAJy9dFt7R5zV4GfRDRiChl2pvkx+QcGpcXs1jX1d/rSn+zrNrxakfIqiy3OFTLbKhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542404; c=relaxed/simple;
	bh=tYxgdCs+JhJBSfhOCTIidJysJEv+7QcuxrKVgWlopHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGrMzqk/Jmyfx6WKR4cHJF+nUzMCL9ZN2mAMycXMNisDxE8zxzJzqGbyWI60z/zBfXCa10AewtgvS0/NeDoeqxuyC609ttFL97HQJsXW8cq6EVWnGABGqtjad99/lRRS6c6zLcnrR863y9mex104oiJvmHvFLqRxm+JhZDGwqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNobw29Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03362C32782;
	Tue,  9 Jul 2024 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542404;
	bh=tYxgdCs+JhJBSfhOCTIidJysJEv+7QcuxrKVgWlopHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNobw29ZUIZUtIKhvw4OktMR16Su5kNYluo5cR3uW7mooIPYGIOMzlUjfPMJICne5
	 YgtOlvQ6Z8ozLUQIHLVOh+IIJCL7qMqWfC02SBW245JlC844h6Cv7jcmzREC6vB1MD
	 mEqPk41qi3Tf1v2lSfRmQDV+DLNj5+0lDOuAasb8WrVq+ax6zslpx1cJBh6csKdogW
	 zy9dfFjTqii/5uz8Qx9ZlQy0H9ZsUqleZVifO3gR2JUW7AhMNvJ0cUpXZVSitCAkjI
	 gjlDCdq1WYymU6nqXt0hZKBLrG+TZRIK7Tf9HcM6i66HGr3BhmbBalIVKjc/d4R0aw
	 LX9wqYsNn5PPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniele Palmas <dnlplm@gmail.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 14/14] net: usb: qmi_wwan: add Telit FN912 compositions
Date: Tue,  9 Jul 2024 12:25:58 -0400
Message-ID: <20240709162612.32988-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162612.32988-1-sashal@kernel.org>
References: <20240709162612.32988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
Content-Transfer-Encoding: 8bit

From: Daniele Palmas <dnlplm@gmail.com>

[ Upstream commit 77453e2b015b5ced5b3f45364dd5a72dfc3bdecb ]

Add the following Telit FN912 compositions:

0x3000: rmnet + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=03 Lev=01 Prnt=03 Port=07 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=3000 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN912
S:  SerialNumber=92c4c4d8
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

0x3001: rmnet + tty (AT) + tty (diag) + DPL (data packet logging) + adb
T:  Bus=03 Lev=01 Prnt=03 Port=07 Cnt=01 Dev#=  7 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=3001 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN912
S:  SerialNumber=92c4c4d8
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
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Link: https://patch.msgid.link/20240625102236.69539-1-dnlplm@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 4dd1a9fb4c8a0..d2a8238e144a6 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1312,6 +1312,8 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1260, 2)},	/* Telit LE910Cx */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1261, 2)},	/* Telit LE910Cx */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1900, 1)},	/* Telit LN940 series */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x3000, 0)},	/* Telit FN912 series */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x3001, 0)},	/* Telit FN912 series */
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9b01, 3)},	/* XS Stick W100-2 from 4G Systems */
-- 
2.43.0


