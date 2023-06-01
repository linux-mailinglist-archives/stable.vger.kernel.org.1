Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D8671F23A
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 20:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjFASjR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjFASjQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 14:39:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B075C0
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 11:39:12 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bacfc573647so1221265276.1
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685644751; x=1688236751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0ssI00N5M7Eaa0OflhC4rtozCouPpbXY1D8edLXwRs=;
        b=AelmmcLt9ArQgh7cF1nf4WUGTJKh7N3RMc3clEIO26pMDbSLhhiDxPVUZRdc7e3YWV
         PMH3t5hqlaDQfBvmtC1/58+ljiiWM6x41KvEMPCn+JYfJ/IiJSKk3mjdRD11QOgdb8wO
         YDw80TfsvsFgOFN0XmnUF5yTIYw59SUpuibL5YYsfvJQGlLrJeR3rtsxFqOPWuskSTj3
         ObaxId+aF626Q9lL9g3IMlI8xn0H1G3Yd6UapgcbwSMM2r+ZJZIvsVdwW9/AaBUqkSVU
         Wtnf7XP0SmiE18vt1ny7PQUZsN0HhDRSid3fvh7NNDQhWlljef3ku2BtGcNDMvTCnGxS
         GRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685644751; x=1688236751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0ssI00N5M7Eaa0OflhC4rtozCouPpbXY1D8edLXwRs=;
        b=VAuxsmH1htXIIbBIrmb/+X2fwh4MRl6NQ6Dbo0tYpmg48c5MDaPjTthkrtTQpXxY26
         ThsZ7KVg4aPp8JqmML78cUP5yyKWSPGd1xYHeku3wOnAVNtvXnkgGsdPBBiGqbwTXJy9
         3UYnmJyBmU5+IrfTSXE/5XS5cg5UTm3zoMO1ZlFTLE916PK/B5CIqIZ8B8TMC/5Vc075
         yhRsdyjOFjmVPuRdKsEU6JNK17K7ArGBqoXHBsGhrevHLxZQYtifOHdZEe1rdXJOeQkB
         zDjggMYEQSKZx25dxN/hIxenhRfv9dNYkt2Dd7qv8WeYPkr46wLsjCfPzrvsxg0CicL1
         HCRQ==
X-Gm-Message-State: AC+VfDwqWHE9TjGa3Z8av91J8rbQyaghacMZTiWhExuemzSfeFPq5ulw
        Jy+jqx+KR5lc1w6b5Dw5J6rp4myAJ5Fv6Wmr0vQZ
X-Google-Smtp-Source: ACHHUZ7B8Wsr+zR5GbuqU8pGyV8agK0YBuTJTaKmdx+SckPHPtRsf9jrKYGwsAJWdSg5+24z0IywDFMT5QesVDp0Huw=
X-Received: by 2002:a0d:ddd4:0:b0:565:f0bd:edd0 with SMTP id
 g203-20020a0dddd4000000b00565f0bdedd0mr10861050ywe.29.1685644751399; Thu, 01
 Jun 2023 11:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <2023060156-precision-prorate-ce46@gregkh> <20259cf7-d50d-4eca-482b-3a89cc94df7b@amazon.com>
 <2023060148-levers-freight-5b11@gregkh> <CAHC9VhQ6W4hq3B122BxcrD6h6_-Q1AguFYYLjAbB6ALCbmzDoQ@mail.gmail.com>
 <2023060102-chatter-happening-f7a5@gregkh>
In-Reply-To: <2023060102-chatter-happening-f7a5@gregkh>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 14:39:00 -0400
Message-ID: <CAHC9VhRuc5jSK7xODqtBvhUmunov+PVVQyLb8oDP8k0pLq_P-g@mail.gmail.com>
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

