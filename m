Return-Path: <stable+bounces-109277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC3CA13C46
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707553A372C
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D9189F43;
	Thu, 16 Jan 2025 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cRe2cJRd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163761DA100
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037859; cv=none; b=UQXyWkM1Ij3PsVsHWmyvdBimNIYPsJ8OLypFGlzj+JjH4bDcmziAblQgFC+82tBVFL9j0Psub0rQk4c3cILExlLaghFwPgYxrmvxkUiWfKCrA32N4Z/NmX8z9qfuIYXpNrDqHhH5GcJgYahiPyRqrOkkNL479m7SgbNOQoV48ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037859; c=relaxed/simple;
	bh=EPBrtyq7kVmo3E7PGeZ3TVLkGONQsKJCMhcEqL/17M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh85Pr4SLa6Dq5o5jFnNwkKRoHXZxQvOqssXoirEQyngm3P1grMvnwML28RypBXk7RdMfr+zvC7mwmCY6mc29k++6uAUpUxQr8qB4Dny3ArxS7adaB2Wk++leVJCj6nPvm0CozRdtsIhHw9akwgeDUXfgN/gx1vRH3bZyDYXUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=cRe2cJRd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43621d27adeso6348415e9.2
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 06:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1737037855; x=1737642655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3/WPboTDu+6FR8CAU3xw5F2IuwYeqnTtNKrAdM5QKA=;
        b=cRe2cJRdtjCIzyVacVVpRE2R4VFXqyuwJIKT/l/uKblCWX5az+HB0Mm2PLqUNhuUoA
         DDr4aXqWCQVomR7MubMv8Znis+lsyIQKOhN+eTg2GJ2fe23kGvoOu/Odgl71ERk3iGbp
         TJUwIsvfuHzZ+9WjMXdUwybxhPsBpkQthMtV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737037855; x=1737642655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3/WPboTDu+6FR8CAU3xw5F2IuwYeqnTtNKrAdM5QKA=;
        b=r+pb73x4Bm1t0Ap/FgtVKfp/P5vqiLSShggljvIBxv43C+529scQsPCyG1Qp8KXNTu
         TqWR/30emDWx1YoD5oTMfTdx9j/9ouA9tuaVr+VKi7RGIxj61Gcv/pI7hNFKCceWP7DD
         E5CZm4psXBBXYl61IfVQNdsDgWixtajiWvy3LTvsGSoB3w+cTRYun8JXySIhpGCiTDRf
         oRAVwdPiiqy3MdRPsLdB1nMfTrdVu6UY1Bho3q/iQTpUWPoVeEqkHOyR1pvbvcURHaqs
         KA2MIOmZffDWespTj98LiznpBIdD993PfVjXH+uj9o21BevYtOJ+vothk7FplUmqbX7a
         5OkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHRJKqc3ShJ75M42BKTfwCAB6ZT+e9zCZeQ7Cadxgg2PBOnncnzKDWEJV7yxdYogtgqLdF2Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywSW2HS+fNichWqFUeFMl2gu6c58LLYgf4wMaBQLsJswYJTCQb
	hR0UnAxNRnjBN2BS6HJbTvf92yDgCr7+j1ctDsLmuGb8Lo8hx8xV1ZaZGH8R70M=
X-Gm-Gg: ASbGnctO21niqtFJpb/EibTJ/kyDRq6r2KkmuKay4UVa+oioXJwKh8STKIVz09yChXZ
	yn8jQMm+DljGjb4nYwkSvpqWwwVdcDhTPRZPpAverT8Gu3iySh1wx9Xb9aZWg0WMMgeUmBfXsRy
	rcL8d2vepCwQXjxCHKyMC9duHoVudM2xeWUV8SkueU3HT6+mHbBu1wMcHaFaRZMhKYpD9xaybb8
	IMo19y3UzewF/LChVs3nyZK62WFFVstuKOhpdL0VEyXrHUvtYMymETeHtanjt/SshZ9
