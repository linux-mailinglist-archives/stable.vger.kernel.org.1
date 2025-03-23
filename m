Return-Path: <stable+bounces-125832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AABD2A6CF72
	for <lists+stable@lfdr.de>; Sun, 23 Mar 2025 14:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711237A6033
	for <lists+stable@lfdr.de>; Sun, 23 Mar 2025 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B65BA2E;
	Sun, 23 Mar 2025 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul4qXyL1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0612E3398
	for <stable@vger.kernel.org>; Sun, 23 Mar 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742736047; cv=none; b=JRljlSD531JFLG8FLgTSFMAPQandlFHRAv1TDXX32eACZfYLBpMg0WMW15Eix9v9R9NjpyXc0s7+r3rHKFQL7plCKBr9Zpw5G5BASx/CaS4OEi9nULj3ip0MMdKg6jIdEXgPwAJwlY/TM0iGV/817HcHItRrH5wA9a8pDfkx1Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742736047; c=relaxed/simple;
	bh=oLFQaBENGsu8WfNYw1bXQJwm8HUdUO0m1kjhEIq4O08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jg3y9mQ5UXtYYSXES0FvtQnpVA4Py+7azhg2A417mzfkxuhyaD8SO7/hyulpzCIfQyLsl7DASErHY8yiefHC6ae33ZQfMsTOqB3wUY82LUxm0kKfe18Hod11mnxK5IZDZyjV70hVh4y+IH1ixo5FGnaqaM0TnfsfI38jR4kYMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ul4qXyL1; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd01781b56so48308756d6.0
        for <stable@vger.kernel.org>; Sun, 23 Mar 2025 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742736044; x=1743340844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLFQaBENGsu8WfNYw1bXQJwm8HUdUO0m1kjhEIq4O08=;
        b=Ul4qXyL1KWIV6Hi36qWWQ0FmgN/lGC0zjSe14/HeCQFyquzj0whx927WzXw3Y7bY3v
         MemitBZYqmlSm7+3LVOEPJ4ocaZK+FxWco0OC0dJkogh7qW1w7A+J2bxTOaLIjiYdoUi
         gq1ZyPoCJnwAckPuY4ucaFMnIEVMaptU/Xz+0CUZTpqvPQ2rKRhVrbLFGmHgek7kRxHg
         B1YO2svV8SmJcfgtyuIAv38zL1kILIaLwwGywtPz9aUuNZZfrSxFhMMG0IDQ5w+WEoAU
         CNSOV0rnlkHkJKmHYB/Pdz1qRAYsd/kV0vWSnlqjwONAED2RFv4JqyetVTYt4IZatxrd
         hK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742736044; x=1743340844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLFQaBENGsu8WfNYw1bXQJwm8HUdUO0m1kjhEIq4O08=;
        b=FkrHRUzZlX7dU+HoFYNnbKnfKtzXJIK7hsi2QbKAmc2DAXtg7OkbdvyjWmVYZ1gvT5
         JeoSe/FFovFhbEzrLWqLdtsJjrjS4+SKSKMHY2w0eX6sjoWpdRh3zKQMGA3yWy78ZQWY
         khK+zvTa/9X4Xw2URRTBKIVm5N56pkhfA4EfkWKzy7HBJ6+Ap6lS63YxIST4ZjVIB3Ie
         6fXc71E6Ast3Vq32V76bfJINEcXKfrcVpoxNt4Q8Hk0YG2GQ57c3orHazG4VIRD+Z7dL
         GVgIO8vjdAylIgCAPdgZtJM4uOwr6Jk6ef6+L55ZkgBC7K/9T5Jk6IwXlPPPJt1EY25x
         FNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIAkUeCEVEOTfkGyMhVy+KRebyJaM+AQj+Uz1w7x+X5dfPxW+jQuI518g6+WtKv7U2QA2e9U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoL/5BggzVNmKTecFhlfe4JrSmpqIkBC9r015RslBe0+IP0SAp
	vrhlx9WJtgGMdgmRI4KbPwr54VLts8GganI17NPiYhlvjOL88pZ7rrPdDOnyPSkveLiLNYOQOLg
	rboJCG7oCCpOxMMAdgrTjBoECee8=
X-Gm-Gg: ASbGncu9KzEaJg+Mz5NgRXgyWg6quMIhPYSGHRsft5FtfQGzVoG7KZ3KYMgnCA35MQl
	VV3UY8irKo8ARcxFFwGqUsnUzH9du72rnDelLlkBaoFVZAHdGFqcHPutdEXrL/F7d8KgjQrsvgm
	71H5CTRXBtOrWZ26KjthYH/UMgpscfNbP+6RiAnQ==
