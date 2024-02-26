Return-Path: <stable+bounces-23760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD0A868199
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 21:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB541C25AC6
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 20:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18C130AF9;
	Mon, 26 Feb 2024 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Vu0ltbrW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42400130AD5
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977613; cv=none; b=tn1qwGVmHlAsVEydvo+kCwN4ALNPuMYfCTjm1OjHf0PxOFeru1Q/vZSBVKgJ2YGtspWKP7ja4M2Ga8e9+OQrmW/lyDjadAAjZ3smQp8RX5NLVU35EOGqRi/Z8kH5afcubNdsrQ0ahSME3iDdL8aK69K+KkRS70NknpfLlbxMKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977613; c=relaxed/simple;
	bh=pehUlEWHJhuRq9lM7KavvQJzY5vJpoSwudZUjolrSuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNp1Sz24rRc8N0Lovr4p5FJx5etKlp++58Byu1tBtK2Gb2TuB8tt2WDMjYS/2oMmyzcgrllXoGxXkuS5727JJIeanv3Q/pVou04dS0yCwSAaycmFQ26o9/VoALGADnMuUt6xGME/rEBGVIt7QCKnPJGZ10uz06T8Ytd/Vscu9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Vu0ltbrW; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so3195166276.1
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 12:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708977610; x=1709582410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMyH3X6y0ghY91KBV/IXMi8hinan8vTup4YSJD234YQ=;
        b=Vu0ltbrWtBfntQBiqMOXofE/xsoZFs0qnwabmBXg2gZBbRjxNb2r8hC4eBn7FLc99M
         un+ei2VMF9y1YGWnSzSkbs4S7suJNMbjP9H/iEaFRHCjYr4Guni2+3X0H8zN/YElaMED
         Sq1pRyIao3TGcVuFlDUKXP5TZ3WlSSOLr3/d41LYh4cCYppPD8KcSN9xSENfirqlR4vO
         1ypQKraoUEHU0IunmWgzNrVuC/wWapFmyXTfJzjhUTRPfhxpJh46vq/rrGz2xbTViXY0
         wr9YPFH7+jduOS2vyzwn5QF8cU8fBQg05UboGcEtoydnqTQpNWuHf7bU5O8MDs1O8xDe
         4HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708977610; x=1709582410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMyH3X6y0ghY91KBV/IXMi8hinan8vTup4YSJD234YQ=;
        b=LtlEv4G3o6AkXey0U2gbAS84XvrHyfwQg7oyWNV/1+p+LgV3tBeM3YPM/3m35wezM2
         woTcPjLg3nOHSV9uk/tz+R3hU0sla0nB3rnhyiO+o8DNhfrrgOACQf3fKVvTJZcvYIpk
         zAhl/rM+qsrmIJIa/E3bcCqq58LzFctnaHpdA4h29zx7ttju74fQgyoNkpKwyGc+gIRa
         ruWGKGgYNmw83z3lSdosqG1plHn9mx2+HR3FDWyTu8uNcNaDwiKE6LG5iFZYor4ZRoeW
         361s14hGcl8QlEnuhXneDy1qmqA0Do7IU1xDnZdgZX4dl0fCSnIw2Lg6l3jMTgFMe39W
         uP3g==
X-Forwarded-Encrypted: i=1; AJvYcCWjnvYDy9nuGF+6Ky09RlxDb4WOQit3YL/No3t2daMVwvNlgrGuMsAA9p8AeC3mYc1xGnLns8yXJc4E/M0MoLIeIRFwuaT1
X-Gm-Message-State: AOJu0Yysv3T6AKKSo7RS/6yX8FauIWu9drbicmxGOqPDMGLBjuBYYbfA
	4YL1H1xp5GYyhY0kzQytHzQvBa1NY5tgIqugo8mf/D5I1+jE8inLiFdk71z39d8agEAGVSorFKw
	Cjc7ZG9bcd702hlC0/IblnOSia6t/jaJUcup7
X-Google-Smtp-Source: AGHT+IH9gi+JHHei3aslePPRBmX+ggOjwi0k4abScoUltl6mqfTgxhLuJg5zV2FSQNlPizp/84gScLMILBMR1UO0cxY=
X-Received: by 2002:a25:8b89:0:b0:dc6:bbbc:80e4 with SMTP id
 j9-20020a258b89000000b00dc6bbbc80e4mr206159ybl.4.1708977610011; Mon, 26 Feb
 2024 12:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
In-Reply-To: <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Feb 2024 14:59:59 -0500
Message-ID: <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@dig=
ikod.net> wrote:
> >
> > aa_getprocattr() may not initialize the value's pointer in some case.
> > As for proc_pid_attr_read(), initialize this pointer to NULL in
> > apparmor_getselfattr() to avoid an UAF in the kfree() call.
> >
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: John Johansen <john.johansen@canonical.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > ---
> >  security/apparmor/lsm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> If you like John, I can send this up to Linus with the related SELinux
> fix, I would just need an ACK from you.

Reviewed-by: Paul Moore <paul@paul-moore.com>

This patch looks good to me, and while we've still got at least two
(maybe three?) more weeks before v6.8 is tagged, I think it would be
good to get this up to Linus ASAP.  I'll hold off for another day, but
if we don't see any comment from John I'll go ahead and merge this and
send it up to Linus with the SELinux fix; I'm sure John wouldn't be
happy if v6.8 went out the door without this fix.

> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > index 98e1150bee9d..9a3dcaafb5b1 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -784,7 +784,7 @@ static int apparmor_getselfattr(unsigned int attr, =
struct lsm_ctx __user *lx,
> >         int error =3D -ENOENT;
> >         struct aa_task_ctx *ctx =3D task_ctx(current);
> >         struct aa_label *label =3D NULL;
> > -       char *value;
> > +       char *value =3D NULL;
> >
> >         switch (attr) {
> >         case LSM_ATTR_CURRENT:
> > --
> > 2.43.0

--=20
paul-moore.com