X-Google-Smtp-Source: AGHT+IHjCovbuDFJ0v9aaZ1SdBt3vgUUVOCFOWA3+FJIYczCS5lvo/bWFIKonN3efDkQ4hh8TWtBxA==
X-Received: by 2002:a05:600c:4f81:b0:434:f1d5:1453 with SMTP id 5b1f17b1804b1-436e2531ec8mr332965685e9.0.1737037854956;
        Thu, 16 Jan 2025 06:30:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753c617sm61767585e9.37.2025.01.16.06.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:30:54 -0800 (PST)
Date: Thu, 16 Jan 2025 15:30:51 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, Sasha Levin <sashal@kernel.org>,
	Dave Airlie <airlied@gmail.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	stable@vger.kernel.org, ashutosh.dixit@intel.com,
	dri-devel@lists.freedesktop.org
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
Message-ID: <Z4kYG0cZdo2JncyE@phenom.ffwll.local>
References: <Z4Z8rQKR2QEaWNyI@phenom.ffwll.local>
 <Z4aIGvAmMld_uztJ@lappy>
 <Z4afbuFN1uc3zhOt@phenom.ffwll.local>
 <Z4d6406b82Pu1PRV@phenom.ffwll.local>
 <2025011503-algorithm-composed-3b81@gregkh>
 <Z4eY4rv8ygi9dRbz@phenom.ffwll.local>
 <Z4ft1fFjbwy0EF-X@lappy>
 <Z4gGKVFFXBQEm_OB@phenom.ffwll.local>
 <Z4jV_cPkg82X6FrY@phenom.ffwll.local>
 <2025011610-request-unleveled-8191@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025011610-request-unleveled-8191@gregkh>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Thu, Jan 16, 2025 at 02:52:23PM +0100, Greg KH wrote:
> On Thu, Jan 16, 2025 at 10:48:45AM +0100, Simona Vetter wrote:
> > Maybe also helps to go back from examples to the generic algorithm, which
> > is two steps:
> > 
> > 1. You first need to find the root sha1 that all the cherry picks
> > originate from. If the sha1 you have doesn't resolve, you skip this.
> > Otherwise look at the commit message, if it has a "(cherry picked from
> > $sha)" line you pick the first line (they're ordered like sob lines), and
> > that's the root sha1. It might not resolve, but it's the search key you
> > need.
> > 
> > 2. You go hunt for all cherry pick aliases for that root sha1. Strictly
> > speaking you'd need to search the entire history, but in practice commits
> > only travel back in time by 3-4 months at most (or a bit less thatn 2 full
> > kernel releases).  Half a year is the defensive assumption. So there's two
> > subcases:
> > 
> > 2a) If you want to find the right commit in upstream, you scan half a year of
> > history in Linus' repo starting from the current tip.
> > 
> > 2b) If you want to check for cherry picks in a stable branch, either to
> > check whether you already have that backport, or whether you need to
> > backport the bugfix for a buggy backport (due to Fixes/Revert: lines). You
> > scan all the stable commits, plus half a year of history from the release
> > tag Linus has done.
> > 
> > It's a bit madness, but more importantly, it's scriptable madness. And
> > since this confuses drm maintainers too, we do have that partially
> > implemented in our own scripts, to make sure we don't miss any bugfixes we
> > need in drm-fixes. Partially because we never have unresolved sha1 in our
> > own repos, because they also contain the -next branches where the root
> > commit is.
> 
> Yes, this is total madness.  Scanning the tree for every commit that we
> want to apply, or potentially apply, or figuring out if there is a
> missing fixes for that commit, is an exponential slowdown.
> 
> Right now we have tools that can go "where was this commit backported
> to" and give us that answer very quickly:
> 	$ /usr/bin/time ~/linux/vulns/tools/verhaal/id_found_in 79d67c499c3f886202a40c5cb27e747e4fa4d738
> 	5.4.289 5.10.233 5.15.176 6.1.124 6.6.70 6.12.9 6.13-rc6
> 	0.06user 0.03system 0:00.09elapsed 100%CPU (0avgtext+0avgdata 5856maxresident)k
> 	0inputs+0outputs (0major+1953minor)pagefaults 0swaps
> as we pre-process the whole kernel tree ahead of time and populate a
> database we can query.
> 
> Code for this is here:
> 	https://git.sr.ht/~gregkh/verhaal
> and that's what we use now for the CVEs to determine when a
> vulnerability showed up, and when it was fixed, and in what branches of
> the tree.
> 
> our older tool took a bit longer:
> 	$ /usr/bin/time ~/linux/stable/commit_tree/id_found_in 79d67c499c3f886202a40c5cb27e747e4fa4d738
> 	5.4.289 5.10.233 5.15.176 6.1.124 6.6.70 6.12.9 6.13-rc6
> 	0.30user 0.90system 0:00.60elapsed 198%CPU (0avgtext+0avgdata 366820maxresident)k
> 	0inputs+0outputs (0major+167451minor)pagefaults 0swaps
> as it abused the filesystem as a database with the output of some 'git
> log' results and relied on 'git grep' a lot to do regex matching.  And
> that turned out to miss a lot of things and have false-positives, hence
> the rewrite above.  I still personally use the old tool for some stable
> work as speed
> 
> Code for the old version is here:
> 	https://git.sr.ht/~gregkh/linux-stable_commit_tree
> 
> .6 seconds doesn't sound like a lot, but when you have to run other
> queries at the same time to walk branches and the like, and you're
> usually running it on a machine that is doing kernel builds at the same
> time, AND you are doing lookups for all commits in a series (100-500 at
> a time) or all CVEs issued so far (5000+), speed matters, hence the
> rewrite which also fixed some consistancy issues we had in our CVE
> entries.
> 
> So to add a whole new "now I need to walk back in time across ALL active
> kernel branches right now, AND maybe go dig elsewhere too" just to get
> things correct for one subsystem, you can see my disinterest and claims
> that "this sucks and is too much work and I'm going to give up".

