Return-Path: <stable+bounces-43695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E548C439E
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA391F21AD7
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768325672;
	Mon, 13 May 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MlxoQiCX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7A4C6D
	for <stable@vger.kernel.org>; Mon, 13 May 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612292; cv=none; b=syWRQAeO5RGD0zVlNaWhLt9UEkld9hB0tgXJnFudVdVcT7lKbXwd0Vb4+etZHsJagG55iVm0AEPuaNmIYixAOgwuWn/R/F6tTMXz8jbZ1RPH2a5jdLS0Gd8DNUVDBlKvuTeC8k4HdPqk3oe4t4STCkBU6p3Em0z0XIqcW82wB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612292; c=relaxed/simple;
	bh=j9bZZti+9FQ+7r5shz9bNfaDhSYxfYzTp3+5PA+YT2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhXqnRa6Q49+xy3qpyG7+BzYsXFBvcHRs6laTuvnb4xzTfi4BI51mH0aBfy5YpAThd/ckGq5VKWT0tlRoFz1mmsqCM0EXm+H0UFYoti0h77jvIZZpO/v11hyu0tqbTP1ZXKDyEji1UzbV5fzha1meteE+yBS3ULAZ+8TbqUAtr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MlxoQiCX; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc71031680so4685502276.2
        for <stable@vger.kernel.org>; Mon, 13 May 2024 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715612288; x=1716217088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M0SyizaRAHUtRPojEicOMbmKA68tXqqO+2+to/w/2k=;
        b=MlxoQiCXSbrfMPXkGp2CySc5KaQkGq4Lb35ptU6hanGbEN0eefxIMEFmO8kqSY/z31
         1hZSAoZtQLSjl+3E4S3icY0v9aT++r/mSboTlo537FdpEFrEXAuCkI7fYDMwptNvwT8m
         XcI7BmZHgPJAdZQWN0xpyRG6Yae44SqlOS1OhzXaO/vZ/XYjQ83q7fmCfowOP4TwC2EN
         38aCZX2r1aAwtdqGpUWpqu3fPBUWxku4JHE2zoIyCb4Mrn04fVauh8/OOoflfoOEkrwS
         VO+KKuN+QhvyJgAb5E5e1ki7klFsPz3CE2rs6b+i3hvQCZ8McPk1UgJtWIrniTkBicDv
         7J1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612288; x=1716217088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M0SyizaRAHUtRPojEicOMbmKA68tXqqO+2+to/w/2k=;
        b=g/httFkKGLCGSWDBPAY0+L3Hv7tgVyY6LUzYclIY2fy3MdT/I6PaZhwoQPrQSveNHY
         0bg4pBMsWWwJKbRHLcjkLq1Kt00vNFVwCDKMo0VLnaLn+8aPgDS1/913MtAdWBrFIJtv
         EZOywEhEUc7vfmiakdewWYVySiUngS7CNH/O+BXDfEBHiMj5C1BOE0TNh4GGQ9VwGcnx
         K128VccSIk53mObK4J38ByuSwajlcLsxDpL7uMIgm1dAiwJ34oOseacGH9kqQdtoueYM
         +5FD9pnk/w1lKezBVDItTamEVbAhRdrOJpJWuk73nSYPwmlQglyVG+ih9mZm/qAXSPiC
         NUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmhEpFsXH1lCNk/lq+FpBpCN28bKDBBUxkQG7J6iulXrGoyyUE55mEcraHbMEcMa9gegu5r6KSY7pg+syf4FI6PUt0LU0s
X-Gm-Message-State: AOJu0YyH/kK2ttss305Bu2J3EOkBilrsUBmOpSu5qBCaWD+ppYoAHyz4
	yaxjkgMPGvt+KBl9V3mCkYnd7ve/NvmP8Nb/SzynBOhovhjdx7QEME9szMp7IdnFrZT6xc/7qen
	I04ncY6rSAIPoBU5IJ2XvaK/yk+12/iE7KbeN
X-Google-Smtp-Source: AGHT+IHDwN+8pFFHqgzAJfSHa/ND4FCnNNX1ClwsHGCc0PzWIetjNmGPFOImdjRGWe9tJ4iyY/v+WvT8iIXTHbiGQJ4=
X-Received: by 2002:a25:53c7:0:b0:de5:5b9c:4452 with SMTP id
 3f1490d57ef6-dee4f319277mr8718086276.21.1715612288420; Mon, 13 May 2024
 07:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
 <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
 <CAHC9VhQHpZZDOoPcCqRQJeDc_DOh8XGvhFF3M2wZse4ygCXZJA@mail.gmail.com> <147b0637-7423-4abc-b7fe-3d8da2c1e57c@canonical.com>
In-Reply-To: <147b0637-7423-4abc-b7fe-3d8da2c1e57c@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 May 2024 10:57:57 -0400
Message-ID: <CAHC9VhRbHKkdtAC4JWFbWpj=T3MG7wPhH1EHhJomKu+pU6oCQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: John Johansen <john.johansen@canonical.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:10=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 2/27/24 08:01, Paul Moore wrote:
> > On Mon, Feb 26, 2024 at 2:59=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>> On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic=
@digikod.net> wrote:
> >>>>
> >>>> aa_getprocattr() may not initialize the value's pointer in some case=
.
> >>>> As for proc_pid_attr_read(), initialize this pointer to NULL in
> >>>> apparmor_getselfattr() to avoid an UAF in the kfree() call.
> >>>>
> >>>> Cc: Casey Schaufler <casey@schaufler-ca.com>
> >>>> Cc: John Johansen <john.johansen@canonical.com>
> >>>> Cc: Paul Moore <paul@paul-moore.com>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> >>>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> >>>> ---
> >>>>   security/apparmor/lsm.c | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> If you like John, I can send this up to Linus with the related SELinu=
x
> >>> fix, I would just need an ACK from you.
> >>
> >> Reviewed-by: Paul Moore <paul@paul-moore.com>
> >>
> >> This patch looks good to me, and while we've still got at least two
> >> (maybe three?) more weeks before v6.8 is tagged, I think it would be
> >> good to get this up to Linus ASAP.  I'll hold off for another day, but
> >> if we don't see any comment from John I'll go ahead and merge this and
> >> send it up to Linus with the SELinux fix; I'm sure John wouldn't be
> >> happy if v6.8 went out the door without this fix.
> >
> > I just merged this into lsm/stable-6.8 and once the automated
> > build/test has done it's thing and come back clean I'll send this,
> > along with the associated SELinux fix, up to Linus.  Thanks all.
> >
> > John, if this commit is problematic please let me know and I'll send a
> > fix or a revert.
>
> sorry, I am still trying to dig out of my backlog. This is good, you can
> certainly have my ACK, I know its already in tree so no point in adding
> it there but wanted to just make sure its on list

No worries, reviews are still appreciated; just because a patch has
made its way up to Linus is no guarantee there isn't something wrong
with it ;)

--=20
paul-moore.com

