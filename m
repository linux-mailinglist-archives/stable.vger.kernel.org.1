Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F130971A2FA
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjFAPqN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjFAPqN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 11:46:13 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5361AB
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 08:46:00 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-568bb833462so10790347b3.1
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685634359; x=1688226359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK++hCc3Kaa6rVR2tRc/cBHa9d+ElfAnOdD5gP7vndU=;
        b=TLtgB2J2XDcfMWr7S6pByOT+d5roiQIGuW6qafTRGOZZTGHEkznrIdeGVWQ5Zase2+
         u/1MdzAY+KGEz6f5sonB/OO1lrtpncymqcWS3BeWvFd2sqlASQtVmMCYghzlsDI1q7++
         ac23XwjoGaQBMUwkg1pBiuCmN+LapFy6DP1u35nngOByswvTDJas2dysGmyeIE56mU6D
         PCo1zHkxlBhPEz+qLy37Ay7tUGjGU6r9HHxbTo3ykmx2/ijeSsem1qlgWQvlkZcB2ZRH
         /ztI2Zpf1mCTHd1zEpuiOTn3ySL/ZjvC/HzYZxZ0oKQJz8Y6DR8iaB0lSYNDn3Vb6qnI
         Hmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685634359; x=1688226359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK++hCc3Kaa6rVR2tRc/cBHa9d+ElfAnOdD5gP7vndU=;
        b=LfvOVBlJT9U3i/X9rVCGM2SzEd1hh+pzTVjC1snOp/yaERGjLH4BXjDYSgcQ9+qMy5
         OA3n4oEoG2gQb2r/rubP/Tv4tB+YnYdy8uYKgBAiKRUriCdxtfEzAdkdSGz1LLiJt2SO
         jM9e/jZQkiFSxcn3yrDGsZOryZ0n1yPrMoZnU9dbFiHsg+UrXOY08ErTNkle5yI9CCLX
         kf5mep1W/fELEtWnysy1l6eHdhU25GjDupFuOfu8yw5fMUbHQMlL/cZDFoHTrEX3Yl7D
         MkiSq8Qv2/Wq5F6925XqCde74a3Z6VU1BgpQlRdm6++ULokIYp3qgEzET/2ZjOAApo5O
         8osA==
X-Gm-Message-State: AC+VfDxFYVUtJjNF+9CzLMp+Pm7stEOmELNbVgymxTxuiqRcsEMeaG3l
        CjYocrtCI2GnO7ViC1D3lEt1ir/hxo+zx1OKHlLPvIifP4HVNJg=
X-Google-Smtp-Source: ACHHUZ7dxX/2cdCjVOasEILYSCRoosOGFfeam5Ut/zrQ7ESAB35JRV9ZsvgV8QStSe7BA27iLPSnfJ2rtH9l5/Z7IbA=
X-Received: by 2002:a0d:d9d5:0:b0:559:e8c2:6a1a with SMTP id
 b204-20020a0dd9d5000000b00559e8c26a1amr9755643ywe.18.1685634359628; Thu, 01
 Jun 2023 08:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <CAHC9VhTmKbQFx-7UtZgg8D+-vtFOar0dMqULYccWQ2x7zJqT-Q@mail.gmail.com> <bb1e18f8-9d31-1ec7-d69a-2d1f5af31310@amazon.com>
In-Reply-To: <bb1e18f8-9d31-1ec7-d69a-2d1f5af31310@amazon.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 11:45:48 -0400
Message-ID: <CAHC9VhTFzN_Y_7HBroJnbTHL2NZEYjFy9BB3JJJBKnwv_k25dw@mail.gmail.com>
Subject: Re: Possible build time regression affecting stable kernels
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     sashal@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
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

On Thu, Jun 1, 2023 at 11:03=E2=80=AFAM Luiz Capitulino <luizcap@amazon.com=
> wrote:
> On 2023-06-01 10:27, Paul Moore wrote:
> > On Wed, May 31, 2023 at 10:13=E2=80=AFPM Luiz Capitulino <luizcap@amazo=
n.com> wrote:
> >>
> >> Hi Paul,
> >>
> >> A number of stable kernels recently backported this upstream commit:
> >>
> >> """
> >> commit 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5
> >> Author: Paul Moore <paul@paul-moore.com>
> >> Date:   Wed Apr 12 13:29:11 2023 -0400
> >>
> >>       selinux: ensure av_permissions.h is built when needed
> >> """
> >>
> >> We're seeing a build issue with this commit where the "crash" tool wil=
l fail
> >> to start, it complains that the vmlinux image and /proc/version don't =
match.
> >>
> >> A minimum reproducer would be having "make" version before 4.3 and bui=
lding
> >> the kernel with:
> >>
> >> $ make bzImages
> >> $ make modules
> >
> > ...
> >
> >> This only happens with commit 4ce1f694eb5 applied and older "make", in=
 my case I
> >> have "make" version 3.82.
> >>
> >> If I revert 4ce1f694eb5 or use "make" version 4.3 I get identical stri=
ngs (except
> >> for the "Linux version" part):
> >
> > Thanks Luiz, this is a fun one :/
>
> It was a fun to debug TBH :-)
>
> > Based on a quick search, it looks like the grouped target may be the
> > cause, especially for older (pre-4.3) versions of make.  Looking
> > through the rest of the kernel I don't see any other grouped targets,
> > and in fact the top level Makefile even mentions holding off on using
> > grouped targets until make v4.3 is common/required.
>
> Exactly.
>
> > I don't have an older userspace immediately available, would you mind
> > trying the fix/patch below to see if it resolves the problem on your
> > system?  It's a cut-n-paste so the patch may not apply directly, but
> > it basically just removes the '&' from the make rule, turning it into
> > an old-fashioned non-grouped target.
>
> I tried the attached patch on top of latest Linus tree (ac2263b588dffd),
> but unfortunately I got the same issue which is puzzling. Reverting
> 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5 does solve the issue though.

I'm at a bit of a loss here ... the only thing that seems to jump out
is that the genheaders tool is run twice without the grouped target
approach, but with both runs happening at the same point in the build
and the second run updating both header files, I'm a bit at a loss as
to why this would be problematic.

I don't want to block on fixing the kernel build while I keep chasing
some esoteric build behavior so I'm just going to revert the patch
with a note to revisit this when we require make >=3D 4.3.

Regardless, thanks for the report and the help testing, expect a
patch/revert shortly ...

--=20
paul-moore.com