Oh I know, but I'm honestly super happy that we've moved from "this is
impossible madness" to "the script takes way too long". Which frankly I
expected we'll get to, because the git grep stuff is ok for us, it's
definitely not fast enough at the scale of stable backports and cve
assignments.

> To do this "right" what I feel I need to do is find ALL matching commits
> in the kernel tree (based on linux-next reports I know DRM isn't the
> only offender here, many commits flow through multiple trees at the same
> time, but only DRM seems to trigger the problems) and then work on
> commit ids as having "aliases" with the duplicate matches.  I'm already
> starting to collect a bunch of "this id is invalid" stuff and maybe come
> up with a "rewrite" table to do queries off of as many times our Fixes
> and even Revert ids are wrong.

So for the annotated cherry-picks I think you need a table with 2 rows,
first has the real commit sha1 (and if you scan linux-next you should
never have a sha1 that doesn't resolve), the second the root sha1 of the
cherry-pick chain, as annotated in the first "(cherry picked from
$root_sha1)" in the commit message.

The full cherry-pick query would then still be the two step process,
except you can skip at step 1 because if there's no entry, you know that
this commit is not part of a cherry-pick group. Since at least with the
drm flow you'll always see the cherry-picks first as new commits land in
Linus' tree.

Then just fill that table with new entries as you scan for updates in
Linus' tree (I wouldn't scan linux-next except for testing this, because
you might pick up bogus entries).

That should be enough to do all the alias querying you need for properly
annotated cherry-picks. But it's not enough for the case of where a patch
is applied twice, without that annotation. So not sure what to do with
those, imo teaching maintainers to annotate them is probably the best
option, since guessing is error prone.

> Ugh, time to dust off my old SQL book and figure out some table joins...
> I'll consider working on this during the merge window and see what I can
> come up with.
> 
> Any pointers to where the scripts you all use for your "catch the
> duplicates" logic you describe above are for the drm developers to use?

Probably not much use, because the actual logic is the git log greps from
this thread, and we cheat with not handling a bunch of corner cases. But
it's dim cherry-pick-branch and dim cherry-pick in our maintainer tools
that helps with the cherry-picking:

https://gitlab.freedesktop.org/drm/maintainer-tools/-/blob/master/dim?ref_type=heads#L1600

Comes with some docs too:

https://drm.pages.freedesktop.org/maintainer-tools/dim.html

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

