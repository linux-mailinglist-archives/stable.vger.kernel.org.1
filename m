Return-Path: <stable+bounces-43272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E148BF11D
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39331C22173
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D713C827;
	Tue,  7 May 2024 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSiM83gq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A713C80E;
	Tue,  7 May 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122899; cv=none; b=llX1FLfIeYtzR85WIM2AtcF8XWuApl4AYehetDZTQVuLSw2JQdPGdH8rfHaNy8RsQwe3OEnoPG3/xpFGldSREbbTZH3K0x9xdqZlwJbgUjuAgazZ+0NHqxsHOq/wYrHdWcfJc/c+2P8sOOMn1A9PylRYe2GR+/3CmpAS/V4U1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122899; c=relaxed/simple;
	bh=jIhUo9V3tSVI9WMdUsbzeNwLslv1pj42BTpio7cmgco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFai9y0SdJkcdCFJ2og5wrZIQwHUvUS997rIfab83laHMqMV3KmYFmgWKniCf130jeRA2SzavYvFSy+dkJshthATTHIw1zSz+9vSJUTNSvP5lCXqZwjDDZAal8mzJJKy9EjFJgybSu3hjIGFeiupr2FXMYZBXl1x7ueQDN+BtIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSiM83gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F03C2BBFC;
	Tue,  7 May 2024 23:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122898;
	bh=jIhUo9V3tSVI9WMdUsbzeNwLslv1pj42BTpio7cmgco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSiM83gqUvYbo1yhKCqPJDGswyEh0+VJqbNFGpYaneLWVjMEB70CFOO+xgNOxGwNW
	 wGBkiOyGif4TSF2saJup05v76l7J2RRz/IgfxemwhlAJUmK+ewbiRKWdrfyYwJQKJG
	 5XSUNCverputPI2gGKv8VUVAj4nJN5WJMLx6AKHKjzwhM8Ator6ZsT4x8BVpiEH12Q
	 QgoEGUS00KHbI6haBRhAUxIOXLSodFPZ4KizIyd13qvgBVju/lmaU0oQ/duLJgbsfg
	 nMUGr71VP8S9LnLBjDFfeVUFIWEBMOPunEQPDj5WOeqlx0lWX83r501Ua4D+DhhUgU
	 h7tDJYD65JyiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniele Palmas <dnlplm@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	bjorn@mork.no,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/3] net: usb: qmi_wwan: add Telit FN920C04 compositions
Date: Tue,  7 May 2024 19:01:29 -0400
Message-ID: <20240507230134.391850-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230134.391850-1-sashal@kernel.org>
References: <20240507230134.391850-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.216
Content-Transfer-Encoding: 8bit

From: Daniele Palmas <dnlplm@gmail.com>

[ Upstream commit 0b8fe5bd73249dc20be2e88a12041f8920797b59 ]

Add the following Telit FN920C04 compositions:

0x10a0: rmnet + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=03 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a0 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
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

0x10a4: rmnet + tty (AT) + tty (AT) + tty (diag)
T:  Bus=03 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a4 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=92c4c4d8
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

0x10a9: rmnet + tty (AT) + tty (diag) + DPL (data packet logging) + adb
T:  Bus=03 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#=  9 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a9 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
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
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 3d342908f57a0..6ca11a53c92a2 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1301,6 +1301,9 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1060, 2)},	/* Telit LN920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
-- 
2.43.0


