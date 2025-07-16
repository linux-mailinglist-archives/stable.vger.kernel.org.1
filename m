Return-Path: <stable+bounces-163108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F52EB073A2
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 12:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB44A1AA368F
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F8A2C326D;
	Wed, 16 Jul 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytNnNUZS"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAEC239E62
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662394; cv=none; b=WyU+9XYzhP/Hbs7RdHwqkLOqivsMWTQQMWyLpEaUgVODw44cU5quT4L+dYsc5SZZqugTy8HUPrXVENV/L6PF2mgWjA0cDUkqk9CFn0UpAdh2xRqAH9SUJ0O2qFDgQw+MqXGY4MQ254wQDKDyVHfho5sRGGYQCEOGRKJF+Du9BmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662394; c=relaxed/simple;
	bh=F8wVUDm7p/zZnHJ/u8Gt2hH6CgWFmzDGXRIM+sGzbFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf/i9mWQYniSmTJApr3CkXczu90NO1kum2B7Yx7iHVcZJWzuLSamPC4au6Yy+1YMhMIq7+hTlzbSiqC3pA2v1NotXfhp5H1uJxg9M2S6UA8QvrJieDCHKW5LK52YCZZmh8+OTbdTnV2uelOutdAv1uvuGMoQ1zp6wssUsecDwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ytNnNUZS; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-713fba639f3so56427257b3.1
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 03:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752662392; x=1753267192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=spxFppZ565q58hNSB1wuY7WIKcmbQWfH+dTajO6FGEM=;
        b=ytNnNUZSrzQj1UPfLZWF7h1gQ25H6Gn3sZA3P/ozMgJvngA9GlMK6DYxJqlZQoccZN
         VMMwSwl1PEDZ20doSZaY2UEWCBmvO7aut/MAzahhySrISRCFgkfRNh6LXEiaItQPmnRc
         Fj9sOfDLSWkUIatBGg0N8x/Ld4lSE/8oSJn+sTNUvKlPNeWRciLqMK2/7mrw+im2AoR0
         VQlo4O5xZIAYpQHSW1v7I7+ntY0XR4zxSD4NHJSGIKjVlxonL32pF8GKktDZMJTHefnv
         22Hyww4UmFdbTlb38cCbK9+PZeMLQpEQlz/Ja+FGZQVWe64o6r5YFRkwFWN06nfzJ3cC
         JdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662392; x=1753267192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spxFppZ565q58hNSB1wuY7WIKcmbQWfH+dTajO6FGEM=;
        b=VA/reKGdDdmwvyzTwBCc2QIa033sCKXv2CBSr/5uPCrGWquypy49Hmsj70buzVqDue
         p3CkyN6LTRzAzpSN7vau7oMUhhmigFUpn2izxroTSGm8lzoCQemI0YTBlDayB9MSexO7
         OzmXBAudnQRfbvhkaKPjTowPNleWmTgiIL8zeaU9QsmrwdlPzMJQmBXsmrFXvoh0zFU9
         WW4uc8/Ln6x7Y+Ug/jy5NXSrduKYP/vepApzgH6y34lVbucoxQlHo9Mg2HnmHaF0/53t
         0uIQxhZuGyNAKpO3SOG6u8GhNalz3QMJ8YOIcQqe2vwxVNX6jCH+QQsLyUPICql39/aB
         Jufg==
X-Forwarded-Encrypted: i=1; AJvYcCUL15sflgSUUuLFjoCj4k2PnC+x3juHKQykqJXNQ0QCnaG/R6LEyrSNZ0+1Jt9iXAnfswUGlWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvLFxq5UyO4CdEnV8mexOX5snoaagQhtpcFvxZxuFWe3e3CD0
	xAdEAJDbsdDgtAksCPerIiyq4DHOpyXoLoh2k2nkpKfIMysPLbrqr0btnKZhzIQgaq8djHaCOn/
	7ZusEI1UFHpVYiUi5XOpKopRPVxsrG1mnb67pU6P8eg==
