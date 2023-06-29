Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AFB7429FD
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 17:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjF2Pz0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 11:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjF2PzZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 11:55:25 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E8010FB
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 08:55:23 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-570877f7838so8389637b3.0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688054123; x=1690646123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIsDwhiyJ0pTpu0UYiy2IDAtImTwe3J7ATR6MXDg+hE=;
        b=H86jsrap+OdTRaFtAQzo66Gv3ijAD7UHMOZ1e6tZ6ZuqwBf/N4ozMQeaMTFpw2MEGQ
         ArMnrtm0ED8ELvHY/rjXMOn0BgPwEz/+V5MKVDX3qbD5cH6upe8awvQ2GF9GoPu7o+2H
         jut5eOZnSHsuf+F6z0Fr+gXAFWNlaykcZ6zHfeL5ncfF/+MzAM0is60mKF8FhcYEQGd0
         WRz4BE/XD2kM4GYsr2/cAQ7fjVvtX08DacvXIg9SibGlLrVFT3lMTD87XUoyrbB7YQQS
         M0mC7aCxrjJd0hm7LU1fkOiIopuj3EtabxoFvo7Jxl1AVkPNpLq9to2BOQopvhJRwvML
         vy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688054123; x=1690646123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIsDwhiyJ0pTpu0UYiy2IDAtImTwe3J7ATR6MXDg+hE=;
        b=ewSEt66pFmv9yH6+dFp3FG95RRSA2xGRcO4/LMmF9OjHcCmauen5hBavDwmzwug7bt
         8gGMbod2TAEWhgiIelTLhCTteNKD4PlDg4wGQJNQs9l3Q7QKVWwevwWbpS4EAo5rZOYc
         YntY5Eaz5Ymmkabnu78f5gBBbmvpWkSgCSih3C0S0RYWx3DeTrc3lDIKdqteF+IyO1hq
         4oco3XyPQIzdW10T80ff1DYO06XxPA/J11uSZQx+WxVnb7/G3C5GSym0ajXFWfXiMbpX
         n3dri4FKOEsXe2U646jce1/1YSjUc0vzgSYX9wPQkX2inzrCgCTnDTiWvLHkS+w9xyBR
         I87g==
X-Gm-Message-State: AC+VfDxSe+fGX8aTxaop9T+BTiOKas++zj85nRSDTYawxv2Q69bffuQt
        zqwdU4kQfd/eehvUsW6iBZ1kx3H1t7/y6huWzR+Y
X-Google-Smtp-Source: ACHHUZ4aMI8cozC5G9yyRAEOlD2SHN/GC6qUW4YWrO+RpoNGi5HSOEeCgXxJk+4o6Had7C1DOaulqjbPiGHH+vY1qek=
X-Received: by 2002:a0d:eb93:0:b0:56d:805:1507 with SMTP id
 u141-20020a0deb93000000b0056d08051507mr41021708ywe.16.1688054122976; Thu, 29
 Jun 2023 08:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <2023060156-precision-prorate-ce46@gregkh> <20259cf7-d50d-4eca-482b-3a89cc94df7b@amazon.com>
 <2023060148-levers-freight-5b11@gregkh> <CAHC9VhQ6W4hq3B122BxcrD6h6_-Q1AguFYYLjAbB6ALCbmzDoQ@mail.gmail.com>
 <2023060102-chatter-happening-f7a5@gregkh> <CAHC9VhRuc5jSK7xODqtBvhUmunov+PVVQyLb8oDP8k0pLq_P-g@mail.gmail.com>
 <2023062846-outback-posting-dfbd@gregkh> <CAHC9VhQfWNxP80PRHMM44fkMx8fnuPJ2VyR-mA1WMLwsAevRuA@mail.gmail.com>
 <2023062955-wing-front-553b@gregkh>
In-Reply-To: <2023062955-wing-front-553b@gregkh>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Jun 2023 11:55:12 -0400
Message-ID: <CAHC9VhQ5Mx_BMuTCyMFKeTWkgZsoXxAipzx6YQhrrhNu61_awA@mail.gmail.com>
Subject: Re: Possible build time regression affecting stable kernels
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Luiz Capitulino <luizcap@amazon.com>, sashal@kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 29, 2023 at 4:43=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Wed, Jun 28, 2023 at 07:33:27PM -0400, Paul Moore wrote:
> > > So, can I get a directory list or file list of what we should be
> > > ignoring for the AUTOSEL and "Fixes: only" tools to be ignoring?
> >
> > I've been trying to ensure that the files/directories entries in
> > MAINTAINERS are current, so that is probably as good a place as any to
> > pull that info.  Do the stable tools use that info already?  In other
> > words, if we update the entries in MAINTAINERS should we also notify
> > you guys, or will you get it automatically?
>
> We do not use (or at least I don't, I can't speak for Sasha here, but
> odds are we should unify this now), the MAINTAINERS file for this, but
> rather a list like you provided below, thanks.

Fair enough, if we ever have any significant restructuring I'll try to
remember to update the stable folks.  Although I'm guessing such a
change would likely end up being self-reporting anyway.

> > Regardless, here is a list:
> >
> > * Audit
> > include/asm-generic/audit_*.h
> > include/linux/audit.h
> > include/linux/audit_arch.h
> > include/uapi/linux/audit.h
> > kernel/audit*
> > lib/*audit.c
> >
> > * LSM layer
> > security/
> > (NOTE: the individual sub-dirs under security/ belong to the
> > individual LSMs, not the LSM layer)
>
> So security/*.c would cover this, not below that, right?

Yes, that should work.

> > * SELinux
> > include/trace/events/avc.h
> > include/uapi/linux/selinux_netlink.h
> > scripts/selinux/
> > security/selinux/
>
> Looks good, thanks for this.

Thanks for maintaining the exception list.

--=20
paul-moore.com
