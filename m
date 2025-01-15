Return-Path: <stable+bounces-109126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA74CA1224B
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 12:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C088A188EC27
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D7248BDF;
	Wed, 15 Jan 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HRiQ3tq5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3A248BDA
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939753; cv=none; b=O5jwR+EKkd6qKCC83KEoGETLMf1LM5gvXEF9KXd0q6lq/3/P88FyCWiV4hINxckcJHywEVJyjHTJGM1BIMaG12tIe9/Y1iua9qZ1XhJJ+cuUnQSTuaZ2qYVfTVL6xwAsnE7frhs+asZmz4JVx4QSCN2EUI6OiH5AKLiI+tlP+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939753; c=relaxed/simple;
	bh=jb531u/+IRzN4n+IpXUWMVmLvnK2WVFNlnP3XQvWuEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmE+fO7R1bk7aCa6/SLTwKWqPIEeGybR72LmK1+kb8w9tDgyyNIT54WI6aWPA/kg/dTMZhTMcbEtWVKUQ/2X8lBO5+pq5lKZWxunMVBzPi4RSaAffo+IFjCSEIcAhhqrMFvG0OBgmU5/wQdsF8OUoBxPRhb1qgqWY2lq8Pop2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=HRiQ3tq5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862a921123so3816080f8f.3
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 03:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1736939749; x=1737544549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq8h2JIFrdENJ/QNUVaetI/BuXSV3NnRFqZVZAjoqUo=;
        b=HRiQ3tq5CXZG+pTbpr+C8X2zE/MZ0C6FX174VwURX4sp1ZCXVE1/a3i7yFuzNUK6kw
         aWuRP1EUic//H14VK+eLZsL/gmayvZpFTG2LIiWPzAtpgUeFbfFgBZ14uu6b9QHdu+n6
         0SHoide0rJUQdDFcSbZf20KDB/eMvP1KnNzDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939749; x=1737544549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq8h2JIFrdENJ/QNUVaetI/BuXSV3NnRFqZVZAjoqUo=;
        b=QEDlv6awo+52MVVF4Fhmlu2hdWagd5dsFFZVvkmiE89i6wqX5/DVRdy1dqRvxvhdaU
         f1ykHPs5EILoSp5xsuCoGQPsXsjyQfUw9nC/gCaK8h5CUeSB7OOXI962C9pBuNdUZMzF
         oWEv2htoXkYRJYwQssMs0L12E5m5sops3GWXkLBegRGGuaCSN+TgMLWoM5d/Ad84wnNH
         7ajLruK0I/YezgTe/a0GE6FVUGVdpP3HXOwS6gWGzo10XT0YBEQ0Faz4/C4GZThUT4OR
         R6SCCJE0LiGE5VM7Ar7itct4x7tZkioGW+WhKTsjGQLNMGQ5nxFdU3edMw3S/1liM1RI
         Z6sw==
X-Forwarded-Encrypted: i=1; AJvYcCVYlMpLrZsLmjwkBCWAhpanEBMnsdRX6IV9El9IXeU+38SRGhfafdOX0f8khvopcLoKUGAxbnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoyarBF9He3yvzZMla7b+RDyd4dcnbyBpBNUjbf3DYVojWy/xR
	F5fOxTvhlo4chsVo5Ltqt2RTV46YNmYRg8iomhitBWHXsKXzaGSV+aYuiWG7ACI=
X-Gm-Gg: ASbGnct+syC5UCYZ+oWPWKZVJEtLmjj2mjE/6zTPICIQNlvElWQQkCBScVzdAnjxgDv
	TXzPQJa5rFsNufpu97cesMfeUEzQLyq15e/kU/oTuiWFjFD3sJIWE6KWPc4MdQwVUQdWI3ORnmM
	+4JN1H8Bo5JM72opcSpiF4WxJqyNsnGS0tIUlxHebKK+o1WcptSbg2h+o0FjZpfMgp8F7Y0sXZk
	LO5GLhJLe90TlO9Hu+xznHFeinm008nC8zQcqzULCQnCXyKAFXeJ9OmZkiu66dyJmvt
