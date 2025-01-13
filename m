Return-Path: <stable+bounces-108348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C1A0ACDD
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 01:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0E4188693D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 00:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341BBA49;
	Mon, 13 Jan 2025 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fuxrn7Tj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092169479
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736729095; cv=none; b=lmQsxC1wWiuxoEehHbzYPDxmUlOKlp+UulpXIoiR6QyYsctoD/GHLzhP7Pmg45CNxaW0W4UA1aO+G0JxEjU+4nus13yNkyJ8b8el63zG+9Fo0+NQhC3KYYJ9Fv6/dmwSxFyGwL5RJqU8W8OM/XcRpFTQehMp8Vhpfj36E1RxR4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736729095; c=relaxed/simple;
	bh=LyTDYmHpglBFQTAEqntEOnZy0uh7WYLJHB0kABbgGiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLqMm9eNAzbd6nFNPxLSvvPo//kIahHt9CsBNV6z24HrIpAMdI/dVEUSe5Cg5dQNyZ4w4kFoFgapX4oHwKIN1D3s+H3GEB6DvJ3x/63u9r1xzg+usPUg8fz0jkXU5ALSp9tUhQhNO4LhG/WGSRHHLZNv3OIyAn3d+oqAup82Txk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fuxrn7Tj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa6a92f863cso726184766b.1
        for <stable@vger.kernel.org>; Sun, 12 Jan 2025 16:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736729091; x=1737333891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed6yu2Btta8uP5wYCLy/XIFrufLqp2ZZTNzoMZ0tWl0=;
        b=Fuxrn7TjFDQ9bLDbeA4C64Y5StetKHG3/VQqse57zA8M3NiHyPn54klzfXRVc+kxxr
         mFDkpSgOgmjQncBMQM9SZVxdtvgUZXEwFMKjWDsT6jZ7FhyJDm7raOoMTDjYcFCqZAnX
         yNlHuNy6yeFeUDlT7/X/9P4h5F1NQ6GBXSYedbtfodQuOi4ktM/mC6XkzJCrbswshVcd
         kl0t+8XUKXHWuqeP8py03BilGZ3pNWz8omDLB9wSjetXXGooBnFPZbw5RIljq3OVC6VH
         bw4vjdWTAEN7IzZosw0bGDWCN8ly/1uwBL9V0PpU5zZX0cWwxI+mVRN9Xtl3kCs9IagO
         Cz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736729091; x=1737333891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed6yu2Btta8uP5wYCLy/XIFrufLqp2ZZTNzoMZ0tWl0=;
        b=awZzcxq6jcBQV7SeyUx+td7CHPqu59I3mRX+hnV3qITRvGnndI541f7Qsqpn/gMasn
         HuSFhdtDkS8JaggIM4Ecf+J8F5TIRBKIsQs8O2jce23XaWxo3zx7DSsbkYCevrg4nF/z
         tJKwjowwu1pRiDoqq3yjV1Sd+Qfrk5PJKzHxy15bRWWzFv36y9oPXWOeHlMqxcrNjVlM
         CRJHZCPk0LWkxii1K7qRZ9zIjAxSsqz7BywV7lIilYYMsUGuJGYnzVcaH6jUVnSrNcog
         ciogwOY62jcaMVDGDEZk6A7x2JDsUyUd7NT+U7luVLzQBCLqhoLAHbHQaTSSI8BuHCyb
         7+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7MYCxoqHmlUYrgK/lDUShwire/EMoLKYvYHMp9cBKtQ263MyvgN6BgzYUokhxmGs9wW2R3T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7Mh2ZdfFx7rpnJF18q6jITVGB9ylA/OTrHiManRwBhWtUkZq
	Q2hhSLPrdOKft8mZVorMRmsKLTouFSLJnBvl8PKpZP/0oEGAikHYI4AzTnZILi1NmsWu6KvITYn
	KM0IEntoAQu64xsGHUfp4I2bZ5rg=
X-Gm-Gg: ASbGncukvt618gHjST3dnxm5oFxU4o+/LWrtZKf5/oKkYEQpn4R7vo2+eUWtMB6dfvg
	KCBzpbZQdq0l9oSEqcC9/mlu3H6HaHVdCup4QMA==
