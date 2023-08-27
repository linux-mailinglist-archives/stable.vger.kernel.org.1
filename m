Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390AF789C4E
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 10:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjH0Iqk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 04:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjH0IqD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 04:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6DECD5
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 01:45:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AB0E62A34
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 08:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7880C4AF6E
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693125938;
        bh=cUwi/7ZyLSL72EESWe/xmCmGixxpd59pa7G7FzSMtTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WechjIWkC/syN4UUMFj/5srerLE3hChifvuKRRsxcqOCu8Yx8MYEoOsS+Z0xvtdTS
         m8myOR6UyOhpLIlbMx9iHU260+QfMqLFthaXwsaPBuqqdTy8zJ3Q3njW/sqPpNj5AL
         QSVlUOCafXYVgqlShDDYe3T5ybAFqgh8yEOnw1oEHRXCuQshaBwbrk1duvqXt44BiQ
         JAO/0GKYxu9UQLexCzoIaWa1QqGzU+bceMUjZ36Z97sfd3qojVeWoO4cL59Q0DI7+B
         gavLkgX/J4VJgxdM3iDAzdh7pb2CzhcuY4vVLiH8dSIKUtUR4rGjiRZt9blPxsiopJ
         JuZPGrU9L01Kg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso3095230a12.1
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 01:45:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZ89SDdsVXdRB0KAnqCqBpjy/gAISWxrVli3iy4oSjnl4Iz8MX
        3FNsygXyo9av8Z/icubIcOBckY8PPKYyxrsE4d0=
X-Google-Smtp-Source: AGHT+IG1Vg7o7mtRlnu3+tPNZ1WtLXLBOvTOGfxB79XvOONA6cWMOq5QXu3QbimPiIlBhyuBJATGvWlDfnoSFsqoMYw=
X-Received: by 2002:aa7:dccd:0:b0:52a:1d9c:83ff with SMTP id
 w13-20020aa7dccd000000b0052a1d9c83ffmr10992092edu.1.1693125937206; Sun, 27
 Aug 2023 01:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <2023082705-predator-enjoyable-15fb@gregkh> <CAAhV-H5WYTGSvkz6tgZZud7gUOYyQGUXgSY_7ipe_0BGkz=YeQ@mail.gmail.com>
 <2023082731-dotted-plexiglas-ce0d@gregkh>
In-Reply-To: <2023082731-dotted-plexiglas-ce0d@gregkh>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 27 Aug 2023 16:45:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5AeBZ9nsmkXi5tjo6r_+JAc=6rvxZvHQHtp8M8EVCX+A@mail.gmail.com>
Message-ID: <CAAhV-H5AeBZ9nsmkXi5tjo6r_+JAc=6rvxZvHQHtp8M8EVCX+A@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] LoongArch: Ensure FP/SIMD registers in the
 core dump file is" failed to apply to 6.4-stable tree
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     chenhuacai@loongson.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 27, 2023 at 4:38=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Aug 27, 2023 at 04:23:35PM +0800, Huacai Chen wrote:
> > On Sun, Aug 27, 2023 at 2:45=E2=80=AFPM <gregkh@linuxfoundation.org> wr=
ote:
> > >
> > >
> > > The patch below does not apply to the 6.4-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git comm=
it
> > > id to <stable@vger.kernel.org>.
> > >
> > > To reproduce the conflict and resubmit, you may use the following com=
mands:
> > >
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git/ linux-6.4.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 656f9aec07dba7c61d469727494a5d1b18d0bef4
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082=
705-predator-enjoyable-15fb@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..
> > >
> > > Possible dependencies:
> > I'm sorry, this is my mistake. 6.4 also need to cut the simd_get()
> > part, because simd is only supported since 6.5
>
> I do not understand, sorry.  Is this relevant for 6.4.y?  If so, can you
> provide a working backport?
Sorry to bother you. Please give up backporting this patch, I found
that there are some dependencies but they shouldn't be backported to
stable branches.
Sorry for that again.

Huacai
>
> thanks,
>
> greg k-h
