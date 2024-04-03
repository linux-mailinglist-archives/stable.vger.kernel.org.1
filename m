Return-Path: <stable+bounces-35657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179CF896196
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 02:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B467A284283
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 00:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D476FC6;
	Wed,  3 Apr 2024 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKNG2Hjx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6744C8E
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105203; cv=none; b=BdoC4CgVQjXWKJmXN/5h+wzVpn3mVnlCw5C/mZrc/02SXP35gSAHoCHMCEtHPMXAwGtGIpytMqr77rDCcIXpEZqEPhpcnKySzbZp2rQGc6OjhJmE14+juB10l+rFrstU3mRgVXQos4zfm3UdNpIvuS4Bv/AURXlO/74xPjVQtRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105203; c=relaxed/simple;
	bh=rR9GSoBlk6XW/KN2ZDpu6bfywTMCuRCcbSOhEFxaPIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0uzgPvL0hLdlP0ZiTNp2Ksvq+4GT0RpRRZMdev7KvT1D7qwvQpqx/L4RoutoD7gFJzKheo16qHPOlE5mh1ARt6bJDmVec/ncP45X45X9H4du/CaG7epn2qqN/rxAe9mpink1q8y3wqntSusD+jUhjMiaocoV5DraSSeK52DPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKNG2Hjx; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-430d3fcc511so97701cf.1
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 17:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712105200; x=1712710000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NNuHBBz5fNhwg1IXVySVK08J4FfQhYlFpyyXMgPlIw=;
        b=zKNG2HjxsQEsTacTnAqQIWafPjckV8tLef0ukMYqASSqhnbbTgqzKiEsbLjNUajYCB
         DEAX9TLGNOW0IgvyAS880NawVgZVcf5yFHs9xJPdaO49QERGuuI16L4Aq9egxqgl7Ysg
         k1KJmhYj3aCXV9XFjAqcQ20boXyxhJmUNcQSiqwcQ5j1MgrSkkrUUwf1wJasgsbGyFKU
         EYC8xLRZVN/AZZMqXbTq9M9j9csPRneibTs3IAlqfSJkFkv8UAAsFKf6y27Q3A9QeFxx
         0Q9kmm1mBZLT0YQl/gI2MMXVc97pbi3XISKElZZMQg1MBxhtlK8Vt97Hii2KI08aq6Ir
         04Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712105200; x=1712710000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NNuHBBz5fNhwg1IXVySVK08J4FfQhYlFpyyXMgPlIw=;
        b=WcsfPib6za88ZrqoKfVrT3UqZh85e53TJdyfzegGsOrBb/WZPm+eB88/RRZ5zAmBGx
         PM/qG3rxUOPINpxdesfWnhkn1qWmBh4jB0KDhSU+uAUo9fgoZbJihepRMhndMAJhwUIP
         adN0oiuiQwxiTm3c7+GSC7xWLzPuJup6FoKOU+lT9gFVCys3/yUwXqSIs7rNjrtSDfkz
         Qm5oZ+Ny3poyYVJhLL6vlZHqOP7eDOeTMbjbS9zjz1060Q2mkVzQTf416g3J84CMr/2f
         SpEUb5pFcd5r/mmpOnuUUCsGpSFaUE5K0qW6TJfhCe1un0+0nTKu5+HVFgjTJyd9IvG+
         CUbw==
X-Forwarded-Encrypted: i=1; AJvYcCVTl/J7igCOivoZpvphpFEf9Mu1E/vktVVZlosCIz9C47ELL9xd7Pk28T3xXrBf6JwKm4Ope9jlU7fyDFjMWiIo8IBl++JH
X-Gm-Message-State: AOJu0YxLcLHNiRjNI9JQJB1r18ENk1/CPcoqa7JwijYGjEsMN2NGGX3C
	z+8mGE2gpmMmN8Lyb4G2MedAGzomBcPzC2c9VsLicqrZ8QLoKyJ4pyQiNySDwUJAMe8ZiMJcSil
	oK74PXuU4yo3fBXFY8t/cXyKxQXOejyAB7KkR
X-Google-Smtp-Source: AGHT+IG3Nh5xeWONVj/egqi6H3Fg2V93xZRW/7SNzNwCn3y/D1xKuDiWwP1Re4yzQ3c7avJWMSoInLQSVUBCPKTwuiE=
X-Received: by 2002:a05:622a:407:b0:431:68e6:314c with SMTP id
 n7-20020a05622a040700b0043168e6314cmr57594qtx.29.1712105200256; Tue, 02 Apr
 2024 17:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tQ0L3-34g4t-mzfQIP6KDe5OYelGnEo6Udzq6Kb_nEcljppSQUXOktpE__nL-CdLOu9gW-4tIIbjtSbqrdCrjEkdhZLPiiHTqRcCB6WORuM=@thefossguy.com>
 <ac4246bf3786230eb9ca85b329e7d0df@manjaro.org> <CAGETcx89V5CJrAq6XwuGiusQnkR804pTgYAtS94v7Q+v=Cv+qA@mail.gmail.com>
 <D0A122WK7CB9.33B2TP6UCMJBJ@thefossguy.com>