X-Gm-Gg: ASbGnctsI8PXWayLe+Xcu13n3gvUC9MI5YR+TDNH+AKE6ynEdOxx5R7bp22c/12H3uE
	iWoqOEvKVOvxU0R6FCuCS/Gr5rsX1kwRjBmeEr72IkdcmcXB9cofCMIiM9+diWmjs+3R6PvYfuN
	YLJFu9GGfgOpy3QMFtjTJ6dQyfs4rTrGBuImaiuK9ckpJJQLYmivb+lcM7sjh6uhHxfeqPUbQae
	oX75i0Q
X-Google-Smtp-Source: AGHT+IF0fbD9xXcmRbFab8+66c7b8WI4hPM/SlyXx9ZK29aUbT3fe6CoVipyvf7SMmS8ze5O7yHLCnWwytc7DSE8mss=
X-Received: by 2002:a05:690c:4b06:b0:710:edf9:d940 with SMTP id
 00721157ae682-7183517f055mr36324777b3.36.1752662391508; Wed, 16 Jul 2025
 03:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711140143.2105224-1-ricky_wu@realtek.com>
In-Reply-To: <20250711140143.2105224-1-ricky_wu@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 16 Jul 2025 12:39:15 +0200
X-Gm-Features: Ac12FXzAflLzV_PiWmkWi2BzOQOEd6W9JptnxrNdS1PY8_PEfhd7R2kkyB8Xxls
Message-ID: <CAPDyKFpmt4eTfBOWphH3LtoW9jAujBs7oAFqqnxkJvP+r83tkw@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: usb: Ensure mmc child device is active when
 card is present
To: Ricky Wu <ricky_wu@realtek.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	mingo@kernel.org, kai.heng.feng@canonical.com, stable@vger.kernel.org, 
	Gavin Li <gfl3162@gmail.com>
Content-Type: text/plain; charset="UTF-8"

+ Gavin

On Fri, 11 Jul 2025 at 16:02, Ricky Wu <ricky_wu@realtek.com> wrote:
>
> When a card is present in the reader, the driver currently defers
> autosuspend by returning -EAGAIN during the suspend callback to
> trigger USB remote wakeup signaling. However, this does not guarantee
> that the mmc child device has been resumed, which may cause issues if
> it remains suspended while the card is accessible.
> This patch ensures that all child devices, including the mmc host
> controller, are explicitly resumed before returning -EAGAIN. This
> fixes a corner case introduced by earlier remote wakeup handling,
> improving reliability of runtime PM when a card is inserted.
>
> Fixes: 883a87ddf2f1 ("misc: rtsx_usb: Use USB remote wakeup signaling for card insertion detection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

This seems reasonable to me, but perhaps some of the USB maintainers
should have a closer look to see if this makes sense. Nevertheless,
feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Moreover, we had a related bug-report/fix posted for the
rtsx_usb_sdmmc driver [1] not that long ago. Do you know if $subject
patch solves this problem too? I have looped in Gavin, if he has some
additional comments around this.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20250510031945.1004129-1-git@thegavinli.com/

> ---
>  drivers/misc/cardreader/rtsx_usb.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
> index 148107a4547c..d007a4455ce5 100644
> --- a/drivers/misc/cardreader/rtsx_usb.c
> +++ b/drivers/misc/cardreader/rtsx_usb.c
> @@ -698,6 +698,12 @@ static void rtsx_usb_disconnect(struct usb_interface *intf)
>  }
>
>  #ifdef CONFIG_PM
> +static int rtsx_usb_resume_child(struct device *dev, void *data)
> +{
> +       pm_request_resume(dev);
> +       return 0;
> +}
> +
>  static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
>  {
>         struct rtsx_ucr *ucr =
> @@ -713,8 +719,10 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
>                         mutex_unlock(&ucr->dev_mutex);
>
>                         /* Defer the autosuspend if card exists */
> -                       if (val & (SD_CD | MS_CD))
> +                       if (val & (SD_CD | MS_CD)) {
> +                               device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
>                                 return -EAGAIN;
> +                       }
>                 } else {
>                         /* There is an ongoing operation*/
>                         return -EAGAIN;
> @@ -724,12 +732,6 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
>         return 0;
>  }
>
> -static int rtsx_usb_resume_child(struct device *dev, void *data)
> -{
> -       pm_request_resume(dev);
> -       return 0;
> -}
> -
>  static int rtsx_usb_resume(struct usb_interface *intf)
>  {
>         device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
> --
> 2.25.1
>

