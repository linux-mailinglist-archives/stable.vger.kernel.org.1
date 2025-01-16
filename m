Return-Path: <stable+bounces-109232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DADA136EC
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64C13A140C
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83FB19FA92;
	Thu, 16 Jan 2025 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UzqPVVva"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F418C332
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020932; cv=none; b=N3F9Or0JSZT08Cpo2HnRAub69ZbzAm0FH99mpa1LuP91rFOc+EvhbnDM2A8Q0Ykms6fsAwX2UX+hY6OuEDKsKpchCIVggi+LzkXuiW2gLuJhkuweX/xXVUiPvCQl0JU5061y+u3/2VfexDrDwr2YwC+KBeV/N8t27fyCWxGiL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020932; c=relaxed/simple;
	bh=82tsaYD10Y+uS7dQENazJDRxHEkNYosaA2I3b2u2svg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zscv/yiiZhnl9Gda6MajoMqOkQ/lO3ZwcUDWGlaYm+Mywawmx5S8aA73qSFEpvxYH1qEEPA1dYIh8vtLPZsxhA0N1Lk25QsZIBYH4KjzWaGZsIHcCPy87Zy2qRXfmciVKkd2g/BIZkDM2bkXft6f8VxFAspii/e7qh3lzM5WLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=UzqPVVva; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so6984635e9.0
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 01:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1737020928; x=1737625728; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DxZqRX/jD7Sl68Atamm+q2FSjIQkmsMhoxMHR8yWhIM=;
        b=UzqPVVvacyavfGhB+9YOuR36Ahl6ihtEfpI2DJBxcK4CDgC9EbWp+XCkOst1b+i9F1
         fk6tx40FSxxc2YUKV3+8dzLofq+qkmE2Nz2tT+muCG1gdT4/vS/v0XL3W5GqiWfAKF8s
         4xJSVWqORkPMeU3D6Z9GFqHG59XFaA/1nJbKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737020928; x=1737625728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxZqRX/jD7Sl68Atamm+q2FSjIQkmsMhoxMHR8yWhIM=;
        b=kCwtsOXIdelKPLXWaDLcf8BJExhuwL6ohLB3Mg9F0pn7Gaorrqqr7lH8Lya1dekgom
         q6un8r30focMt7EkuaMjBToRBBEXx3j+rY/hrWXDfdrOj+GR6d795s+0wnTBliat/DvL
         9PXazU7G085dF4u5wog/9zAGPqvKQq2jvanMFbZUBlRt5RM1hQNPtBb/fu1F2dUNqQx4
         h49vZ9PsJrgrVZ3Fc6OJjfht25iDHM72rKyOj2I/KM5W/MoNSUtgl/6JgUc9hR9pod2+
         Zw9db0wWe0omWpmDWEv8zILn35p5XIgV9pcxkAOAZsOApgUDUrQjSNgM5td83T41KHUM
         Hf9g==
X-Forwarded-Encrypted: i=1; AJvYcCXfl1PP7SvjG2Xl47J2vZUbhJ0jjbeMv1pBhDIixMS+Amg/o9vNUCbzlx+0rHwvM/uJRZnh/j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbndTylfS7Zsi+TrXoKFNWg2XFM+NXQu+e2m5113JvWj5/Ce7u
	Lv9CPsLp0bEABhF2Xi9U8o8oFqgB5UsoE3XokAb3ksRUzLPE+PRbs1FuYJ2u6As=
X-Gm-Gg: ASbGncvtAEpcVBtCOjos46xnDUYejaLrcYMM8L71o3CaqebuHFvRA5l3uflGCOA736K
	WCa2GyRhowWHnR+xJw1266WJ6RHQy3YkU3llxSKYuqThUZNR7yjJMfYzL+qBKoDhsetCjjVQO/Y
	4syr0W0O1pTUgJ75/zufVawam3b5cY5KURVi6rZIXdN1egTFCkmMu3nT0UUVGuSZ8RYfs0QVGE6
	vq5pm6i7bhOTDkAY/jmea0sygwlCHIGg4mzYf/5Imh6gjGA4kftc+j5cwG7jyGx1RSb
X-Google-Smtp-Source: AGHT+IGfHD+eQSfe4MI5LDoFF/8QauDJ7PTB/M6pys2+C1P2icUt6gf/9Sx6pkN/wwtikOj8VRMfSA==
X-Received: by 2002:adf:a782:0:b0:38a:88f8:aac8 with SMTP id ffacd0b85a97d-38a88f8ace6mr18968718f8f.54.1737020928120;
        Thu, 16 Jan 2025 01:48:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74c5b2esm52959945e9.23.2025.01.16.01.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 01:48:47 -0800 (PST)