X-Google-Smtp-Source: AGHT+IHJz2hV0xsbSDBKNaB2/vONqxw1OAY8jbW5Z/7WmMqH6v7J1oSNXmcIh1d1t7wqxMjaYMNNkg==
X-Received: by 2002:a5d:6d83:0:b0:386:3864:5cf2 with SMTP id ffacd0b85a97d-38a8730497dmr22102325f8f.19.1736939749350;
        Wed, 15 Jan 2025 03:15:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bddbf50a2sm6856602f8f.43.2025.01.15.03.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:15:48 -0800 (PST)
Date: Wed, 15 Jan 2025 12:15:46 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, Sasha Levin <sashal@kernel.org>,
	Dave Airlie <airlied@gmail.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	stable@vger.kernel.org, ashutosh.dixit@intel.com,
	dri-devel@lists.freedesktop.org
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
Message-ID: <Z4eY4rv8ygi9dRbz@phenom.ffwll.local>
References: <CAPM=9twogjmTCc=UHBYkPPkrdHfm0PJ9VDoOg+X2jWZbdjVBww@mail.gmail.com>
 <2025011247-spoilage-hamster-28b2@gregkh>
 <CAPM=9tx1cFzhaZNz=gQOmP9Q0KEK5fMKZYSc-P0xA_f2sxoZ9w@mail.gmail.com>
 <2025011352-fox-wrangle-4d3f@gregkh>
 <CAPM=9tzkJ=dn2gq7GcvtN_C95ZzxwC7XMMXHBrwF6Ez6fYfU=g@mail.gmail.com>
 <Z4Z8rQKR2QEaWNyI@phenom.ffwll.local>
 <Z4aIGvAmMld_uztJ@lappy>
 <Z4afbuFN1uc3zhOt@phenom.ffwll.local>
 <Z4d6406b82Pu1PRV@phenom.ffwll.local>
 <2025011503-algorithm-composed-3b81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025011503-algorithm-composed-3b81@gregkh>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Wed, Jan 15, 2025 at 10:38:34AM +0100, Greg KH wrote:
