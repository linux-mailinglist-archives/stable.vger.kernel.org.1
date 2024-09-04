Return-Path: <stable+bounces-72984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC096B64B
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7763A1C21A7E
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D09E1925B1;
	Wed,  4 Sep 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSbgmHs2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D0405C9
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441466; cv=none; b=GqhwsMrM0BCVfm7SHAaKBXqqegq0rnlosG+EYTjwhgFA1v5W9Q1071Ap+oatPwk/jCABSmcphY7+rN67KPJ5r/Cgn0aPqxnyYWk3+hAOYxgL/Ik+3GBb4YbZcn4fMBqaAbt69a424RsobqjDOfMD33qDg/6zYUUOKS3ZsTHY7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441466; c=relaxed/simple;
	bh=PmPnmZ2NmpDTrJT2ks6rkc1Zr4rD7IA3h4zqnn/3oME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8OOzYDPvidSDluTxFGw545whQNWn2qWiv42BaFfD47R6uHv3NTmxcOvkgPNrSbHtQbVMa9DMsG2dJe09tDt9+LLAL0zQVAU5Kd+b0w5u8FqB0mZ/g1ceUgADzuwz9ulO1OHIkAFmfmVvq3fnyqcAe320D/g5nWGpUp+jsVUgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mSbgmHs2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bb72a5e0bso55026135e9.1
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 02:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725441462; x=1726046262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynepl8UlvIYWtFTozo06Dnk8jJ++H1fOO9lM/5/91cE=;
        b=mSbgmHs2vJrjXx4//vC6bkiuXxnfuCrPobANDRn/HcKkzbimisfNoro7L5eSfr8UKi
         wohLQmg5YVIF+eT53i6uYuhSXk5Etd8EBqIA/sFrLanxIFWFAXhcRC5L4CwUTVguI+qU
         f83LWQfdhp067ruaBkWteoWcksRBJFBuxfV7M/KtzYUI/iJz6sRpzUipMPOBzFxrxO/B
         /QIa//85FI2Quxd7twJuQAdBFZ96W9xa9igQLaSak+TMTJo9Aw25p5BlWZ9G+1Sf5Lom
         9FdIcoKOGuvPEsgkpH1+c71tko784eAGL2z5QjBvsmo/pbN52vx4jYFRxaBZcGfqdM/M
         Bu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725441462; x=1726046262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynepl8UlvIYWtFTozo06Dnk8jJ++H1fOO9lM/5/91cE=;
        b=rTj3WETArPc5hnlf/1ye2X60JRHunzEAkb9Ml/yVftoWgiMf8KfGV9hZ6YYGjRcH+b
         Y0agDlgiP94zcSgd5jBozqOXflCSPEzfswsYkQ9cpWghbQLH+Q+2IpMKpM8ObOQ6UVzJ
         dKgDJwLN/+Nznacwi8RL5f1FeKvQyQ2Ak3onBNr1wHGwvyFUXKXl0JrOSYE4WQAOYhp/
         FMHQiY7mGRLDjqovYpkYzVyyKZQwI/b8Y/c0xvhHEaGwDnWw6OqZ3R5auwdWG8iWIn43
         6WIOAcYr03k632mBhk8gjQf+pcOkKc9Y3GYgnR56SznwG8Rp4fbaKc8t8JWzzv6tcEy2
         +o4A==
X-Gm-Message-State: AOJu0YxL0XZeW5A9wBh4YSlyiAysgPH87Uav/IPvy/c6a/om56F49B5b
	rKpxCu+w0KWi+xe5vWDN4PmeLx5PzjmfXUcaXyq+w6fs2Rsw8s1UHAucZmBkkqw=
X-Google-Smtp-Source: AGHT+IGsBaPBCu8fGAu+ZNrc6LjDJF2wLwMEmZfjGQXZ/Lt7M2qEoUmdYUb+QpJjSGmN4c5NVl9TUg==
X-Received: by 2002:a05:6000:18a7:b0:376:7a68:bc42 with SMTP id ffacd0b85a97d-3767a68c23dmr3745816f8f.27.1725441462261;
        Wed, 04 Sep 2024 02:17:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639d512sm230815755e9.18.2024.09.04.02.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:17:41 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:17:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, jslaby@suse.cz, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH stable 4.19.y] ALSA: usb-audio: Sanity checks for pipes
Message-ID: <7656cec0-3e12-47cf-af5c-178b7103ef17@stanley.mountain>
References: <2024081929-scoreless-cedar-6ad7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081929-scoreless-cedar-6ad7@gregkh>

We back ported these two commits:

801ebf1043ae ("ALSA: usb-audio: Sanity checks for each pipe and EP types").
fcc2cc1f3561 ("USB: move snd_usb_pipe_sanity_check into the USB core")

However, some chunks were accidentally dropped.  Backport those chunks as
well.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is from manual review.  I checked 5.4.y and this was okay there.

diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index 7712e2b84183..3b39c53d5610 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -88,6 +88,9 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 	void *buf = NULL;
 	int timeout;
 
+	if (usb_pipe_type_check(dev, pipe))
+		return -EINVAL;
+
 	if (size > 0) {
 		buf = kmemdup(data, size, GFP_KERNEL);
 		if (!buf)
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 43cbaaff163f..b6df92fdf950 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -743,11 +743,13 @@ static int snd_usb_novation_boot_quirk(struct usb_device *dev)
 static int snd_usb_accessmusic_boot_quirk(struct usb_device *dev)
 {
 	int err, actual_length;
-
 	/* "midi send" enable */
 	static const u8 seq[] = { 0x4e, 0x73, 0x52, 0x01 };
+	void *buf;
 
-	void *buf = kmemdup(seq, ARRAY_SIZE(seq), GFP_KERNEL);
+	if (usb_pipe_type_check(dev, usb_sndintpipe(dev, 0x05)))
+		return -EINVAL;
+	buf = kmemdup(seq, ARRAY_SIZE(seq), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	err = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x05), buf,
@@ -772,7 +774,11 @@ static int snd_usb_accessmusic_boot_quirk(struct usb_device *dev)
 
 static int snd_usb_nativeinstruments_boot_quirk(struct usb_device *dev)
 {
-	int ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+	int ret;
+
+	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
+		return -EINVAL;
+	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 				  0xaf, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				  1, 0, NULL, 0, 1000);
 
@@ -879,6 +885,8 @@ static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
 
 	dev_dbg(&dev->dev, "Waiting for Axe-Fx III to boot up...\n");
 
+	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
+		return -EINVAL;
 	/* If the Axe-Fx III has not fully booted, it will timeout when trying
 	 * to enable the audio streaming interface. A more generous timeout is
 	 * used here to detect when the Axe-Fx III has finished booting as the

