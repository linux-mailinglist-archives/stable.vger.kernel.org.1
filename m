Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFEB742A7D
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 18:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjF2QUY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 12:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjF2QUX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 12:20:23 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638AC2D71
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 09:20:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bd6d9d7da35so783303276.0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688055621; x=1690647621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+KtmUBWxSjriFRLno1dk5SimgpB3VlmZWfUisUgPj4=;
        b=Sge26L/dSUWnnPYSGgzxXYcFdyl4wGANYPKaVQPGn9jodqyxF19+C6H7g05fQDBVar
         6w1zunRpyWy10fZQ/Tm+3ci1gSVT7jBjv5uzISSNJMgwFayzvDVkcltjRKglxSJ5Zj/w
         Nnt6zAHWXUzdOgyJl4GFFIfVbPYtl+tuBIwmvylaBZD7mzhgajBY4f7Y5VmBlIAobkgu
         shoDd+rF5p6BZnareLxzembazcjkZJ23u7fb78fLAONYFkcG7XHPB7Qa4eYTuBzu1HRX
         Iqj8RYSmHW+WCLgE9jKaqtoPhbxL73MsqMm0LNuT662L3E0JuysQGWflkVWuu1OpAtwE
         xybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055621; x=1690647621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+KtmUBWxSjriFRLno1dk5SimgpB3VlmZWfUisUgPj4=;
        b=UD+/ScJF1sumu4RzRNCo1lpfL9wM24N+TR1pTzRto9kBBAYg8XoU51yNcLhglp18vU
         AQx1r1OUQ0/F2nqmVchgCAy4t6XA7bHIWfbi/pBIKwLC1+ulEOpTI6ZRpimN35ckAtYT
         VyI1HLlfuPc6p3ypXOHpiBWYxTTCUQj2WBFtzjYI+qBPx+fbjOWz83C+f4rlEtQ0osNr
         y/9MPxMFUEmkMJ47iWBDBkftHZ8paoe8ODwaeXro8SkAudBMFTU2M9upQ5XnZOHKZm+f
         BWP6WHelkqZbkE7EjYlxaz0+ajhx1kO9WNvUsZx5AXFx1jlaeyOwfs4rct+Zx/on5kxM
         bZlg==
X-Gm-Message-State: ABy/qLafPCvcTbW475/InTfRU6BWLfsLyOYSCKQVua7dh6RS+WHilxdg
        zvDnVqrKGPb9U5faNQj76hsSb+LTHQi1NWT3KUOXtgYFaxOu2kE=
X-Google-Smtp-Source: APBJJlEDaCREW+WJZurDsEEwWolK9WwAHI4wzmjCmeX45sU9hcb4ypTbaobrI04YmJI1cyk9XjRlu9xniPGgYB89UG4=
X-Received: by 2002:a0d:d90a:0:b0:577:3aaf:c876 with SMTP id
 b10-20020a0dd90a000000b005773aafc876mr711535ywe.30.1688055621423; Thu, 29 Jun
 2023 09:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <2023060156-precision-prorate-ce46@gregkh> <20259cf7-d50d-4eca-482b-3a89cc94df7b@amazon.com>
 <2023060148-levers-freight-5b11@gregkh> <CAHC9VhQ6W4hq3B122BxcrD6h6_-Q1AguFYYLjAbB6ALCbmzDoQ@mail.gmail.com>
 <2023060102-chatter-happening-f7a5@gregkh> <CAHC9VhRuc5jSK7xODqtBvhUmunov+PVVQyLb8oDP8k0pLq_P-g@mail.gmail.com>
 <2023062846-outback-posting-dfbd@gregkh> <CAHC9VhQfWNxP80PRHMM44fkMx8fnuPJ2VyR-mA1WMLwsAevRuA@mail.gmail.com>
 <2023062955-wing-front-553b@gregkh> <CAHC9VhQ5Mx_BMuTCyMFKeTWkgZsoXxAipzx6YQhrrhNu61_awA@mail.gmail.com>
 <2023062943-cognitive-basin-2261@gregkh>
In-Reply-To: <2023062943-cognitive-basin-2261@gregkh>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Jun 2023 12:20:10 -0400
Message-ID: <CAHC9VhSvaATiuvB-AP5J16TCNzN8soWeTQAh9mxBP_0gwxT4CA@mail.gmail.com>
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

On Thu, Jun 29, 2023 at 12:07=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
> On Thu, Jun 29, 2023 at 11:55:12AM -0400, Paul Moore wrote:
> > On Thu, Jun 29, 2023 at 4:43=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > > On Wed, Jun 28, 2023 at 07:33:27PM -0400, Paul Moore wrote:
> > > > > So, can I get a directory list or file list of what we should be
> > > > > ignoring for the AUTOSEL and "Fixes: only" tools to be ignoring?
> > > >
> > > > I've been trying to ensure that the files/directories entries in
> > > > MAINTAINERS are current, so that is probably as good a place as any=
 to
> > > > pull that info.  Do the stable tools use that info already?  In oth=
er
> > > > words, if we update the entries in MAINTAINERS should we also notif=
y
> > > > you guys, or will you get it automatically?
> > >
> > > We do not use (or at least I don't, I can't speak for Sasha here, but
> > > odds are we should unify this now), the MAINTAINERS file for this, bu=
t
> > > rather a list like you provided below, thanks.
> >
> > Fair enough, if we ever have any significant restructuring I'll try to
> > remember to update the stable folks.  Although I'm guessing such a
> > change would likely end up being self-reporting anyway.
> >
> > > > Regardless, here is a list:
> > > >
> > > > * Audit
> > > > include/asm-generic/audit_*.h
> > > > include/linux/audit.h
> > > > include/linux/audit_arch.h
> > > > include/uapi/linux/audit.h
> > > > kernel/audit*
> > > > lib/*audit.c
> > > >
> > > > * LSM layer
> > > > security/
> > > > (NOTE: the individual sub-dirs under security/ belong to the
> > > > individual LSMs, not the LSM layer)
> > >
> > > So security/*.c would cover this, not below that, right?
> >
> > Yes, that should work.
> >
> > > > * SELinux
> > > > include/trace/events/avc.h
> > > > include/uapi/linux/selinux_netlink.h
> > > > scripts/selinux/
> > > > security/selinux/
> > >
> > > Looks good, thanks for this.
> >
> > Thanks for maintaining the exception list.
>
> Cool, it's maintained here:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-que=
ue.git/tree/ignore_list
>
> if it's ever needed to be updated in the future.

Noted, thanks.

--=20
paul-moore.com