> On Wed, Jan 15, 2025 at 10:07:47AM +0100, Simona Vetter wrote:
> > On Tue, Jan 14, 2025 at 06:31:26PM +0100, Simona Vetter wrote:
> > > On Tue, Jan 14, 2025 at 10:51:54AM -0500, Sasha Levin wrote:
> > > > On Tue, Jan 14, 2025 at 04:03:09PM +0100, Simona Vetter wrote:
> > > > > On Tue, Jan 14, 2025 at 11:01:34AM +1000, Dave Airlie wrote:
> > > > > > > > > We create a "web" when we backport commits, and mark things for "Fixes:"
> > > > > > > > > When we get those ids wrong because you all have duplicate commits for
> > > > > > > > > the same thing, everything breaks.
> > > > > > > > >
> > > > > > > > > > I just don't get what the ABI the tools expect is, and why everyone is
> > > > > > > > > > writing bespoke tools and getting it wrong, then blaming us for not
> > > > > > > > > > conforming. Fix the tools or write new ones when you realise the
> > > > > > > > > > situation is more complex than your initial ideas.
> > > > > > > > >
> > > > > > > > > All I want to see and care about is:
> > > > > > > > >
> > > > > > > > >  - for a stable commit, the id that the commit is in Linus's tree.
> > > > > > > > >  - for a Fixes: tag, the id that matches the commit in Linus's tree AND
> > > > > > > > >    the commit that got backported to stable trees.
> > > > > > > > >
> > > > > > > > > That's it, that's the whole "ABI".  The issue is that you all, for any
> > > > > > > > > number of commits, have 2 unique ids for any single commit and how are
> > > > > > > > > we supposed to figure that mess out...
> > > > > > > >
> > > > > > > > Pretty sure we've explained how a few times now, not sure we can do much more.
> > > > > > >
> > > > > > > And the same for me.
> > > > > > >
> > > > > > > > If you see a commit with a cherry-pick link in it and don't have any
> > > > > > > > sight on that commit in Linus's tree, ignore the cherry-pick link in
> > > > > > > > it, assume it's a future placeholder for that commit id. You could if
> > > > > > > > you wanted to store that info somewhere, but there shouldn't be a
> > > > > > > > need.
> > > > > > >
> > > > > > > Ok, this is "fine", I can live with it.  BUT that's not the real issue
> > > > > > > (and your own developers get confused by this, again, look at the
> > > > > > > original email that started this all, they used an invalid git id to
> > > > > > > send to us thinking that was the correct id to use.)
> > > > > > 
> > > > > > I'm going to go back and look at the one you pointed out as I'm
> > > > > > missing the issue with it, I thought it was due to a future ID being
> > > > > > used.
> > > > > 
> > > > > I think the issue is that with the cherry-picking we do, we don't update
> > > > > the Fixes: or Reverts: lines, so those still point at the og commit in
> > > > > -next, while the cherry-picked commit is in -fixes.
> > > > > 
> > > > > The fix for that (which our own cherry-pick scripts implement iirc) is to
> > > > > keep track of the cherry-picks (which is why we add that line) and treat
> > > > > them as aliases.
> > > > > 
> > > > > So if you have a Fixes: $sha1 pointing at -next, then if you do a
> > > > > full-text commit message search for (cherry picked from $sha1), you should
> > > > > be able to find it.
> > > > > 
> > > > > We could try to do that lookup with the cherry-pick scripts, but a lot of
> > > > > folks hand-roll these, so it's lossy at best. Plus you already have to
> > > > > keep track of aliases anyway since you're cherry-picking to stable, so I
> > > > > was assuming that this shouldn't cause additional issues.
> > > > > 
> > > > > The other part is that if you already have a cherry picked from $sha1 in
> > > > > your history, even if it wasn't done with stable cherry-pick, then you
> > > > > don't have to cherry-pick again. These should be easy to filter out.
> > > > > 
> > > > > But maybe I'm also not understanding what the issue is, I guess would need
> > > > > to look at a specific example.
> > > > > 
> > > > > > > > When future tools are analysing things, they will see the patch from
> > > > > > > > the merge window, the cherry-picked patches in the fixes tree, and
> > > > > > > > stable will reference the fixes, and the fixes patch will reference
> > > > > > > > the merge window one?
> > > > > > >
> > > > > > >
> > > > > > > > but I think when we cherry-pick patches from -next that fix
> > > > > > > > other patches from -next maybe the fixes lines should be reworked to
> > > > > > > > reference the previous Linus tree timeline not the future one. not
> > > > > > > > 100% sure this happens? Sima might know more.
> > > > > > >
> > > > > > > Please fix this up, if you all can.  That is the issue here.  And again,
> > > > > > > same for reverts.
> > > > > > >
> > > > > > > I think between the two, this is causing many fixes and reverts to go
> > > > > > > unresolved in the stable trees.
> > > > > > >
> > > > > > > > Now previously I think we'd be requested to remove the cherry-picks
> > > > > > > > from the -fixes commits as they were referencing things not in Linus'
> > > > > > > > tree, we said it was a bad idea, I think we did it anyways, we got
> > > > > > > > shouted at, we put it back, we get shouted that we are referencing
> > > > > > > > commits that aren't in Linus tree. Either the link is useful
> > > > > > > > information and we just assume cherry-picks of something we can't see
> > > > > > > > are a future placeholder and ignore it until it shows up in our
> > > > > > > > timeline.
> > > > > > >
> > > > > > > I still think it's lunacy to have a "cherry pick" commit refer to a
> > > > > > > commit that is NOT IN THE TREE YET and shows up in history as "IN THE
> > > > > > > FUTURE".  But hey, that's just me.
> > > > > > >
> > > > > > > Why do you have these markings at all?  Who are they helping?  Me?
> > > > > > > Someone else?
> > > > > > 
> > > > > > They are for helping you. Again if the commit that goes into -next is immutable,
> > > > > > there is no way for it to reference the commit that goes into -fixes
> > > > > > ahead of it.
> > > > > > 
> > > > > > The commit in -fixes needs to add the link to the future commit in
> > > > > > -next, that link is the cherry-pick statement.
> > > > > > 
> > > > > > When you get the future commit into the stable queue, you look for the
> > > > > > commit id in stable history as a cherry-pick and drop it if it's
> > > > > > already there.
> > > > > > 
> > > > > > I can't see any other way to do this, the future commit id is a
> > > > > > placeholder in Linus/stable tree, the commit is immutable and 99.99%
> > > > > > of the time it will arrive at some future point in time.
> > > > > > 
> > > > > > I'm open to how you would make this work that isn't lunacy, but I
> > > > > > can't really see a way since git commits are immutable.
> > > > > 
> > > > > Yeah the (cherry picked from $sha1) with a sha1 that's in -next and almost
> > > > > always shows up in Linus' tree in the future shouldn't be an issue. That
> > > > > part really is required for driver teams to manage their flows.
> > > > > 
> > > > > > > > I think we could ask to not merge things into -next with stable cc'ed
> > > > > > > > but I think that will result in a loss of valuable fixes esp for
> > > > > > > > backporters.
> > > > > > >
> > > > > > > Again, it's the Fixes and Reverts id referencing that is all messed up
> > > > > > > here.  That needs to be resolved.  If it takes you all the effort to
> > > > > > > make up a special "stable tree only" branch/series/whatever, I'm all for
> > > > > > > it, but as it is now, what you all are doing is NOT working for me at
> > > > > > > all.
> > > > > > 
> > > > > > I'll have to see if anyone is willing to consider pulling this sort of
> > > > > > feat off, it's not a small task, and it would have to be 99% automated
> > > > > > I think to be not too burdensome.
> > > > > 
> > > > > It's not that hard to script, dim cherry-pick already does it. It's the
> > > > > part where we need to guarantee that we never ever let one slip through
> > > > > didn't get this treatment of replacing the sha1.
> > > > > 
> > > > > The even more insideous one is when people rebase their -next or -fixes
> > > > > trees, since then the sha1 will really never ever show up. Which is why
> > > > > we're telling people to not mess with git history at all and instead
> > > > > cherry-pick. It's the lesser pain.
> > > > 
> > > > But this does happen with cherry picks... A few examples from what I saw
> > > > with drivers/gpu/drm/ and -stable:
> > > > 
> > > > 5a507b7d2be1 ("drm/mst: Fix NULL pointer dereference at
> > > > drm_dp_add_payload_part2") which landed as 8a0a7b98d4b6 ("drm/mst: Fix
> > > > NULL pointer dereference at drm_dp_add_payload_part2") rather than
> > > > 4545614c1d8da.
> > > 
> > > This one also landed through Alex' tree, and before he switched over to
> > > cherry-pick -x and not trying to fix things up with rebasing. Because in
> > > theory rebasing bugfixes out of -next into -fixes avoids all that trouble,
> > > in practice it just causes a reliably even bigger mess.
> > > 
> > > > e89afb51f97a ("drm/vmwgfx: Fix a 64bit regression on svga3") which
> > > > landed as c2aaa37dc18f ("drm/vmwgfx: Fix a 64bit regression on svga3")
> > > > rather than 873601687598.
> > > 
> > > This one is from 2021. Iirc it's the case that motivated us to improve the
> > > commiter documentation and make it clear that only maintainers should do
> > > cherry-picks. Occasionally people don't know and screw up.
> > > 
> > > > a829f033e966 ("drm/i915: Wedge the GPU if command parser setup fails")
> > > > which indicates it's a cherry-pick, but I couldn't find the equivalent
> > > > commit landing at any point later on.
> > > 
> > > This one was a maintainer action by Dave and me, where we went in and
> > > rebased an entire -next tree. Also from 2021, even more exceptional than
> > > the "committer cherry-picked themselves and screwed up".
> > > 
> > > I'm not saying that the cherry-pick model with committers is error free.
> > > Not at all. It's just in my experience substantially less error prone than
> > > anything else, it's simply the less shit option.
> > > 
> > > Roughly the options are:
> > > 
> > > - rebase trees to not have duplicated commits. Breaks the committer model,
> > >   pretty much guarantees that you have commit references to absolutely
> > >   nowhere at all in practice because people butcher rebases all the time.
> > >   Also pisses off Linus with unecessary rebases that don't reflect actual
> > >   development history.
> > > 
> > >   Plus we'd insta run out of maintainers in drm if we do this.
> > 
> > Bit more here, because this isn't hyperbole. drm isn't magic, we don't
> > have more maintainer volunteers than any other subsystem. And if we'd run
> > the show the same way as most others, we'd suffer like everyone else from
> > overloaded and burnt out maintainers.
> > 
> > We fixed the "not enough maintainer volunteers" problem by radically
> > changing the workflow, and radically reducing the amount of work
> > maintainers have to do. But that has consequences, and that's why we
> > cherry-pick so much.
> > 
> > If you center your flow around committers, then you also need to accept
> > that for a committer the most important tree is their driver/subsystem
> > tree, and everything else is downstream. And they don't care about
> > downstream at that much. Exactly like how maintainers don't care that much
> > about stable trees as their downstream, and you're trying to make it as
> > easy as possible for them.
> > 
> > Roughly translating things:
> > 
> > - For you, stable is the downstream that cherry-picks from the main
> >   development branch. For drm committers, drm-fixes is their downstream
> >   that cherry-picks from the development tree (and everything else is even
> >   further downstream).
> > 
> > - For you Linus' git tree is the development branch you cherry-pick from.
> >   For drm committers the drm-foo-next branch is their development branch
> >   that we cherry-pick from.
> > 
> > - You asking us to not cherry-pick but instead do the classic maintainer
> >   approach of filtering out fixes into foo-fixes branches is the same as
> >   if you'd ask maintainers to send bugfixes for stable to you directly,
> >   rebase them out of their pr to Linus and then backmerge. This is total
> >   bullocks, because stable isn't the development branch.
> 
> No, I can live with you all cherry-picking as that seems to make your
> life easier, what I am complaining about is when that cherry-picking
> causes massive confusion as the Fixes: and Revert ids end up showing
> going "back in time" and pointing to the wrong commit.
> 
> And note, the commit that caused this recent thread DID actually confuse
> your own developers, and they used the wrong git id as well, so it's not
> like your own developers don't get confused either.
> 
> It's your tree, you all run it like you want to, I'm just pointing out
> that the current way you all are running it IS causing problems for
> those of us who have to deal with the result of it.

So my understanding is that you got confused by this:

> commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream

$ git log --grep="(cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)" --since="6 month ago"   --pretty=oneline
f0ed39830e6064d62f9c5393505677a26569bb56

And yes f0ed39830e6064d62f9c5393505677a26569bb56 is the commit you care
about for stable backport and cve tracking purposes, because it's the one
in v6.13-rc6.

And the thing is, Sasha's bot found that one too:

https://lore.kernel.org/all/20250110164811-61a12d6905bb8676@stable.kernel.org/

Except Sasha's bot plays guessing games, the above git log query is exact.

Like I tried to explain in my reply to Sasha somewhere else in this thread
it really only takes two things:
- drm maintainers consistently add cherry picked from lines anytime we
  cherry-pick
- you adjust your script to go hunt for the cherry pick alias if you get a
  sha1 that makes no sense, so that you can put in the right sha1. And if
  you do that for any sha1 you find (whether upstream references, Fixes:
  or Reverts or stable candidate commits or whatever really), it will sort
  out all the things we've been shouting about for years now.
  Automatically, without human intervention, because it's just a git
  oneliner.

Of course people will still screw up, and Sasha found two examples from
2021 for that. And assuming you do add the above fallback to find the
"right" sha1 to your scripts I'll happily promise that Dave&me will make
damn sure it gets correctly added everywhere. We _want_ to scripts this
all as much as possible too, and not cause you endless amounts of
exceptions.

And we've been adding these cherry-picked lines intentionally from the
start of the committer model exactly because we wanted to make sure you
can handle the fallout with just scripts.

Note that most (maybe all?) the amd examples are because Alex has been
trying to do what you're asking for here, and in theory that works, but in
practice it's just so much worse.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

