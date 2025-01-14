Return-Path: <stable+bounces-108606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A15FA10A35
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369F31885896
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C4E232424;
	Tue, 14 Jan 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="S+rs61T+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF981741
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866998; cv=none; b=sEiC6haxavBTn8oEZ/43hJ0bskB7Ie+SoBWXRBg1Zxh7IY3/Va4m0ZzXpsZtmDDdKLpsoBAxMztEoMFQkGfJpEYUdGNFw625EoZ0He85vA7j7SrWYh6j1pfoxFP3O8m3b8Hy8/8iRxOFOd/DTunKrGIEquvgD8gmcao0DNIDDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866998; c=relaxed/simple;
	bh=d+YFRP5CctysD2GtKpcMcZqbX4Yl3MNTVQyjqjARTro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcT71E/lnj07+AgBEnTTl96wTz7MiV8CILm0HT2rqQr31pEf6SOBsV4rWjZnlRTjwu34e569CqfR83I1hgqEsZbK7F/+435WrZiNGqo5WxY58xlXKz+OembDIvgNiUST4dCc4IxEsyFD9Hv16FrSSvgGec0EGnDP2ZNnAg5XvyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=S+rs61T+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so9447007a12.2
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 07:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1736866994; x=1737471794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qamS5xSdPS//oTx5ylL4lqMb/FrrfRF6PhZqWBXShg4=;
        b=S+rs61T+uhvgkTPgRzHA8FduMdhmLisU36HpIomd9B+d46C+/eMkULYcnTUyfcwBPj
         JjCoxmUQ2MpfrUoKexX3k1L0StJ0Ei8O/LrOkiylUhAFAdoNi/RsLbcMmCMZHoHhJ9Rg
         QEgyoU7gL+sgImxsuOhr5f0jbrb5oxGClE+c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736866994; x=1737471794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qamS5xSdPS//oTx5ylL4lqMb/FrrfRF6PhZqWBXShg4=;
        b=j+B/TQE+NtYLq2oXWMb8zS1j0KLNkg6xWE78KFCpxZLMZBehhwq/Yzs0hscjeRBGA9
         AwLVzL0KP991c12luvnqncP5qsc2cN71tvvos5cIHNzO3SihWtvJ1VYxiDqKSksVtSBB
         NceJkox0+Wj1dVqxHbDpvo/+C/6hCw6GmljuzxGZ9ZPdSnN1+Nu0pNqGG9HLOBNVKh+v
         ypXoSn5CMqhzmhXg91xCaHm+Nf0fpezgcIyYCXA83twfAkf7EKnvkLO6e9+NwjkNh3d2
         d8n+dSDDMz9iNWymE4/OFAg335EUSjyb6+A6A/s2J04V6oU5DVrU5PBmLXjicm2ZnpC8
         5/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWFa2/BPNsDM3i3GG/7s2kaKbBlQ6iU0zbhuxamQ+3nQXKcVuqIFCcF91XVNnqFBjPwAFS0ugA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrVpj0FXMeV/CQ0Wf49MT1J9ydTYiGD1O8pphkIIavdcxcWm//
	Iq9cCqLelou5G0OGFat4skQ1KDwewpN6VV+FnOfzFSQ2zhOY5QySAPNlyYo6JiQ=
X-Gm-Gg: ASbGncuZRFe10wY0iKgm0X87SsZoFzLUoppAnkuyev63mF5cBPvlCZHQ3Q5/UTSK3Bl
	TT8+viqlawB7qdaqWB4c0sXjU3scc70NIg6CwIj6P4DwPnLXv4UVpuJ3u883pVilnoIVuISvh8M
	I/ijO7drmSc/rAWdLjXWGagUIQRNeAVCAsPmKXWAUkvX9eok5xeZmVU9i4cpmDCVhUCrkTAPaUl
	8g+ouE2bkyz6cL0srjzKo6QL11vXWbpgBCQJ7JQ1s7/HNk4r6wVgQPTZU9fC6yAu1YL
