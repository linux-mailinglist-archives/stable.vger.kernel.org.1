Return-Path: <stable+bounces-240571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CVgKSAj62muIwAAu9opvQ
	(envelope-from <stable+bounces-240571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:00:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BF945B085
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B830C300C924
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37547379EE2;
	Fri, 24 Apr 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPVPiTlt"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094737DE9F
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017627; cv=pass; b=kEJaRh/7hlu7sLuQjbV7altwyTs9o5JUT6+/md+DBKQJ9ed590gPdRRv2J6MDDKb58kjQzCgkdeESjh9NFmPDEJApAs3jiBKn+h1GtREBf9/ejsJJUv60ooCLbkR3T7nSV1U/csyE7Mp4jk6UZyEMqpMjQKBU1wzkIaclw3O8u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017627; c=relaxed/simple;
	bh=H9V5KfJK8VWSkWZzm/7oR5jhNPvSpl081u1G+mn469o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/xXDakhIFpHbLRuxVYBOJc9x96GyiZVjY/2x6Pc9A8uXoI5DnEWgjghAn4SI/xMrOeIQ3REddGFRKYA4stnH48egr1MBx1mTvHWJN32tXX8781HV/ITB5tji/OIGHFYS4hNkWFiWXp1Gv6ADVPaqb8XhDjGoA+gmUk08GcoOWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPVPiTlt; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-656d749109cso101539d50.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777017625; cv=none;
        d=google.com; s=arc-20240605;
        b=BMFea9recytJQHL6XKBM5mT7+ASAgV+mLxO/MBG98XMrbR4fq68BVmkPfQLSWiU1zO
         X6z1ZJlAdbCSa+87nA5xZ5ndR9ONcLPpY4A2Kq4l42XCdYl9dM0Fa16dIZzKCTPbyRAd
         q7xlpjjh023gR7T9hdHQi0j0WeTSXmATtDlVPWkv3wiXXSrb+odOq20JF8ilm7sNCtkq
         SABnBh2mKNlUox0RqgxNqSZCpCgnGp3qWxpAZGlwIoGdGB8oER6v7RItLMuQtqnXoQnE
         yvLViac1ae1PI4qC+lvhnsNBREC4Er61BqjzNNarMpl3i7lp2MzWHSj5i8kDO60/oByp
         ELpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7/Pf7FKJvV5p6OiWqf5fVKF7/RdrgTzsTTFg4r2irt0=;
        fh=380ngqXB+z37m4UOtukPWlDY/icpfRmlmNcsBruP5kI=;
        b=ddBODPZEaQqLuofIqJMjK9Tb6M+jmdB7PTXXsu+MxUQe7ux8IsL7sHHl3Vk0OGsiAK
         5J7Ytl88HNagYMObsb0VAcZt0k22/7MVVbhtsSyOCUV/6NUUnBR4/8iHpPp0F+rTGONV
         zjwUxgFJtI2pFrF+581v9yrAzKNPRgnIc3J8CssehnC2AtdLSRlYnhjDhGFrO663Ce1a
         9aIIrktMUBz78E1iVny79T6Q9TaMFlFoZeSpJDHd+O2vAfVsALwgcxsm9/m7roIr+sst
         /oQCOma3aBtI1lczQ0sUoiUhXQF0kOjVX0JOJ87hG+5IsQ7UlJ1Znc6FENTA5FElWp36
         KBMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777017625; x=1777622425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/Pf7FKJvV5p6OiWqf5fVKF7/RdrgTzsTTFg4r2irt0=;
        b=GPVPiTlthl+Wx2vYtWk3vG6wLQh2U64yJG7Xt9nbE6pegZTMnV2Hbi3rOgUs4SnVNq
         QHNWs5dVUqk+d+JEgJ9BbV24jPEKMPLvnacC8ATk5aTdBAoyQGaiNB1DsXZaXkM6GZc/
         d7TdH/DMjZAcvTgVFy1OS8EnCi4+gCHyZz4XlgPUX29Fih3zB1chAy5+nkWO3Rs9fCuy
         NVkVD/k7E4HG8LIHaYju3ZlpO9+Yo7HiVGH/6FpLDIa7zREJyih2XHebynyDI6g1R4gq
         W12pBSPIDLmrGsSNE5o7JWC7ldBGB/B4mmE6n03RvlUs8jTRHJ1PmX3DiZGRwJlmOOeR
         iY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777017625; x=1777622425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/Pf7FKJvV5p6OiWqf5fVKF7/RdrgTzsTTFg4r2irt0=;
        b=RjLwYG6JFWzCh4giJvxxXnPvBc84iJlmQCQIgzTW9HQS8JM/4jvbxPUTzSHCNKPoI1
         RpKvD+r6i/4l3UANoSYn5WOeut3OZOVzUYCYOfD9dngovZfkfC4PkBxcu4ZG4sFcLQEb
         KfaoAdB8QA1dP0P/Ez3N1eR6xjg2hFjfWYRygoo0JemCeuhjujobJPm9yaWhCE/9Rfxe
         y1W6ZHHnV4fZ6FiAwzLSSEz0YZx9NTTV7JZ4igiO+Zyi1DOrOH5aBIKY+R99eTYMzuPh
         sbqKwZ+My2udn+Qy/p/mM0yel/7duwTwIMV3c938kwvC2AjnRyxdLa13QR/8yJhyhubA
         QEkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AwrdV4QRbZci6RpXU8Gmx0ZZO4Nb+lEFkcvxyYI8dmzExZxceJiwX12xYo9hg7erxAcmwTgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RZZDXPqzcyTQBWfZYhlZTgPsDV0Z03cd9pRZOJ1Dei0pKjSt
	oxwe2b2SBw1kfpEFdM1g4nuv/jEsWgYSD9rZR/+Lspz0Kfj47ZhgdMVbHOYZC8l3c5LnGZchrfn
	D7J4EFDAAEXlPVd/VDEANzW7xjKLnLis=
X-Gm-Gg: AeBDiesZE3Zf8RzSKK6CnIT2Id+mZQkXmM0Ji2Uw16LyAAYkfDZSsRoi+rjyHl3dp1H
	EnapOpf2TjWIegONocmK1HgksIma1yiF2TLfrDow45UXrB2UZ6WEu50I0Fl2WZV6U/pKas3QKtQ
	u4fhwJNbmpHTngleL20ignr34v+FAn/nEOKd/P6Xh2vRuekzYcALoSmWJ59IGYMFXoqEiWzhZ5O
	FrSPLdMbfvV2N1amFfF74sNmZXQkRI/R9DG3rG7l0RhW88G44IJ1exgckHUYQJxEj6wM87uPyr3
	AZkoPUgdh+ylB74AZXax
X-Received: by 2002:a05:690e:d42:b0:64e:e896:a7c with SMTP id
 956f58d0204a3-65310acebf1mr26232243d50.55.1777017624640; Fri, 24 Apr 2026
 01:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413154727.3051321-1-lgs201920130244@gmail.com>
 <CAD++jLnC5MGg1e_Suv6BD_=XKbsn1aLxHxRfCdD3Nos+2XRzfw@mail.gmail.com>
 <aa801626-2e33-489a-931f-600540fe4ae3@roeck-us.net> <CAD++jLkv=5rJhGv6t9H-oP9k5MY8s-fH1=gHVC88ctbiaMPC7A@mail.gmail.com>
In-Reply-To: <CAD++jLkv=5rJhGv6t9H-oP9k5MY8s-fH1=gHVC88ctbiaMPC7A@mail.gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:00:10 +0800
X-Gm-Features: AQROBzCp7GbvsKNqFEL0lZZwrTRJ-dOMRbt04jshHAKKnM3_ynbfvbbhROtoI7c
Message-ID: <CANUHTR8SLnhQ_Yx2tXbDcrZfDSXP+dRnNVhq1WbWJuUDvVhPxQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: ixp4xx: fix reference leak on
 platform_device_register() failure
To: Linus Walleij <linusw@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Imre Kaloz <kaloz@openwrt.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 18BF945B085
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240571-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,roeck-us.net:email]

