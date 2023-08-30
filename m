Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD5878DB27
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbjH3Sij (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbjH3HcW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 03:32:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD638CCF
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 00:32:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbb3195013so116505ad.1
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693380739; x=1693985539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iz2oCR+RAlpCrkxasky0/cEyFi5EfsfgieHbbEfIWZM=;
        b=yLxBw6Egb45a0joG/LAHUP2vv3u5FOVU8rsczXV7MAXxXuUA3qqj04LC8A/Kvu9vFm
         CeNhIbRL2PPycc2BrqO0l+sDJcRCNVZMIVlI13zGbVM9HDXIWmBk4LB8qFWJRuk3ELEB
         bMlxM9oFaS1QTjfFRgsUdaSES/0CIdzxYHj07K1Bqv/XB0ptcl302L4R7Qe+AqjMCrxE
         co+TE6zQEvwl7JWlNMr6PQqjEuqjjZnmowoOOcmrKvgbEXvolIUxqkVU2TMx2CD4eTfS
         +IKFD7+4CfiGBX9OFZgJCSgaVW6inxpXOWh9J/c1RTv+gcGi7Y+XQF44iqf/FLxPdWhB
         SsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693380739; x=1693985539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iz2oCR+RAlpCrkxasky0/cEyFi5EfsfgieHbbEfIWZM=;
        b=L2sEAfystGBfi16VEsGts2Oqd2KzXGKg/qdph4yoK32UC3prZzM+oDwOx/DwRFOS7E
         Tik9U4M8ZAR9S7blhEErGPunxj6quOpqQZUq1o6YkjIuFaI8AhDRjzgINRz+kr2qGutT
         hHS74srA/DCFbU9P5xAwQq+f/8uJf0FaWGlNxByN3ig5esZBpQRo5bu1RC+HdJxAXKSO
         TbWaLHTqoZAYN0Bntqw793NdQ3/Qh8cAhMvqzsakHdS9yIRXGlPvY8wt8Q4HP9Ly483u
         H6yTfpAlNQ7QhC/rx60vukbqdggXXF2mj077GHA/djWAr8Fh1R8TKR8Tumb6tUHSxYMN
         ANbw==
X-Gm-Message-State: AOJu0YztkqA1EnwSJV8E1Od/rkyCkURuVWhPHzz2GVcTcFbUguqIclNa
        Dj2WCcqhqI6a1yVDlzcXqMnXJaRT81+6iYiiI4gyvg==
X-Google-Smtp-Source: AGHT+IHZDLHCdHYQ9I3MT4mWpxfcxGu0ny/XtY9avjaPygtJms04xIPzZ3tibXlSN07Fmv4Sg13Y6y8nu+j0D9py61Y=
X-Received: by 2002:a17:902:d2c2:b0:1ae:51f3:a4d with SMTP id
 n2-20020a170902d2c200b001ae51f30a4dmr468257plc.13.1693380738930; Wed, 30 Aug
 2023 00:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
 <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
 <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com> <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com>
In-Reply-To: <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com>
From:   =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>
Date:   Wed, 30 Aug 2023 09:31:41 +0200
Message-ID: <CADj_en4MTtqm0VSs2=1K5VB0fpZjga3ttMLE7RoEGQgxvQ8XFA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Sven van Ashbrook <svenva@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        adrian.hunter@intel.com, SeanHY.chen@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        reniuschengl@gmail.com, stable@vger.kernel.org,
        ulf.hansson@linaro.org, victor.shih@genesyslogic.com.tw,
        victorshihgli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 30, 2023 at 4:27=E2=80=AFAM Ben Chuang <benchuanggli@gmail.com>=
 wrote:
>
> Hi,
> On Wed, Aug 30, 2023 at 12:35=E2=80=AFAM Sven van Ashbrook <svenva@chromi=
um.org> wrote:
> >
> > + Rafael for advice on runtime_pm corner cases.
> >
> > On Mon, Aug 28, 2023 at 10:48=E2=80=AFPM Ben Chuang <benchuanggli@gmail=
.com> wrote:
> > >
> > >
> > > My concern is that when runtime_pm is false, gl9763e is disabled LPM
> > > negotiation, gl9763e can't enter L1.x and s0ix may fail.
> > > It seems that runtime_pm will always exist and that's ok.
> > >
> >
> > Thank you. I believe we can address your concern.
> >
> > - XXX_suspend/XXX_resume (i.e. classic suspend/resume) depends on
> >   CONFIG_PM_SLEEP. This always selects CONFIG_PM. This always includes
> >   the runtime_pm framework. So, if XXX_suspend/XXX_resume gets called,
> >   the runtime_pm framework is always present, but may not be actively
> >   managing the device.
> This is ok.
>
> >
> > - "when runtime_pm is false" AFAIK the only way to disable runtime_pm
> >   when CONFIG_PM is set, is to write "on" to /sys/devices/.../power/con=
trol.
> >   See https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-device=
s-power
> >   In that case, the runtime_pm framework will activate the device, call=
ing
> >   XXX_runtime_resume() if necessary. Are there other ways of disabling =
it?
> >
> > - if /sys/devices/.../power/control is "on", then:
> >   gl9763e_runtime_resume() always called -> LPM always disabled
> >   gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled
> >   In between "classic" XXX_suspend and XXX_resume, LPM will be enabled,
> >   so the device can enter L1.x and S0ix.
> In this cas, after gl9763e_resume(), it is LPM disabled.
> Is there no chance for gl9763e to enter L1.x again when the system is idl=
e?
With runtime PM disabled via sysfs, the short answer is not since
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Df9e5b33934cec24b8c024add5c5d65d2f93ade05.

The longer answer is:
1. System boots up with LPM flags in PCI config space in default value
(might be LPM enabled).
2.1. If runtime PM is disabled before first runtime suspend -
registers will be left in their default state.
2.2. If runtime PM is disabled after first runtime suspend, the device
will be woken up and the gl9763e runtime resume callback will disable
LPM.
>
> >
> > And the LPM negotiation flags look correct.
> > Does that address your concerns?
>
> Best regards,
> Ben Chuang

--
Best Regards,
Stanis=C5=82aw Kardach
