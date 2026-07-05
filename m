Return-Path: <stable+bounces-272030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f/IbGiolSmoF+wAAu9opvQ
	(envelope-from <stable+bounces-272030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 11:34:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB359709967
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 11:34:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=online.de header.s=s42582890 header.b=VvgJfMgO;
	dmarc=pass (policy=none) header.from=online.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272030-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272030-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EABB73011BCC
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 09:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD06331A4C;
	Sun,  5 Jul 2026 09:34:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C912FF69;
	Sun,  5 Jul 2026 09:34:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783244067; cv=none; b=s6jacHrbkJR9g5+VOdRHjQgw4GzVne+Ptq/tv/5JsyzUKoJdQUw+Pe5M5jgIw1oTK0DF+NBsx4fZRG00LOrft3LMthn4ET343929sQ1MyLlhUGye89TKC0YuZBCHXj6B6jw1m3z3ttGKJGge/nro9WJj3D/Zx6ZFR7tLpXN8Gso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783244067; c=relaxed/simple;
	bh=yXfnUSlfgW8h+/ebbCX+cHsY9xUISQDbp6WhSQpakL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF3QJlUrYN0/F60757T2Vx9/kkV4PGXiyDKNMB/11A4tqe14tA+P+CAbnGqtQLILAXkQdx+E49i3LaUxD3ZXPcisJRyJ370ccUxwaRUnBdfoz5iq1CyC/0Oc24Xh06SliKPJ1V0opio9gokFwqLsvz20oT5cjo/uUgTkmiFlRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=cito@online.de header.b=VvgJfMgO; arc=none smtp.client-ip=212.227.126.130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1783244063; x=1783848863; i=cito@online.de;
	bh=3pb54LRDTSM6BHVclrZA0GnAxIdFQllfs38Z+oxs7SY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VvgJfMgOZIyM+RvWoj5oJFG7ppf0dER1rY8KbuEu102YnXffqQO0Lm3id1i38Lqd
	 kIseaY16mnToApYQKa5B4BUvg01VVe+rekyei0CAJKoh6ep5/sjMCZxqRQZ52TLY1
	 uYTiHN/EK0zp8rC7MFAAzScatxmBO19t71GrEYPLTXxlml0JkYfCWX/4ZXBpjn2ma
	 9fwFELv/rMoLkMKLwuR+E90xDmrPImMjyvE4phKUT0wQK6ZMQaZ4Qt3++NsM3SOKs
	 gcAuETFqQ41QZsB6/aeM3xJuSh7NfzlHhYpR6UjW2mImPHGzsUpwc89FapFiSFCDY
	 eR6JhcWzwcS0zymz5Q==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MZkxj-1wcmla36pT-00TRrQ; Sun, 05
 Jul 2026 11:29:05 +0200
From: cito@online.de
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Christoph Zwerschke <cito@online.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU
Date: Sun,  5 Jul 2026 11:28:56 +0200
Message-ID: <20260705092857.27050-2-cito@online.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704231312.340274-1-cito@online.de>
References: <20260704231312.340274-1-cito@online.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Y2C078dbLzUplkGwj/StfQPs29Lr7oOl6ieE99t7kX5TUTokOy
 gn0Pe1EdQtQf/++bLpQk87zm2p6LvntFlXRWjU4ODfOCAYA78GO6ExHJTzkLWijo6uFY0Aw
 qevgAwXjB6PQF4dpiht/blOCm99kMYEO/rh16WVSjmPpQLZWGnzyu1x8siKw4o1SgSEPt2p
 aaHMTb3OooXGQGWbfATwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rv7MLk/UDlw=;e4VZkK24v8dwO8965z72Nbe2LAh
 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
 PfK9Tq7g==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[online.de,none];
	R_DKIM_ALLOW(-0.20)[online.de:s=s42582890];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272030-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-bluetooth@vger.kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:linux-kernel@vger.kernel.org,m:cito@online.de,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cito@online.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org,online.de];
	DKIM_TRACE(0.00)[online.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cito@online.de,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[online.de:from_mime,online.de:email,online.de:mid,online.de:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB359709967

From: Christoph Zwerschke <cito@online.de>

Add the vendor/product ID (0x0b05, 0x1bef) to the usb_device_id table for
the Realtek RTL8761CU-based ASUS USB-BT540 adapter. It binds via the
generic Bluetooth class today, so BTUSB_REALTEK is never set and the
rtl8761cu firmware is not loaded, leaving the controller non-functional.
With the entry the driver loads rtl_bt/rtl8761cu_fw.bin (already shipped b=
y
linux-firmware) and the adapter works (tested: A2DP and ASHA).

Similar to commit bc597f0cc44f
("Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV").

Device info from /sys/kernel/debug/usb/devices:

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D 22 Spd=3D12   M=
xCh=3D 0
D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0b05 ProdID=3D1bef Rev=3D 2.00
S:  Manufacturer=3DRealtek
S:  Product=3DBluetooth Controller
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms

Cc: stable@vger.kernel.org
Signed-off-by: Christoph Zwerschke <cito@online.de>
=2D--
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e9b0b1dcc1d1..c15c7ab5bd2e 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -856,6 +856,10 @@ static const struct usb_device_id quirks_table[] =3D =
{
 	{ USB_DEVICE(0x37ad, 0x0600), .driver_info =3D BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
=20
+	/* Additional Realtek 8761CU Bluetooth devices */
+	{ USB_DEVICE(0x0b05, 0x1bef), .driver_info =3D BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info =3D BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info =3D BTUSB_REALTEK },
=2D-=20
2.55.0


