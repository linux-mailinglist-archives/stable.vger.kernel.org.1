Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B4A741C81
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 01:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjF1Xdn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 19:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjF1Xdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 19:33:41 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5D51BDF
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 16:33:39 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-576a9507a9bso1331737b3.1
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687995219; x=1690587219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeFclnybHgjxTOJvmelojoFKWa74D7B3w2LzJzAqi/8=;
        b=bjSJ0idhFa+IRPNbT6obSo/V4vKw15Iykq6aysGwuFPw1bbZsGp9RIxCNuwJkiSTDR
         IvG7xVs5w7hbfjzsg7617aoDRmYmKJpNzBhR16ScbcHJ/NyNQdgdhgmb6jbbmXzdMyjg
         kC4WCC0eP9ulrHNH+rjKgoES3ejj8RJiEZzCk6ZckYlyJC9U9Gt8wq29T4S3k8Var6iB
         yXyGJjGizHu9gFYp9KTahVyKKRxbQDsKSrz11Q0dLYVLQI03m7QKT/vRz0d1YebVi1pz
         10k99SdHPIfLytVcnh9ZdxlOBHfcUevsBaFnfhGvDtwW5eO3wm+irP8o9hgG81IAPV1k
         BKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687995219; x=1690587219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeFclnybHgjxTOJvmelojoFKWa74D7B3w2LzJzAqi/8=;
        b=RKmn5yyV/wwrgx57Q2zjC2j7u8BT1VC1+BWyCGUqs7E8vi2Qug67I1RaGR+6YNzyal
         Qd3NcnADx3MiTZD/MoC/NvX/FDbZhB3BxkUfDx4ZJI9+SH5KmUmGrWXvH3NSGtHT8j69
         Jat1Bvja7d4LA+qYjmHkUlNL330VDkFrHUOfBfDKwgv/4bP7cg9TuZWB2q1H7q8mXgaj
         udgPO4SYohijRAIua/TTExXRdW6e+vctkVhpKWmJ1Cx6JdPDyMHW9EjjX7svNac50Gun
         BCc9uC4fTIk3h23TKrLOYgGJKUnwAjkQUSzlCfe8hhGcXgPzVK2a/np/thgoRFTWcIKA
         QtZQ==
X-Gm-Message-State: ABy/qLaI64JZmH7OVKWUpAau0JcTvvhumoMHUVkTW0BJZfRG7uGtzTWs
        8hhQ6W3G6nN2PBb5Uvq6ODBhBIz/9nIlnnUmI1lC
X-Google-Smtp-Source: APBJJlEO2TPsqir3D6Z32iv7ak8OuBRgDSLoI/e9iKnRB9mBiMglQvnRpl4nfj2y3W0ksi8BClwzcKtw0xnLFatyjA0=
X-Received: by 2002:a81:520c:0:b0:573:284d:6476 with SMTP id
 g12-20020a81520c000000b00573284d6476mr3280323ywb.1.1687995218787; Wed, 28 Jun
 2023 16:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <2023060156-precision-prorate-ce46@gregkh> <20259cf7-d50d-4eca-482b-3a89cc94df7b@amazon.com>
 <2023060148-levers-freight-5b11@gregkh> <CAHC9VhQ6W4hq3B122BxcrD6h6_-Q1AguFYYLjAbB6ALCbmzDoQ@mail.gmail.com>
 <2023060102-chatter-happening-f7a5@gregkh> <CAHC9VhRuc5jSK7xODqtBvhUmunov+PVVQyLb8oDP8k0pLq_P-g@mail.gmail.com>
 <2023062846-outback-posting-dfbd@gregkh>
In-Reply-To: <2023062846-outback-posting-dfbd@gregkh>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Jun 2023 19:33:27 -0400
Message-ID: <CAHC9VhQfWNxP80PRHMM44fkMx8fnuPJ2VyR-mA1WMLwsAevRuA@mail.gmail.com>
Subject: Re: Possible build time regression affecting stable kernels
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Luiz Capitulino <luizcap@amazon.com>, sashal@kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 28, 2023 at 2:33=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Thu, Jun 01, 2023 at 02:39:00PM -0400, Paul Moore wrote:

...

> > We definitely have different opinions on where the -stable bug fix
> > threshold lies.  I am of the opinion that every -stable backport
> > carries risk, and I consider that when deciding if a commit should be
> > marked for -stable.  I do not believe that every bug fix, or every
> > commit with a 'Fixes:' tag, should be backported to -stable.
>
> Ok, I'll not argue here, but it feels like there is a lack of changes
> for some of these portions of the kernel that end up in stable kernels.
> I'll trust you on this.

I don't know what to say here ... aside from the previously discussed
difference of opinion regarding stable tags, we just haven't had many
bad bugs in the LSM layer, SELinux, or audit the past few years.  I'd
like to claim better code, better review, yadda yadda but in reality
I'm sure it's just dumb luck.

> So, can I get a directory list or file list of what we should be
> ignoring for the AUTOSEL and "Fixes: only" tools to be ignoring?

I've been trying to ensure that the files/directories entries in
MAINTAINERS are current, so that is probably as good a place as any to
pull that info.  Do the stable tools use that info already?  In other
words, if we update the entries in MAINTAINERS should we also notify
you guys, or will you get it automatically?

Regardless, here is a list:

* Audit
include/asm-generic/audit_*.h
include/linux/audit.h
include/linux/audit_arch.h
include/uapi/linux/audit.h
kernel/audit*
lib/*audit.c

* LSM layer
security/
(NOTE: the individual sub-dirs under security/ belong to the
individual LSMs, not the LSM layer)

* SELinux
include/trace/events/avc.h
include/uapi/linux/selinux_netlink.h
scripts/selinux/
security/selinux/

--=20
paul-moore.com