Date: Thu, 16 Jan 2025 10:48:45 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Sasha Levin <sashal@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Greg KH <gregkh@linuxfoundation.org>,
	Dave Airlie <airlied@gmail.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	stable@vger.kernel.org, ashutosh.dixit@intel.com,
	dri-devel@lists.freedesktop.org
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
Message-ID: <Z4jV_cPkg82X6FrY@phenom.ffwll.local>
References: <2025011352-fox-wrangle-4d3f@gregkh>
 <CAPM=9tzkJ=dn2gq7GcvtN_C95ZzxwC7XMMXHBrwF6Ez6fYfU=g@mail.gmail.com>
 <Z4Z8rQKR2QEaWNyI@phenom.ffwll.local>
 <Z4aIGvAmMld_uztJ@lappy>
 <Z4afbuFN1uc3zhOt@phenom.ffwll.local>
 <Z4d6406b82Pu1PRV@phenom.ffwll.local>
 <2025011503-algorithm-composed-3b81@gregkh>
 <Z4eY4rv8ygi9dRbz@phenom.ffwll.local>
 <Z4ft1fFjbwy0EF-X@lappy>
 <Z4gGKVFFXBQEm_OB@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4gGKVFFXBQEm_OB@phenom.ffwll.local>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Wed, Jan 15, 2025 at 08:02:01PM +0100, Simona Vetter wrote:
