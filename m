Return-Path: <stable+bounces-240584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ4pNd0u62mBJgAAu9opvQ
	(envelope-from <stable+bounces-240584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:50:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6708145BB76
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B461830185A3
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0295D35B658;
	Fri, 24 Apr 2026 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSReVLai"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76F33A9F8
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020588; cv=pass; b=gekzqjH2oF+WEvNkLYBtlGWGatAdU5/gaDxDVmPuYdhwK2J8CaPbAnAz8T1FY24umgbW4tV4MqAobWvMPfo3gt5A2id9F4DbP6DzEOXV+cCLx6zDPbXP+dNancEhlvj5dzRujwJVt4CsLUdlpKoxiI2375GttZv+2pq3zMgLClg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020588; c=relaxed/simple;
	bh=bp4CHkwtHm/yNe5ftwnGy+F9/hm5CgtWKfBVgAu3/Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDgDMw8D1W0VUUlBb/ETHLvLYuWmG8yhGiEG59daOBXp4U6IkG7tndjT6xbonjY1MXf2S4s2wcAWirkPnfgk1YFQklKZMRRLMB74Mv9G1u4Ln2+IujZVFa+wmRZ+hBbbxNVRn/09ra5Mgo6a8B9m8zfcuzsxBaJ9l7QuwqlXreg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSReVLai; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65427236e94so4819952d50.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777020586; cv=none;
        d=google.com; s=arc-20240605;
        b=QR5zxKal/40Lfq0N3sOFVKP+26DvacjV7BmtGsUqFI4gvmOH1KoBtRxv9auSc/+xRj
         ZJ5YcrK+8BS5eiMU80pdFeFkrku/X3Td7INbiQJoh3/NcwuNheTOvwEg9SkrFqCow9in
         On+JSqwxhJYJ35I8cxATrC4BcH2k/h/GqzC82okWaJVby02dllYum3Tn43o4cruUCcxn
         PBP15kBBnteyI8keYEa7f0lFKMUOzGpYJy9IViG7glS9GjQKfgSpEHxbi+6cvdL6r4BV
         2by77qzWCAzNaAFSorbX0fouEN0Y5u2gnhuRtWeFWelyig6TFQ7x0Q43eh+uhSPMvEmc
         DrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GQehjiJmR0uqm/keJWoGWadsPstIT7+2ouE9/A7a4oo=;
        fh=Xl+MZLeLMDC+uNVAwUx4bsLSeN3W4H682irRABuXBnw=;
        b=gKP5aVKrRNMFqH4lIOGQG+a6Hs+jqrfg2tQUD175zk/ErSik44d9zXBTvS5q32KDer
         zmqN+xO2Ho7ErxKi7pHLaLloWrz5uHYH9IhmXmNLCKq6RAZDX49jmyZ9jZQnPx60W7/w
         Il/DhOtvEzN3uKG7H+nSkJRFNrXxYao3FTr6UJcOPdHXuAvMtnoh+4PpdriTaFj7z/Ra
         LPr9cVlZaT/3WHlj+feWHA4SAJVEMPlHXO/1xoHoSFhGGnCm4M0KY3zpBDb7zMNwUDKp
         7tu/gf4jqhW66F0t04Hi64aMivHxwtj0GxQIfA2PFKE9igqvSRd+GF7m/4XvVZYRAIqu
         r4+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777020586; x=1777625386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GQehjiJmR0uqm/keJWoGWadsPstIT7+2ouE9/A7a4oo=;
        b=TSReVLaifvHXCBtS0r8EF1jVDnwKsC+mPkgaJi92LkvXmpxexxTFJkc/Lz6jxkoupZ
         wBF+R/BQwxxqEENUVWXs1PRt4dYTwLxhuy+4G345xvZVkKPTd2Z3kysErrU6+HfFydp8
         MKC38T0KAEHnqebkHyQ/wA0H/lCyoE8J0ti/39EkV10qNftsNa9xtXf1oMreaR6bmsH+
         3SGBNj4rrTVcUU3o0TrSiExl5fkNp7eyZuS/KSD2KTgywJwZDWiO9bdZZkwwNqmXdohN
         AGmEK2XOvAJuYAVjY64o4P+jmp+BtHXdu6IKhzc3rXSisgw82IXCP39Gd4k0f1Wzgjv7
         WEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777020586; x=1777625386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQehjiJmR0uqm/keJWoGWadsPstIT7+2ouE9/A7a4oo=;
        b=I9HFVVdJS1U9M3vqipXs1THuWtwGOSfFcAPt5Q3jJ+qn/wq0Qtaw7zS43gheRdI36p
         ZtpgHYKkrYM0OdYnoYqxu58oGWzjbnaVr151isFbgYaO5NuQmCFvaJsqBKg5V1rbcfNT
         JJ9Z+yMBltsD0TthgPcyTDOJ88HHZxsFZrar32tUIcZFZEMmAEYmVuzQJNuzEs0wXCAS
         ayKiY3jZmIN6+fzy6u16FJSDLZqoJa60S2wlYTO64rs0fASLlryCXbJWkrfL2WXXwZtV
         bpT6BLEfkPRaqV9GCsbrTtvQ8KdIxdI3MkDd6AsDCxnj/13rAXA0QwbCEatpP0O5rRHc
         aULQ==
X-Forwarded-Encrypted: i=1; AFNElJ+88dRAVeIafmIEZIwRUsgsOkPO7bqQMurkN/Nv5fKnokZYb6DaDye+IM715qpM0cUgTlLD0Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykqyGLUtO3z9nuP7PsucXqVHNoSJE9m47exq3tMoFbb2rPre5S
	HXCvFUPiyaTg73mcIUXM/hMPEbf4mC24ND/6sYmBv1mxjxyX9kZhQsaDJJSt7D3P7cq6j+ctRL8
	TORFVXQPIWIuSJjzVBqMF3UTZ02VxgFY=
X-Gm-Gg: AeBDietLRuob70NT5tkWkCRPqRkqmbiyrIAwNizA6DxPerbuhyPwg7onlrcyZCQsgLy
	rKBC1n2cI+pXVWXC3lUXYmC2FIeZ5OFLaD6b/Ix8NZaawKlfP1M+PC2T1ad6eAPI9V9bs2oLWpg
	O2zNbAFNENMIC8/BMJgiEi76d95hYNPaCVkREgBJjhC1xldVP6cvG+Ze51cpF/Lyv1fV3niCaaQ
	nONz8IZOzSUD0mfWbZ0WG7SQyTvwkLhGlr0jCHgTjvkuQoCW5af8kja/DXRtzTHSrJQEhlRdr4o
	8H2I24IujNjH45jMQvr6
X-Received: by 2002:a05:690e:b46:b0:654:5d65:9fe1 with SMTP id
 956f58d0204a3-6545d65a50emr8674290d50.8.1777020586306; Fri, 24 Apr 2026
 01:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415183436.3763871-1-lgs201920130244@gmail.com> <463cec4f-a038-4bd0-90df-76e0ef48381c@kernel.org>
In-Reply-To: <463cec4f-a038-4bd0-90df-76e0ef48381c@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:49:32 +0800
X-Gm-Features: AQROBzDc9asseH5Q--_xHnSI-mK1kVwpFsYPD_rv0VNAvdsqutw3hyErl1PRuZo
Message-ID: <CANUHTR-Oe3ztfvn-jUEarCKZa-74kmOQiNMQKtoiT58pCneaYg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_accent: fix reference leak on failed device registration
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk@dyn-67.arm.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6708145BB76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240584-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Jiri,

Please disregard this patch.

On Thu, 16 Apr 2026 at 14:14, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Hi,
>
> On 15. 04. 26, 20:34, Guangshuo Li wrote:
> > When platform_device_register() fails in accent_init(), the embedded
> > struct device in accent_device has already been initialized by
> > device_initialize(), but the failure path returns the error without
> > dropping the device reference for the current platform device:
> >
> >    accent_init()
> >      -> platform_device_register(&accent_device)
> >         -> device_initialize(&accent_device.dev)
> >         -> setup_pdev_dma_masks(&accent_device)
> >         -> platform_device_add(&accent_device)
> >
> > This leads to a reference leak when platform_device_register() fails.
>
> What reference exactly?
>
> > Fix this by calling platform_device_put() before returning the error.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
>
> How did you verify you did the right change?
>
> > Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   drivers/tty/serial/8250/8250_accent.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_accent.c b/drivers/tty/serial/8250/8250_accent.c
> > index 1691f1a57f89..e9cf40268c0e 100644
> > --- a/drivers/tty/serial/8250/8250_accent.c
> > +++ b/drivers/tty/serial/8250/8250_accent.c
> > @@ -25,7 +25,13 @@ static struct platform_device accent_device = {
> >
> >   static int __init accent_init(void)
> >   {
> > -     return platform_device_register(&accent_device);
> > +     int ret;
> > +
> > +     ret = platform_device_register(&accent_device);
> > +     if (ret)
> > +             platform_device_put(&accent_device);
>
> In particular, what does put_device() do on a static device, even
> initialized, ie. with no device::release? Try it...
>
> IMO, all the patches are bogus.
>
> thanks,
> --
> js
> suse labs

After re-checking it, accent_device is a static platform_device and it
does not provide a dev.release callback, so calling platform_device_put()
on the platform_device_register() failure path is not appropriate and can
trigger the missing release callback warning.

This falls into the same static platform_device pattern as the other
patches, so I will drop it.

Sorry for the noise.

Best regards,
Guangshuo Li

