Return-Path: <stable+bounces-238667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ATsHXFK5WlqggEAu9opvQ
	(envelope-from <stable+bounces-238667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:34:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2BF4258FE
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60EA9300440D
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 21:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C03301704;
	Sun, 19 Apr 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGnjblmp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395A2C11DE
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776634473; cv=none; b=gQ5LpRQngfQ/k7HH1jklr7letbAzDEUm2lcNu98qO8b+HjBMwHuID7X++D2sacGW71bGzWeiotBchbkUftHl7zq2l8PAL0Ecl+tPM09CpIgyOEfjXKOGfvBP3hjXP3Z6QFoBTjz/tH+8v2gbgOcjxL0tgUbxJ3Dv2SCn5014d5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776634473; c=relaxed/simple;
	bh=XikKA9okOWpqYy6BizuQYG95CVPEXUggob/mHGCo650=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWu171mRgf7aoaw7BNA1wPSDc2OdjT8AWvNVsvVWSpkp0mcz6KNALVCiNBX1IwkEfZvM/Vs7DVGBKWHrog5476dYyTD9iyqvgHyKMzMxu6V4AWrnmlbY3JE0sLz+kiZ4B/uz1MPWodfMYdo28SSAOSs2bbiCRpU6zy9gRYxQFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGnjblmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47E6C2BCB9
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 21:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776634472;
	bh=XikKA9okOWpqYy6BizuQYG95CVPEXUggob/mHGCo650=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BGnjblmp0/yintTjMODejt0EkQS8DRzgsOAC4fM4wVWMQb8XMTjcXtRYaNbOccbR2
	 Qr2TWXAfIVtwY76dsiUaNZg2iEiuaUF+rybRF7z/qb1Z86Poj4tKw8YJT5mh1MzuWN
	 dspspIFH2K2LjVf0Xi4BQgknubISHS2lbw9UOBuizQbqRIZnfLmFdZV40JYN+ANLKJ
	 E2ud0nisFlt4uKKSlq0Of7TeW+4Gc2sbjWHpwB3UrXcMfTSzLbI9K18VCgOnXB07PQ
	 mKa8sp7mxCHP1k3yd6HAajZeGONjxGqpFmlWZLzRpIpxzboF6D+zerSbSJRl2obZtB
	 6fVT9St44fAqg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a40b2bc96dso2802902e87.3
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 14:34:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/NKBgNDLH5Ug23OZjHPe28SshQwFMiz0Uv0zLDHdLpUxfohivllGkuTmifXWk6+C35Xhk5zPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlqqOVbQUAvlVf7mzkNeIMX0FLvhtjif75yijBIRyQxkW1JwT
	Qyi/v85lx6QiE+UGrgCkE7b5etOewHWtsEb46q0EUN+ZjeqZUi0eH5FUWvrIJ4UjrSVCMgje/1d
	7yvGKyKKwHSp1a6WJL5aWRvMKWgQrQdY=
X-Received: by 2002:ac2:5b4a:0:b0:5a4:178d:9174 with SMTP id
 2adb3069b0e04-5a4178d91bcmr2244072e87.19.1776634471587; Sun, 19 Apr 2026
 14:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413154727.3051321-1-lgs201920130244@gmail.com>
 <CAD++jLnC5MGg1e_Suv6BD_=XKbsn1aLxHxRfCdD3Nos+2XRzfw@mail.gmail.com> <aa801626-2e33-489a-931f-600540fe4ae3@roeck-us.net>
In-Reply-To: <aa801626-2e33-489a-931f-600540fe4ae3@roeck-us.net>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 19 Apr 2026 23:34:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLkv=5rJhGv6t9H-oP9k5MY8s-fH1=gHVC88ctbiaMPC7A@mail.gmail.com>
X-Gm-Features: AQROBzAWdTk5eKPuadf02OlssZp85G7z5VJoMspySJ9Be8ONr5PC74pXWoY6xQM
Message-ID: <CAD++jLkv=5rJhGv6t9H-oP9k5MY8s-fH1=gHVC88ctbiaMPC7A@mail.gmail.com>
Subject: Re: [PATCH] watchdog: ixp4xx: fix reference leak on
 platform_device_register() failure
To: Guenter Roeck <linux@roeck-us.net>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Imre Kaloz <kaloz@openwrt.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[gmail.com,openwrt.org,linaro.org,kernel.org,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238667-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,roeck-us.net:email]
X-Rspamd-Queue-Id: 6E2BF4258FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 11:08=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
> On 4/19/26 13:22, Linus Walleij wrote:

> > Hi Guangshuo,
> >
> > thanks for your patch!
> >
> > On Mon, Apr 13, 2026 at 5:47=E2=80=AFPM Guangshuo Li <lgs201920130244@g=
mail.com> wrote:
> >
> >> ixp4xx_timer_probe() directly returns the result of
> >> platform_device_register(&ixp4xx_watchdog_device). When registration
> >> fails, the embedded struct device in ixp4xx_watchdog_device has alread=
y
> >> been initialized by device_initialize(), but the failure path does not
> >> drop the device reference, leading to a reference leak.
> > (...)
> >
> >> -       return platform_device_register(&ixp4xx_watchdog_device);
> >> +       ret =3D platform_device_register(&ixp4xx_watchdog_device);
> >> +       if (ret)
> >> +               platform_device_put(&ixp4xx_watchdog_device);
> >
> > If the problem in the description is indeed there, it seems the bug
> > is inside platform_device_register(), surely a function returning an
> > error code is supposed to clean up any resources it takes before
> > returning an error. It seems wrong to try to fix this in all the
> > consumers.
> >
>
>  From platform_device_register():
>
> /**
>   * platform_device_register - add a platform-level device
>   * @pdev: platform device we're adding
>   *
>   * NOTE: _Never_ directly free @pdev after calling this function, even i=
f it
>   * returned an error! Always use platform_device_put() to give up the
>   * reference initialised in this function instead.
>   */
>
> Not that any code actually does that as far as I can see, but isn't
> the above doing exactly what the comment suggests ?

Yeah and Johan Hovold wrote that comment and he usually knows
what he's doing so let's go with this then, I'm convinced!

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

