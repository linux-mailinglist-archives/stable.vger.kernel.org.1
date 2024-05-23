Return-Path: <stable+bounces-45612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D158C8CCB4C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 06:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559E3282BFC
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 04:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DA550A62;
	Thu, 23 May 2024 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nR2jow7H"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107B364A4
	for <stable@vger.kernel.org>; Thu, 23 May 2024 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716437715; cv=none; b=sRlzgWHSnYVTqntmgxVPkg7fdUpCV6iucpjvjewgWKIwFBO7eGLgK4Z5wiZ3PkYkln8MDUfk/fQ6EAZuuDK6QECLka6Wje4noNlEZ2r11scCSkNL096S7q9UcGEXNkX1f7axb/gyPazoX1AcxTvVyblGtyKoPFqX++BBBRHQuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716437715; c=relaxed/simple;
	bh=zvCTIHs5YqJAlk7Ohu27hGvHT/jfiV6FMeApCgHcMnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq3n3aVYN1r7PYVwudDNej81Rhdp/RDTWpmDAzH5qFhsH15WLpsWscLcbMsQcBUXxtHabfVFgLaV9zmPEx+T8BERnUgjL+g0iVgDSrqPglwf2S0gT225LVl74+E1QnUW5NrHrFfH/y7R53mrSDscGuGEJiY0fUfAPoWL41MuzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nR2jow7H; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-62036051972so61843467b3.1
        for <stable@vger.kernel.org>; Wed, 22 May 2024 21:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716437712; x=1717042512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MET5FIAW2m/C0sBmsEV+FEl5MEocq9FyxllKEm3F0/Q=;
        b=nR2jow7H8vmBxPsIpl9rspXzEP0FIDRS+RniwgtVv8KCkuAzX8brFRjesJJDuHvNx0
         FJA/Idl/9vy8n/UsTp4Hvve0afrveSM9nHf4HhUGoTZKDevo75Tl1iw6mLUdCT7RFIjO
         r0wNTa8gQHAWllnQm3HbV7NvBRim3+A2kkdE4lh5TRJaMPBaa9zMzIZWkhxREeFVMoAZ
         YDleR4VHPHxX/e0Ar49y+bNwTvG/4HOZd+uyebMyvRLFkQE8WaOTIT7Ff695uA3swEw7
         khIJ/CxOOAB5Zxv/uWkGolmR7VyQNxoMYTI5Ne/JHFs4RiPhh+uzC74YmnkJ4cjq4zTa
         8Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716437712; x=1717042512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MET5FIAW2m/C0sBmsEV+FEl5MEocq9FyxllKEm3F0/Q=;
        b=pm3tewXgvWC6ermbQQRAdF7jDtBHx4GCOam34c/lBjuoXx/BNAP5S09v5KORY0zHLd
         omftbP9eG4OQokLApbnQwrwvckUnQiO92AJ2Gey9unSstr6MCuCtiL92YX95jg8++Sz0
         /QUCMKGh2kwxd7EXeSTnp0990TUPiGtnxVDUZ+UZhE/nRzKs1vVzoqvgPQLKSpZDSHog
         JWYltMmf4m4eg+l6cD7jq0dzOdqjLyx5lFSxbCpp3Vq/JQjimhVfpyNwr6C0vIPdhTOC
         PtBhlCLaGwwI4ayo6zkURtRetrCSbsY4tcW0YkSVztkyrpKCfBgDd0SWK3FNsnUiunRx
         HBVg==
X-Forwarded-Encrypted: i=1; AJvYcCWh7S2VAgNkssf9Nf+BDhQ0Muxt+/uFX3+fre+3ser0hlNuMoHl2aGhCvr/Wph38sfIJrMt9Nu7jRxS7DGGTUeOMSy/zoi0
X-Gm-Message-State: AOJu0YwVJ829OyZ2ITAyiONseoIbhkJpCJKjT1aPCUqb/ofdEWWTkcIa
	pzuhpOyQkN4QjVMjVwhIRmLKZKcvlrJgg2I6zFDlGHBa6xkGq8NhcmPclDAExqI/AUpnP5sqicI
	WrZjjG+JXRyYY8+x1nCtRZfz/WQg8OK2KFK8urA==
X-Google-Smtp-Source: AGHT+IHkorZjav4Gf4d1OozhsH8Pxc0dMg8/LiEOsXhzjkpYSCLGHEfn/HFnM6PbS2MvI8LGr5ycTQTnUTfx3eftbnY=
X-Received: by 2002:a81:4f4d:0:b0:61b:748:55a1 with SMTP id
 00721157ae682-627e46ca1a9mr40027607b3.13.1716437712376; Wed, 22 May 2024
 21:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510090846.328201-1-jtornosm@redhat.com>