> On Wed, Jan 15, 2025 at 12:18:13PM -0500, Sasha Levin wrote:
> > On Wed, Jan 15, 2025 at 12:15:46PM +0100, Simona Vetter wrote:
> > > On Wed, Jan 15, 2025 at 10:38:34AM +0100, Greg KH wrote:
> > > So my understanding is that you got confused by this:
> > > 
> > > > commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream
> > > 
> > > $ git log --grep="(cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)" --since="6 month ago"   --pretty=oneline
> > > f0ed39830e6064d62f9c5393505677a26569bb56
> > > 
> > > And yes f0ed39830e6064d62f9c5393505677a26569bb56 is the commit you care
> > > about for stable backport and cve tracking purposes, because it's the one
> > > in v6.13-rc6.
> > > 
> > > And the thing is, Sasha's bot found that one too:
> > > 
> > > https://lore.kernel.org/all/20250110164811-61a12d6905bb8676@stable.kernel.org/
> > > 
> > > Except Sasha's bot plays guessing games, the above git log query is exact.
> > 
> > Cool, can we test it out? I'll try and pick a recent commit (2024).
> 
> Thanks a lot for specific examples, makes it much easier to walk through
> them and show how much cherry pick tracing is neeeded.
> 
> > Let's assume that I'm looking at the v6.10 git tree before 50aec9665e0b
> > ("drm/xe: Use ordered WQ for G2H handler") made it upstream ("git
> > checkout v6.10" will do the trick), and I get a backport request that
> > says:
> > 
> > 	commit 50aec9665e0babd62b9eee4e613d9a1ef8d2b7de upstream
> > 
> > I run my trusty script that says "50aec9665e0b isn't real, grep for
> > cherry picked from line!". My trusty script runs the query you've
> > provided:
> > 
> > $ git log --grep="(cherry picked from commit 50aec9665e0babd62b9eee4e613d9a1ef8d2b7de)" --since="6 month ago"   --pretty=oneline
> > 2d9c72f676e6f79a021b74c6c1c88235e7d5b722 drm/xe: Use ordered WQ for G2H handler
> > c002bfe644a29ba600c571f2abba13a155a12dcd drm/xe: Use ordered WQ for G2H handler
> > 
> > Which commit do I pick? Note that they are slightly different from
> > eachother, and c002bfe644 landed in v6.9 while 2d9c72f676 landed in
> > v6.10.
> 
> Ok let me first explain why this happens. drm subtrees feature-freeze
> around -rc6/7, to make sure that when the merge window is open we don't
> have a buggy chaotic mess but are ready. Which means for that short amount
> of time there's 3 trees:
> 
> - drm-intel-next, which aims at v6.11 at this point and contains 50aec9665e0babd62b9eee4e613d9a1ef8d2b7de
> - drm-intel-next-fixes, which aims for v6.10-rc and contains the
>   cherry-picked version 2d9c72f676e6f79a021b74c6c1c88235e7d5b722 of the
>   same commit
> - drm-intel-fixes, which aims at v6.9-rc and contains yet another
>   cherry-picked version c002bfe644a29ba600c571f2abba13a155a12dcd of the
>   same commit
> 
> Now we generally rotate maintainership among releases, so Thomas Hellström
> was taking care of anything needed for v6.10 and Lucas De Marchi for v6.9,
> and they both individually did the necessary cherry pick at pretty much
> the same time. And so we end up with two cherry-picks of the same commit.
> At other times you might end up with a chain of cherry-picks, it's all the
> same.
> 
> Now looking back this is it's very silly, but it's a lot less silly as
> stuff gets merged into Linus' tree.
> 
> First v6.9 gets tagged, which contains c002bfe644a29ba600c571f. You don't
> have that in v6.8.y yet, so you  cherry-pick it over. Nothing special
> here. If you feel like you also assign a CVE for that upstream commit.
> 
> Then v6.10-rc1 is released, which contains 2d9c72f676e6f79a021b74c6. You
> don't have that, or a cherry pick of that commit in any of your stable
> trees, so might be tempted to try to backport it and then realize you seem
> to have a duplicate of this commit already.
> 
> But you're not yet done cherry-pick tracing, because 2d9c72f676e6f79a021b7
> contains the following line in its commit message:
> 
>     (cherry picked from commit 50aec9665e0babd62b9eee4e613d9a1ef8d2b7de)
> 
> So you also need to check whether you have any cherry-picks of 50aec9665e0babd:
> 
> - v6.9.y contains c002bfe644a29ba600c, so doesn't need another backport of
>   that. You skip this commit.
> 
> - v6.8.y and older stable trees contain a backport of c002bfe644a29ba6,
>   and if you didn't delete any cherry-picked lines all those backports
>   still contain
> 
>   (cherry picked from commit 50aec9665e0babd62b9eee4e613d9a1ef8d2b7de)
> 
>   line, so you know you're good and don't need another copy of that
>   commit.
> 
> Since this commit gets completely filtered you're also not tempted to
> assign a new CVE for this one. So no risk of duplicates.
> 
> Next up v6.11-rc1 is released, which contains 50aec9665e0babd62b9eee4e613d9a1ef8d2b7de.
> You check all your stable release branches and notice they all contain a
> cherry pick already:
> 
> - v6.10.y has 2d9c72f676e6f79a021b7
> - v6.9.y has c002bfe644a29ba600c571f
> - v6.8.y and older have a cherry pick of c002bfe644a29ba600c571f
> 
> Again this commit is completely filtered out with cherry-pick tracin
> checks.
> 
> Note that except for the first patch none of this mess should ever get
> past scripted filtering. Which means it should not confuse stable
> maintainers, and it also should not result in multiple CVEs getting
> assigned. Because only the first commit (c002bfe644a29ba600c in v6.9) will
> ever get past all the cherry pick tracing checks.
> 
> > > Like I tried to explain in my reply to Sasha somewhere else in this thread
> > > it really only takes two things:
> > > - drm maintainers consistently add cherry picked from lines anytime we
> > >  cherry-pick
> > > - you adjust your script to go hunt for the cherry pick alias if you get a
> > >  sha1 that makes no sense, so that you can put in the right sha1. And if
> > >  you do that for any sha1 you find (whether upstream references, Fixes:
> > >  or Reverts or stable candidate commits or whatever really), it will sort
> > >  out all the things we've been shouting about for years now.
> > 
> > We still have holes here... For example, this backport claims to:
> > 
> > 	Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA stream close")
> > 
> > But 8135f1c09dd2 is a cherry-pick:
> > 
> > 	(cherry picked from commit 0c8650b09a365f4a31fca1d1d1e9d99c56071128)
> > 
> > In the future, if we get a new patch that says:
> > 
> > 	Fixes: 0c8650b09a36 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA stream close")
> > 
> > By your logic, our scripts will look at it and say "0c8650b09a36 is a
> > real commit, but it's not in linux-6.12.y so there's no need to backport
> > the fix".
> > 
> > Which is the wrong thing to do, because we have 8135f1c09dd2 in
> > linux-6.12.y.
> > 
> > So no, this isn't a simple trace-the-cherry-pick-tags exercise.
> 
> So this is not quite what you do, because before you drop this patch you
> have to check whether you have a cherry-pick of 8135f1c09dd2 in your
> stable branch.
> 
> Now if we assume that only the stable team does cherry picks, you can
> limit your search to just the v6.12.y branch from the v6.12, and you'd
> wrongly conclude that you don't have a cherry pick there. But since the
> drm maintainers also do cherry-picks then limiting yourselv to just the
> patches you've applied to v6.12 will miss some, so you need to cherry-pick
> trace some more (I think 6 months into the past is generally enough, from
> your starting point commit).
> 
> And then you'll find that 8135f1c09dd2 is in v6.12 and a cherry-pick of
> 0c8650b09a36 so you need that bugfix.
> 
> > >  Automatically, without human intervention, because it's just a git
> > >  oneliner.
> > 
> > So look at the backport in question which started this thread. The
> > backporter ends up with:
> > 
> > """
> > [...]
> > 
> > commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream
> 
> Cherry pick tracing says this is f0ed39830e6064d62f9c5393505677a26569bb56
> which is in v6.13-rc1.
> > 
> > [...]
> > 
> > Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA stream close")
> 
> This one is in v6.12, but it's already a cherry-pick, so you need to be
> careful and look for possible other versions, because its commit message
> contains
> 
>     (cherry picked from commit 0c8650b09a365f4a31fca1d1d1e9d99c56071128)
> 
> But further cherry-pick tracing didn't show up any more commits that we
> didn't know of, so it's all done.
> 
> And 0c8650b09a365f4a31fca1d1d1e9d99c56071128 itself is in v6.13-rc1, so
> that resolves.
> 
> > Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com> # commit 1
> > Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > Cc: stable@vger.kernel.org # 6.12+
> > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20241220171919.571528-2-umesh.nerlige.ramappa@intel.com
> > (cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)
> 
> This commit will show up in v6.14-rc1. Currently all you can use this for
> is as a lookup key to find other cherry-pick copies.
> 
> > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > (cherry picked from commit f0ed39830e6064d62f9c5393505677a26569bb56)o
> 
> This commit is in v6.13-rc6, because that -rc series also needed the
> cherry-pick since the broken commit was in v6.13-rc1. And this commit
> itself is correctly annotated as a cherry-pick of 55039832f98c7e05f1, so
> it all checks out.
> 
> > """
> > 
> > Where most of the git IDs in it are invalid right now :)
> 
> They all make sense, but sometimes you do have to do a bit more
> cherry-pick tracing than what you've done.
> 
> Sometimes you need to do multiple levels of tracing, sometimes you start
> at a cherry-pick and need to fish out the original sha1 first (even if
> that's not one that resolves for you, you can still use it to find more
> cherry-picks). And because the stable team isn't the only maintainer team
> doing cherry-picks, you need to broaden your query a bit and can't limit
> yourself to your own cherry-picks only, to make sure you get them all.
> 
> Happy to walk you through even more special-case ladden examples. I tried
> to think them all through when cooking up the committer model years ago,
> I might indeed have missed a case. But pretty sure that the answer will be
> "you need more cherry-pick tracing".