X-Google-Smtp-Source: AGHT+IGFhUCfPs1iR3CkDYsYNahmLsoRWWY9B7JJso7mCLgcIEWbAZOvBJrA2LL1JYB/DAtKYoJUSg==
X-Received: by 2002:a05:6402:5188:b0:5d2:7396:b0ca with SMTP id 4fb4d7f45d1cf-5d972e08141mr24249007a12.12.1736866993520;
        Tue, 14 Jan 2025 07:03:13 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a5277sm6105694a12.80.2025.01.14.07.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:03:12 -0800 (PST)
Date: Tue, 14 Jan 2025 16:03:09 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Dave Airlie <airlied@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	stable@vger.kernel.org, ashutosh.dixit@intel.com,
	dri-devel@lists.freedesktop.org
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
Message-ID: <Z4Z8rQKR2QEaWNyI@phenom.ffwll.local>
References: <2025010650-tuesday-motivate-5cbb@gregkh>
 <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh>
 <CAPM=9txn1x5A7xt+9YQ+nvLaQ3ycekC1Oj4J2PUpWCJwyQEL9w@mail.gmail.com>
 <CAPM=9twogjmTCc=UHBYkPPkrdHfm0PJ9VDoOg+X2jWZbdjVBww@mail.gmail.com>
 <2025011247-spoilage-hamster-28b2@gregkh>
 <CAPM=9tx1cFzhaZNz=gQOmP9Q0KEK5fMKZYSc-P0xA_f2sxoZ9w@mail.gmail.com>
 <2025011352-fox-wrangle-4d3f@gregkh>
 <CAPM=9tzkJ=dn2gq7GcvtN_C95ZzxwC7XMMXHBrwF6Ez6fYfU=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzkJ=dn2gq7GcvtN_C95ZzxwC7XMMXHBrwF6Ez6fYfU=g@mail.gmail.com>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Tue, Jan 14, 2025 at 11:01:34AM +1000, Dave Airlie wrote:
> > > > We create a "web" when we backport commits, and mark things for "Fixes:"
> > > > When we get those ids wrong because you all have duplicate commits for
> > > > the same thing, everything breaks.
> > > >
> > > > > I just don't get what the ABI the tools expect is, and why everyone is
> > > > > writing bespoke tools and getting it wrong, then blaming us for not
> > > > > conforming. Fix the tools or write new ones when you realise the
> > > > > situation is more complex than your initial ideas.
> > > >
> > > > All I want to see and care about is:
> > > >
> > > >  - for a stable commit, the id that the commit is in Linus's tree.
> > > >  - for a Fixes: tag, the id that matches the commit in Linus's tree AND
> > > >    the commit that got backported to stable trees.
> > > >
> > > > That's it, that's the whole "ABI".  The issue is that you all, for any
> > > > number of commits, have 2 unique ids for any single commit and how are
> > > > we supposed to figure that mess out...
> > >
> > > Pretty sure we've explained how a few times now, not sure we can do much more.
> >
> > And the same for me.
> >
> > > If you see a commit with a cherry-pick link in it and don't have any
> > > sight on that commit in Linus's tree, ignore the cherry-pick link in
> > > it, assume it's a future placeholder for that commit id. You could if
> > > you wanted to store that info somewhere, but there shouldn't be a
> > > need.
> >
> > Ok, this is "fine", I can live with it.  BUT that's not the real issue
> > (and your own developers get confused by this, again, look at the
> > original email that started this all, they used an invalid git id to
> > send to us thinking that was the correct id to use.)
> 
> I'm going to go back and look at the one you pointed out as I'm
> missing the issue with it, I thought it was due to a future ID being
> used.

I think the issue is that with the cherry-picking we do, we don't update
the Fixes: or Reverts: lines, so those still point at the og commit in
-next, while the cherry-picked commit is in -fixes.

The fix for that (which our own cherry-pick scripts implement iirc) is to
keep track of the cherry-picks (which is why we add that line) and treat
them as aliases.

