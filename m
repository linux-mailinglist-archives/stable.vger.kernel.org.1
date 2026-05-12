Return-Path: <stable+bounces-245566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIG6BXYyA2oA1gEAu9opvQ
	(envelope-from <stable+bounces-245566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:00:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72731521D8D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3195430DB6A9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED69F1D63E4;
	Tue, 12 May 2026 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KF16H/fx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B223E1735
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591094; cv=none; b=cr0QtaYXo5bhskQpjpr7I+sYq/ob1nJYXD+DZAofQgTEdAKAY9EmIWbnx+5OYy9IMOcqHuSo2fGdvsx22/yvaAIo2cO48/TLFBHkSgM1sBAESB/ph12qiwUduMIOsq4UBeARUh5j9T9iUOXE6GlhJbIBOK70BW61/VZKrqbqwLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591094; c=relaxed/simple;
	bh=Bwj6SG50tx7zvCHLHz9Mv5NCilc8mOQIbDilUe5gM8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guo3CW4ucRbpAdFtifnTS7xOSH8CyhuUm7XkdGUXie/aZ3/K16vkNnB7jyrCvV3Z1+yj4vwLKg0xW8kVGkXcmwdKeLOiwrKOOpdUZF3pACs1YZRImC7u74Z3TFnXDn5JO5FzR6KApMsOlGWJRiYDqnpDEElJBax7qBrh3UZX4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KF16H/fx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd24f466598so173956466b.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778591091; x=1779195891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QciNpbOfQQYRXUiwuR9rhHSVvAPPydKWFQzyM2egsY8=;
        b=KF16H/fxhHXAJWSrOAGDNi4Y+lSEbWskRr2oscI8tb3b55NY0W6A+tIPZK2DkOGkBR
         b1gVEEvcowD/JNU0HW4rkGA9Fj4lw0VA6S68sE1XlLJxpKxg4uJEwWYaHeubwHk55A9Y
         /PCR8iGRg9DAYALgoFLxRLXtq0Lk7Cut4tUpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591091; x=1779195891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QciNpbOfQQYRXUiwuR9rhHSVvAPPydKWFQzyM2egsY8=;
        b=OLZ7Zz3HAz9UtVq5tZWzWJTDPhxW5BFRFudJwBxNV9ve8zhBd3qV6hrtPbeUteu5vu
         miecSEcYR9S2bIOW7Kqqy+DkBEdESRICas0sebNDrQm1oxw7fkCJwBMmOlEvZZ117Ilo
         OlyuKko3qtYutmuQibe2Fk2MJnyXt81mQew0+RRxncmExGrW6OypUtphanyA/7tdSrpq
         q8+ef+wWFm+vCVeoq+bAi3Fh8GF4+ISY6x56ZRuF4yVI58gxIyfyK4ALvKF/yng2sIB1
         VSvyhBElJtkB80TQ/v48es0pCThUae5u96WmWNvxonKFsCkC24updI5LZY19Bsyuwolr
         ekkw==
X-Forwarded-Encrypted: i=1; AFNElJ+xQhLeYFgXrduh/1Cbnzigwi4yJezcSAQ1yrM86xk2ozu12i3yga2P1QsLmJ/FXBFhy3H6pPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQokbP5Dy60lh1HYx6q8NBKZR1Q76sTZkRSWUFN7cNUNQB5LE
	5hTQZyMaMXTpuqiPuRP6G58fJkJL3cO3T0l8pvPrPsYFei/u/3kam/A8mnhOrksQtwO3Ag1eXgU
	jbEpmKaQS
X-Gm-Gg: Acq92OHlwbQj3Dovl4D/oQ7V6mlKFDbB0F0DFv1zq3t8vhLlsxokemGus5rMZVnV4FG
	8jhTFg1Qw1fWER74mevdFWRwm/nnqHgJtkvK1G9MI//nhI1glAPcDzmrc8suSIlTq0Xr806jamZ
	sPl3RTagTPnSp87ipxtlBYDW1KU9IKGn+HbIoMHAIUqQi6FXOQOFq6OLgGQlbLrkcYkgh8R+hF5
	mMd30pqP02ol/+53pNGDX5/uRImzdwHmHl458k9Nx669TFZ1DzsroI8fPTKiQRpjCh7JPnI0Guh
	90zbfbzwcYsOE7CW6HN4sdEKo8qX4/uw63VqqzUEBblFHwMNPhLb+X8E+1qCMIOKmzNXeYRlHxS
	J0YH30/G3BilWFJJyoYs7atW0GqMOx2uPf+QU/YVbboDIk63A7NwTC63G/ZSR0K+WDK1nW+pnRi
	CQ4fy80TwoI+gl7o1gXbFvwmUpc6+ECVsLNY0iXGG5GrgaOEwdp4FUZecnM9ZD
X-Received: by 2002:a17:906:6a25:b0:bd1:ba57:ec8d with SMTP id a640c23a62f3a-bd1ba57f385mr450348666b.17.1778591087954;
        Tue, 12 May 2026 06:04:47 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd2f4a7b7f3sm70961666b.52.2026.05.12.06.04.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 06:04:46 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ba545100a13so939121266b.2
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:04:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9qnzlTRNwx8zAzbb7lv06SHWa6FVNZlIqaTh6py9ZT6PmasHw5Wl6ucfmFCMXlyDPYfide5yk=@vger.kernel.org
X-Received: by 2002:a17:906:4786:b0:bc1:6ec9:453b with SMTP id
 a640c23a62f3a-bcc14d9dfeemr813452166b.42.1778591085452; Tue, 12 May 2026
 06:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
 <20260323-uvc-hwtimestamp-v1-3-aa42e3865204@chromium.org> <20260511155125.GD3043805@killaraus.ideasonboard.com>
 <CANiDSCs5jeEN7OL1PDc0XXtCP5Op2jpnWJyw7WR4Vn_Z7ECYOQ@mail.gmail.com> <20260512123827.GB4128@killaraus.ideasonboard.com>
In-Reply-To: <20260512123827.GB4128@killaraus.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 12 May 2026 15:04:32 +0200
X-Gmail-Original-Message-ID: <CANiDSCvrrhweC66+mAp1MxrG+8yEeBBpeOOSguxR0xO1kFA00w@mail.gmail.com>
X-Gm-Features: AVHnY4JzE1Xda9TZIe55UwfOZ72LTVW2oLWCakhoC3PmZeuGo55v4k9oMaLJ5Zk
Message-ID: <CANiDSCvrrhweC66+mAp1MxrG+8yEeBBpeOOSguxR0xO1kFA00w@mail.gmail.com>
Subject: Re: [PATCH 3/4] media: uvcvideo: Relax the constrains for
 interpolating the hw clock
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 72731521D8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245566-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ideasonboard.com:email]
X-Rspamd-Action: no action

