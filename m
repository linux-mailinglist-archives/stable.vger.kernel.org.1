Return-Path: <stable+bounces-108344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF5CA0ABB7
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 21:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B636163AA3
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 20:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CE92A8C1;
	Sun, 12 Jan 2025 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTxq59k7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498E2CAB
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736712126; cv=none; b=Wrpm9ZXej+5bWa9Hb1QELCaOZmu5nMdXu6KRL+oGCtmJCvU76i4Xr0H63+feMRRs5lOqP3wewMEFN6VnQWX/chUbtddd96h7K7d8GIn8r0l0f3xRW+OdzsTyuDTasrBLpm00ei99l8W3dEXmBv9Aw88du+8FWDLrK9pRT++6VzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736712126; c=relaxed/simple;
	bh=kc4M/joXB2vKAKtd07ZccwDQNK2chG6tYdoAuo1R1XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmdLWwDpjC35Fxi1YgdvKKTr1cklCAGCU6z7QY9HaGhIkDsIVuI7v0JsEILQTHeuStjPB6np+vtcG0G3YW3gRFICi16GX6wQGta5CydLa6bemD5+oRqRoFk44f9QwzOqziB1ouaPopxKGe/HyR+USEXR3VXGxFWRRZTZFpfStP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTxq59k7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaec111762bso667788066b.2
        for <stable@vger.kernel.org>; Sun, 12 Jan 2025 12:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736712123; x=1737316923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24vtEXUXafY7Re8u3pp9OeLIw9fFnvJ67DsBpxoTqI0=;
        b=jTxq59k7YCcPnXYmajLbIcDFbvJPg7PfHOin1EkWGuOrbMVQNTWlEZOmNv1UBz0LiX
         btmLkxcE6N2KmoBBMoqa2SqtZI3+rdd56VYizmB1JrhvIepeYTBM4iOfdyCPdb3MCUF3
         fJQPfEClo2BSxPGNZKYQfepcxz7AHez3XxF/B2tg6ofSSkkOH3smnI6bAvOtF+ZV2HJU
         zYNIUwAUUdaiJ33aImyxnsN7R1Iqa7gwv8NCCesQbUuNToa2VfwyVjBCkJh1VPwZiHjd
         5uwm9TNTzqNHgYbGH3vouJV5B5tEj7m2svAj27DkH5D4pyPxIK0FTgvPpVGVk/aYm6+G
         TyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736712123; x=1737316923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24vtEXUXafY7Re8u3pp9OeLIw9fFnvJ67DsBpxoTqI0=;
        b=n5M67ZLDeEgk+QUXCUVasFgWTUdFHrz9LCarAcVT1wL/rL5cpHPr4VDUd0NYFLZukR
         6lr7nC8yZauGq8lf9e8hLF/OsDYqbXXS3nQd6mznnvOXkdvZe6O32VNUdG4pDvwgLzor
         XxPk9ccfgG7FCwARzBaceA2WTb8Gplx5WU6CN+fx7gXSKSYH4EWYZpEWDYwZI0v23iAm
         IVaHfWu2wLsnH4cqISc+oJAcTgliLl9aLlI7AKrnAqNS3owEW6uv59G+uzyhzzNxj5iU
         x1WrvpqjT/sGC0j4Xzw1LwllYByz/HNsYEVOybs+itKO9M6R2gbB0mqjd5NVYQ9p7HYW
         B4Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXSeDhmT7WAZcVLpbz8+vd9Zh6zHiWkdIB64zqtbfCi3n9nYQNTvEyh3A+w1s03GaHrMr5rVOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0RBwhQCe2QVbmN7yD9hNfLffKNyS3cWUVOxgf32aVVfP6sNS
	bgNq2uCjsQy57BBMsKbL/OuB5m/8ie1GuA06/Vc+3vR/pNdkKBoy5gYqtVuHVmwq/316i45oM9z
	JfS7U3pU/q0Mn/JjuQ1jg3Wmlrvo=
X-Gm-Gg: ASbGnctPAlMHVa3Bl5fKlIuJKq4zC43naPlI+qO31HkRpL3wDFZ3VaAYllPFMn4r1Uk
	LxN2wKdJ+yuKVHwZzBdeXTEljMPcc26hTgThE
X-Google-Smtp-Source: AGHT+IHby0afkV/v10eb19sI9PIOWGJ7MGAbVtLTzN7zISyycHxAAyza1GqllKQgKc9yQOKMKZDFNP70/RFKyb2MKcY=
X-Received: by 2002:a17:907:6090:b0:aa6:94c0:f753 with SMTP id
 a640c23a62f3a-ab2ab74042bmr1826117066b.33.1736712122912; Sun, 12 Jan 2025
 12:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025010650-tuesday-motivate-5cbb@gregkh> <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh> <CAPM=9txn1x5A7xt+9YQ+nvLaQ3ycekC1Oj4J2PUpWCJwyQEL9w@mail.gmail.com>
