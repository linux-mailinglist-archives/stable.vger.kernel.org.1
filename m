Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3652077A162
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjHLRZe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 13:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLRZd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 13:25:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA8610DD;
        Sat, 12 Aug 2023 10:25:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bcf2de59cso396741866b.0;
        Sat, 12 Aug 2023 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691861134; x=1692465934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPoK3QYVMErj8ksIirupQJBibC077B0dsY9ngGq8Ju8=;
        b=n61mQokqdEtFqPYmBScB5blHewnrXoIcspcb7onC/v/hsbwN++Ne+l24qaHjema8L0
         1hxCo62jaLtLcJ17Lep9dswGVPNQhRvO3FeSSrJLAskYkL5BuZq0+7DAGlcpLKrdpXBW
         lHaY25kcrJTiWY0ihLqq1Zyl2j05E7Rh7tCCeXqQ5Seb0725au6ewdcCz5x5/jJTI8LB
         nOysuxFmymuUhOmZCdxuPOIKEpRR6RFGr0GIAOZ5Zo6Kj9Txgy53ibbmR9faVXmDseyd
         ECcOMScwJiAvJHVmq6NrYtTwAqI79TZJde2qhr9E40S+eMSb+uTr3AonCB7aWRTq5yJD
         JXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691861134; x=1692465934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPoK3QYVMErj8ksIirupQJBibC077B0dsY9ngGq8Ju8=;
        b=iY7FKUY+0WKpEeC7lgHkfqJJvUi/gGWV8FkPo5VOs3/+r9L1JUE2bzkNkZiXSfTcxr
         qpCpauPapvIgLDt1PGqCtsJRb01zUYwBVUZ0O5rbeGXTGVFS7oqLwVQ7L8YSWc3tSB4Q
         0RG7lTw+MLfp9yf8ahIwPPIctVKEKSjMlYhJUGpPHenYgSUfzOegYiW/eTZ0OG87Xa0/
         sthk/pdMsFRIFJhcVmpYxX20ZJTaYvHDuiRQcDFkv6p27bz+YYOYlJ0JjabPQGC+blTM
         jR3JYsOmYZ6Fy9fNU+Imb//rv4l/ph9pb/s8uS8zj1djuQHjCwu/QjM6wefno7puvwHF
         CUFg==
X-Gm-Message-State: AOJu0YzyL+orzDDigMMQGSYykyU5tDYBlMvwsi5HrHmdF86RGfF91fSZ
        JQ+pWSljsj23DFCCUe3JWHV54queAWwq1IhnCt3JsQpRy4U5Mw==
X-Google-Smtp-Source: AGHT+IF1KzCogawe01ORY6XkZAiXa5dXF8kdw11BnogSKsuzn7mSjska2MzGP1MEru7R1gHInTSP3oZu4l0MbLl8HBI=
X-Received: by 2002:a17:906:8315:b0:99c:b65b:54ed with SMTP id
 j21-20020a170906831500b0099cb65b54edmr3936305ejx.60.1691861133704; Sat, 12
 Aug 2023 10:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230812144818.383230-1-hdegoede@redhat.com>
In-Reply-To: <20230812144818.383230-1-hdegoede@redhat.com>
From:   Andrew Kallmeyer <kallmeyeras@gmail.com>
Date:   Sat, 12 Aug 2023 10:25:22 -0700
Message-ID: <CAG4kvq8O1em-DJa6JucOtym-kNxPuGUa+zK8R8PqYPEu2nHBiw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: lenovo-ymc: Only bind on machines with a
 convertible DMI chassis-type
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        platform-driver-x86@vger.kernel.org, Gergo Koteles <soyer@irl.hu>,
        =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Aug 12, 2023 at 7:48=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> The lenovo-ymc driver is causing the keyboard + touchpad to stop working
> on some regular laptop models such as the Lenovo ThinkBook 13s G2 ITL 20V=
9.
>
> The problem is that there are YMC WMI GUID methods in the ACPI tables
> of these laptops, despite them not being Yogas and lenovo-ymc loading
> causes libinput to see a SW_TABLET_MODE switch with state 1.
>
> This in turn causes libinput to ignore events from the builtin keyboard
> and touchpad, since it filters those out for a Yoga in tablet mode.
>
> Similar issues with false-positive SW_TABLET_MODE=3D1 reporting have
> been seen with the intel-hid driver.
>
> Copy the intel-hid driver approach to fix this and only bind to the WMI
> device on machines where the DMI chassis-type indicates the machine
> is a convertible.
>
> Add a 'force' module parameter to allow overriding the chassis-type check
> so that users can easily test if the YMC interface works on models which
> report an unexpected chassis-type.
>
> Fixes: e82882cdd241 ("platform/x86: Add driver for Yoga Tablet Mode switc=
h")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2229373
> Cc: Gergo Koteles <soyer@irl.hu>
> Cc: Andrew Kallmeyer <kallmeyeras@gmail.com>
> Cc: Andr=C3=A9 Apitzsch <git@apitzsch.eu>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Too bad that this caused problems for some people. Thank you for
getting it fixed Hans!

While I had trouble applying this patch as is (maybe the code has
changed a bit since my patch), I was able to manually add these lines
and test this fix on my laptop (Yoga 7 14AIL7). The new device was
found and everything worked as expected.

Tested-by: Andrew Kallmeyer <kallmeyeras@gmail.com>

> Note: The chassis-type can be checked by doing:
> cat /sys/class/dmi/id/chassis_type
> if this reports 31 or 32 then this patch should not have any impact
> on your machine.

My laptop (Yoga 7 14AIL7) has chassis_type 31, just to add more info.
