Return-Path: <stable+bounces-108561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C4A0FDD4
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 02:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649FB3A6548
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 01:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672C63596A;
	Tue, 14 Jan 2025 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkclQWWR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CFCB673
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817140; cv=none; b=a54eSRwSeFX+BSTwhiJYDLqDpbkp0m6h89RnTE/Dq5fnJmDTQbvsSLKgsPTKtfjmgk7nfZgNKfJETKAz/ODcUh4W7b3HkQZSFUakQO5e37UbYfLFuuH6ap3sDEGR2T1mtQBxVOw0pmBjR+PgSov4EmRLbmJ0U1drqEtrMmpom1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817140; c=relaxed/simple;
	bh=gEAdrUc4DAu6kGwp7BLt2w/f9qDptfx44yb09rje8N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkHZWJvrgvm7XUJkSnhhr4P7U5s3JzQ8DIjRIJQoRlbZQbbOVvkLX9KzZhyVoN3j3S50KSOPiwg6ba95yUvyVlE29x7LsdxZuRS/XNrbcaDPLGBD+uqy++MNJc8beJoJIfEvIwUmSAoHDJt/2d0OwzxE8tRWPA/tl4wVRMfT3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkclQWWR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaec61d0f65so969103966b.1
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 17:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736817137; x=1737421937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWqPdJGeQo7PUO9WTDvJd72Uxz/7LJTMAQqHq6qP2wQ=;
        b=PkclQWWRvZVO3Z3oQB38V51drIhbPB55I+7pOcYolWaH/M6hquKjggsEwtvb8VM/1U
         rsszUs+oSHLNUbwLwfDjvdviDedeuEUKRMb7Qaep9c1IfLzDcjhMtlCofMq+9kHSeEQ4
         khsZm62jyw4UGzVUXUFu0Qw2mAKdGPx/14NwMnx2S9TdGpxng69hevkX5Hg4oqO8w5gL
         y0wGU+AomTL1VunRCPTAi04hR9fYPuEaX5nf8hOt4ZcCTsYuBJX+Dpdkttdcw2Mbtnag
         QbzCFl8ZjpgXqYXvm/t0LFmO5YkV2Zp2yyCErn+Ce9MWJUb/CBvYHviD+6C35hgz7fh4
         8gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736817137; x=1737421937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWqPdJGeQo7PUO9WTDvJd72Uxz/7LJTMAQqHq6qP2wQ=;
        b=Woj9BJMz4hyyZ+bXmEmSGSpnI9TCAqCq/VQHnZ1ZFbH3RUI62RsOnUPpSR24bYiovs
         X4+1b/Eb5gkTXbN9y1PAYYuK7kKCY+Xi/EEjF3vcHHYdRIpdsryCoIIpepoB5fvIa+v8
         QgSaMJFjsBOJNVrt9n3UM166/ke1ok9shjJFoUzzokdBSaX6707sq7I9TugSF+0nusuA
         NH8BIbi3wLjNMNKuCaX4C6NsRpfOzchE9WMC6LCAP2SZJ985MKe3HP20nfFqAofMNBP1
         aiP4bjxILcZIdLDLz4A/kQePuCc9dKTwb37srv8qzhKRey4oGf/GfntpoDbvLIMQp1di
         O37w==
X-Forwarded-Encrypted: i=1; AJvYcCUFN77D/xPRynrCTBY99hxaM21X/u2+A3XipxQ4tO3xHdgTW95B4HkJoia/h9v6A5sziZkZGRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DjfCB786BqMSSt2WcW1Kown53Vc2nmFx+u+vnxoPIfNVI7wE
	+aSivO3IePs79CqW/ETRSVnOy/SSqdlg1zoM5ui2mYwLJrQnqaWduIL4cQTLP8y8MXlmyPyDNRw
	aMfjnIFdCF7osWf+1HZtPgx/Qenwyqatu
X-Gm-Gg: ASbGncv8L1TL1akBdP+nPyDXukyPtyMKla5xHzUIyAtnIXq+98Z5BXFTBITfORfKQex
	wU0lqgNlxjSMyeuS9sVfPpYj5S4eAL4KmQpF0