In-Reply-To: <D0A122WK7CB9.33B2TP6UCMJBJ@thefossguy.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 2 Apr 2024 17:46:04 -0700
Message-ID: <CAGETcx_ToHsp_c+Yt0qqST4Zd-GC7dPn_j=PpB1n1xpZtOnMfg@mail.gmail.com>
Subject: Re: Fixing the devicetree of Rock 5 Model B (and possibly others)
To: Pratham Patel <prathampatel@thefossguy.com>
Cc: Dragan Simic <dsimic@manjaro.org>, sebastian.reichel@collabora.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 4:32=E2=80=AFPM Pratham Patel
<prathampatel@thefossguy.com> wrote:
>
> On Tue Apr 2, 2024 at 4:54 AM IST, Saravana Kannan wrote:
> > On Sat, Mar 23, 2024 at 10:10=E2=80=AFAM Dragan Simic <dsimic@manjaro.o=
rg> wrote:
> > >
> > > Hello Pratham,
> > >
> > > On 2024-03-23 18:02, Pratham Patel wrote:
> > > > I looked at the patch and tried several things, neither resulted in
> > > > anything that would point me to the core issue. Then I tried this:
> > >
> > > Could you, please, clarify a bit what's the actual issue you're
> > > experiencing on your Rock 5B?
> >
> > Pratham, can you reply to this please? I don't really understand what
> > your issue is for me to be able to help.
>
> Hi,
>
> I apologize for not replying. Somehow, I did not notice the reply from
> Dragan. :(
>
> Since this patch was applied, an issue in the Rock 5B's DT has been
> unearthed which now results in the kernel being unable to boot properly.
>
> Following is the relevant call trace from the UART capture:
>
> [   21.595068] Call trace:
> [   21.595288]  smp_call_function_many_cond+0x174/0x5f8
> [   21.595728]  on_each_cpu_cond_mask+0x2c/0x40
> [   21.596109]  cpuidle_register_driver+0x294/0x318
> [   21.596524]  cpuidle_register+0x24/0x100
> [   21.596875]  psci_cpuidle_probe+0x2e4/0x490
> [   21.597247]  platform_probe+0x70/0xd0
> [   21.597575]  really_probe+0x18c/0x3d8
> [   21.597905]  __driver_probe_device+0x84/0x180
> [   21.598294]  driver_probe_device+0x44/0x120
> [   21.598669]  __device_attach_driver+0xc4/0x168
> [   21.599063]  bus_for_each_drv+0x8c/0xf0
> [   21.599408]  __device_attach+0xa4/0x1c0
> [   21.599748]  device_initial_probe+0x1c/0x30
> [   21.600118]  bus_probe_device+0xb4/0xc0
> [   21.600462]  device_add+0x68c/0x888
> [   21.600775]  platform_device_add+0x19c/0x270
> [   21.601154]  platform_device_register_full+0xdc/0x178
> [   21.601602]  psci_idle_init+0xa0/0xc8
> [   21.601934]  do_one_initcall+0x60/0x290
> [   21.602275]  kernel_init_freeable+0x20c/0x3e0
> [   21.602664]  kernel_init+0x2c/0x1f8
> [   21.602979]  ret_from_fork+0x10/0x20

This doesn't make a lot of sense. "remote-endpoint" shouldn't be
related to anything to do with psci cpuidle. I'm guessing something
else is failing much earlier in boot that's indirectly causing this
somehow? Can you please take a look at what's failing earlier and let
us know? Or see what driver probe is failing up to this point but used
to work in the good case.

Also, where is the dts file that corresponds to this board in upstream? Is =
it
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts

>
> > Also, can you give the output of <debugfs>/devices_deferred for the
> > good vs bad case?
>
> I can't provide you with requested output from the bad case, since the
> kernel never moves past this to an initramfs rescue shell, but following
> is the output from v6.8.1 (**with aforementioned patch reverted**).
>
> # cat /sys/kernel/debug/devices_deferred
> fc400000.usb    platform: wait for supplier /phy@fed90000/usb3-port
> 1-0022  typec_fusb302: cannot register tcpm port
> fc000000.usb    platform: wait for supplier /phy@fed80000/usb3-port
>
> It seems that v6.8.2 works _without needing to revert the patch_. I will
> have to look into this sometime this week but it seems like
> a8037ceb8964 (arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from =
rk3588 i2s)
> seems to be the one that fixed the root issue. I will have to test it
> sometime later this week.

Ok, once you find the patch that fixes things, let me know too.

-Saravana