Hi Laurent

On Tue, 12 May 2026 at 14:38, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, May 11, 2026 at 05:58:30PM +0200, Ricardo Ribalda wrote:
> > On Mon, 11 May 2026 at 17:51, Laurent Pinchart wrote:
> > > On Mon, Mar 23, 2026 at 01:10:30PM +0000, Ricardo Ribalda wrote:
> > > > In the initial version we set the min value to 250msec. Looks like
> > > > 100msec can also provide a good value.
> > >
> > > I'd like to know where the value comes from and how it has been tested.
> >
> > I used the Android CTS framework for testing. It checks in multiple
> > places that the timestamps are stable.
>
> You deleted the information from the comment below, and didn't mention
> anything in the commit message, so I was wondering if the situation has
> changed. I'd like to retain the information somewhere.

I believe it should be fixed in v2. Looks like I have to send a v3
anyway :P so I will double check that it is still there.

Thanks!


>
> > > > Now that we are at it, refactor a bit the code to make it cleaner.
> > >
> > > Do you mean using a macro ? You can mention that explicitly here.
> > >
> > > > Fixes: 6243c83be6ee8 ("media: uvcvideo: Allow hw clock updates with buffers not full")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_video.c | 18 +++++++++++-------
> > > >  1 file changed, 11 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > index c7ebedb3450f..dcbc0941ffe6 100644
> > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > @@ -494,6 +494,13 @@ static int uvc_commit_video(struct uvc_streaming *stream,
> > > >   * Clocks and timestamps
> > > >   */
> > > >
> > > > +/*
> > > > + * The accuracy of the hardware timestamping depends on having enough data to
> > > > + * interpolate between the different clock domains. This value is sof cycles,
> > > > + * this is, milliseconds.
> > > > + */
> > > > +#define MIN_HW_TIMESTAMP_DIFF 100
> > >
> > > UVC prefix.
> > >
> > > > +
> > > >  static inline ktime_t uvc_video_get_time(void)
> > > >  {
> > > >       if (uvc_clock_param == CLOCK_MONOTONIC)
> > > > @@ -834,15 +841,12 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
> > > >               y2 += 2048 << 16;
> > > >
> > > >       /*
> > > > -      * Have at least 1/4 of a second of timestamps before we
> > > > -      * try to do any calculation. Otherwise we do not have enough
> > > > -      * precision. This value was determined by running Android CTS
> > > > -      * on different devices.
> > > > +      * Check that we have enough data to do the interpolation.
> > > >        *
> > > > -      * dev_sof runs at 1KHz, and we have a fixed point precision of
> > > > -      * 16 bits.
> > > > +      * y1 and y2 are dev_sof with a fixed point precision of 16 bits.
> > > >        */
> > > > -     if (clock->size != clock->count && (y2 - y1) < ((1000 / 4) << 16))
> > > > +     if (clock->size != clock->count &&
> > > > +         (y2 - y1) < (MIN_HW_TIMESTAMP_DIFF << 16))
> > > >               goto done;
> > > >
> > > >       y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

