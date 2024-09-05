Return-Path: <stable+bounces-73596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A3596D8C2
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 14:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F861F27B65
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7BB19924E;
	Thu,  5 Sep 2024 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGor5xhp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70819885F
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539895; cv=none; b=jRHJL85RURFTRpWWwxMpCMhMyzXedSoeU+KEl37iMaMmi+Qjj5MMnRA5pYyKfSYxwkESZEefJZr4/HUaoHaTRlYvh1KOEdMMIEFAffNeybSX5QMMCqCx8zvlaOl6mCjA96l3InoB81HJQJuE9RRJm4QQXL2jYsSaaQALsFXbNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539895; c=relaxed/simple;
	bh=ukkZyE7LXwdJJqRPK/L0BXZuSTBljsR0rbZyHsV5L6g=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lzG6AYe3auweSsrqLe1fVFvvoe34AUG0V3uT3Pb5AZ+r1K0giY8ol9aysvCeM3ozzn+UvHtCIyaykU+f13HxG5DGlD7iDeZ7onw5fBTTegzk98snhZ0f0aVKWvnRDu8Cnx7zNSzfPzx2Crc3uAcTsN5bebBY1wJmG8XU4T6UKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mGor5xhp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3770320574aso412970f8f.2
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 05:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725539892; x=1726144692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kJg5IFa84xRILizcvK4k6RTiWZZ3HPdsh0baJag3tfc=;
        b=mGor5xhpe+3XkBxAZP6Wvl1qoU2CTK18QGsxJBFoe+QmcJehKJaHmwDiQL4MSbm328
         sx6haZ7y4u/PYex4a8r/dgbsIW4RpBaltkIdcZxG3wweAHNFiP5Z3CsyQAPIh+pd4ag5
         eGN0BraaGREb3+NRW2sc/WuU2Eebld5MRqNU+oV0RGU6BMiPM8zd7rYHZabl71ec7e5Q
         8tQflVCcERSnX77ZBNWqu2C36IoJVsXxGyIjXPpQ2ijVtNj+zVfFfYNbCgtsN2Ndoo0U
         Ok1ReGB9oL/8VdKPfHF/m7Nx92sRNCszSi+ThHSRLywY0gw2Ca6d00/mEBOJ2r0BJC1r
         frjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539892; x=1726144692;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJg5IFa84xRILizcvK4k6RTiWZZ3HPdsh0baJag3tfc=;
        b=Ez2uoirgGELGaL3DE9iz+M3SkbfO+sWV7I4xVQm3IxMufYH4hL4J3pZLm1wOMk5qRp
         qHn8+uK46wvLxMauB5IuG/phfIWgv2uPJhtZlEpVR8K01BTILAa90FOgm7kQvxhVLbM4
         +/C3Moy5PVEiaa7mySUygqzzF7xgG/DfxYOuv1FXtboqOXd8UKMpqDbofp32FZ8p94SW
         tjA8EC+UKUF6SH6erhxV5ADamFowuwjzqnwOdvaavnVGI3crdhmOs2L/nmgRMdObzBRr
         Ea4lul7QCuGCfKaZhb23R086Vsp2Pfcj8xO/+lBJGpjefVAO1+3cjKKUQeDn1wDNDEd3
         b8SA==
X-Forwarded-Encrypted: i=1; AJvYcCW0vrkLPYdUF/s2eZ+wnwEUsJZLYDSI2a09YU5KZ/p5MIs6kGM4T0ox8wBoeKm2rQ25IPjldtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmXJp3FFm0MKjrv+93Ach0hSFstZk5JaBhq8Keuvw6sY0Xx6h
	Nl6jaAqPnXSj8aWJJelBs8o0DFHlb3329ZujiSrTyXGvKlhpMIwfTlkwVHDt+RE=
