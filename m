Return-Path: <stable+bounces-108559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F777A0FDC1
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 02:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5473A63A4
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 01:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DD5C149;
	Tue, 14 Jan 2025 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuSWw/zq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73797320B
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736816509; cv=none; b=PjpLKUMPc0NZOyOyzUpXT63jNhZS6+UhX8yBLsOuNdvcyj30/sJeSTSDb/bKzUYdlf3bNECu0y9yrTqDzlwXVMsZxWzaLK1YIOl7haIr4IUGPR05Ul/3SW6k4z2+r99k8dPTmlRyUebJbGIMHzGTIblkFgiV3hctuxLy5xlm8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736816509; c=relaxed/simple;
	bh=MDzcAlGBBxJ8IC2MKQfJ70934w4BurmAQDYPcvT4r5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrqD3XjYwg1zqKf3UQyF0eyHyhYvK0u3HvLffEIIFRk6UpZCJ2IC9fZQI0EsBCnoI1GYlFYeWHgxCdqeaB54VVMej5wd3akkQM7AmM8/zKyIsCaud2jdD1oo5brBAfBpJjExCdJ3lf6s4OemijwnevgbeqGnYqF4g0OsJ2dTo48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuSWw/zq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so8595687a12.0
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 17:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736816506; x=1737421306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KR8x262wVRYayaz4U2ZgFqy9W7ibQPJchFlUBvgpUkk=;
        b=XuSWw/zqsukyiKAd7XrBhVTMAXt9NTvPqVdsJMNAlKb32mmAjJKpSiK5rakb5CtDpm
         gvLouzNBvCzlRCfsLHt3dNEOA5+3RFsl5ULEsGoHDLsgbGbZeFB+BGHuCsd4FjDMoOxh
         UPXO82CgomL+j3RGl5i7vTcSCjKbn7VVJdEibgRAvR8q0JETjoYFe8sysJpkRrpjPPx9
         UKSoeNCeQdlAlUFwSb1O6MR6RBqIDQPlPr1sr9gLk8FeTv4T0ZdPbnMynM4gJOxYxwQU
         /DyOQpuXVwY1nqBmJd7KLuf2p+uIonF7nYQ1Axsoq8v7Iqbg5Vu7o2zBccTruPrO4ly3
         ugpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736816506; x=1737421306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KR8x262wVRYayaz4U2ZgFqy9W7ibQPJchFlUBvgpUkk=;
        b=fywBGewnLFw+oiDs2pPu1C7RObUB5HGXLQG/upgxxHTwpYWQV+meEPyq+NRHrs3QHg
         2GrIu29WYhAfx2a7dL+ssy9GUxP9SJc1yyTJautPczR/lFZoEGMuVTI8SMkn8746tQT6
         uRWp+60EAnAH3ne7qxCIaeoBsi1zBljEj/RIR03NkVmQd8s/rr6TYBqBAuviICCxGHQw
         bAyEWWYR/QJKkGygY7+fWM3cgWZuasgD8MhGV6o8sm2x/bSQIwCLl/+GQ+slPMGa33VU
         eC8JwoiwETc/0Nnc7wjYb8rHoIO5PxUEA/boGc4m8UcGREcl7TIguqupIMbvdRHt2wvY
         Npqw==
X-Forwarded-Encrypted: i=1; AJvYcCV8bw4af3fsQvPb8l+VKXTwI8+XIhbRGncHpixBkrVAGDrD4xd6PbhbcblZlydEGbWvwAjIOQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNgh0dvOHOhoph0wwjgvXppz9u1pJeIf+MErRlqMRCzEDYLW9
	HOhG78tG138RzwKASbQx1V/C99a44x2aC4VCWh11IrdemNtFfkege73isalEeZJfki42dzWrE7o
	W5Wrqs/b/kz8FQN+4AwbTe8dS0zjF5g==
X-Gm-Gg: ASbGncvdG15r49QbKrRYN3itdwd2y9FGV+GfXAsxBEoQQRIFC3cgP0IEV1XPLZp3Pbq
	SHcpwgeR4uGd0d1jhUjLxW1kLE4C88xRkJBCJ
X-Google-Smtp-Source: AGHT+IG9OHjRVB5dxRB6vjb7ClexQSh4MMDqBXloIl743i+E/OfJn+NfmJ7bcb3UQcp2tS+54tAPWTGPOsxw7hp/3JQ=
X-Received: by 2002:a17:907:7f03:b0:aac:1b56:324a with SMTP id
 a640c23a62f3a-ab2ab6e3ce0mr1753586266b.26.1736816505566; Mon, 13 Jan 2025
 17:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025010650-tuesday-motivate-5cbb@gregkh> <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh> <CAPM=9txn1x5A7xt+9YQ+nvLaQ3ycekC1Oj4J2PUpWCJwyQEL9w@mail.gmail.com>
 <CAPM=9twogjmTCc=UHBYkPPkrdHfm0PJ9VDoOg+X2jWZbdjVBww@mail.gmail.com>
 <2025011247-spoilage-hamster-28b2@gregkh> <CAPM=9tx1cFzhaZNz=gQOmP9Q0KEK5fMKZYSc-P0xA_f2sxoZ9w@mail.gmail.com>
 <2025011352-fox-wrangle-4d3f@gregkh>
