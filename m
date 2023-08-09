Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647F4776769
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjHISgN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 14:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHISgN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 14:36:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C89211F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:36:12 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so2188881fa.0
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691606170; x=1692210970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6XaNRnADYL6BfmJLMU8ikF4TaveyP0VMAvN6HyDdfo=;
        b=GeRukGKRMYqxQYoav5mEmzDg+GExj0GSr+1C/1RoPEhsTSXLyseE7R2epxSK1/Y4zN
         E/sJBIyGDRyvFBjYKD/37CaZCASI1CtGIHVkBYgyOltBO9Na3JhLqMmbr1jyzNUocvjD
         ECK9HXlhJzvI6HfYlIW756LDYJKkKgg9i7eIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691606170; x=1692210970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6XaNRnADYL6BfmJLMU8ikF4TaveyP0VMAvN6HyDdfo=;
        b=O/uIsVX9FXK0tn1y8HP7sXo0nxEvDlmA1mv5XSsthBRQQvYtZJIl+uXU3h85mgO06N
         CjRXA7zB0AN+yLQ7tf4lekU/e7nisqu0ustmSXWgkAOQwOckD5pQQOdmGvsTivMXz4yM
         yVR2Ljr2yILHMAfpHCxNg/Rnbai2AAGPFvN2JlCGj9dcp+nPKl7QUubpzBGhpluh8IBf
         YzW+LgBPknOMkNNaxWCSTz+Nfz7qETI5I6jj2t4/3iC1N1w+75Z2+Pe26gkAQC7Ke1lB
         YHKixSbFCCdTygtclQUSVWY1IfpvivzT3bSSf+4rmlkDJOpEDsFApH2y9kXJJqCBH+/3
         y6Fw==
X-Gm-Message-State: AOJu0YxSyDpEOKFLUfOqXxWBWAEU2cDWO2GFITyAnHSJbuvzvPh61ZjM
        IokWGmvvC8MFXKNoMQ6CLKn5LMMKtSYRecFICSavzg==
X-Google-Smtp-Source: AGHT+IGXygtLz02FQtSpXeyHUyBXzsYrmeSt8NX1zrHnO3+oXSuKYWIrjbSoiWc3YJoJ3FlTnX7RlCDbOcgTVrnmCf8=
X-Received: by 2002:a2e:804e:0:b0:2b9:ea17:5580 with SMTP id
 p14-20020a2e804e000000b002b9ea175580mr26304ljg.17.1691606170530; Wed, 09 Aug
 2023 11:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103633.485906560@linuxfoundation.org> <20230809135326.GE3031656@google.com>
 <f47340c6-3c41-1f91-d0f9-fe0b59a23aac@roeck-us.net>
In-Reply-To: <f47340c6-3c41-1f91-d0f9-fe0b59a23aac@roeck-us.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 9 Aug 2023 14:35:59 -0400
Message-ID: <CAEXW_YQ4GqPwvUF8=8CWmdj=cD56v_eEVK-EirsObQXyBDFVpg@mail.gmail.com>
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

On Wed, Aug 9, 2023 at 12:18=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 8/9/23 06:53, Joel Fernandes wrote:
> > On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wrote:
> >> This is the start of the stable review cycle for the 5.15.126 release.
> >> There are 92 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, pleas=
e
> >> let me know.
> >>
> >> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>      https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.126-rc1.gz
> >> or in the git tree and branch at:
> >>      git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> >> and the diffstat can be found below.
> >
> > Not necesscarily new with 5.15 stable but 3 of the 19 rcutorture scenar=
ios
> > hang with this -rc: TREE04, TREE07, TASKS03.
> >
> > 5.15 has a known stop machine issue where it hangs after 1.5 hours with=
 cpu
> > hotplug rcutorture testing. Me and tglx are continuing to debug this. T=
he
> > issue does not show up on anything but 5.15 stable kernels and neither =
on
> > mainline.
> >
>
> Do you by any have a crash pattern that we could possibly use to find the=
 crash
> in ChromeOS crash logs ? No idea if that would help, but it could provide=
 some
> additional data points.

The pattern shows as a hard hang, the system is unresponsive and all CPUs
are stuck in stop_machine. Sometimes it recovers on its own from the
hang and then RCU immediately gives stall warnings. It takes 1.5 hour
to reproduce and sometimes never happens for several hours.

It appears related to CPU hotplug since gdb showed me most of the CPUs
are spinning in multi_cpu_stop() / stop machine after the hang.

thanks,

 - Joel
