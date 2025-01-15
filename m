Return-Path: <stable+bounces-108687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C30C1A11CF0
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29A0188BCF1
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB95246A1F;
	Wed, 15 Jan 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="N56Sa+5E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC61246A25
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932074; cv=none; b=hODP5BmVId5P5FXTFJD4j8lk3LfjSCXNsoT8iyqeAzcIpzIO8wKcEfIKUco69zS8rinGJtFQeOxgkYYiMqzynurme82HBVYB33mBBNvFtJlf9ECb/JLdcEWaeDf/q4fH18t2LthJzO26U6nAoAzYWCoWbYrB5y9JwlClpi57Y7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932074; c=relaxed/simple;
	bh=fwtRkywrsKNvFwNCJAjSurDjtBOmIvEvljXDSMwRzYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nShZPeiSozNIn8u32t3MFKEWpdzS0HckFSnjRE9JFMSlN94RW9+cbPOUtKTxkGYzcK/PYCOrE3/M8BOBO5ehfuRrKgM7Owq3EC434S/oLvzsOtw9VbdGMgP/+T8bw5d70i4lb9LZk2xMUdNfZFyCija+58sH6/okjLLf3HbPmMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=N56Sa+5E; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385dece873cso3161437f8f.0
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 01:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1736932070; x=1737536870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mD7Unk3v6s5Zif9sDplqn8fHlG5kt3jEr0Y4pbLTR7E=;
        b=N56Sa+5E4hlvsbfh3JxmDHdCY0BuEAjvIMCDWbYoHh0r/WLnwGKAjiaiumudbZhD2W
         D84XPx0zBXnASm5TQ0aLqFgfqNfKkIuhW8eGj8cbMwoKl0d3mXMR+UDqk/9ofJe3H5Fa
         PnMeRRlkl1gJzj50jxO7GsTdAIMZCrWWKgQCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736932070; x=1737536870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD7Unk3v6s5Zif9sDplqn8fHlG5kt3jEr0Y4pbLTR7E=;
        b=GrNVCCx/czOuIHqEpqspq9zzLw+zr42fan5YNrD++qvBwOsCGuQSAkwT+ytdQ2QGD9
         JTTRCqlDj50RtaL1iTjHrDL00WfW/snChTlhkyrYwwdzECVQkCxDioXCCPBSvF1XX+7D
         fgow9uxESs3TCFTrKO7RGoEkKEQKVCeCmeFNILw40bfznNImIPJ6zsSTlK3q6/H36v1e
         Tp2+yHPpoe2Pkp73ORDRBPg/0EgmIsECMJEpOjdCvnK8bu4rIA+HubW5f2rUpRwNaG+3
         5nGoSB90dZu3LOyTE66SwsOWicWBWD6PVr1H+ptTsO4JOMQPqUq31CTibD0EP1dzhqlP
         sLbw==
X-Forwarded-Encrypted: i=1; AJvYcCXv8UV8j1N2XQ7oOyDjGm4EpHRdSDSgwGepZZz5ml0e8A8OYX2IJ2WxRAQ4xOwbxwwaeYsGS+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7sP1za3+Gk9N65Nqxg76goDwD/B4hWwYSIRWVnrd3tYIN0ohV
	IJ1+f+NhzU4JvTOqIpwHTOOKgYRyCsRxMu5nbK3FT8iJiWyZGjHFgV6vXH7uJpc=
X-Gm-Gg: ASbGncuMZoMizhJKcqXOwbLIdR0x3zZI5fRKzDsrEvoL61KWohDvmtYge3Ava7ECCNN
	0hIclIdI69Az+8n14V9XSn2iekboxxZ1PheUHsVK4Q3MfGsBniafct8oT974asCGE9UogKxUKJg
	Pmx+BVOa5gM2kFNlYzerx5Brpl98+FOPJR/uPxNOoRf6lbzvLgk97cOJPw9O5LS14XmUNZgSWF8
	rJ04qaNkfAeo68mqX0WpT9dVQFA9PWn0hXDWjyifiiDIz0JpcCC778+4sUgFpkbhBg4
X-Google-Smtp-Source: AGHT+IHdcK3gaoRSBZChCC2jvljvsxyz1yLEUm4zgfpaMrBGty8/fVU25ED1B8uEOTXL4rMU9hMOZw==
X-Received: by 2002:a5d:648a:0:b0:38a:4b8a:e47d with SMTP id ffacd0b85a97d-38a8730ac0emr24182863f8f.26.1736932070350;
        Wed, 15 Jan 2025 01:07:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499965sm16328255e9.5.2025.01.15.01.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:07:49 -0800 (PST)
