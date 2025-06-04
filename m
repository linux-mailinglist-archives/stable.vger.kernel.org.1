Return-Path: <stable+bounces-151439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D02ACE0F5
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0821189624C
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBAB1C9DC6;
	Wed,  4 Jun 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWKGdiPY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271C54AEE0
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749049769; cv=none; b=TGS3H0s3WkV+uq48C4eMz4Zh1omPI2k9jDeDYecuQRHh1rL9ZU6KGjBJ3q9grZw7zkDiyecu6Px5t9wKgFu9Rbs16JW1H4QcwqpnTsGCcpFHQVFb1PWJFR+5MvP1TLcz8c6aw7HdEnpfSmDIaB+911HNucmA7BSmsRJQm8P21OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749049769; c=relaxed/simple;
	bh=C10TF8pAh03ckQUw312vo4b5sDxnSY7uA1bM1V7VG0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWQxoQMIxbscRl+kV4FwXkYYC0czBkau1NzxQPgCKVhgE1fM3qD2RumCT0aqsh5SIZXPfS14CctgsH7Fthzb0fQsVnTRHJ11SpxBHMHFL53ZCqMEhhqdRixyWXuRDRUup3RCmy+x7HUY3V2zBRet3BZJvHMjEOxVF7ltujYqUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWKGdiPY; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b26fabda6d9so695838a12.1
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749049767; x=1749654567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp7b9UWglKz6wOi8/Z6EppjceiKVGJSk3hfX62HZXNw=;
        b=FWKGdiPY9fo6thKCG+tSkT8ljGdL/If1n5FzZFmaFjB2GmAGqVE+ONuwh8tblLdiG6
         NWnFmtDxiq/S3xpj5tKnNRop72tkswjCUDsF4cGKexTbUogj6Ibgd4ks9ANfdmbr1klV
         emQ07HmhSEZD2/oshf0iRa6/o+IB68qTI/1GuzheU/sSzC73QD+bwNjKn4Ife5rMoF3D
         gSwBCh4kznw2hNW9G/Noj9LRQ4V6dmekoVNkdWE3nFMMG3QqC8bRsQPZOQ4rrLq3d3Fq
         hIs1YiuAX9p3LnRUtNw8mHbDeTalWP2/7eEq37SRZQJSzpJOT50BNO0gOYJVIVMvuF4h
         RbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749049767; x=1749654567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rp7b9UWglKz6wOi8/Z6EppjceiKVGJSk3hfX62HZXNw=;
        b=LrltFFsG+PNr8QXLjbxfs+CCoYddxG/eoZDEHMVpxxMx873E//tUrPwRGQkVR0ipiT
         aAlki4c2R++C61cClAx8Zx+GYyH2HxCKBCyTnQPaMqKtipoN6aTFR519ErTJKILsktqh
         +Aouz12cP2/YxMMmN4Ib/kHGxgtOfGdNshPPGdu7aZj0Mk2hJ/r2cpkPwZYF2FKUU3f0
         ROLioz7iW3MEpogXCwShERc6fWVcbJftJBB9/AGkmuZclUPQHB+TvwJJsewTxTKLLHkH
         ezxyz+V1YHhgPn3ZSZZarncafQtiU0qaDeuYjCT99vaQXPs+dJ6RGpP0RuXr03GMHNhI
         LUVw==
X-Forwarded-Encrypted: i=1; AJvYcCWYh2N+wHjdKG3uDIWqnaflkZ+WYi3jvcmbB9t1IidLNiW1UtZkGLArx6sOoraz6yN/LZW1D+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXgTC5mH3vObV8v/uZi22stKJdXb/Uux2REnEs0FlBgh/MBr39
	B3XqTeVIrp2stxjHFbWjqge+4/f6GuJfMWw9RpQ+vfIT7qxayoKZ57pIkG6QeXPTbsFisI43WDP
	QKw4Cxmrj7i4qFXp2uJakG6WWL4kP/jE=
X-Gm-Gg: ASbGncvQg0iidM/47zK07M8prJvPXwU1viacrm/npH4QuMiwlPYrjwKK5LQP9spqr3G
	EEeFYEiIt5yPQuB4yevp0I8BHQrOsz3BRmP5h/VNqD+n0jZBgHTOWvJxjCcTm2e5B63qK39f4Ol
	uxn48CAGCn4t0XodDh5oIAFE9/ZPCNOkE449Q4rqMsh9BD