So if you have a Fixes: $sha1 pointing at -next, then if you do a
full-text commit message search for (cherry picked from $sha1), you should
be able to find it.

We could try to do that lookup with the cherry-pick scripts, but a lot of
folks hand-roll these, so it's lossy at best. Plus you already have to
keep track of aliases anyway since you're cherry-picking to stable, so I
was assuming that this shouldn't cause additional issues.

The other part is that if you already have a cherry picked from $sha1 in
your history, even if it wasn't done with stable cherry-pick, then you
don't have to cherry-pick again. These should be easy to filter out.

But maybe I'm also not understanding what the issue is, I guess would need
to look at a specific example.

> > > When future tools are analysing things, they will see the patch from
> > > the merge window, the cherry-picked patches in the fixes tree, and
> > > stable will reference the fixes, and the fixes patch will reference
> > > the merge window one?
> >
> >
> > > but I think when we cherry-pick patches from -next that fix
> > > other patches from -next maybe the fixes lines should be reworked to
> > > reference the previous Linus tree timeline not the future one. not
> > > 100% sure this happens? Sima might know more.
> >
> > Please fix this up, if you all can.  That is the issue here.  And again,
> > same for reverts.
> >
> > I think between the two, this is causing many fixes and reverts to go
> > unresolved in the stable trees.
> >
> > > Now previously I think we'd be requested to remove the cherry-picks
> > > from the -fixes commits as they were referencing things not in Linus'
> > > tree, we said it was a bad idea, I think we did it anyways, we got
> > > shouted at, we put it back, we get shouted that we are referencing
> > > commits that aren't in Linus tree. Either the link is useful
> > > information and we just assume cherry-picks of something we can't see
> > > are a future placeholder and ignore it until it shows up in our
> > > timeline.
> >
> > I still think it's lunacy to have a "cherry pick" commit refer to a
> > commit that is NOT IN THE TREE YET and shows up in history as "IN THE
> > FUTURE".  But hey, that's just me.
> >
> > Why do you have these markings at all?  Who are they helping?  Me?
> > Someone else?
> 
> They are for helping you. Again if the commit that goes into -next is immutable,
> there is no way for it to reference the commit that goes into -fixes
> ahead of it.
> 
> The commit in -fixes needs to add the link to the future commit in
> -next, that link is the cherry-pick statement.
> 
> When you get the future commit into the stable queue, you look for the
> commit id in stable history as a cherry-pick and drop it if it's
> already there.
> 
> I can't see any other way to do this, the future commit id is a
> placeholder in Linus/stable tree, the commit is immutable and 99.99%
> of the time it will arrive at some future point in time.
> 
> I'm open to how you would make this work that isn't lunacy, but I
> can't really see a way since git commits are immutable.

Yeah the (cherry picked from $sha1) with a sha1 that's in -next and almost
always shows up in Linus' tree in the future shouldn't be an issue. That
part really is required for driver teams to manage their flows.

> > > I think we could ask to not merge things into -next with stable cc'ed
> > > but I think that will result in a loss of valuable fixes esp for
> > > backporters.
> >
> > Again, it's the Fixes and Reverts id referencing that is all messed up
> > here.  That needs to be resolved.  If it takes you all the effort to
> > make up a special "stable tree only" branch/series/whatever, I'm all for
> > it, but as it is now, what you all are doing is NOT working for me at
> > all.
> 
> I'll have to see if anyone is willing to consider pulling this sort of
> feat off, it's not a small task, and it would have to be 99% automated
> I think to be not too burdensome.

It's not that hard to script, dim cherry-pick already does it. It's the
part where we need to guarantee that we never ever let one slip through
didn't get this treatment of replacing the sha1.

The even more insideous one is when people rebase their -next or -fixes
trees, since then the sha1 will really never ever show up. Which is why
we're telling people to not mess with git history at all and instead
cherry-pick. It's the lesser pain.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