In-Reply-To: <CAPM=9txn1x5A7xt+9YQ+nvLaQ3ycekC1Oj4J2PUpWCJwyQEL9w@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 13 Jan 2025 06:01:51 +1000
X-Gm-Features: AbW1kvbQgOIwAFBVofsWBbX8rfnWl9fkseD6QT7FQOEEdZyOQjRUOvNm1-HXN7E
Message-ID: <CAPM=9twogjmTCc=UHBYkPPkrdHfm0PJ9VDoOg+X2jWZbdjVBww@mail.gmail.com>
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode of
 operation for OAR/OAC)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>, stable@vger.kernel.org, 
	ashutosh.dixit@intel.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025 at 05:51, Dave Airlie <airlied@gmail.com> wrote:
>
> On Sun, 12 Jan 2025 at 22:19, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jan 10, 2025 at 12:53:41PM -0800, Umesh Nerlige Ramappa wrote:
> > > commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream
> >
> > <snip>
> >
> > > Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA=
 stream close")
> > > Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com=
>
> > > Reviewed-by: Matthew Brost <matthew.brost@intel.com> # commit 1
> > > Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > > Cc: stable@vger.kernel.org # 6.12+
> > > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > > Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > > Link: https://patchwork.freedesktop.org/patch/msgid/20241220171919.57=
1528-2-umesh.nerlige.ramappa@intel.com
> > > (cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)
> > > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.co=
m>
> > > (cherry picked from commit f0ed39830e6064d62f9c5393505677a26569bb56)
> >
> > Oh I see what you all did here.
> >
> > I give up.  You all need to stop it with the duplicated git commit ids
> > all over the place.  It's a major pain and hassle all the time and is
> > something that NO OTHER subsystem does.
> >
> > Yes, I know that DRM is special and unique and running at a zillion
> > times faster with more maintainers than any other subsystem and really,
> > it's bigger than the rest of the kernel combined, but hey, we ALL are a
> > common project here.  If each different subsystem decided to have their
> > own crazy workflows like this, we'd be in a world of hurt.  Right now
> > it's just you all that is causing this world of hurt, no one else, so
> > I'll complain to you.
>
> All subsystems that grow to having large teams (more than 2-4 people)
> working on a single driver will eventually hit the scaling problem,
> just be glad we find things first so everyone else knows how to deal
> with it later.
>
> >
> > We have commits that end up looking like they go back in time that are
> > backported to stable releases BEFORE they end up in Linus's tree and
> > future releases.  This causes major havoc and I get complaints from
> > external people when they see this as obviously, it makes no sense at
> > all.
>
> None of what you are saying makes any sense here. Explain how patches
> are backported to stable releases before they end up in Linus's tree
> to me like I'm 5, because there should be no possible workflow where
> that can happen, stable pulls from patches in Linus' tree, not from my
> tree or drm-next or anywhere else. Now it might appear that way
> because tooling isn't prepared or people don't know what they are
> looking at, but I still don't see the actual problem.
>
> >
> > And it easily breaks tools that tries to track where backports went and
> > if they are needed elsewhere, which ends up missing things because of
> > this crazy workflow.  So in the end, it's really only hurting YOUR
> > subsystem because of this.
>
> Fix the tools.
>
> >
> > And yes, there is a simple way to fix this, DO NOT TAG COMMITS THAT ARE
> > DUPLICATES AS FOR STABLE.  Don't know why you all don't do that, would
> > save a world of hurt.
>
> How do you recommend we do that, edit the immutable git history to
> remove the stable
> tag from the original commit?
>
> >
> > I'm tired of it, please, just stop.  I am _this_ close to just ignoring
> > ALL DRM patches for stable trees...
>
> If you have to do, go do it. The thing is the workflow is there for a
> reason, once you have a large enough team, having every single team
> member intimately aware of the rc schedule to decide where they need
> to land patches doesn't scale. If you can't land patches to a central
> -next tree and then pick those patches out to a -fixes tree after a
> maintainer realises they need to be backported to stable. Now I
> suppose we could just ban stable tags on the next tree and only put
> them on the cherry-picks but then how does it deal with the case where
> something needs to be fixes in -next but not really urgent enough for
> -fixes immediately. Would that be good enough, no stable tags in -next
> trees, like we could make the tooling block it? But it seems like
> overkill, to avoid fixing some shitty scripts someone is probably
> selling as a security application.

If you were to ignore stable tags on drm, could we then write a tool
that creates a new for-stable tree that just strips out all the
fixes/backports/commits and recreates it based on Linus commits to
you, or would future duplicate commits then break tools?

I just don't get what the ABI the tools expect is, and why everyone is
writing bespoke tools and getting it wrong, then blaming us for not
conforming. Fix the tools or write new ones when you realise the
situation is more complex than your initial ideas.

Dave.