X-Google-Smtp-Source: AGHT+IGthoBbpaqBJcrGYHMDUW3KcRg4ercfQBsQMliy5ivIZJikYWNyrmxDmSk4vIwwl3Qj5v5xi3blOFwndRjH62w=
X-Received: by 2002:a17:90b:48c6:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-3130cabf1f7mr1711680a91.0.1749049767203; Wed, 04 Jun 2025
 08:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530200918.391912-1-aurabindo.pillai@amd.com>
 <CADnq5_P1Wf+QmV7Xivk7j-0uSsZHD3VcoROUoSoRa2oYmcO2jw@mail.gmail.com>
 <jn3rvqffhemwjltd6z5ssa2lfpszsw4w7c4kjmkqqbum6zqvmi@pv6x2rkbeys6>
 <CADnq5_PHv+yxYqH8QxjMorn=PBpLekmLkW4XNNYaCN0iMLjZQw@mail.gmail.com>
 <2025060410-skinning-unguided-a3de@gregkh> <od2jpxazsa6ee6fqom7owcgh53lz3wjjjk4scoe2mxjzrytl7f@jwwwxfuo4pkj>
In-Reply-To: <od2jpxazsa6ee6fqom7owcgh53lz3wjjjk4scoe2mxjzrytl7f@jwwwxfuo4pkj>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Jun 2025 11:09:15 -0400
X-Gm-Features: AX0GCFt2PBa2_eEVwZO7kfuI3uEXaUUmdBuNz1Ww735Vt7eI_4g4qnI1dSIpmks
Message-ID: <CADnq5_OdFQhokdysSHdeBca=UViCcqKWmfbedMAadWFWBiNE=Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
	stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 10:55=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello Alex,
>
> On Wed, Jun 04, 2025 at 03:29:58PM +0200, Greg KH wrote:
> > On Wed, Jun 04, 2025 at 09:15:14AM -0400, Alex Deucher wrote:
> > > On Wed, Jun 4, 2025 at 5:40=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@baylibre.com> wrote:
> > > > On Fri, May 30, 2025 at 04:14:09PM -0400, Alex Deucher wrote:
> > > > > Already included in my -fixes PR for this week:
> > > > > https://lists.freedesktop.org/archives/amd-gfx/2025-May/125350.ht=
ml
> > > >
> > > > Note the way this was done isn't maximally friendly to our stable
> > > > maintainers though.
> > > >
> > > > The commit in your tree (1b824eef269db44d068bbc0de74c94a8e8f9ce02) =
is a
> > > > tad better than the patch that Aurabindo sent as it has:
> > > >
> > > >         This reverts commit cfb2d41831ee5647a4ae0ea7c24971a92d5dfa0=
d ...
> > > >
> > > > which at least is a known commit and has Cc: stable.
> > > >
> > > > However this is still a bit confusing as commit cfb2d41831ee has no=
 Cc:
> > > > stable, but a duplicate in mainline: f1c6be3999d2 that has Cc: stab=
le.
> > > >
> > > > So f1c6be3999d2 was backported to 6.14.7 (commit
> > > > 4ec308a4104bc71a431c75cc9babf49303645617), 6.12.29 (commit
> > > > 468034a06a6e8043c5b50f9cd0cac730a6e497b5) and 6.6.91 (commit
> > > > c8a91debb020298c74bba0b9b6ed720fa98dc4a9). But it might not be obvi=
ous
> > > > that 1b824eef269db44d068bbc0de74c94a8e8f9ce02 needs backporting to =
trees
> > > > that don't contain cfb2d41831ee (or a backport of it).
> > > >
> > > > Please keep an eye on that change that it gets properly backported.
>
> I'm not sure if my mail was already enough to ensure that
> 1b824eef269db44d068bbc0de74c94a8e8f9ce02 will be backported to stable,
> so that request still stands.
>
> > > DRM patches land in -next first since that is where the developers
> > > work and then bug fixes get cherry-picked to -fixes.  When a patch is
> > > cherry-picked to -fixes, we use cherry-pick -x to keep the reference
> > > to the original commit and then add stable CC's as needed.  See this
> > > thread for background:
> > > https://lore.kernel.org/dri-devel/871px5iwbx.fsf@intel.com/T/#t
>
> Yeah I thought so. The problem isn't per se that there are duplicates,
> but that they are not handled with the needed care. I don't know about
> Greg's tooling, but my confusion would have been greatly reduced if you
> reverted f1c6be3999d2 instead of cfb2d41831ee. That is the older commit
> (with POV =3D mainline) and the one that has the relevant information (Cc=
:
> stable and the link to cfb2d41831ee).

The revert cc'd stable so it should go to stable.  You can check the
cherry-picked commits to see what patches they were cherry-picked from
to see if you need to apply them to stable kernels.

>
> Getting this wrong is just a big waste of time and patience (or if the
> backport is missed results in systems breaking for problems that are
> already known and fixed).

Tons of patches end up getting cherry-picked to stable without anyone
even asking for them via Sasha's scripts.  Won't this cause the same
problem?

Alex