X-Google-Smtp-Source: AGHT+IHB+NFWk2sx2SV+tsZrEs3O6Gl/8v4e/4O4iNCwpwj1Av4IuTeeGUrJOlHvENv25TFkx6zIWQ==
X-Received: by 2002:a5d:648d:0:b0:374:c6ad:a7c6 with SMTP id ffacd0b85a97d-374c6adab4amr10489721f8f.20.1725539891770;
        Thu, 05 Sep 2024 05:38:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb239sm237065515e9.5.2024.09.05.05.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:38:11 -0700 (PDT)
From: Takashi Iwai <dan.carpenter@linaro.org>
X-Google-Original-From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 5 Sep 2024 15:38:07 +0300
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, Hillf Danton <hdanton@sina.com>,
	alsa-devel@alsa-project.org, stable@vger.kernel.org
Subject: [PATCH 1/2 4.19.y] ALSA: usb-audio: Sanity checks for each pipe and
 EP types
Message-ID: <599b79d0-0c0f-425e-b2a2-1af9f81539b8@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c0ef6b-f4bf-41f7-ad36-55f5b4b3180a@stanley.mountain>

[ Upstream commit 801ebf1043ae7b182588554cc9b9ad3c14bc2ab5 ]

The recent USB core code performs sanity checks for the given pipe and
EP types, and it can be hit by manipulated USB descriptors by syzbot.
For making syzbot happier, this patch introduces a local helper for a
sanity check in the driver side and calls it at each place before the
message handling, so that we can avoid the WARNING splats.

Reported-by: syzbot+d952e5e28f5fb7718d23@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/usb/helper.c | 17 +++++++++++++++++
 sound/usb/helper.h |  1 +
 sound/usb/quirks.c | 14 +++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index 7712e2b84183..b1cc9499c57e 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -76,6 +76,20 @@ void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype
 	return NULL;
 }
 
+/* check the validity of pipe and EP types */
+int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe)
+{
+	static const int pipetypes[4] = {
+		PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
+	};
+	struct usb_host_endpoint *ep;
+
+	ep = usb_pipe_endpoint(dev, pipe);
+	if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+		return -EINVAL;
+	return 0;
+}
+
 /*
  * Wrapper for usb_control_msg().
  * Allocates a temp buffer to prevent dmaing from/to the stack.
@@ -88,6 +102,9 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 	void *buf = NULL;
 	int timeout;
 
+	if (snd_usb_pipe_sanity_check(dev, pipe))
+		return -EINVAL;
+
 	if (size > 0) {
 		buf = kmemdup(data, size, GFP_KERNEL);
 		if (!buf)
diff --git a/sound/usb/helper.h b/sound/usb/helper.h
index f5b4c6647e4d..5e8a18b4e7b9 100644
--- a/sound/usb/helper.h
+++ b/sound/usb/helper.h
@@ -7,6 +7,7 @@ unsigned int snd_usb_combine_bytes(unsigned char *bytes, int size);
 void *snd_usb_find_desc(void *descstart, int desclen, void *after, u8 dtype);
 void *snd_usb_find_csint_desc(void *descstart, int desclen, void *after, u8 dsubtype);
 
+int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe);
 int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe,
 		    __u8 request, __u8 requesttype, __u16 value, __u16 index,
 		    void *data, __u16 size);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 43cbaaff163f..087eef5e249d 100644
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
+	if (snd_usb_pipe_sanity_check(dev, usb_sndintpipe(dev, 0x05)))
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
+	if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
+		return -EINVAL;
+	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 				  0xaf, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				  1, 0, NULL, 0, 1000);
 
@@ -879,6 +885,8 @@ static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
 
 	dev_dbg(&dev->dev, "Waiting for Axe-Fx III to boot up...\n");
 
+	if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
+		return -EINVAL;
 	/* If the Axe-Fx III has not fully booted, it will timeout when trying
 	 * to enable the audio streaming interface. A more generous timeout is
 	 * used here to detect when the Axe-Fx III has finished booting as the
-- 
2.45.2


