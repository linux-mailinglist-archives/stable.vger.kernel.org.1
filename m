Return-Path: <stable+bounces-238166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDGBIUrF32kmYwAAu9opvQ
	(envelope-from <stable+bounces-238166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:05:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7734069CE
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBC4E30F1123
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975E43E51D2;
	Wed, 15 Apr 2026 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2CO8yjU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188103E3C7D
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272179; cv=pass; b=dpvc1+LOiq4ToK2SYnlOKQfw3gYQLuKWzoAFkZB9dgnXwylxbkj35JpRMoIevpiAZ8iD6eM30Xez6x8fYNS920VjfROeJ6iwPdYFwzlac/YRtCTmFvE4OEJ9iGg9kpt9VW1TsydJOk+I52lwbihG/v2xw69/YBQRKpmjHyf6VMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272179; c=relaxed/simple;
	bh=5epuAobbYmsxoedp3xAwQFuZrWLlYCQPKXraMn3SjRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rbw7vDfln75hBVTIuL6SkWxRegHM9uHIc9CJ5uS2VN7zL/M5TaqSDjiluqaeartNZ8cOzAt7DnBjbGo6fCuOuTz8VO4R7y/v/yqYIBLfepVT6nv83FkSdp0qVVfGdF0QWCrPG7s3I38HzTwx/7dwYcIEWtExdErIJTppkjMKYR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2CO8yjU; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6501725d888so5563579d50.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776272177; cv=none;
        d=google.com; s=arc-20240605;
        b=OznFuYzxnVjwCaR8gJVZHO9MBlb//hgcISZobyXzkqaEn58ge63g+ITO9cVoeiiKw9
         Suj+o4B904PjQ38/poV8w7FBqT9rGFZWupPG+ee7UIKJ2ogCz5RKVXCGdtNxCYY4hDua
         rMiwNUjWK/a1lLdPkBuCSoja3YkInWFKVH33NhOz4aMoSiQNn0nAISoN4g4FwEQTMn+4
         7YDOAHs0S5ceBRy7lnVHP5X0Rg/M/smU/z7RB5Ydt+6b7m31b97RGLk/Tdyn5grIEwmR
         hum0APt+nzWvwo+2KqELZL2E6//alQIJDL7/N2TIOxcpTJU1b5gDvXgA6qa0nNvWGbor
         R0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DxfxzTbLJENYe0fpAejm84GGliDjSkVvHXvgo3kQKiw=;
        fh=d7EHuue5nGWHrShhKdRxsgeGFy32ofgeU+B+yTvyMzc=;
        b=ElhB6Cd7q5YCX2vyQAwXdGebJcfnwSvVgmxZrDw0jemcPlyYODTCk3IdnQ/M4JHEHn
         RL+LAlp0htjdQ/0Zjh+icB7uSzeBD/r8aSuBWBzgG8gaprS3qw9PAUI10g5fHxkMQqS+
         EFaG2AQGXmH/ovTfjt4xEyKJHw6x71ks7bHGHiN4MMfVFrEVK8oGwcQjoAZMG289BTWk
         nAzx7DUGZocQytXMD1PiWXtwbVxtMDrEYQX9OV1PWfjE5NSlQ7pyC1W1gQFio3EaiGRj
         VMCXC9d/BjQ+UgU1N6o99lJ4lVvKbMeuBH4mKHHuC8mAAvr1DL9Oy1ARb8zTZ+2so5UJ
         zycA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776272177; x=1776876977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DxfxzTbLJENYe0fpAejm84GGliDjSkVvHXvgo3kQKiw=;
        b=L2CO8yjUI0M9naLEKslWmmJBPwCOz84N7R44enYFAg4aaymGVs3R2iWZwhl6HuNNzN
         bDJG3LXmj0sQ7AMmeZVgM7DU+rvWyL48LvN2QC3UiqqbDgZv3p6jW1A99GGyCSfg3T5/
         t3VCdIgBgiKwpXjcTx8lvvHV1SUfQUhoHGWvt28dKy5KICpzDNr3w32fNisIXgnkxZyx
         vOm9CE6AhCMkmA+zkBzYo/X9uyjMPLGv4tJkzPFapHWlbnn1N43KxiwGZaAJyhRtRJ+r
         yg2ArFl20sKu7ACqJmBk/BgsItiBinreqUuKnCG9D54O4Nzv5zuxi1vA8CDWsaH7nYKl
         9y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272177; x=1776876977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxfxzTbLJENYe0fpAejm84GGliDjSkVvHXvgo3kQKiw=;
        b=EWFkdZqTQaP4fCXczWrk6n0JQGHMh9GbNbUkCPKqqYRF8vUff67vQBEw8BkFG4vZmt
         qFtoHixXdpjygY2xzUdqSENnFVOq/7f0Zvo3KlQ0wmOye+d/m9/ppYD3MOffELdixKxU
         AlZH1mXmJwoKf8/LXIY3zQ624vbKBhUfKARqynG7UcZwXHAzfQWUMH9e7kM3j6M98730
         wx7wQtYbtFy7lByC8pyBntk0Zzq7KjlGEuMeizlY2zvauwNfgaxQnIv/kD8eD/KBg9aA
         n8Q1Ljgl4pBAzDyCVdhvUrYuV4rSDQuu4RAdFK/9/0YW4QMQOT2FqyVAV5IFqdK/2vzd
         L6EA==
X-Forwarded-Encrypted: i=1; AFNElJ+C0XHQuCgsN2gWh5tBL6mPmspxWGKIiKF8mfmv9xdRlJau3VyDKxi6mLh8ipx1aCyj3sbP7Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJhBnab0lFoghaUAZH8ZkqREB5G22xvox4WC4v3OlggBFAWQjP
	oCLaDAlrT/MUjprhE9mMDa9jRghcvJuMdJA+5GHOPy6+DRyLQUZEgoUlZAA+rjBk95VwKPAoZpO
	IhQys4k4OwREQ4SP4rVXXZhU+EQNmYWeQiLpJyBM03ANr
X-Gm-Gg: AeBDietE9vSvzBZkgRv3/3CThLl+3EbMJ8/kSUGKi764+EVdYHOq0a1lKv+fl17utHL
	Rz7YyRr07tud6tsNrluLYOBLB4NTJriMl0meIjWMWv0lH19r+C/dNWuYiDjirxSc0fH7hCxD5Uf
	J78YKGOVgof3+KKm/I4HI/IgqsdnvJ42ndAZC+miX7CtIPFBKOGeGutK0+C8FngjjLAXHPrdHit
	1FK0vFtLy89kicuF9JcGl5Psml7mHU6QryhsunxM6dvLBbtm7LcG8CZaddOdFmyqi44W2oZ5Nx0
	trb0CvVyUjeFLIHB9ZE=
X-Received: by 2002:a05:690e:d47:b0:650:3bbc:5375 with SMTP id
 956f58d0204a3-65198a6a25fmr20140207d50.17.1776272177023; Wed, 15 Apr 2026
 09:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415154537.3451732-1-lgs201920130244@gmail.com> <75275f6e-8314-4dd6-a54e-95320c2224e2@linuxfoundation.org>
In-Reply-To: <75275f6e-8314-4dd6-a54e-95320c2224e2@linuxfoundation.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 00:56:05 +0800
X-Gm-Features: AQROBzDWvsozjNU7eDjvF9U_L-zmhpO2iMCzmTSGiAlkEe91aq-uxJImLxVv6s8
Message-ID: <CANUHTR9j8-wHB8rE1zGLaUw4ZyNh2Mq3njFerBoUcVPWAh7w6A@mail.gmail.com>
Subject: Re: [PATCH] media: vimc: fix reference leak on failed device registration
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Dafna Hirschfeld <dafna.hirschfeld@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238166-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2D7734069CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Shuah,

Thanks for reviewing.

On Thu, 16 Apr 2026 at 00:01, Shuah Khan <skhan@linuxfoundation.org> wrote:
>

>
> Can you share your manual review?
>
> Can other static analysis tools for example scripts/coccinelle support
> your findings?
>
> >
> > Fixes: 4babf057c143f ("media: vimc: allocate vimc_device dynamically")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   drivers/media/test-drivers/vimc/vimc-core.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/test-drivers/vimc/vimc-core.c
> > index 15167e127461..fee0c7a09c4f 100644
> > --- a/drivers/media/test-drivers/vimc/vimc-core.c
> > +++ b/drivers/media/test-drivers/vimc/vimc-core.c
> > @@ -421,6 +421,7 @@ static int __init vimc_init(void)
> >       if (ret) {
> >               dev_err(&vimc_pdev.dev,
> >                       "platform device registration failed (err=%d)\n", ret);
> > +             platform_device_put(&vimc_pdev);
>
> Where does platform_device_get() happen when platform_device_register() fails?
>
> thanks,
> -- Shuah

My manual review was based on the platform_device_register() call
chain and its documented lifetime rules.

The relevant code path is:

ret = platform_device_register(&vimc_pdev);
if (ret) {
dev_err(&vimc_pdev.dev,
"platform device registration failed (err=%d)\n", ret);
return ret;
}

and

int platform_device_register(struct platform_device *pdev)
{
device_initialize(&pdev->dev);
setup_pdev_dma_masks(pdev);
return platform_device_add(pdev);
}

If platform_device_add() fails, platform_device_register() returns an
error, but the reference initialized by device_initialize() is still
owned by the caller. The API documentation for platform_device_register()
also explicitly says:

"Never directly free @pdev after calling this function, even if it
returned an error! Always use platform_device_put() to give up the
reference initialised in this function instead."

So there is no matching platform_device_get() on the failure path.
The reference comes from device_initialize(), and platform_device_put()
is needed to drop that initial reference when registration fails.

That was also how I manually confirmed the issue after the tool report:
I checked the platform_device_register() / platform_device_add()
implementation and verified that the vimc failure path returns directly
without calling platform_device_put().

I found this issue using a tool I recently developed. The scan was run
on kernel version v7.0-1262-g4fa12523f7bc.

Thanks,
Guangshuo

