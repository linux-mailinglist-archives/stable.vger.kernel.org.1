Return-Path: <stable+bounces-73597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7F396D8C3
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 14:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDDF1C22A20
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 12:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC919AA68;
	Thu,  5 Sep 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4gmpaRW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B48B19885F
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539900; cv=none; b=E/13bgTQZ40nV879cHotpUedyoiBkz5AwpfUEaBuOnrRgAOcqZWzM+JaI56yas35wgjMSxPxaxvNeaE22LqrxLjqfcRoRD70tHcAcbTLdvZWGS9T1LKID/Sv05brLF+sj5fom3VqyN0EdGj7O91QqdWzSHIEG7f9e1imIddUi/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539900; c=relaxed/simple;
	bh=lit5iBxVDFpk4ULIy0i42xv115wo/uqoPdVZId53JPk=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bydLrnIgMBdzQ6v6wFXlV+OCIntx508IzY5ewYEvmCo6niJn6WPeR7qawobBN/Jd7ZzvxCBGEgIfVCoekH7ZzdoDpdD6+mKDsGtmHwZpviVF36WiXLTeQlgK0Oa1EkSDK1UBeS0JFEa40A91KOR6fWKGz23zQcUbQcpid1w4XlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4gmpaRW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bb8cf8abeso5685955e9.2
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 05:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725539897; x=1726144697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8tBVBv6hqzsh3Y7wmsPJR+JvC6LY/bf7F+mJ4H3uNA=;
        b=G4gmpaRWulh4is0mBxylit3i+nSZugTtKZ2xtGd79+iWvDGi9gHlAU/OvxNb6jQrsG
         tGhNf+xdxgom2TaMgIsnFWj9R0bliPDEHANM3ifjoIdIgE3R/93oj0EjlGOG6HNyj4TR
         Hm1+haHH/fOh6SEoSHFwz31Uj3Szb4FPtvueEaiHed3xNrcEJdcb8KCN4tRgY+GXZBfa
         4pWeFnIqpvu21jmMlwIsosKvHfZkQ3Dy7TIS+5HaxxO01PTO2KaVCio03WCiaO9j6WqO
         EgQGQ1KdznbywxJ3/KWQqtBpJnVAUZ3SFBx7X/Da5BMicF0AdiXvxIYie0nicAJSq24m
         NpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539897; x=1726144697;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8tBVBv6hqzsh3Y7wmsPJR+JvC6LY/bf7F+mJ4H3uNA=;
        b=q6zR6NEY1PdXFVmSS3GNBfWOuNx5lTTIIzHbu2jEuc7cAhBLWC1bHNyaDsBH0rWuq7
         HLcC6Euvw5RINVI4bjE5bXyW8Tfiz0I8K4I2FXK7rxfZFCQokpfyFk0bqraSe7ynQQNM
         eyRNCW2g57kY07u5SGyaFIWjshXc28onPvoWAuEBpmdKRVjawRVh4IBeiPPmYpNC6+iY
         xf3UISUXsBf5xTG2PGs1H8Q+2huQtxo0QsvFqCFPJsdMCmcCBYkDMELTJvoj0koeomcs
         U+ewOodvj+6WroaPYIo3NtgJlAirsA4xni21SxoYPbicMUAL07YcxBkt5g684ooCh4IF
         nD+A==
X-Forwarded-Encrypted: i=1; AJvYcCVbIrqESVyWbZ9uBrYWLYMz6lkmfuOfuSGQqZxnCp7DFafkv2VAxepqW1c2An/UItbhVWIneDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw7b2ZI0L0rmE7h1Tm/0F9QW782xqWk+hrmPvXT2PYLIo0dKtK
	AMnoa9DuSriPPAMG/UPahILQxY9pDG4AmBBDuPDem8rInycGZY/hwzjNcwT2USk=
X-Google-Smtp-Source: AGHT+IEUeJhq6nXQUzmxvES2TVSIG9etjyshwco7odL0scyeNSEVlHlJx1JBy6Ds2ivDpmh9lPiSVQ==
X-Received: by 2002:a05:600c:1551:b0:428:ea8e:b48a with SMTP id 5b1f17b1804b1-42c8de5f5c3mr51960955e9.8.1725539897504;
        Thu, 05 Sep 2024 05:38:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbc127ec5sm205513245e9.19.2024.09.05.05.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:38:17 -0700 (PDT)
From: Hillf Danton <dan.carpenter@linaro.org>
X-Google-Original-From: Hillf Danton <hdanton@sina.com>
Date: Thu, 5 Sep 2024 15:38:13 +0300
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Hillf Danton <hdanton@sina.com>, alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2 4.19.y] ALSA: usb-audio: Fix gpf in
 snd_usb_pipe_sanity_check
Message-ID: <d830ede4-1736-4548-94b3-51a21fa935c3@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c0ef6b-f4bf-41f7-ad36-55f5b4b3180a@stanley.mountain>

[ Upstream commit 5d78e1c2b7f4be00bbe62141603a631dc7812f35 ]

syzbot found the following crash on:

  general protection fault: 0000 [#1] SMP KASAN
  RIP: 0010:snd_usb_pipe_sanity_check+0x80/0x130 sound/usb/helper.c:75
  Call Trace:
    snd_usb_motu_microbookii_communicate.constprop.0+0xa0/0x2fb  sound/usb/quirks.c:1007
    snd_usb_motu_microbookii_boot_quirk sound/usb/quirks.c:1051 [inline]
    snd_usb_apply_boot_quirk.cold+0x163/0x370 sound/usb/quirks.c:1280
    usb_audio_probe+0x2ec/0x2010 sound/usb/card.c:576
    usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
    really_probe+0x281/0x650 drivers/base/dd.c:548
    ....

It was introduced in commit 801ebf1043ae for checking pipe and endpoint
types. It is fixed by adding a check of the ep pointer in question.

BugLink: https://syzkaller.appspot.com/bug?extid=d59c4387bfb6eced94e2
Reported-by: syzbot <syzbot+d59c4387bfb6eced94e2@syzkaller.appspotmail.com>
Fixes: 801ebf1043ae ("ALSA: usb-audio: Sanity checks for each pipe and EP types")
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/usb/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index b1cc9499c57e..029489b490ca 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -85,7 +85,7 @@ int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe)
 	struct usb_host_endpoint *ep;
 
 	ep = usb_pipe_endpoint(dev, pipe);
-	if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+	if (!ep || usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
 		return -EINVAL;
 	return 0;
 }
-- 
2.45.2


