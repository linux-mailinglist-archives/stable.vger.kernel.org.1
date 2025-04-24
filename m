Return-Path: <stable+bounces-136601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F702A9B167
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3096F923A88
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECC19CC3E;
	Thu, 24 Apr 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="UiBzdblN"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F38612CDA5;
	Thu, 24 Apr 2025 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506029; cv=none; b=SZtTuGSqwSeOAgkazdEtnypL3/69ofMqk3HxtkQhuxOYTNhoOErzQf4z5QwhXFd/NB57g8E9yDgHbUINTtx3M9KUJDta7CYEyf/28xwV1YFYbylqWCzj63HIyMZeACtKL8115h5iy9JM3jx8q5AkD0R4mTIhfI4cFwp6DOlMraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506029; c=relaxed/simple;
	bh=Bn7qKgmVirMnL4HSoD6+ySbU242thJzaLTltDmOvM9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YOHyrghSLKMSGgPUJ9casVPkVL8lEYrVzGLY8Bd5cU663iCxks4Gv4GeaHbM7fZTqY2ElfuAV3H7cF8pX102Kh5d/9iKpVlZeO3elRVdPhJwD47DQndKt0J3N7/lNdEWzIsnCy5oG4j30KVKWt375MxVhn0jLlskUWCReFy46As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=UiBzdblN; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1745506020; x=1746110820; i=christian@heusel.eu;
	bh=BiYoI3t07zEC8MRuyXYTtYuABNrGYYjjjTp7cv/tN5k=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UiBzdblNx8SwoBGVxvk9jjILOoLWahs1kH+IM9Jg1GoFjDtyCk7d6VMXlArVRrCV
	 cImoPPph4TrSVxDGFE4IFj2DND54y/B6fE6KDxDealrOQ8kNrQq1/YvHSSPLMxZ9I
	 xyk6DtjWUJEpcJV3O9PZPKmD0QBFd0KESuAK0mAVObJyNaehAL43rmKHkIgsC6GQl
	 DAYR2elgIPK/3EdTRx5hyUD4BgpERUy+gRW35H43fpfG00yTsJNKg5kEuBpcJNqEu
	 JLz6g3bh9yLkh4i+UQrKViu6W8HiUfsubgDPrBUJ4K26vux5YRRwkMWJ0FCbbYIOV
	 QdVGVxbZY82aIH5o/Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.localdomain ([80.187.66.147]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7auL-1uBYB23HSf-0093Pm; Thu, 24 Apr 2025 16:01:06 +0200
From: Christian Heusel <christian@heusel.eu>
Date: Thu, 24 Apr 2025 16:00:28 +0200
Subject: [PATCH] Revert "rndis_host: Flag RNDIS modems as WWAN devices"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20250424-usb-tethering-fix-v1-1-b65cf97c740e@heusel.eu>
X-B4-Tracking: v=1; b=H4sIAPtDCmgC/x2MywqAIBAAf0X23ELZA+tXokPmpnux0Iog+veWj
 jMw80CmxJRhUA8kujjzFgWqQsES5ugJ2QmDLnVbNrrBM1s86AiSRY8r31j3pjPG1trNDqTbE4n
 +n+P0vh/8VO0nYwAAAA==
X-Change-ID: 20250424-usb-tethering-fix-398688b32dad
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, 
 Christian Heusel <christian@heusel.eu>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2318; i=christian@heusel.eu;
 h=from:subject:message-id; bh=uCmWJ08d3T6sqzruRhhWDBmrpAmhzZjpMdT+4kKwQso=;
 b=owEBbQKS/ZANAwAIAcBH1PMotSWFAcsmYgBoCkQYdLRPMzkf+QHfzbvX3tEyVNKkXCfmnJZ2b
 F3yPlBdc5+JAjMEAAEIAB0WIQRvd5reJHprig9yzBPAR9TzKLUlhQUCaApEGAAKCRDAR9TzKLUl
 hbkUEADVFJTdIYmV70vJOafWG6Q0MJ2+D744VIi72htiDZaU5KXXnhjhgcCkc7ERzzc6EPBdfvh
 fT0tSm0OSj5EmPxftgKRfnKpuSzgUf3JrqszWBjc3b1VS116beAeKyBSL3CDxn410Qgefxq6ONN
 Snx4HfR6mmQMdYskMAmBfXcnhZumZbOs6E79j4Rgo9aGyhn8e5br9Wjydvdaha6ofhalKG4/noI
 3V1sxjlLAtItMZN6x8K/Sw//g6oOpKeUarSXzINs2jE1KE+KM9iEL0ao23V7D/Abvx5j8uIOnsH
 Zd3XTbOumKO9MwGhRFcWscVXtTbwcwE4l08BvhjLrNQcx1CCXK4r1NDkqEvmCEQPkEs5gOCKe2s
 KcH2umRSOXY3MdEFn6MfOaswwA9qB3GYfklyjZJ5sFsZ7B/CYK5taj4ZBdF2B2mJN+n8ZZJNOTa
 GRQh2SZ5wcR4TfSt/UO8xGbvngKYeHzj1PVMBar79KJNDpwolwDF4Q12CUTfP0aPs2kCuWFaeTA
 qSq8esVlTmrAYmpstcqq5ggZHK12aTwAgzo137jYyjctXFMGjwAMeHZ2/tAEHRQKYF/x0xp1J8l
 rQvN2uVtySCduj5BGS8ibjNrLYHIy+QSEWgpYxK7DTRpQcR+TXmmojhXCma6F4AKINd9+Xit5sO
 aVMbYywjdZ0p1AQ==
X-Developer-Key: i=christian@heusel.eu; a=openpgp;
 fpr=6F779ADE247A6B8A0F72CC13C047D4F328B52585
X-Provags-ID: V03:K1:inbTguRCRiMzNvBapqeKfvNgoRAp4ykFIM+J2mJo0gamsw0VmE2
 SCWeqUtxg/rShR/rwfRc771bqCWDaQuMi2EiSCFU/1U7cbNqcuOcfj6n03OKFnTz8PoT3Xy
 cj3rVVGs0Lo8CPxQbCb3CxFRkiY/ojr9BH/QlvXlUFPFXIBABy3qJl/IsDYJqUiFt5Q2FTk
 /8AdAL1xp0bS9+MPHtEHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PflABPEdXXQ=;RPRrPH81t1zq5AQlBJjAPtNrmDf
 z1ri80UOQmYc4dRQUCwE5PDe/i4AuVyT68lf9t4FuUdxaA6OqAOMueSuojh8tubI4CHNBcRW7
 6jAjlC3xrBbdKpr26g06tMgBOivVL0NfE2FXD5NK5f4pUUFRSVczL34JXwwY2GsRLERxgRZvr
 Xwf0Jb6vgkwENptVDqO8r7I5CZBayJBwgfnRtdvarmas+9hzEMs8sNtBMRzvwyyUQadp95qQc
 ZjmGS9cHnh9nrzr/vfbCu5v1MNbbxhEawVbH+dNpjxl7A7hG6YUVXLGy7QjBP3XNDyC6JZnLu
 CoTVuxEs/3aLm+6vTqVhbTO2MyCNQqvbONprbOhfckBCsJ7fLHuNdMogxphtbiCUKJ4FhuDpc
 tfcbRormUhfG15NRrOY2pdX7iTXliAvZPdBOPJZfXehfsssLtv7VrQNcKtkecnKxc6gH2ivFd
 DY1XrrOMyEJcVCZf6lZGyXr5BrI3xbSvCkWUwCOPHugWzsrNtLrTyw8xO9v6HJNpCx7DH4ayd
 yKtxvKjcXLrUkyCrQoULoM2CGNamwCtEXdvpUDCfonqww/ED4jio9nURsWRRkBjcbzebweZ0H
 /qYqskUX9VQpXLidBVBZhdirQLm5Ex049Vb50Iv+8w5fxCoWx7uMi0hRhJxKoRsu5//Zqp3/x
 hYJMaVFao/MPUPXdId7ujlm48QFsxT7ALMXmTJtMy+1MHBoJ+u8FB12OXdmQ1lsvjoEqxb/TL
 8ix9TaULacjJ7hw+sWq3GDtHmZMwH81/ekfIA1SkbmwJ88ixv7HJ2Bq5H8aurUKBGDWK5s20y
 yfrbNkEKuhlzI3Lqa/ZSTjYEJy6i/hT0DAY2xznOO4kLF5BgbJQQ38Cl+xq7Rl/0IEJmAwkKm
 eLGCYYpUt3vXzKKMhh7eGl0j7i1uFHzfcLm0AG+6e6yAxmm0M+C/THAZg2GxZGqcowO4p2IF7
 wsBJShEbeaBWPmfd9Jy+MJtMYboksE+8moo2SUTuPyzBFwvQFBHRNChAmt+vKXlVbw+wG3wPS
 1GxyDcFvAk2QbjjiTIm2pG9hrUHCLkzyXZ2COmHf787pNwXQO3oP+2w2DKA8xKxaNveeozQEo
 ebEriHEf+7+pL2Ih0kZmk5xvpRh3GBw4FNf7WdP6z8NGsOL+fv0HdGFDtHWH4PsYq3ww/Co5i
 CDbZuHM40lxEAIeMWLr8XzPzMzxW5GW5l/3a8Ol3TZucCEEmcI571WTcuG9Or5Jrl8BGvP/dy
 93ZYovJGafW889NA9VXP4Gvp9hJITNjbnLnjxMrF9UePt8x5PiIGgyBmFrNUHieqWpUZe06No
 /q3t2GI+gAXepIrMOGveVwcKBQrjL7+gTtItIBFrZXs94+JSNsSP78Gf3Hce63EOyIYWsKe4R
 33jLZG0aF7F35D1DYAYsjHW+kq43b0ci7QzcE=

This reverts commit 67d1a8956d2d62fe6b4c13ebabb57806098511d8. Since this
commit has been proven to be problematic for the setup of USB-tethered
ethernet connections and the related breakage is very noticeable for
users it should be reverted until a fixed version of the change can be
rolled out.

Closes: https://lore.kernel.org/all/e0df2d85-1296-4317-b717-bd757e3ab928@h=
eusel.eu/
Link: https://chaos.social/@gromit/114377862699921553
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220002
Link: https://bugs.gentoo.org/953555
Link: https://bbs.archlinux.org/viewtopic.php?id=3D304892
Cc: stable@vger.kernel.org
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Christian Heusel <christian@heusel.eu>
=2D--
 drivers/net/usb/rndis_host.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index bb0bf1415872745aea177ce0ba7d6eb578cb4a47..7b3739b29c8f72b7b108c5f4ae=
11fdfcf243237d 100644
=2D-- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -630,16 +630,6 @@ static const struct driver_info	zte_rndis_info =3D {
 	.tx_fixup =3D	rndis_tx_fixup,
 };
=20
-static const struct driver_info	wwan_rndis_info =3D {
-	.description =3D	"Mobile Broadband RNDIS device",
-	.flags =3D	FLAG_WWAN | FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SET=
INT,
-	.bind =3D		rndis_bind,
-	.unbind =3D	rndis_unbind,
-	.status =3D	rndis_status,
-	.rx_fixup =3D	rndis_rx_fixup,
-	.tx_fixup =3D	rndis_tx_fixup,
-};
-
 /*-----------------------------------------------------------------------=
=2D-*/
=20
 static const struct usb_device_id	products [] =3D {
@@ -676,11 +666,9 @@ static const struct usb_device_id	products [] =3D {
 	USB_INTERFACE_INFO(USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
 	.driver_info =3D (unsigned long) &rndis_info,
 }, {
-	/* Mobile Broadband Modem, seen in Novatel Verizon USB730L and
-	 * Telit FN990A (RNDIS)
-	 */
+	/* Novatel Verizon USB730L */
 	USB_INTERFACE_INFO(USB_CLASS_MISC, 4, 1),
-	.driver_info =3D (unsigned long)&wwan_rndis_info,
+	.driver_info =3D (unsigned long) &rndis_info,
 },
 	{ },		// END
 };

=2D--
base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
change-id: 20250424-usb-tethering-fix-398688b32dad

Best regards,
=2D-=20
Christian Heusel <christian@heusel.eu>