X-Google-Smtp-Source: AGHT+IHADxkVijX1SDXR/BdC961tQo7xkFTqgVAf31KMP0gAmMQXk5WLx9VDoC7t4S1tqOFG9trHI/khKgzptxwy/+I=
X-Received: by 2002:a17:906:d555:b0:aa6:8d51:8fdb with SMTP id
 a640c23a62f3a-ab2ab703ef6mr1630615666b.19.1736729090868; Sun, 12 Jan 2025
 16:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025010650-tuesday-motivate-5cbb@gregkh> <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh> <CAPM=9txn1x5A7xt+9YQ+nvLaQ3ycekC1Oj4J2PUpWCJwyQEL9w@mail.gmail.com>
 <CAPM=9twogjmTCc=UHBYkPPkrdHfm0PJ9VDoOg+X2jWZbdjVBww@mail.gmail.com> <2025011247-spoilage-hamster-28b2@gregkh>
In-Reply-To: <2025011247-spoilage-hamster-28b2@gregkh>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 13 Jan 2025 10:44:41 +1000
X-Gm-Features: AbW1kvbdLKwykGc27KCJQu_69YzqdxTNa4wGRT1Ri3yglteUcswsn0Ew4zBHKWc
Message-ID: <CAPM=9tx1cFzhaZNz=gQOmP9Q0KEK5fMKZYSc-P0xA_f2sxoZ9w@mail.gmail.com>
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode of
 operation for OAR/OAC)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>, stable@vger.kernel.org, 
	ashutosh.dixit@intel.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025 at 07:09, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 13, 2025 at 06:01:51AM +1000, Dave Airlie wrote:
> > On Mon, 13 Jan 2025 at 05:51, Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > On Sun, 12 Jan 2025 at 22:19, Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> > > >
> > > > On Fri, Jan 10, 2025 at 12:53:41PM -0800, Umesh Nerlige Ramappa wro=
te:
> > > > > commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream
> > > >
> > > > <snip>
> > > >
> > > > > Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE o=
n OA stream close")
> > > > > Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel=
.com>
> > > > > Reviewed-by: Matthew Brost <matthew.brost@intel.com> # commit 1
> > > > > Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > > > > Cc: stable@vger.kernel.org # 6.12+
> > > > > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > > > > Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > > > > Link: https://patchwork.freedesktop.org/patch/msgid/2024122017191=
9.571528-2-umesh.nerlige.ramappa@intel.com
> > > > > (cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f=
16)
> > > > > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.inte=
l.com>
> > > > > (cherry picked from commit f0ed39830e6064d62f9c5393505677a26569bb=
56)
> > > >
> > > > Oh I see what you all did here.
> > > >
> > > > I give up.  You all need to stop it with the duplicated git commit =
ids
> > > > all over the place.  It's a major pain and hassle all the time and =
is
> > > > something that NO OTHER subsystem does.
> > > >
> > > > Yes, I know that DRM is special and unique and running at a zillion
> > > > times faster with more maintainers than any other subsystem and rea=
lly,
> > > > it's bigger than the rest of the kernel combined, but hey, we ALL a=
re a
> > > > common project here.  If each different subsystem decided to have t=
heir
> > > > own crazy workflows like this, we'd be in a world of hurt.  Right n=
ow
> > > > it's just you all that is causing this world of hurt, no one else, =
so
> > > > I'll complain to you.
> > >
> > > All subsystems that grow to having large teams (more than 2-4 people)
> > > working on a single driver will eventually hit the scaling problem,
> > > just be glad we find things first so everyone else knows how to deal
> > > with it later.
> > >
> > > >
> > > > We have commits that end up looking like they go back in time that =
are
> > > > backported to stable releases BEFORE they end up in Linus's tree an=
d
> > > > future releases.  This causes major havoc and I get complaints from
> > > > external people when they see this as obviously, it makes no sense =
at
> > > > all.
> > >
> > > None of what you are saying makes any sense here. Explain how patches
> > > are backported to stable releases before they end up in Linus's tree
> > > to me like I'm 5, because there should be no possible workflow where
> > > that can happen, stable pulls from patches in Linus' tree, not from m=
y
> > > tree or drm-next or anywhere else. Now it might appear that way
> > > because tooling isn't prepared or people don't know what they are
> > > looking at, but I still don't see the actual problem.
> > >
> > > >
> > > > And it easily breaks tools that tries to track where backports went=
 and
