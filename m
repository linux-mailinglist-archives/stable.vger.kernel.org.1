Return-Path: <stable+bounces-163293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC26B093B2
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 20:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E20189CB56
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 18:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49C82FA64E;
	Thu, 17 Jul 2025 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M59+Fa9H"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E61F0992
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752775320; cv=none; b=sQYG0yYUfFWVW36Kp6eHL6EvtLU6rM0LsEgqJDIgIglMPGOjLSQtzaIkUhiOHHsgim5TfnPuQChdt325JO4Le5QDYthgVKXrI40XBLVLOCIQQ+qDOkgZ+CVEb3tJ/F5SlC/sAzIUnVP3DwWOBBfgd9oTq5Xe3/VoyUKVLn+Kweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752775320; c=relaxed/simple;
	bh=Ux/XUbZrjrZ5icvEfMb+fRvCSfaTQPzstHhwyeYefq4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dwdVI3z3S2eDEked4fNdNNOkW1A42cVqxb+OzRlpFJ9uMEYBvT6FeIYkFZxFNo9NLe1u9bch2bmuVUhAGllxIQcLh+cOuE0rBk/KrxOpZszIEGwpC6SAZsUstBfOV3NFUyJrlfMCGdaEI4twmA6cvv78da4UYu6cR8XxbhH0m2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M59+Fa9H; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so1021324f8f.3
        for <stable@vger.kernel.org>; Thu, 17 Jul 2025 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752775317; x=1753380117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aBHXt0ewopLcuu1qBHUicsTua/XNcGgsEZR3E71VE8g=;
        b=M59+Fa9HJRmQ/DEtd2piR/E4hIriRVg/Ze64YYML6HvPitdnOOpxdRGSRPtjOPVRuM
         mVvQKJDYCghROsKsJFPyjIOd3y7G0Df3gBf0irwd2UdU2VfyMfKXKVDZk27Q0sfYj8FF
         16D8eVWZrlGG9Wf12jOv3YMlOiZ0BJky/smHP3tMW+c5lPewsE6UGYoQqcGdwCdl/nIH
         Sxb4cudncOQKEkzPLrnjzn/57SwIOnrwDnDXRjimbFjpZ3Vg3W35fSiyVjHJ9fElYRNC
         HBQTJvSvxCqv4l719axBuO0mw+Cgd0s1In28SbY5M0WrlRpczfBSMaJ+qW5dfe1zGcPN
         t8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752775317; x=1753380117;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBHXt0ewopLcuu1qBHUicsTua/XNcGgsEZR3E71VE8g=;
        b=rSjGvu5L+j4SPu7faNNwx9TQ7yet1X7+gwJzuJZBrv3Nh0p3dwoagjfm2wy+vZar/E
         5NW8tzn7nGsyRFKKTHq4Ur2LUutwOQ0sgZSPalucjfUkWo7crESjk1+BJYnpZBj9vgHY
         L6Nl71+qFcpUQ2Uc0InIFRBcr/As7CeTGB3hYdK7oB/zzTSuKxA7/TtCY9RYG5mnlv8B
         XNyK1XTSE9hppSBj55iJZjiKlMzoD14OXHHhaY9vhSqLumC9cn3YDsjj872/CCTcG3cz
         /rOjki4+Iexpqo+94p8DtVr/9OQJFwNq3r+KFdwilf+WgcgLv9DA7+luNzAj6Jbz2h/K
         5eZg==
X-Forwarded-Encrypted: i=1; AJvYcCWDvs2rv4sqxLDsouyiocozlRVcSbm5OBHIU3D298vHSx1AG7RlLMFb3nihnn4AUbZvPdbR+ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdz2hLVFF8fnnsereCVd7h/3kJ+4v9BSuZpFPnqBT4AgSAgPqb
	WgWkLa27bAojfwTxpa97vMkRJ3quOtS3I44W7Ib2/fKFzxHTqidU9TXFj8Hc4Nu3T9jyshFeLNj
	InsbRN03qP6cUkE+zdRHJQVyZReP+IrtYJiNDqIWG
X-Gm-Gg: ASbGnctj3zbRtTIkt++RVjk1AILCGgYJ/CLxFWsOgJdS//U3QrTK6HktVPnlU5ewS2k
	i6klJsM7EOXl1xtt7SyocSOpYi8bsxSqwig2NpYZ/0x9KAE+asS/CuYTeAiPpNxTvfd+6hXrP3e
	OEiuUTwQsEAiLSRMpPYgAitKcldXW3OQYtCjfYeVqh/82huJqsrC9VJLnLFSYifbAl006qYjWoU
	TKJPtpzfZATVTLsNymjNCvYKzoYAif1zYNk
X-Google-Smtp-Source: AGHT+IFvdTmOg7+pD8vUlVLGeBk+gkiShFoTqBolUzcUuAZVYGcA2GEEZQjKbBBwFkJrV05rGR/ulq+Fp7cVEtgOWOs=
X-Received: by 2002:a05:6000:144b:b0:3a5:2599:4178 with SMTP id
 ffacd0b85a97d-3b60e4c8f5fmr5842168f8f.19.1752775316854; Thu, 17 Jul 2025
 11:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gwendal Grignou <gwendal@google.com>
Date: Thu, 17 Jul 2025 11:01:45 -0700
X-Gm-Features: Ac12FXyerUkpgZcEecxDOI40_wwidC4JV1skvAnOQOx7azFT3BQlFHJ5VXbZRqA
Message-ID: <CAMHSBOWue5bwysERvoZQjSG8h32me06wwcSQGteTN=aX=5OXYg@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: usb: Ensure mmc child device is active when
 card is present
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, gfl3162@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kai.heng.feng@canonical.com, 
	Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org, ricky_wu@realtek.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
Why not calling rtsx_usb_resume() here?
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

