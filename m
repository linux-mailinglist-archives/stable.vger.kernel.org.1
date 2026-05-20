Return-Path: <stable+bounces-249886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE5NCNKdDWoS0AUAu9opvQ
	(envelope-from <stable+bounces-249886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:41:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 961F258CC56
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A7C8330B7D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5873DBD64;
	Wed, 20 May 2026 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R7OCIv+c"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2843DBD49
	for <stable@vger.kernel.org>; Wed, 20 May 2026 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276514; cv=none; b=Tk8aRNKha56GceEaJtD96RVWAdutPd6aSjfWuUmBiT4+YiIA/IUHv/lmGYgBfGmL2Ka/mrehfXWZf9zkTGScXhNpEbeea/0tbNF8RSaFozQ1QuAqCeUW8MowBLUyiVhK6nsVM0dp2oNM/k5BWSUKapWfk1fAt1405d7BoD/Dpno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276514; c=relaxed/simple;
	bh=wHGYDSWFEv/maEkL2rhNe2j3zUzQpXpWf1PfSV6DbwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEIt3A0B1IrG0bGDYZqgpa1nCna0snxuhBP54rjMMyExH9FVfYBtiIrqrv6Wfv+cjl7d1PWDO6d5klFSe4cHC8/nos1I83cYA7rTC8RJyRoK/2bCavT1FBNhnhyRRxXOYKsXFyyuYfGW0tCWdVZRZd4zdv1fygii/fjyC5LSlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R7OCIv+c; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tr
	G1ev+LTclCM3i1X6Y5RncqO4cd7XBJ58hJpIXPk1Q=; b=R7OCIv+csUGt8xGzae
	+oG+5NWklqJ1XdEN0m/3Ch0KmM2PF1rvgEXU+vQEZ9k0tbzWODDZmZHKqvOVRTiH
	O8Wpw4Q9pmo4a39xkhzCpqNMn1X4vNx/0/M43ARZdIPiDUGegsk7aCAHEXBFV//W
	6XFm/ZiojDCaWfK7aTa0vXyOc=
Received: from GHT-5854251031.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3b3vUmg1q+ejSCQ--.65350S2;
	Wed, 20 May 2026 19:28:20 +0800 (CST)
From: zwq2226404116@163.com
To: zwq2226404116@163.com
Cc: Wanquan Zhong <wanquan.zhong@fibocom.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/1] USB: serial: option: add missing RSVD(5) flag for Rolling RW135R-GL
Date: Wed, 20 May 2026 19:28:18 +0800
Message-ID: <20260520112818.304890-1-zwq2226404116@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b3vUmg1q+ejSCQ--.65350S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFyUtFWxXr48Xw4DCw4xtFb_yoWxJr4xpF
	4rJaySvrWkXFy8XFnxCr1fZFWFgas29r17A3WUZw4SgFZayrs7Kr1UA34SgFnFkr4FkrsF
	qa98K3y8Ka4kJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUa2NAUUUUU=
X-CM-SenderInfo: h2ztjjaswuikqrrwqiywtou0bp/xtbC8xS5EWoNmtRPkQAA34
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249886-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zwq2226404116@163.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fibocom.com:email]
X-Rspamd-Queue-Id: 961F258CC56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wanquan Zhong <wanquan.zhong@fibocom.com>

The RW135R-GL entry added in commit 01e8d0f74222 ("USB: serial: option:
add support for Rolling Wireless RW135R-GL") was missing the
.driver_info = RSVD(5) flag used by other Rolling Wireless MBIM laptop
modules (e.g. RW135-GL and RW350-GL).

Without this flag, the option driver incorrectly binds to the reserved
ADB interface (If#5) in multi-interface USB modes, causing AT/MBIM
communication failures after mode switching. This matches the handling
of other Rolling Wireless MBIM devices.

- VID:PID 33f8:1003, RW135R-GL for laptop debug M.2 cards (with MBIM
  interface for Linux/Chrome OS)

  0x1003: mbim, diag, AT, pipe

  Here are the outputs of usb-devices:

T:  Bus=03 Lev=01 Prnt=01 Port=04 Cnt=02 Dev#=  8 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=33f8 ProdID=1003 Rev= 5.15
S:  Manufacturer=Rolling Wireless S.a.r.l.
S:  Product=Rolling RW135R-GL Module
S:  SerialNumber=12345678
C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

- VID:PID 33f8:1003, RW135R-GL for laptop debug M.2 cards (with MBIM
  interface for Linux/Chrome OS)

  0x1003: mbim, diag, AT, ADB, pipe

  Here are the outputs of usb-devices:

T:  Bus=03 Lev=01 Prnt=01 Port=04 Cnt=02 Dev#=  7 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=33f8 ProdID=1003 Rev= 5.15
S:  Manufacturer=Rolling Wireless S.a.r.l.
S:  Product=Rolling RW135R-GL Module
S:  SerialNumber=12345678
C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

- VID:PID 33f8:1003, RW135R-GL for laptop debug M.2 cards (with MBIM
  interface for Linux/Chrome OS)

  0x1003: mbim, pipe

  Here are the outputs of usb-devices:

T:  Bus=03 Lev=01 Prnt=01 Port=04 Cnt=02 Dev#=  9 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=33f8 ProdID=1003 Rev= 5.15
S:  Manufacturer=Rolling Wireless S.a.r.l.
S:  Product=Rolling RW135R-GL Module
S:  SerialNumber=12345678
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Fixes: 01e8d0f74222 ("USB: serial: option: add support for Rolling Wireless RW135R-GL")
Signed-off-by: Wanquan Zhong <wanquan.zhong@fibocom.com>
Cc: stable@vger.kernel.org
---
v4 -> v5: Use 12-char commit id and correct Fixes tag summary; move
changelog below --- separator; restore usb-devices output
v3 -> v4: Device table entry formatting aligned with existing pattern
---
 drivers/usb/serial/option.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index c71461893d20..dfec7467b36c 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2466,7 +2466,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0302, 0xff) },			/* Rolling RW101R-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0802, 0xff),			/* Rolling RW350-GL (laptop MBIM) */
 	  .driver_info = RSVD(5) },
-	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x1003, 0xff) },			/* Rolling RW135R-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x1003, 0xff),			/* Rolling RW135R-GL (laptop MBIM) */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Global */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x40) },
-- 
2.43.0