> > > > if they are needed elsewhere, which ends up missing things because =
of
> > > > this crazy workflow.  So in the end, it's really only hurting YOUR
> > > > subsystem because of this.
> > >
> > > Fix the tools.
> > >
> > > >
> > > > And yes, there is a simple way to fix this, DO NOT TAG COMMITS THAT=
 ARE
> > > > DUPLICATES AS FOR STABLE.  Don't know why you all don't do that, wo=
uld
> > > > save a world of hurt.
> > >
> > > How do you recommend we do that, edit the immutable git history to
> > > remove the stable
> > > tag from the original commit?
> > >
> > > >
> > > > I'm tired of it, please, just stop.  I am _this_ close to just igno=
ring
> > > > ALL DRM patches for stable trees...
> > >
> > > If you have to do, go do it. The thing is the workflow is there for a
> > > reason, once you have a large enough team, having every single team
> > > member intimately aware of the rc schedule to decide where they need
> > > to land patches doesn't scale. If you can't land patches to a central
> > > -next tree and then pick those patches out to a -fixes tree after a
> > > maintainer realises they need to be backported to stable. Now I
> > > suppose we could just ban stable tags on the next tree and only put
> > > them on the cherry-picks but then how does it deal with the case wher=
e
> > > something needs to be fixes in -next but not really urgent enough for
> > > -fixes immediately. Would that be good enough, no stable tags in -nex=
t
> > > trees, like we could make the tooling block it? But it seems like
> > > overkill, to avoid fixing some shitty scripts someone is probably
> > > selling as a security application.
> >
> > If you were to ignore stable tags on drm, could we then write a tool
> > that creates a new for-stable tree that just strips out all the
> > fixes/backports/commits and recreates it based on Linus commits to
> > you, or would future duplicate commits then break tools?
>
> That would be great, just pick which commit id to reference (i.e. the
> one that shows up in Linus's tree first.)
>
> But then, be careful with the "Fixes:" tags as well, those need to line
> up and match the correct ones.
>
> We create a "web" when we backport commits, and mark things for "Fixes:"
> When we get those ids wrong because you all have duplicate commits for
> the same thing, everything breaks.
>
> > I just don't get what the ABI the tools expect is, and why everyone is
> > writing bespoke tools and getting it wrong, then blaming us for not
> > conforming. Fix the tools or write new ones when you realise the
> > situation is more complex than your initial ideas.
>
> All I want to see and care about is:
>
>  - for a stable commit, the id that the commit is in Linus's tree.
>  - for a Fixes: tag, the id that matches the commit in Linus's tree AND
>    the commit that got backported to stable trees.
>
> That's it, that's the whole "ABI".  The issue is that you all, for any
> number of commits, have 2 unique ids for any single commit and how are
> we supposed to figure that mess out...

Pretty sure we've explained how a few times now, not sure we can do much mo=
re.

If you see a commit with a cherry-pick link in it and don't have any
sight on that commit in Linus's tree, ignore the cherry-pick link in
it, assume it's a future placeholder for that commit id. You could if
you wanted to store that info somewhere, but there shouldn't be a
need.

When the initial commit enters during the next merge window, you look
for that subject or commit id in the stable tree already, if it
exists, dump the latest Linus patch on the floor, it's already in
stable your job is done.

When future tools are analysing things, they will see the patch from
the merge window, the cherry-picked patches in the fixes tree, and
stable will reference the fixes, and the fixes patch will reference
the merge window one?

I'm just not seeing what I'm missing here, fixes tags should work
fine, but I think when we cherry-pick patches from -next that fix
other patches from -next maybe the fixes lines should be reworked to
reference the previous Linus tree timeline not the future one. not
100% sure this happens? Sima might know more.

Now previously I think we'd be requested to remove the cherry-picks
from the -fixes commits as they were referencing things not in Linus'
tree, we said it was a bad idea, I think we did it anyways, we got
shouted at, we put it back, we get shouted that we are referencing
commits that aren't in Linus tree. Either the link is useful
information and we just assume cherry-picks of something we can't see
are a future placeholder and ignore it until it shows up in our
timeline.

I think we could ask to not merge things into -next with stable cc'ed
but I think that will result in a loss of valuable fixes esp for
backporters.

Dave.

