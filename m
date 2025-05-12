Return-Path: <stable+bounces-144025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF4FAB4587
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 22:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DB619E67D5
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA32E297125;
	Mon, 12 May 2025 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="xGAtQcr2"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24FF1B6CF1;
	Mon, 12 May 2025 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747082250; cv=none; b=Sc7gjiOuCeq69Z7ZFNTyJYm4ga8RCq8X20vH9vLLrOBpVhMUQ2njTOy3SkWbr01vn12c8GUfwSP6zbYt1Gj611ltLNa/uCcKefn1up6dDd5MZz/F28pJ7NaaoJ3SHEAoVtlkbeOUt2tL81jiGd/T93hbQp6KZrqQ35kzhcoKtRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747082250; c=relaxed/simple;
	bh=Jnbhu+3zpTMBTqhYWevRyYw6xUl7YSnfNgdoVlvygmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RFn0smFk3QCq3g5xnFRqJWa5Sr1VNjMBo87LtvHf+oHBhfSO/mDc98Xswx1JNnptONU47G+gpsVOhQomftcBykYoaQnVugujUWkcKDtn2CR+vIcRaNeO8rNBeS5WF10m8JBdJzpFklCHKxXnmX+rBuoO4DTbncB14l0Ot2cRhLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=xGAtQcr2; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1747082245; x=1747687045; i=christian@heusel.eu;
	bh=v5IPjjPdS4AX/054+2XWNWZoam2uEJChhCqsehtFEcc=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=xGAtQcr2blQh9ZKWRIofwcFetiyxmjpHGr1I6d23foOIjhzbrTF4s9fGfsWGJ917
	 jFvhYx52dnFHr3M1eBoaS2GVq1Ql0KELA6PUy2lkLAdGti3P1KKC8ps3OL/yghpTt
	 LFdasN6um/7McWXhGQy4/DztQNOw+vx21ZQyKCXS1miQGo5FYRlJWzgAkIjXCwVSi
	 AyYIuzlGYSwK+3/HLbTuQzqiX4uF24SWuIm3h4ZOkzgo6OMy59935n3pSm1Jb/Nce
	 YTLO7GRiGxuiJ/jyjevc5E+80TtRq3jyUItOEATmXwn6WFRJtCXn9V6DGBqIf9Pdj
	 PKNBXz00BEfn3AIkmQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.localdomain ([89.244.90.40]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNtGq-1ucg7f47I0-00UEIt; Mon, 12 May 2025 22:24:12 +0200
From: Christian Heusel <christian@heusel.eu>
Date: Mon, 12 May 2025 22:23:37 +0200
Subject: [PATCH] ALSA: usb-audio: Add sample rate quirk for Audioengine D1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20250512-audioengine-quirk-addition-v1-1-4c370af6eff7@heusel.eu>
X-B4-Tracking: v=1; b=H4sIAMhYImgC/x3MQQqAIBBG4avErBtIwYquEi1Ep/oJrLQiiO6et
 PwW7z2UJEISdcVDUS4krCFDlQW52YZJGD6bdKVNZZRme3qsEiYE4f1EXNh6jyNn3KhWatfWVjt
 HebBFGXH/83543w/8U/gObAAAAA==
X-Change-ID: 20250512-audioengine-quirk-addition-718e6c86a2cc
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Christian Heusel <christian@heusel.eu>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=christian@heusel.eu;
 h=from:subject:message-id; bh=T9nyqPOg2vRW5mnTPvD+UoZUWmgIkXbcc2Hb0EE8f7Q=;
 b=owEBbQKS/ZANAwAIAcBH1PMotSWFAcsmYgBoIljhEuX+ZbwJp5mNldpSXNG31Ogx3W9URffKQ
 mmuo9yXpDGJAjMEAAEIAB0WIQRvd5reJHprig9yzBPAR9TzKLUlhQUCaCJY4QAKCRDAR9TzKLUl
 hWj7D/4yaYeUzOtd1rmbaZCWY/HA9EUntN7fjTblqHu3Sn9ocKfV3K3DETws9yiEj2+joXJ3dvl
 ZgWDvKcniPT6VkE/KUywU7sWpwwLjbqiX1Udqs8g7cPz6mWUx8+ybAYBjUYixKcBZQ1f/hhvvd/
 ehnlP0BH2fOSnpWDuqOAQZYwjOQa18QG8cgnLX75qvg8E9Gk+ScuMjL38J75Kfx3SNAGBTxJiZB
 +nJPa1UKqxRvJoNLDTCze4tseS59f+miYSICcIGdHL07T0ptU1ZXzNnuxPCjGiUglTSZd/3YOUE
 SkZ3wox7OXs90JxvrBsMPk44sNMeX8QX6oT9QSBJxbtHZgHJrV1JfxwQL4ZJ0+HgUmeMd8L3WTp
 55Zzq9+Hl9FoMjeRtQcbCqwD6GaL36pTKw8vDrFaoDbW1M4kvkd26NSAHAvWFyehfqqcRy/ivoJ
 Q0MKYbQDZTO3pVFqaBVIfEeChZRwaz86NSAT4wFinRV4TlxcsbJ9/JbYAz7MhcObqnKFqY5oYZC
 5dVgt/AkhUxt2szo+W8ilVsl4JqqRYN0y4tAir6Ukp4fonYVqcJggMBl3DtcgAJoI0n7DmpB03H
 2wvgkJX6Jvxvz0Irxe2s3joeAA2v4wR8CXd8WvusiVcO2RwT4KR0cljXyQss/gXC+UVQ5/7ivJQ
 EdoirFaE9iqVl1A==
X-Developer-Key: i=christian@heusel.eu; a=openpgp;
 fpr=6F779ADE247A6B8A0F72CC13C047D4F328B52585
X-Provags-ID: V03:K1:r8gcN1SJNqU2hfw9rpVP9dmQjgonF9wWrAaxjZinHlO8OVGHD1q
 riFc/XpBp5PUm5fjg09BmSOwsifudYg0xSw6QHB2qPd0YkxITE1bBC4QmUhAuL4OD06Hi6J
 20MEU52wKtudEsu9ssppGaC8FLYob4PgsZAyrnarCX0h8IL1BTntg1aTr0W6bP0uuZOBsCB
 wkzZ0TfVTTRecrhe1uFNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PhcBKGKJ6Is=;TjiN0bfpIoCVwFhSucg1BiU4x2K
 V7aaJkd/JyqT8em96jir+tfgSef+fMrsGyRayLvkmJGdXzyRGFdKi0KlDRbCsJTO3fdmLKNE6
 cHdDS20qxNisFTw3GXK17o86QeTgmaqvxmYSc2WARAbSo82Wt5wLQwssmBXexmobxenSSU8CZ
 1Dk9dR7hbuUcpR5ho/zIrklCtkubSog0d2LGN2eC24piWdWCkAFvBzqibd+IqZn7pLZcs5C03
 8h1hSM0a4OK75UPk+vQj1Q8ebJ1E4sc8T7ZDYS/6LLqhidOhPurVIV+FYCmmi5KFEtttThtwN
 eCc0vJiZNrujR0XdU8cHbLkidR8ThR2KMMwC1sR8ot+Ku6dIwme0myK8xcJcw1KeuCwnb0mcO
 crbwq2G9JOPqlcbi0sqaNUuZszLSL6or624WOCr30bl+TytMg6Ygkr+XYKcz82wCN1AuezdnX
 Ivlk+dIKxErThGZCdpvEkQqWWx34eW3hHMaceiMvWJ99ywFpVgo6eeEKsucp11BYMdysWIkkE
 KXEfavVCjiRQyYpjYq0iIB935Z7n2hmLpNg26pETRLm04XG4V40I1r2MqLIpsk/l8Y8kI6fJZ
 WR8W5/W3xCAlX96CvH/46OVebE/DlFOU9NLH3/vBQQzpewVTuNNjZNj6HCjV1NvJZp1avPtgx
 PKkub2tN7Jrmft0jSQzRbka8d7xXRT3fP8MUB1wMKKpUNLtDFRKTXIHhAyTHU7kgUpM79nI5d
 kjbMNfGIB0OAo20vYJG0yKpP6wTNGVX8nwvfB2LdiOZLp9yAIr63ZeqAii3aneHUlft8f3VP+
 Nuv2Xq7U66Omg4szXYmcw3hWU3NKWQ8z/l+EVrEbhDY713DsKwJpKH0rNdkcZybhScOnjPhMf
 cR8sJDJ6/lBsZvvAG0vTAJ9G6suhOnU7tV5iPYuMFbf19nMwwUyF3isf23vpzKp4Wd0dWIzdR
 E+DtyQTTOySP2HI2G/b8LAZl1uE6GEV/Kp+AjgnS6feDlVs2zHxD+C7Y3I7aWPUJahOBpG0Wu
 EFU4/koP4ig8/6lLZaj4djFuLWhi9roZjLUh4zkrgYeZVJ4RGpFhtfiu0ehIkSBAYGPdiCRmV
 qbRfOxrDKL5NgvaBUJ9+/XtBuKp6wdFeTFXb1fWiwDzHVsoPaDpa4kgmQD0WG8rqROD46V22/
 pOltJmpdAfLuMaEOKiS/0ySvrMIfU5vBqzZkY4CpmEJF6RqT7gR342qb0+jo0iQ/CntRKjJ85
 nrofFZvXQzXi5dJ0HTs3KvkU2RSCQynx3m1pMcFuvXy6mp+e++1+zXzlOZGs95TL9oJboerI5
 2TUy8AHPb9wbEh7cRPj7sUaDuQLIjfyPITAHJCMNB9bmgDzQz2N88Q+hjKB5nlD3c2BxdYXUt
 LnTxHDqZSCFFi1PTpsRyUeDhwEp5nQlPxpFAZpX6AtiKkgA1ObTQ03RyzC

A user reported on the Arch Linux Forums that their device is emitting
the following message in the kernel journal, which is fixed by adding
the quirk as submitted in this patch:

    > kernel: usb 1-2: current rate 8436480 is different from the runtime =
rate 48000

There also is an entry for this product line added long time ago.
Their specific device has the following ID:

    $ lsusb | grep Audio
    Bus 001 Device 002: ID 1101:0003 EasyPass Industrial Co., Ltd Audioeng=
ine D1

Link: https://bbs.archlinux.org/viewtopic.php?id=3D305494
Fixes: 93f9d1a4ac593 ("ALSA: usb-audio: Apply sample rate quirk for Audioe=
ngine D1")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Heusel <christian@heusel.eu>
=2D--
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9112313a9dbc005d8ab6076a6f2f4b0c0cecc64f..eb192834db68ca599770055cb5=
63201e648f20ba 100644
=2D-- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2250,6 +2250,8 @@ static const struct usb_audio_quirk_flags_table quir=
k_flags_table[] =3D {
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0fd9, 0x0008, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */

=2D--
base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
change-id: 20250512-audioengine-quirk-addition-718e6c86a2cc

Best regards,
=2D-=20
Christian Heusel <christian@heusel.eu>