Hi Linus, Guenter,

Thanks for reviewing and discussing this.

On Mon, 20 Apr 2026 at 05:34, Linus Walleij <linusw@kernel.org> wrote:
>
> On Sun, Apr 19, 2026 at 11:08=E2=80=AFPM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> > On 4/19/26 13:22, Linus Walleij wrote:
>
> > > Hi Guangshuo,
> > >
> > > thanks for your patch!
> > >
> > > On Mon, Apr 13, 2026 at 5:47=E2=80=AFPM Guangshuo Li <lgs201920130244=
@gmail.com> wrote:
> > >
> > >> ixp4xx_timer_probe() directly returns the result of
> > >> platform_device_register(&ixp4xx_watchdog_device). When registration
> > >> fails, the embedded struct device in ixp4xx_watchdog_device has alre=
ady
> > >> been initialized by device_initialize(), but the failure path does n=
ot
> > >> drop the device reference, leading to a reference leak.
> > > (...)
> > >
> > >> -       return platform_device_register(&ixp4xx_watchdog_device);
> > >> +       ret =3D platform_device_register(&ixp4xx_watchdog_device);
> > >> +       if (ret)
> > >> +               platform_device_put(&ixp4xx_watchdog_device);
> > >
> > > If the problem in the description is indeed there, it seems the bug
> > > is inside platform_device_register(), surely a function returning an
> > > error code is supposed to clean up any resources it takes before
> > > returning an error. It seems wrong to try to fix this in all the
> > > consumers.
> > >
> >
> >  From platform_device_register():
> >
> > /**
> >   * platform_device_register - add a platform-level device
> >   * @pdev: platform device we're adding
> >   *
> >   * NOTE: _Never_ directly free @pdev after calling this function, even=
 if it
> >   * returned an error! Always use platform_device_put() to give up the
> >   * reference initialised in this function instead.
> >   */
> >
> > Not that any code actually does that as far as I can see, but isn't
> > the above doing exactly what the comment suggests ?
>
> Yeah and Johan Hovold wrote that comment and he usually knows
> what he's doing so let's go with this then, I'm convinced!
>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>
> Yours,
> Linus Walleij

After further checking, this patch is not appropriate for this driver.
ixp4xx_watchdog_device is a static platform_device, and it does not have
a dev.release callback. Calling platform_device_put() on the
platform_device_register() failure path can therefore trigger the missing
release callback warning.

So please disregard this patch. I will drop it and will also go back and
check the other patches I sent for the same pattern, and send follow-ups
where they should be ignored or reverted.

Sorry for the confusion, and thanks again for the review.

Best regards,
Guangshuo Li

