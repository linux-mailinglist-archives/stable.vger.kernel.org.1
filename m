Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F6E7E83C4
	for <lists+stable@lfdr.de>; Fri, 10 Nov 2023 21:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjKJUbb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 10 Nov 2023 15:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjKJUb2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 10 Nov 2023 15:31:28 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FC835780
        for <stable@vger.kernel.org>; Fri, 10 Nov 2023 04:53:03 -0800 (PST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C466440C4E
        for <stable@vger.kernel.org>; Fri, 10 Nov 2023 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699620780;
        bh=rQz1XEF+09FV0wYKQEHG4CRIbx1Q7DTh+y5gnO8WcbM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=wHEDBtfKxP8I4v1PPlFHdc57CXNQ5DLTw0Abf49NrAjma5acjL1es+d0TwvCo1ooJ
         JtJLYUkXAZTSGV+6ZN0MjfNL6mjVsRYxgsqgym7P9ft9i9p1GKZWWljXEi29xuVdiF
         iKZGo2HkB2XwDVSBzJyEbVIL39wR+bNqhis/Krep6/iv4jF0+qd83oNi1IGolHWbNl
         cJQXva9akeoGdCPCotu5jfoOTVcJ5lm/gFAwYsRvBKFvliA1t62rimlyq3Z0pErMGb
         1jcZI9mcySEwsMnZ9nIPbDi7wgyqXBwmpsQ4ybI2FqhntQ50Q3ksiWCHiuZCxbxLto
         Cgf+RsCNQqN4g==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2804e851d5cso2023832a91.0
        for <stable@vger.kernel.org>; Fri, 10 Nov 2023 04:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699620779; x=1700225579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQz1XEF+09FV0wYKQEHG4CRIbx1Q7DTh+y5gnO8WcbM=;
        b=tCV/KAO/uyBs+HCsXZp9L89WuOYBgs7ac1pZpqSPpMFkuF6xIZfHXFXh4g4IEo8Bt9
         Fmifq7304YPc+pvNcH07nhvwDKyvRr8cVCQVPAJ70cNtOvBNfBzyJCKHz1FX8XeriXCe
         mrRsyKU26sELc56ls4qNO9+U+/FJzQAlcNVkKRjX+RmSmjYfz1rejAkoHT8qui5ESu+K
         u5Bevpe+ZPTk2BjfpFKYfGBR91IjMiAgNEvFDXMcVkOZlqdIVYtwSFDV1n570vkYSBr6
         FA0ircFdlBib1fUyGx1y3xPpzYPDF0Lj2JjaxebdtwK4Nxx0WI8f5O8sWfGAJ/jct9ht
         wkVw==
X-Gm-Message-State: AOJu0Yy4/EXK3HZdYI8OZm5LYsQ4gWZU/yaDU48ZgEs7s4h/9YFwl/RT
        sWDFcT7D6rZXU74+JHanL3TJoElGiUrKTd4rRESOStfB0G9URE9vHDcC3hgfFughYIFbs+GUhGk
        UoCBSM2wIM17JF3RNPqBjI52GtPzVKNuBz0lXIJVzw8Z7R4EC3A==
X-Received: by 2002:a17:90b:1d03:b0:280:4799:a841 with SMTP id on3-20020a17090b1d0300b002804799a841mr4829840pjb.38.1699620779359;
        Fri, 10 Nov 2023 04:52:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnczUq1VC3lW8Z/p4H5gQI8h4wKRWrRJatMYBw6a+WKwY+ovLUCuSr/qS2Bo2wOsiAR0FM2aGrvUeOcuVrw2E=
X-Received: by 2002:a17:90b:1d03:b0:280:4799:a841 with SMTP id
 on3-20020a17090b1d0300b002804799a841mr4829828pjb.38.1699620779062; Fri, 10
 Nov 2023 04:52:59 -0800 (PST)
MIME-Version: 1.0
References: <9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net>
 <CAAd53p7BSesx=a1igTohoSkxrW+Hq8O7ArONFCK7uoDi12-T4A@mail.gmail.com> <a592ce0c-64f0-477d-80fa-8f5a52ba29ea@redhat.com>
In-Reply-To: <a592ce0c-64f0-477d-80fa-8f5a52ba29ea@redhat.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 10 Nov 2023 14:52:45 +0200
Message-ID: <CAAd53p608qmC3pvz=F+y2UZ9O39f2aq-pE-1_He1j8PGQmM=tg@mail.gmail.com>
Subject: Re: [REGRESSION]: acpi/nouveau: Hardware unavailable upon resume or
 suspend fails
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Owen T. Heisler" <writer@owenh.net>, stable@vger.kernel.org,
        regressions@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Hans,

On Fri, Nov 10, 2023 at 2:19=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi All,
>
> On 11/10/23 07:09, Kai-Heng Feng wrote:
> > Hi Owen,
> >
> > On Fri, Nov 10, 2023 at 5:55=E2=80=AFAM Owen T. Heisler <writer@owenh.n=
et> wrote:
> >>
> >> #regzbot introduced: 89c290ea758911e660878e26270e084d862c03b0
> >> #regzbot link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/273
> >> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218124
> >
> > Thanks for the bug report. Do you prefer to continue the discussion
> > here, on gitlab or on bugzilla?
>
> Owen, as Kai-Heng said thank you for reporting this.
>
> >> ## Reproducing
> >>
> >> 1. Boot system to framebuffer console.
> >> 2. Run `systemctl suspend`. If undocked without secondary display,
> >> suspend fails. If docked with secondary display, suspend succeeds.
> >> 3. Resume from suspend if applicable.
> >> 4. System is now in a broken state.
> >
> > So I guess we need to put those devices to ACPI D3 for suspend. Let's
> > discuss this on your preferred platform.
>
> Ok, so I was already sort of afraid we might see something like this
> happening because of:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D89c290ea758911e660878e26270e084d862c03b0
>
> As I mentioned during the review of that, it might be better to
> not touch the video-card ACPI power-state at all and instead
> only do acpi_device_fix_up_power() on the child devices.

Or the child devices need to be put to D3 during suspend.

>
> Owen, attached are 2 patches which implement only
> calling acpi_device_fix_up_power() on the child devices,
> can you build a v6.6 kernel with these 2 patches added
> on top please and see if that fixes things ?
>
> Kai-Heng can you test that the issue on the HP ZBook Fury 16 G10
> is still resolved after applying these patches ?

Yes. Thanks for the patch.

If this patch also fixes Owen's issue, then
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>


>
> Regards,
>
> Hans
>