Date: Wed, 15 Jan 2025 10:07:47 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Sasha Levin <sashal@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	stable@vger.kernel.org, ashutosh.dixit@intel.com,
	dri-devel@lists.freedesktop.org
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
Message-ID: <Z4d6406b82Pu1PRV@phenom.ffwll.local>
References: <2025011215-agreeing-bonfire-97ae@gregkh>
 <CAPM=9txn1x5A7xt+9YQ+nvLaQ3ycekC1Oj4J2PUpWCJwyQEL9w@mail.gmail.com>
 <CAPM=9twogjmTCc=UHBYkPPkrdHfm0PJ9VDoOg+X2jWZbdjVBww@mail.gmail.com>
 <2025011247-spoilage-hamster-28b2@gregkh>
 <CAPM=9tx1cFzhaZNz=gQOmP9Q0KEK5fMKZYSc-P0xA_f2sxoZ9w@mail.gmail.com>
 <2025011352-fox-wrangle-4d3f@gregkh>
 <CAPM=9tzkJ=dn2gq7GcvtN_C95ZzxwC7XMMXHBrwF6Ez6fYfU=g@mail.gmail.com>
 <Z4Z8rQKR2QEaWNyI@phenom.ffwll.local>
 <Z4aIGvAmMld_uztJ@lappy>
 <Z4afbuFN1uc3zhOt@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4afbuFN1uc3zhOt@phenom.ffwll.local>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Tue, Jan 14, 2025 at 06:31:26PM +0100, Simona Vetter wrote:
