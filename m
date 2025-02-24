Return-Path: <stable+bounces-118714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D9DA4176B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 09:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1AE188FB3B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CA017BEBF;
	Mon, 24 Feb 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="MKQ4f10o"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F61282EE;
	Mon, 24 Feb 2025 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386014; cv=none; b=FcLow8glTy0qh6sd6tscoM5xeDckl/HHkoMoyMSYuffsI0lluWGJe3e4Oo4k4NWuS63jTIkCqIKBbL9gwxtTAWRhN8lW2e6++gFyczXjj2ra3LvWIWcfEYZpc3o+9lBFu5DQjYINTyEy8XBtOEVqCxi3do3CPt83/Wa4iGTV0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386014; c=relaxed/simple;
	bh=NuzFwxtYdesIophLu0YyccS/I+GnQ6AvcugdwLFq/CY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=skZ7QAyT12fWWQzpQeYivuBky9BomC38KJqJ3ejffbpPYJKoh+I7/MziHbKL9IscW9Pp6aCCJeH1vfp0cHdFb6UFKgPHxsqNJ2ED2NyPi0+KZYA9eLN3gkxRXhyZbS3iu9krqPsSzEidPneaDEwyGuV7gm7kdgd8EKx45K6C5Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=MKQ4f10o; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1740385999; x=1740990799; i=christian@heusel.eu;
	bh=KgVRmiwCVReVwWRPkj4/Qyf0OtRG7F/ydIgzOByr4Zg=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MKQ4f10o3LW3TDhCKde2QqP1N9krMOy4d6v3C8hnb2NY2GdimkmYeTA8ejbugU7Z
	 p7PvEhQGiCMHE1/CdQfJ5MV4ga2CxjEdXVwhg9zu79gBVMEp+apFyDRIucvzctAZL
	 pkqgfx5MxMLGh0Hv0sAdrC7PV6tUY3Hy+TdspiC0tZBsl7wfSpnqy2LQ1Lx7hmVJw
	 +/V+WwWw5Ww5qlWkC5fdp+hRSaeR2TZn41B2/1dQsaYAd0Lmkd6pT9ZtY+wzy3pjx
	 052oKejQySj6CN1vXvRCZKpqe3e+L+8T9Qwu9dRm3XXQQxIUByqu/WMAODpbqMF/o
	 sK/n3fDlNiuMyvJb+A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.localdomain ([141.70.80.5]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MKbwg-1u0pt52sMm-00IAck; Mon, 24 Feb 2025 09:33:19 +0100
From: Christian Heusel <christian@heusel.eu>
Date: Mon, 24 Feb 2025 09:32:59 +0100
Subject: [PATCH] Revert "drivers/card_reader/rtsx_usb: Restore interrupt
 based detection"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20250224-revert-sdcard-patch-v1-1-d1a457fbb796@heusel.eu>
X-B4-Tracking: v=1; b=H4sIALouvGcC/x2MQQqAMAzAviI9W9C5ofgV8VDWTntR6UQE8e8Oj
 4EkD2QxlQxj9YDJpVn3rUBbVxBX2hZB5cLgGhca5zwWSezEzJGM8aAzrph66n3o2PNAUMrDJOn
 9X6f5fT/NpgpWZQAAAA==
X-Change-ID: 20250224-revert-sdcard-patch-f7a7453d4d8a
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sean Rhodes <sean@starlabs.systems>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
 stable@vger.kernel.org, qf <quintafeira@tutanota.com>, 
 Christian Heusel <christian@heusel.eu>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053; i=christian@heusel.eu;
 h=from:subject:message-id; bh=V6xy3xipLArMKiCyA2z7lBLNfypg99krUJnGZrY8h+I=;
 b=owEBbQKS/ZANAwAIAcBH1PMotSWFAcsmYgBnvC7OCYTL/0VjTDcElDQJfiRhKcbn1dx/CiwaL
 403m0uA7hCJAjMEAAEIAB0WIQRvd5reJHprig9yzBPAR9TzKLUlhQUCZ7wuzgAKCRDAR9TzKLUl
 hawaD/9jUFBJsEKllhjaSIqOJBKKamQgve1ikyxMX6hcCnXDV8Vq2Ff6B90v6+ndhrQ7ecsbB4V
 HkV2Do7Z0GSwdeGlKYpQlTTgzFQ2ZKkmu9CRp93l95aU9KYiHuq/ESIt/XzYn4p2zn/qAqfWfUU
 fZN70LLjeMOzayDqOIhjRB8yU7LgpoaoHTreOqRsZ5B8jMmasvwdyDUfL0qaPbErRxaEa0XdYaZ
 +z8i4V90UJx6xRlF4xeA2F6XQPtthcWjt+uLMOUV/6xCr6pWClw10Hiwf9l29/g4ac0L1pSNwU4
 909bhNvTWbCp63PHaIipjEmbgBPGpdWcSRm5ZYiNTQEHbYBMwghPcFoOh3BaaBreove/QRJjdwQ
 u1SKx3bUPS6+R++yzwOUh9jw2ha1Mx978GSOLlj/Zc09LGmubPqAqyXNTBTdKt0ER1Q2vBdUaGr
 We3PaeXGneeu4rNUtl18bdXER6cej9Qm7m7wha0RYwJ5C/8TDe5ISaLjioFdL+XQgQtHTiUeZOo
 +tnnQEJ5zbWTQVDsIJKkD6LjmIVUJBK0KYtex1UotLUL+XLivKt6MNKgw0b/9kgBvejdrO3pjpZ
 1w3MLogwZZzpRrdBzP50EviUPLy2Gg9TyyZFjJiR8w7noMU1tLIZP+jzzh+5xO4RxDUUgkg4y7p
 iK8cVvKf59/Y48Q==
X-Developer-Key: i=christian@heusel.eu; a=openpgp;
 fpr=6F779ADE247A6B8A0F72CC13C047D4F328B52585
X-Provags-ID: V03:K1:cP2vEgXYL7A+FBvrgir/UoCCcxPcVF0N/v2xJTZcaZYFbB/xvbr
 YB9ao8B5gUrn6wvpi1UUghABvbsM545vww4HgRKKMnaDvF094vmJTJxzecfrpd51z54W6ml
 uIWvRsqEeLwSLm0059jgw5m5a+5avCDtBLyw+X9ZnXJdJjjf9NnVajSyGsdC647DE79shag
 nfviVGBRMYte/Kx0PablQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LCklwuAw0Og=;ONA//bQGGaAuhUAPERHOSf42mu/
 hRYNn/tAxtgVGymKS8O/oIkWMjtoQcEKVhrbcf2U4A1ADynEziksTelACTsPhoynjGZnJhOel
 GPrMNhbLXm3T0pXPP350sc+k01jgxmUvc7CS5iDH+H8ZMjt8oswxIG9yTwewzfb4cI7VhxlF4
 Yl3YKMSB2LSmDcnZq9j4Kvrx2PVQNMFOeveTLSybZ1V9b+62pcM3nAF2qB+6XcvC4q+TssEm7
 5UDFRHL+jrwhXJaOp5Cxg2WQ7DjE4jKalHpg/c/+zeui03X7yPY4Xvln7ls03qeKoX9Qiv8AT
 qpVZrIT3fwpgRbUB+kYxCOO2brMrRAbH9z1yUgOyNUJE5FvcMCmWDk8jxwa8v4gdZHU7KsBe0
 MZ/3/UUE6Hut1xKlT4I41sqJ9A0fG/7H5ZXL0qfp1yo0KfeUHBB7mMcX8grfxOJpBWWrOrWTq
 0WSPMvekLnFtcJVujC8kDy4KLW5Zi2IClrFJmgaQeojOo8fHftgEFb/EMjptLkFaQgWiIGREo
 or+1Xr42tR//amT+BJy5nYfoO5pM23OQYlRFeWcYOqOrAax75zZRLDkA71bb8P7+gYBAjBMmM
 tcdbHyCQa46TTJ5oqcX3wx0ufpSjEuGgmkdj7Fiw0sNIRibx/IWHD21dFjQFTSBFvD/bLLMXr
 yO5DfvZleYAfxDD5BAVOFSUpOf1kqFL8Qt0tQp4MaxA2O1NRH6fMCgBz+1fjVOZq4sHiypQxo
 VmP3TdDAP/lV3WyXt5uYjKSOniBLEnusk73PInuxX1lNmJyk6k6A5/iwgNQSrRwhmdA8T6U0e
 fp/ZhzcFEjGYK/eVj6vPw/co9Uqvr23ASVdRqUWsBrOEtJk9nPO4hEjCRrqflzqclUXWl5Y8i
 K27cZZ8GYzoQaTTqUWoqTMIqLr6ndSTyTu5YkcZix4XLVWNWxr5vX1K6RhdRvTXM0+bnPn50J
 9IproCwRdmCsjpbrJRaR9+Z9xprsiT4KPSTXyjKL2Xark62tt2PkwXQECh8CLBolutHC5kgxq
 46tsJ/tZaA6CUYhn1OMNHgMzzp5Rw+nwSamy83I/2nmvobfmi/DIinAuNq0QZpciLjWHpVUfD
 vx1QH6T+bvdbQ8/ZZkmrjyPaASSemkJFBMdyNEC5ZahtqmaZ1qrMSOjJ/dheG9CJKfdExK99h
 7Ekmm9XzJcBRNgjET84PNxwQHS9humwgp/+6AAEez5A2yKidbbwRkd43XFn3PI2FCFh02YaDK
 sFcuAHtNtojLObgMXG2RXEMFt0YKcIEXmVGkDuOPSomedxzjWEvnGNjjSdpmoUS1w/1r9EUux
 F5L2F/IKeOY+GSlfvfAGmpyXUcsk/n+5gbYu0sBNUXu6omsj/2EQK4i8MKEJFqtCtfX9X0eHj
 PdKmXWgDGt/StOvKgfGYNwWwt/CTWdVgMHASg=

This reverts commit 235b630eda072d7e7b102ab346d6b8a2c028a772.

This commit was found responsible for issues with SD card recognition,
as users had to re-insert their cards in the readers and wait for a
while. As for some people the SD card was involved in the boot process
it also caused boot failures.

Cc: stable@vger.kernel.org
Link: https://bbs.archlinux.org/viewtopic.php?id=3D303321
Fixes: 235b630eda07 ("drivers/card_reader/rtsx_usb: Restore interrupt base=
d detection")
Reported-by: qf <quintafeira@tutanota.com>
Closes: https://lore.kernel.org/all/1de87dfa-1e81-45b7-8dcb-ad86c21d5352@h=
eusel.eu
Signed-off-by: Christian Heusel <christian@heusel.eu>
=2D--
 drivers/misc/cardreader/rtsx_usb.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/=
rtsx_usb.c
index e0174da5e9fc39ae96b70ce70d57a87dfaa2ebdb..77b0490a1b38d79134d48020bd=
49a9fa6f0df967 100644
=2D-- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -286,7 +286,6 @@ static int rtsx_usb_get_status_with_bulk(struct rtsx_u=
cr *ucr, u16 *status)
 int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 {
 	int ret;
-	u8 interrupt_val =3D 0;
 	u16 *buf;

 	if (!status)
@@ -309,20 +308,6 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u1=
6 *status)
 		ret =3D rtsx_usb_get_status_with_bulk(ucr, status);
 	}

-	rtsx_usb_read_register(ucr, CARD_INT_PEND, &interrupt_val);
-	/* Cross check presence with interrupts */
-	if (*status & XD_CD)
-		if (!(interrupt_val & XD_INT))
-			*status &=3D ~XD_CD;
-
-	if (*status & SD_CD)
-		if (!(interrupt_val & SD_INT))
-			*status &=3D ~SD_CD;
-
-	if (*status & MS_CD)
-		if (!(interrupt_val & MS_INT))
-			*status &=3D ~MS_CD;
-
 	/* usb_control_msg may return positive when success */
 	if (ret < 0)
 		return ret;

=2D--
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250224-revert-sdcard-patch-f7a7453d4d8a

Best regards,
=2D-
Christian Heusel <christian@heusel.eu>