In-Reply-To: <20240510090846.328201-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Thu, 23 May 2024 12:15:01 +0800
Message-ID: <CAMSo37V5uqJ229iFk-t9DBs-1M5pkWNidM6xZocp4Osi+AOc1g@mail.gmail.com>
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set
 to down/up
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Isaac Ganoung <inventor500@vivaldi.net>
Content-Type: text/plain; charset="UTF-8"

Hi, Jose

On Fri, 10 May 2024 at 17:09, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> The idea was to keep only one reset at initialization stage in order to
> reduce the total delay, or the reset from usbnet_probe or the reset from
> usbnet_open.
>
> I have seen that restarting from usbnet_probe is necessary to avoid doing
> too complex things. But when the link is set to down/up (for example to
> configure a different mac address) the link is not correctly recovered
> unless a reset is commanded from usbnet_open.
>
> So, detect the initialization stage (first call) to not reset from
> usbnet_open after the reset from usbnet_probe and after this stage, always
> reset from usbnet_open too (when the link needs to be rechecked).
>
> Apply to all the possible devices, the behavior now is going to be the same.
>
> cc: stable@vger.kernel.org # 6.6+
> Fixes: 56f78615bcb1 ("net: usb: ax88179_178a: avoid writing the mac address before first reading")
> Reported-by: Isaac Ganoung <inventor500@vivaldi.net>
> Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
Sorry, I just have a time to test this patch, and it does not help for the issue
I reported here:
https://lore.kernel.org/all/CAMSo37UN11V8UeDM4cyD+iXyRR1Us53a00e34wTy+zP6vx935A@mail.gmail.com/

Here is the serial console log after I cherry picked this change:
https://gist.github.com/liuyq/6255f2ccd98fa98ac0ed296a61f49883

Could you please help to check it again?
Please let me know if there is anything I could provide for the investigation.

Thanks,
Yongqin Liu
>  drivers/net/usb/ax88179_178a.c | 37 ++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 377be0d9ef14..a0edb410f746 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -174,6 +174,7 @@ struct ax88179_data {
>         u32 wol_supported;
>         u32 wolopts;
>         u8 disconnecting;
> +       u8 initialized;
>  };
>
>  struct ax88179_int_data {
> @@ -1672,6 +1673,18 @@ static int ax88179_reset(struct usbnet *dev)
>         return 0;
>  }
>
> +static int ax88179_net_reset(struct usbnet *dev)
> +{
> +       struct ax88179_data *ax179_data = dev->driver_priv;
> +
> +       if (ax179_data->initialized)
> +               ax88179_reset(dev);
> +       else
> +               ax179_data->initialized = 1;
> +
> +       return 0;
> +}
> +
>  static int ax88179_stop(struct usbnet *dev)
>  {
>         u16 tmp16;
> @@ -1691,6 +1704,7 @@ static const struct driver_info ax88179_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1703,6 +1717,7 @@ static const struct driver_info ax88178a_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1715,7 +1730,7 @@ static const struct driver_info cypress_GX3_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset = ax88179_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1728,7 +1743,7 @@ static const struct driver_info dlink_dub1312_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset = ax88179_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1741,7 +1756,7 @@ static const struct driver_info sitecom_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset = ax88179_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1754,7 +1769,7 @@ static const struct driver_info samsung_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset = ax88179_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1767,7 +1782,7 @@ static const struct driver_info lenovo_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset = ax88179_reset,
> +       .reset = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1780,7 +1795,7 @@ static const struct driver_info belkin_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop   = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1793,7 +1808,7 @@ static const struct driver_info toshiba_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1806,7 +1821,7 @@ static const struct driver_info mct_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop   = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1819,7 +1834,7 @@ static const struct driver_info at_umc2000_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop   = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1832,7 +1847,7 @@ static const struct driver_info at_umc200_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop   = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> @@ -1845,7 +1860,7 @@ static const struct driver_info at_umc2000sp_info = {
>         .unbind = ax88179_unbind,
>         .status = ax88179_status,
>         .link_reset = ax88179_link_reset,
> -       .reset  = ax88179_reset,
> +       .reset  = ax88179_net_reset,
>         .stop   = ax88179_stop,
>         .flags  = FLAG_ETHER | FLAG_FRAMING_AX,
>         .rx_fixup = ax88179_rx_fixup,
> --
> 2.44.0
>


-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