Maybe also helps to go back from examples to the generic algorithm, which
is two steps:

1. You first need to find the root sha1 that all the cherry picks
originate from. If the sha1 you have doesn't resolve, you skip this.
Otherwise look at the commit message, if it has a "(cherry picked from
$sha)" line you pick the first line (they're ordered like sob lines), and
that's the root sha1. It might not resolve, but it's the search key you
need.

2. You go hunt for all cherry pick aliases for that root sha1. Strictly
speaking you'd need to search the entire history, but in practice commits
only travel back in time by 3-4 months at most (or a bit less thatn 2 full
kernel releases).  Half a year is the defensive assumption. So there's two
subcases:

2a) If you want to find the right commit in upstream, you scan half a year of
history in Linus' repo starting from the current tip.

2b) If you want to check for cherry picks in a stable branch, either to
check whether you already have that backport, or whether you need to
backport the bugfix for a buggy backport (due to Fixes/Revert: lines). You
scan all the stable commits, plus half a year of history from the release
tag Linus has done.

It's a bit madness, but more importantly, it's scriptable madness. And
since this confuses drm maintainers too, we do have that partially
implemented in our own scripts, to make sure we don't miss any bugfixes we
need in drm-fixes. Partially because we never have unresolved sha1 in our
own repos, because they also contain the -next branches where the root
commit is.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