X-Google-Smtp-Source: AGHT+IFCDCO2/M93TgpfAkpsO+Lh3Rs7o9HI+eNKf4UjZ8GRRERuWrViMpuNEgNxiPCEKAGDuhYiS9zyTUrP3KJpdmU=
X-Received: by 2002:a05:6214:1d02:b0:6e8:f3ec:5406 with SMTP id
 6a1803df08f44-6eb3f2d741dmr168374656d6.19.1742736044393; Sun, 23 Mar 2025
 06:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001210625.95825-1-ryncsn@gmail.com> <5e7ad224-651c-41aa-8d9b-b9ac43241793@gmail.com>
 <CAHk-=whVD8B=jJveFQGggyHD7srr_43aR96qZicETSNBJ65Akw@mail.gmail.com>
In-Reply-To: <CAHk-=whVD8B=jJveFQGggyHD7srr_43aR96qZicETSNBJ65Akw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 23 Mar 2025 21:20:08 +0800
X-Gm-Features: AQ5f1Jpqq3d1lhfuF5cxAdCPV29dFv7CPM0bzllR-_cdLiN0_GyjxXa3HS4kef8
Message-ID: <CALOAHbAkcuiHWf70sWcYPUoYzm7ifbUihxoCOX9-7s2AgKzejw@mail.gmail.com>
Subject: Re: [PATCH 6.1.y 6.6.y 0/3] mm/filemap: fix page cache corruption
 with large folios
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ryncsn@gmail.com, axboe@kernel.dk, brauner@kernel.org, clm@meta.com, 
	ct@flyingcircus.io, david@fromorbit.com, dhowells@redhat.com, 
	dqminh@cloudflare.com, gregkh@linuxfoundation.org, kasong@tencent.com, 
	sam@gentoo.org, stable@vger.kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 11:54=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 22 Mar 2025 at 05:17, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > At this point, XFS large folios appear to be unreliable in the 6.1.y
> > stable kernel.
>
> I suspect it's a bad idea to start using large folios on stable
> kernels.

It seems that way. Since the 6.1.y stable branch continues to enable
XFS large folios after the page cache corruption issue was resolved,
we considered it safe to keep the feature enabled. As a result, we did
not revert the problematic commit after applying this patch series.

> Even with the page cache corruption fix, 6.1 is old enough
> that I don't know what other fixes have happened since.
>
> It's not like the large folio code has been _hugely_ problematic, but
> there has definitely been various small fixes related to it, and maybe
> some of them have missed stable.
>
> So I think stable should revert the "turn on large folios" in general.

I will send a revert of commit 6795801366da ('xfs: Support large
folios') to the 6.1.y stable.

>
> That said:
>
> > We would appreciate any suggestions, such as adding debug messages to
> > the kernel source code, to help us diagnose the root cause.
>
> I think the first thing to do - if you can - is to make sure that a
> much more *current* kernel actually is ok.
>
> Without a consistent reproducer it's going to be hard to really bisect
> things, but the first step should be to make sure it's not some new
> kind of issue that happens to be unique to what you do.
>
> By "current" I don't necessarily mean "very latest" - 6.14 is going to
> be released this weekend - but certainly something much more recent
> than 6.1-stable.
>
> Because while the stable trees obviously collect modern fixes, subtler
> issues can easily fall through if people don't realize how important a
> particular fix was. Sometimes the "obvious cleanup patches" end up
> fixing things unintentionally just by making the code more
> straightforward and correcting something in the process.
>
> Without any real clues outside of "corruption", it's hard to even
> guess whether it's core MM or VFS code, or some XFS-specific thing.
> There has been large folio work in all three areas.

This issue is particularly challenging to diagnose because there are
no warnings in the kernel log, and the kernel continues to function
perfectly fine even after the application core dump occurs.

>
> So I suspect unless somebody has something in mind, "bisect it" to at
> least partially narrowing it down would be the only thing to do.
> Bisecting to one particular commit obviously is the best scenario, but
> even narrowing it down to "the issue still happens in 6.12, but is
> gone in 6.13" kind of narrowing down might help give people more of a
> place to start looking.

Thank you for your suggestion. I will give it a try, though it might
take some time since we haven=E2=80=99t yet found a reliable way to reprodu=
ce
the issue.

--=20
Regards
Yafang

