Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC8776786
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 20:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjHISjv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 14:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHISju (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 14:39:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289C5DC
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:39:50 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so1833151fa.3
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691606388; x=1692211188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDpA3TPjDsZcyNcQJPSOOqubO7M5Cub0rju0uQ99gSw=;
        b=LwmKPiVmagqAvTmHyRR6iNihTxZ8WFw1TuBD9eHe/S9oW77gDGU4rsUsDp45syIWQI
         iHqotEDovHPa7TbhdbK7rFblT/16jvSVdb+YG8BcVObg6IrHUUOat/l4DF7aVeyKhGOj
         OszzGdb3wgh2Yh4X/bx29AJZeej+t53bs+iWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691606388; x=1692211188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDpA3TPjDsZcyNcQJPSOOqubO7M5Cub0rju0uQ99gSw=;
        b=Yb2O0HoKbKtpu/NXQbyuZdCnwX931uue0b2IsYeAwhtuxtLtnz/U30VxsluQHI4eFZ
         8Wdn3bKZZkuZmXPnC7/xF9bGgqEBYh5oKoPN9l2SxU2JG+uocP9QKkH9yfgKRcfF0EEW
         5E8N93tFvEZlUZQNx6LUgDFYJS4fPnD4ehtc9PRlcswAV7onbCgdL8Tyh7N8xkxm7U6/
         z2BpeydeEBg6nQkRZbJmTAUptqMKUHqdtl8Kmyyytk17ILNq+b3qcgIQgHFf5hhXZjiU
         j8pX7FlqekIWa/gFpfc5kst+gXumujD7fgTzxMDyAIfFxZEHZcwyEOtaAyAAAazuCSEx
         lV2w==
X-Gm-Message-State: AOJu0YzKvCHE+ICGozBrzkMCNwH6LwE+VaFdqfFoBiN+x3KH4kv5vYYJ
        3E07xJNgrwQ3lgogmHlN3i3xvoDVkiN3hxSVacl7bA==
X-Google-Smtp-Source: AGHT+IHy3NEU9UgVEMkbuYmFBQcXwFYdHQ+pPGMERBY1aNbem7Yi1XcUSDdMcYqv/Jz6BYR9ylR30raLmShqEYuZZbY=
X-Received: by 2002:a05:651c:151:b0:2b7:2ea:33c3 with SMTP id
 c17-20020a05651c015100b002b702ea33c3mr37988ljd.22.1691606388320; Wed, 09 Aug
 2023 11:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103633.485906560@linuxfoundation.org> <20230809135326.GE3031656@google.com>
 <f47340c6-3c41-1f91-d0f9-fe0b59a23aac@roeck-us.net> <CAEXW_YQ4GqPwvUF8=8CWmdj=cD56v_eEVK-EirsObQXyBDFVpg@mail.gmail.com>
In-Reply-To: <CAEXW_YQ4GqPwvUF8=8CWmdj=cD56v_eEVK-EirsObQXyBDFVpg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 9 Aug 2023 14:39:37 -0400
Message-ID: <CAEXW_YRi8cW+jHad8Dm_XTL+-OX7-S0X9TbZOyeOL=Tu9sV_4Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 9, 2023 at 2:35=E2=80=AFPM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
>
> On Wed, Aug 9, 2023 at 12:18=E2=80=AFPM Guenter Roeck <linux@roeck-us.net=
> wrote:
> >
> > On 8/9/23 06:53, Joel Fernandes wrote:
> > > On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wrote:
> > >> This is the start of the stable review cycle for the 5.15.126 releas=
e.
> > >> There are 92 patches in this series, all will be posted as a respons=
e
> > >> to this one.  If anyone has any issues with these being applied, ple=
ase
> > >> let me know.
> > >>
> > >> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> > >> Anything received after that time might be too late.
> > >>
> > >> The whole patch series can be found in one patch at:
> > >>      https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patc=
h-5.15.126-rc1.gz
> > >> or in the git tree and branch at:
> > >>      git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-5.15.y
> > >> and the diffstat can be found below.
> > >
> > > Not necesscarily new with 5.15 stable but 3 of the 19 rcutorture scen=
arios
> > > hang with this -rc: TREE04, TREE07, TASKS03.
> > >
> > > 5.15 has a known stop machine issue where it hangs after 1.5 hours wi=
th cpu
> > > hotplug rcutorture testing. Me and tglx are continuing to debug this.=
 The
> > > issue does not show up on anything but 5.15 stable kernels and neithe=
r on
> > > mainline.
> > >
> >
> > Do you by any have a crash pattern that we could possibly use to find t=
he crash
> > in ChromeOS crash logs ? No idea if that would help, but it could provi=
de some
> > additional data points.
>
> The pattern shows as a hard hang, the system is unresponsive and all CPUs
> are stuck in stop_machine. Sometimes it recovers on its own from the
> hang and then RCU immediately gives stall warnings. It takes 1.5 hour
> to reproduce and sometimes never happens for several hours.
>
> It appears related to CPU hotplug since gdb showed me most of the CPUs
> are spinning in multi_cpu_stop() / stop machine after the hang.
>

Adding to this, it appears one of the CPUs is constantly firing and
reprogramming hrtimer events for some reason every few 100
microseconds (I see this in gdb). My debug angle right now is to
figure out why it does that but collecting a trace is hard as it
appears even trace collection may not be happening once hung and the
only traces I am getting are the ones after the hang recovers, not
during the hang.  I am also trying to see if multi_cpu_stop() can
panic the kernel if it sits there too long.

 - Joel