In-Reply-To: <2025011352-fox-wrangle-4d3f@gregkh>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 14 Jan 2025 11:01:34 +1000
X-Gm-Features: AbW1kvaGwLvveXklTE7aevENmTbX0FOvCCXg2F4583PfDIdJlspnVErwlQzInhc
Message-ID: <CAPM=9tzkJ=dn2gq7GcvtN_C95ZzxwC7XMMXHBrwF6Ez6fYfU=g@mail.gmail.com>
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode of
 operation for OAR/OAC)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>, stable@vger.kernel.org, 
	ashutosh.dixit@intel.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

> > > We create a "web" when we backport commits, and mark things for "Fixes:"
> > > When we get those ids wrong because you all have duplicate commits for
> > > the same thing, everything breaks.
> > >
> > > > I just don't get what the ABI the tools expect is, and why everyone is
> > > > writing bespoke tools and getting it wrong, then blaming us for not
> > > > conforming. Fix the tools or write new ones when you realise the
> > > > situation is more complex than your initial ideas.
> > >
> > > All I want to see and care about is:
> > >
> > >  - for a stable commit, the id that the commit is in Linus's tree.
> > >  - for a Fixes: tag, the id that matches the commit in Linus's tree AND
> > >    the commit that got backported to stable trees.
> > >
> > > That's it, that's the whole "ABI".  The issue is that you all, for any
> > > number of commits, have 2 unique ids for any single commit and how are
> > > we supposed to figure that mess out...
> >
> > Pretty sure we've explained how a few times now, not sure we can do much more.
>
> And the same for me.
>
> > If you see a commit with a cherry-pick link in it and don't have any
> > sight on that commit in Linus's tree, ignore the cherry-pick link in
> > it, assume it's a future placeholder for that commit id. You could if
> > you wanted to store that info somewhere, but there shouldn't be a
> > need.
>
> Ok, this is "fine", I can live with it.  BUT that's not the real issue
> (and your own developers get confused by this, again, look at the
> original email that started this all, they used an invalid git id to
> send to us thinking that was the correct id to use.)

I'm going to go back and look at the one you pointed out as I'm
missing the issue with it, I thought it was due to a future ID being
used.

> > When future tools are analysing things, they will see the patch from
> > the merge window, the cherry-picked patches in the fixes tree, and
> > stable will reference the fixes, and the fixes patch will reference
> > the merge window one?
>
>
> > but I think when we cherry-pick patches from -next that fix
> > other patches from -next maybe the fixes lines should be reworked to
> > reference the previous Linus tree timeline not the future one. not
> > 100% sure this happens? Sima might know more.
>
> Please fix this up, if you all can.  That is the issue here.  And again,
> same for reverts.
>
> I think between the two, this is causing many fixes and reverts to go
> unresolved in the stable trees.
>
> > Now previously I think we'd be requested to remove the cherry-picks
> > from the -fixes commits as they were referencing things not in Linus'
> > tree, we said it was a bad idea, I think we did it anyways, we got
> > shouted at, we put it back, we get shouted that we are referencing
> > commits that aren't in Linus tree. Either the link is useful
> > information and we just assume cherry-picks of something we can't see
> > are a future placeholder and ignore it until it shows up in our
> > timeline.
>
> I still think it's lunacy to have a "cherry pick" commit refer to a
> commit that is NOT IN THE TREE YET and shows up in history as "IN THE
> FUTURE".  But hey, that's just me.
>
> Why do you have these markings at all?  Who are they helping?  Me?
> Someone else?

They are for helping you. Again if the commit that goes into -next is immutable,
there is no way for it to reference the commit that goes into -fixes
ahead of it.

The commit in -fixes needs to add the link to the future commit in
-next, that link is the cherry-pick statement.

When you get the future commit into the stable queue, you look for the
commit id in stable history as a cherry-pick and drop it if it's
already there.

I can't see any other way to do this, the future commit id is a
placeholder in Linus/stable tree, the commit is immutable and 99.99%
of the time it will arrive at some future point in time.

I'm open to how you would make this work that isn't lunacy, but I
can't really see a way since git commits are immutable.

>
> > I think we could ask to not merge things into -next with stable cc'ed
> > but I think that will result in a loss of valuable fixes esp for
> > backporters.
>
> Again, it's the Fixes and Reverts id referencing that is all messed up
> here.  That needs to be resolved.  If it takes you all the effort to
> make up a special "stable tree only" branch/series/whatever, I'm all for
> it, but as it is now, what you all are doing is NOT working for me at
> all.

I'll have to see if anyone is willing to consider pulling this sort of
feat off, it's not a small task, and it would have to be 99% automated
I think to be not too burdensome.

Dave.