On Thu, Jun 1, 2023 at 11:51=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Thu, Jun 01, 2023 at 10:56:24AM -0400, Paul Moore wrote:
> > On Thu, Jun 1, 2023 at 9:20=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > > On Thu, Jun 01, 2023 at 09:13:21AM -0400, Luiz Capitulino wrote:
> >
> > ...
> >
> > > > Yes. I'm reporting this here because I'm more concerned with -stabl=
e kernels since
> > > > they're more likely to be running on older user-space.
> > >
> > > Yeah, we are bug-compatible!  :)
> >
> > While I really don't want to go back into the old arguments about what
> > does, and does not, get backported to -stable, I do want to ask if
> > there is some way to signal to the -stable maintainers that a patch
> > should not be backported?  Anything coming from the LSM, SELinux, or
> > audit trees that I believe should be backported is explicitly marked
> > with a stable@vger CC, as documented in stable-kernel-rules.rst,
> > however it is generally my experience that patches with a 'Fixes:' tag
> > are generally pulled into the -stable releases as well.
>
> Really?

Yes, really.

> Right now we HAVE to pick up the Fixes: tagged commits in those
> subsystems as you are missing lots of real fixes.

This starts to bring us back to the old argument about what is
appropriate for -stable, but I've been sticking as close as possible
to what is documented in stable-kernel-rules.rst which (ignoring
things like HW enablement) advises that only patches which fix build
issues or "serious issues" should be considered for -stable.  I
consider every bug fix that goes into the LSM, SELinux, and audit
trees to see if it meets those criteria, if it does I mark it with a
-stable tag, if not I leave the -stable tag and ensure it carries a
'Fixes:' tag if it makes sense and an appropriate root-cause commit is
identified.

We definitely have different opinions on where the -stable bug fix
threshold lies.  I am of the opinion that every -stable backport
carries risk, and I consider that when deciding if a commit should be
marked for -stable.  I do not believe that every bug fix, or every
commit with a 'Fixes:' tag, should be backported to -stable.

> I just quick looked
> and noticed 8cf0a1bc1287 ("capabilities: fix potential memleak on error
> path from vfs_getxattr_alloc()") which you should have tagged, right?

Nope.  That's a memleak for a weird corner case that isn't really
going to be triggered in practice; it was found only by code
inspection and requires code modification to exercise.  See the
discussion around the original revision for more information:

https://lore.kernel.org/linux-security-module/20221025104544.2298829-1-cuig=
aosheng1@huawei.com/

Can you explain why you HAD to pick up that commit?

> In fact, I've considered most of the LSM code as a "we never tag
> anything for stable so we rely on the Fixes: pickup to clean up after
> us" subsystem.  We have many of those in the kernel, so you are in good
> company :)

That would be amusing if it were correct, but your use of absolutes
betrays you.  Looking at code under security/ from v5.10 to current on
I see 71 -stable tags as of today.  It looks like the last one I
marked was from October of 2022.  We could deep dive more on this, but
I think that's a waste of everyone's time.

> > I could start dropping the 'Fixes:' tag from non-stable tagged
> > commits, but that's a step backwards in my opinion.
>
> If a commit has fixes: why wouldn't it be ok for stable trees?  That
> feels very odd to me.

Backports have risk, and in my opinion not every bug fix rises to the
level of severity to sufficiently counter that risk.  The -stable
kernel documentation seems to support that; if you believe every bug
fix should be backported to the -stable kernels I would suggest you
update the documentation.

> Anyway, if you really want, yes, we can add you to the "list of
> subsystems we do not pick anything for except by explicit cc: stable
> marking" that we have, but note, that feels wrong to me based on the
> very low number of patches being tagged for these directories over time.

That's great, I didn't know you maintained such a list.  Please add
the LSM, SELinux, and audit trees to the subsystems which are only
backported when there is an explicit -stable tag.  It is worth noting
that this should not affect the -stable backport policy for other
LSMs, e.g. AppArmor, although I can mention this list to the other LSM
maintainers as they may want to be added.

--=20
paul-moore.com