X-Google-Smtp-Source: AGHT+IGk1rLjbCwHpCrMJLg8GTQSpq28SjylCz+YVmJ1l/5tk2xH6hsQ4VBNdxmRiUZIHDFFoj5vs5J7fTnoTcKZWoA=
X-Received: by 2002:a17:907:3da1:b0:aaf:3f57:9d2e with SMTP id
 a640c23a62f3a-ab2aaaf6571mr2258973766b.0.1736817136400; Mon, 13 Jan 2025
 17:12:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025010650-tuesday-motivate-5cbb@gregkh> <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh>
In-Reply-To: <2025011215-agreeing-bonfire-97ae@gregkh>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 14 Jan 2025 11:12:05 +1000
X-Gm-Features: AbW1kvYyf9IyhJjapU_Vlu0qGyAzEWDRjPTCN40O24xjgHFZMvodugfzct7PJQg
Message-ID: <CAPM=9txHupDKRShZLe8FA2kJwov-ScDASqJouUdxbMZ3X=U1-Q@mail.gmail.com>
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode of
 operation for OAR/OAC)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>, stable@vger.kernel.org, 
	ashutosh.dixit@intel.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 12 Jan 2025 at 22:19, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 10, 2025 at 12:53:41PM -0800, Umesh Nerlige Ramappa wrote:
> > commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream
>
> <snip>
>
> > Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA s=
tream close")
> > Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com> # commit 1
> > Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > Cc: stable@vger.kernel.org # 6.12+
> > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20241220171919.5715=
28-2-umesh.nerlige.ramappa@intel.com
> > (cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>
> Oh I see what you all did here.
>
> I give up.  You all need to stop it with the duplicated git commit ids
> all over the place.  It's a major pain and hassle all the time and is
> something that NO OTHER subsystem does.

Let me try and work out what you think is the problem with this
particular commit as I read your email and I don't get it.

This commit is in drm-next as  55039832f98c7e05f1cf9e0d8c12b2490abd0f16
and says Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset
OAC_CONTEXT_ENABLE on OA stream close)

It was pulled into drm-fixes a second time as a cherry-pick from next
as f0ed39830e6064d62f9c5393505677a26569bb56
(cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)

Now the commit it Fixes: 8135f1c09dd2 is also at
0c8650b09a365f4a31fca1d1d1e9d99c56071128

Now the above thing you wrote is your cherry-picked commit for stable?
since I don't see
(cherry picked from commit f0ed39830e6064d62f9c5393505677a26569bb56)
in my tree anywhere.

So this patch comes into stable previously as
f0ed39830e6064d62f9c5393505677a26569bb56 ? and then when it comes in
as 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 you didn't notice you
already had it, (there is where I think the extra step of searching in
git history for the patch (this seems easily automatable) should come
in.

Or is the concern with the Fixes: line referencing the wrong thing?

Dave.
>
> Yes, I know that DRM is special and unique and running at a zillion
> times faster with more maintainers than any other subsystem and really,
> it's bigger than the rest of the kernel combined, but hey, we ALL are a
> common project here.  If each different subsystem decided to have their
> own crazy workflows like this, we'd be in a world of hurt.  Right now
> it's just you all that is causing this world of hurt, no one else, so
> I'll complain to you.
>
> We have commits that end up looking like they go back in time that are
> backported to stable releases BEFORE they end up in Linus's tree and
> future releases.  This causes major havoc and I get complaints from
> external people when they see this as obviously, it makes no sense at
> all.
>
> And it easily breaks tools that tries to track where backports went and
> if they are needed elsewhere, which ends up missing things because of
> this crazy workflow.  So in the end, it's really only hurting YOUR
> subsystem because of this.
>
> And yes, there is a simple way to fix this, DO NOT TAG COMMITS THAT ARE
> DUPLICATES AS FOR STABLE.  Don't know why you all don't do that, would
> save a world of hurt.
>
> I'm tired of it, please, just stop.  I am _this_ close to just ignoring
> ALL DRM patches for stable trees...
>
> greg k-h

