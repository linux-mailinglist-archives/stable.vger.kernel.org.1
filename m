Return-Path: <stable+bounces-6609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A51AD8115F1
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 16:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152E21C20F5B
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A63159E;
	Wed, 13 Dec 2023 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVnbJ9AU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01227EB
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 07:17:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5522ba3f94aso731422a12.1
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 07:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702480625; x=1703085425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFRmR5aw7jYs0R06huL/PXrkIxEyHWBggBrJG8pw4QE=;
        b=dVnbJ9AUAvLHnwvGljtfHAJBxCQXEPRD6GqvRVbE5T7mEiJM00B0J8n0Z1UyMTdjj6
         ouTB9ctGWQ4c342ISNvDZ4mnDAh2JYbn8H+hiPhNGCAl7kufLJWtBe7bfncC8voaTn9K
         4O2solPMhghghDCQZh93TuyVzgYSi+VSPem3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480625; x=1703085425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFRmR5aw7jYs0R06huL/PXrkIxEyHWBggBrJG8pw4QE=;
        b=rUE4VTWAfZdNc2jAm4RaDggzicya6rQbqz0Bar1eSaOaxs90PeHoJgJis4cuciP8a4
         Gb/+bDGMXfL84xef60e7X5syERWKTMRBEwGvJm9OJLM14PcHRlG7odU/ZUqAhpk2BYnJ
         nqE2xR0w2MJgVFvYGpyVrwdf4t0RNbRcBrBSgO9uJA8/58BkX3/CIKkN60/skiers48U
         /JscXuqoxMlA3R4PvGMyN63sHnUd0hgZTf11An2OmpDA9VuN4r+owTqTuqje1oSt7LUz
         IGHOZ9SMG1Ld42CxFaydV1hzg8J4Jt1yXhHUE8yEbLPL930eM7cKylJPKoGHMWmZuee0
         hEIg==
X-Gm-Message-State: AOJu0YySt9Zj7gyNPX2xbP3YucOI49fGP7L1Pa971jtQ3X0mRyNIAvLC
	BD5iQheDQrDrAs77azCEr9jKVohEcA+D4jHJPT69Pg==
X-Google-Smtp-Source: AGHT+IF7a3blg0wFXJfTcuSvG6ETUM29GvKdbS8DdXbJpjVCylcntFX51XreFL7JGvd3LmNKa7zLfQ==
X-Received: by 2002:a17:907:971b:b0:a19:a1ba:bab2 with SMTP id jg27-20020a170907971b00b00a19a1babab2mr2842308ejc.88.1702480625482;
        Wed, 13 Dec 2023 07:17:05 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id tx17-20020a1709078e9100b00a1b75e0e061sm8007205ejc.130.2023.12.13.07.17.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 07:17:05 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso68445e9.0
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 07:17:05 -0800 (PST)
X-Received: by 2002:a05:600c:3648:b0:3f7:3e85:36a with SMTP id
 y8-20020a05600c364800b003f73e85036amr401838wmq.7.1702480624929; Wed, 13 Dec
 2023 07:17:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211182036.606660304@linuxfoundation.org> <ZXi9wyS7vjGyUWU8@duo.ucw.cz>
 <a6af01bf-7785-4531-8514-8e5eb09e207e@roeck-us.net> <ZXliuTqyO_IjlIz7@amd.ucw.cz>
 <2023121342-wanted-overarch-84a7@gregkh>
In-Reply-To: <2023121342-wanted-overarch-84a7@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 13 Dec 2023 07:16:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WK52EjYh0nn8e0PEvY5ovUOn9rymnY09B7SQNgUXymPw@mail.gmail.com>
Message-ID: <CAD=FV=WK52EjYh0nn8e0PEvY5ovUOn9rymnY09B7SQNgUXymPw@mail.gmail.com>
Subject: Re: RTL8152_INACCESSIBLE was Re: [PATCH 6.1 000/194] 6.1.68-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Machek <pavel@denx.de>, Guenter Roeck <linux@roeck-us.net>, grundler@chromium.org, 
	davem@davemloft.net, stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 13, 2023 at 12:50=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 13, 2023 at 08:52:25AM +0100, Pavel Machek wrote:
> > Hi!
> >
> > > > > This is the start of the stable review cycle for the 6.1.68 relea=
se.
> > > > > There are 194 patches in this series, all will be posted as a res=
ponse
> > > > > to this one.  If anyone has any issues with these being applied, =
please
> > > > > let me know.
> > > >
> > > >
> > > > > Douglas Anderson <dianders@chromium.org>
> > > > >      r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
> > > > >
> > > > > Douglas Anderson <dianders@chromium.org>
> > > > >      r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
> > > > >
> > > > > Douglas Anderson <dianders@chromium.org>
> > > > >      r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash=
()
> > > > >
> > > > > Douglas Anderson <dianders@chromium.org>
> > > > >      r8152: Add RTL8152_INACCESSIBLE checks to more loops
> > > > >
> > > > > Douglas Anderson <dianders@chromium.org>
> > > > >      r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
> > > >
> > > > Central patch that actually fixes something is:
> > > >
> > > > commit d9962b0d42029bcb40fe3c38bce06d1870fa4df4
> > > > Author: Douglas Anderson <dianders@chromium.org>
> > > > Date:   Fri Oct 20 14:06:59 2023 -0700
> > > >
> > > >      r8152: Block future register access if register access fails
> > > >
> > > > ...but we don't have that in 6.1. So we should not need the rest,
> > > > either.
> > > >
> > >
> > > Also, the missing patch is fixed subsequently by another patch, so it=
 can not
> > > be added on its own.
> >
> > For the record I'm trying to advocate "drop all patches listed as they
> > don't fix the bug", not "add more", as this does not meet stable
> > criteria.
>
> But the original commit here does say it fixes a bug, see the text of
> the commits listed above.  So perhaps someone got this all wrong when
> they wrote the original commits that got merged into 6.7-rc?  Otherwise
> this seems like they are sane to keep for now, unless the original
> author says they should be dropped, or someone who can test this driver
> says something went wrong.

Right. The patches that "add RTL8152_INACCESSIBLE" to more loops are
bugfixes, but they're not terribly important ones to backport. While
they technically make sense even on older kernels and could
conceivably make the older kernels unload the r8152 driver a little
faster when a device is unplugged, it's not a big deal. On the first
version of the recent patches I didn't even add a "Fixes" tag for them
but I was asked to during the review process.

The "add RTL8152_INACCESSIBLE" patches become more important with
commit d9962b0d4202 ("r8152: Block future register access if register
access fails"). Once you have that it's possible to end up in the
"INACCESSIBLE" situation in response to normal (ish) error handling
and thus you want it to be faster.

Based on our experience in ChromeOS, commit d9962b0d4202 ("r8152:
Block future register access if register access fails") is a pretty
important fix and I would say it should be backported to stable.
Certainly we've backported it to our kernels in ChromeOS. In our case
we made things easier on ourselves by backporting pretty much all
patches to the r8152 driver.

-Doug