> On Tue, Jan 14, 2025 at 10:51:54AM -0500, Sasha Levin wrote:
> > On Tue, Jan 14, 2025 at 04:03:09PM +0100, Simona Vetter wrote:
> > > On Tue, Jan 14, 2025 at 11:01:34AM +1000, Dave Airlie wrote:
> > > > > > > We create a "web" when we backport commits, and mark things for "Fixes:"
> > > > > > > When we get those ids wrong because you all have duplicate commits for
> > > > > > > the same thing, everything breaks.
> > > > > > >
> > > > > > > > I just don't get what the ABI the tools expect is, and why everyone is
> > > > > > > > writing bespoke tools and getting it wrong, then blaming us for not
> > > > > > > > conforming. Fix the tools or write new ones when you realise the
> > > > > > > > situation is more complex than your initial ideas.
> > > > > > >
> > > > > > > All I want to see and care about is:
> > > > > > >
> > > > > > >  - for a stable commit, the id that the commit is in Linus's tree.
> > > > > > >  - for a Fixes: tag, the id that matches the commit in Linus's tree AND
> > > > > > >    the commit that got backported to stable trees.
> > > > > > >
> > > > > > > That's it, that's the whole "ABI".  The issue is that you all, for any
> > > > > > > number of commits, have 2 unique ids for any single commit and how are
> > > > > > > we supposed to figure that mess out...
> > > > > >
> > > > > > Pretty sure we've explained how a few times now, not sure we can do much more.
> > > > >
> > > > > And the same for me.
> > > > >
> > > > > > If you see a commit with a cherry-pick link in it and don't have any
> > > > > > sight on that commit in Linus's tree, ignore the cherry-pick link in
> > > > > > it, assume it's a future placeholder for that commit id. You could if
> > > > > > you wanted to store that info somewhere, but there shouldn't be a
> > > > > > need.
> > > > >
> > > > > Ok, this is "fine", I can live with it.  BUT that's not the real issue
> > > > > (and your own developers get confused by this, again, look at the
> > > > > original email that started this all, they used an invalid git id to
> > > > > send to us thinking that was the correct id to use.)
> > > > 
> > > > I'm going to go back and look at the one you pointed out as I'm
> > > > missing the issue with it, I thought it was due to a future ID being
> > > > used.
> > > 
> > > I think the issue is that with the cherry-picking we do, we don't update
> > > the Fixes: or Reverts: lines, so those still point at the og commit in
> > > -next, while the cherry-picked commit is in -fixes.
> > > 
> > > The fix for that (which our own cherry-pick scripts implement iirc) is to
> > > keep track of the cherry-picks (which is why we add that line) and treat
> > > them as aliases.
> > > 
> > > So if you have a Fixes: $sha1 pointing at -next, then if you do a
> > > full-text commit message search for (cherry picked from $sha1), you should
> > > be able to find it.
> > > 
> > > We could try to do that lookup with the cherry-pick scripts, but a lot of
> > > folks hand-roll these, so it's lossy at best. Plus you already have to
> > > keep track of aliases anyway since you're cherry-picking to stable, so I
> > > was assuming that this shouldn't cause additional issues.
> > > 
> > > The other part is that if you already have a cherry picked from $sha1 in
> > > your history, even if it wasn't done with stable cherry-pick, then you
> > > don't have to cherry-pick again. These should be easy to filter out.
> > > 
> > > But maybe I'm also not understanding what the issue is, I guess would need
> > > to look at a specific example.
> > > 
> > > > > > When future tools are analysing things, they will see the patch from
> > > > > > the merge window, the cherry-picked patches in the fixes tree, and
> > > > > > stable will reference the fixes, and the fixes patch will reference
> > > > > > the merge window one?
> > > > >
> > > > >
> > > > > > but I think when we cherry-pick patches from -next that fix
> > > > > > other patches from -next maybe the fixes lines should be reworked to
> > > > > > reference the previous Linus tree timeline not the future one. not
> > > > > > 100% sure this happens? Sima might know more.
> > > > >
> > > > > Please fix this up, if you all can.  That is the issue here.  And again,
> > > > > same for reverts.
> > > > >
> > > > > I think between the two, this is causing many fixes and reverts to go
> > > > > unresolved in the stable trees.
> > > > >
> > > > > > Now previously I think we'd be requested to remove the cherry-picks
> > > > > > from the -fixes commits as they were referencing things not in Linus'
> > > > > > tree, we said it was a bad idea, I think we did it anyways, we got
> > > > > > shouted at, we put it back, we get shouted that we are referencing
> > > > > > commits that aren't in Linus tree. Either the link is useful
> > > > > > information and we just assume cherry-picks of something we can't see
> > > > > > are a future placeholder and ignore it until it shows up in our
> > > > > > timeline.
> > > > >
> > > > > I still think it's lunacy to have a "cherry pick" commit refer to a
> > > > > commit that is NOT IN THE TREE YET and shows up in history as "IN THE
> > > > > FUTURE".  But hey, that's just me.
> > > > >
> > > > > Why do you have these markings at all?  Who are they helping?  Me?
> > > > > Someone else?
> > > > 
> > > > They are for helping you. Again if the commit that goes into -next is immutable,
> > > > there is no way for it to reference the commit that goes into -fixes
> > > > ahead of it.
> > > > 
> > > > The commit in -fixes needs to add the link to the future commit in
> > > > -next, that link is the cherry-pick statement.
> > > > 
> > > > When you get the future commit into the stable queue, you look for the
> > > > commit id in stable history as a cherry-pick and drop it if it's
> > > > already there.
> > > > 
> > > > I can't see any other way to do this, the future commit id is a
> > > > placeholder in Linus/stable tree, the commit is immutable and 99.99%
> > > > of the time it will arrive at some future point in time.
> > > > 
> > > > I'm open to how you would make this work that isn't lunacy, but I
> > > > can't really see a way since git commits are immutable.
> > > 
> > > Yeah the (cherry picked from $sha1) with a sha1 that's in -next and almost
> > > always shows up in Linus' tree in the future shouldn't be an issue. That
> > > part really is required for driver teams to manage their flows.
> > > 
> > > > > > I think we could ask to not merge things into -next with stable cc'ed
> > > > > > but I think that will result in a loss of valuable fixes esp for
> > > > > > backporters.
> > > > >
> > > > > Again, it's the Fixes and Reverts id referencing that is all messed up
> > > > > here.  That needs to be resolved.  If it takes you all the effort to
> > > > > make up a special "stable tree only" branch/series/whatever, I'm all for
> > > > > it, but as it is now, what you all are doing is NOT working for me at
> > > > > all.
> > > > 
> > > > I'll have to see if anyone is willing to consider pulling this sort of
> > > > feat off, it's not a small task, and it would have to be 99% automated
> > > > I think to be not too burdensome.
> > > 
> > > It's not that hard to script, dim cherry-pick already does it. It's the
> > > part where we need to guarantee that we never ever let one slip through
> > > didn't get this treatment of replacing the sha1.
> > > 
> > > The even more insideous one is when people rebase their -next or -fixes
> > > trees, since then the sha1 will really never ever show up. Which is why
> > > we're telling people to not mess with git history at all and instead
> > > cherry-pick. It's the lesser pain.
> > 
> > But this does happen with cherry picks... A few examples from what I saw
> > with drivers/gpu/drm/ and -stable:
> > 
> > 5a507b7d2be1 ("drm/mst: Fix NULL pointer dereference at
> > drm_dp_add_payload_part2") which landed as 8a0a7b98d4b6 ("drm/mst: Fix
> > NULL pointer dereference at drm_dp_add_payload_part2") rather than
> > 4545614c1d8da.
> 
> This one also landed through Alex' tree, and before he switched over to
> cherry-pick -x and not trying to fix things up with rebasing. Because in
> theory rebasing bugfixes out of -next into -fixes avoids all that trouble,
> in practice it just causes a reliably even bigger mess.
> 
> > e89afb51f97a ("drm/vmwgfx: Fix a 64bit regression on svga3") which
> > landed as c2aaa37dc18f ("drm/vmwgfx: Fix a 64bit regression on svga3")
> > rather than 873601687598.
> 
> This one is from 2021. Iirc it's the case that motivated us to improve the
> commiter documentation and make it clear that only maintainers should do
> cherry-picks. Occasionally people don't know and screw up.
> 
> > a829f033e966 ("drm/i915: Wedge the GPU if command parser setup fails")
> > which indicates it's a cherry-pick, but I couldn't find the equivalent
> > commit landing at any point later on.
> 
> This one was a maintainer action by Dave and me, where we went in and
> rebased an entire -next tree. Also from 2021, even more exceptional than
> the "committer cherry-picked themselves and screwed up".
> 
> I'm not saying that the cherry-pick model with committers is error free.
> Not at all. It's just in my experience substantially less error prone than
> anything else, it's simply the less shit option.
> 
> Roughly the options are:
> 
> - rebase trees to not have duplicated commits. Breaks the committer model,
>   pretty much guarantees that you have commit references to absolutely
>   nowhere at all in practice because people butcher rebases all the time.
>   Also pisses off Linus with unecessary rebases that don't reflect actual
>   development history.
> 
>   Plus we'd insta run out of maintainers in drm if we do this.

Bit more here, because this isn't hyperbole. drm isn't magic, we don't
have more maintainer volunteers than any other subsystem. And if we'd run
the show the same way as most others, we'd suffer like everyone else from
overloaded and burnt out maintainers.

We fixed the "not enough maintainer volunteers" problem by radically
changing the workflow, and radically reducing the amount of work
maintainers have to do. But that has consequences, and that's why we
cherry-pick so much.

If you center your flow around committers, then you also need to accept
that for a committer the most important tree is their driver/subsystem
tree, and everything else is downstream. And they don't care about
downstream at that much. Exactly like how maintainers don't care that much
about stable trees as their downstream, and you're trying to make it as
easy as possible for them.

Roughly translating things:

- For you, stable is the downstream that cherry-picks from the main
  development branch. For drm committers, drm-fixes is their downstream
  that cherry-picks from the development tree (and everything else is even
  further downstream).

- For you Linus' git tree is the development branch you cherry-pick from.
  For drm committers the drm-foo-next branch is their development branch
  that we cherry-pick from.

- You asking us to not cherry-pick but instead do the classic maintainer
  approach of filtering out fixes into foo-fixes branches is the same as
  if you'd ask maintainers to send bugfixes for stable to you directly,
  rebase them out of their pr to Linus and then backmerge. This is total
  bullocks, because stable isn't the development branch.

The only difference is that for drm committers, Linus' tree is also not
the development branch, it's the drm-next branches. And sure drm is like
10x smaller than the kernel overall, but that doesn't mean your request
that we rebase our development branch because downstream (meaning
drm-fixes, which feeds into Linus' git) can't cope with cherry-picks is
10x more reasonable. It's still fundamentally a busted workflow.

And if you ditch the notion that for committers drm-next is their
development branch, then you cannot have a committer model. And if you
ditch that drm is as starved for maintainer volunteer time as any other
subsystem, because we're really not special.

Cheers, Sima
 
>   I think this is also what Alex tried to do until very recently.
> 
> - cherry-pick, but pretend it didn't happen. This means either people
>   perfectly fix up all tags (see above, doesn't happen in practice) or you
>   need to do title based guessing games. Plus you need to do title-based
>   guessing games with the duplicates anyway.
> 
> - cherry-pick -x. You can actually handle this one with scripts and no
>   human shouting. Unless people forgot to use -x or screwed up something
>   else (which is why we have a script and docs). Which does happene, but
>   the two examples you've found for that flow are from 2021. There should
>   also be some that are more recent.
> 
> - we give up on stable for drm.
> 
> Cheers, Sima
> 
> > Or the following 3 commits:
> > 
> > 0811b9e4530d ("drm/amd/display: Add HUBP surface flip interrupt
> > handler") which has a stable tag, and no cherry-pick line.
> > 
> > 4ded1ec8d1b3 ("drm/amd/display: Add HUBP surface flip interrupt
> > handler") which is a different code change than the previous commit, and
> > a completely different commit message, no stable tag, and no cherry-pick
> > line.
> > 
> > 7af87fc1ba13 ("drm/amd/display: Add HUBP surface flip interrupt
> > handler") which has the same code change as above, and it has the same
> > commit message as 4ded1ec8d1b3 but with an added stable tag, and again -
> > no cherry-pick line.
> > 
> > -- 
> > Thanks,
> > Sasha
> 
> -- 
> Simona Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

