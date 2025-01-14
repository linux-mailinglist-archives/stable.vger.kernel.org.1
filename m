Return-Path: <stable+bounces-108612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBCEA10B81
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3141886B1A
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0001215746B;
	Tue, 14 Jan 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhNz+Ycq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02C2157466
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869916; cv=none; b=N4fSQ3olwCje4T/wNfGUFP21JfSRFL6Dt2RPrjA9PRn4u9OqVeoJG27chexoH/O5G/vfpXEVmnZ4c7EEkx0txxXTOmIr+lLo9Mw+j6D5OyJ3lQLmZtThkhxZr4T/LN5Dyf6ChDOX4ol5PGyv+24lfV27wccWKQdW6ydn8CjLA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869916; c=relaxed/simple;
	bh=wsYeo3rGEgavhETw6bcQwamxaY/nTvwCmCnDsRChyCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkcvljXpfgkIeFzBD6VJRN+vJQ3YGdVWjNZxiZ+HnLZHnBtFLAEOUidFixZPOmbUCGDEeDZOLpPh0Xl+EQYHpDPMGolrwORdDyLcqbd6fSV03vc3XUPpD7eUelW/H9nLpHhqP21Q6MJV4kHhEBmRYmEZtH34hlhYsjB3d9oXtRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhNz+Ycq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAC4C4CEDD;
	Tue, 14 Jan 2025 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736869916;
	bh=wsYeo3rGEgavhETw6bcQwamxaY/nTvwCmCnDsRChyCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhNz+Ycqfz6lQITP90rySki4j+FtwC2eQd6gGzwYk9sbfEqdPWwqVEnBHBgnq8asK
	 xU/cn/4b/C6D98sL6m1ZC06Vqzq49NsKXTgHWX8uIPIQYRwYMSyIHT4nDTATUCERII
	 gXGoQp3a6nU03TFuUAT0pbTwcyqyMklvooKJbtKij+0GUTMPe7Bvu3piSHHV1Zr+Lw
	 YGQQZ7C8KX0VMzzwzLM9kHIr9azGiuMMX81Hn9zjYUbu20BHUilkpP4BNTqYIQwjMW
	 iycENT2JUO6kOTtnGDkWMZijC6rQL4R0ueQrvW312/vQctCs+w/ym7gNtuo3qWnGdm
	 rwz4uZYdqBbBA==
Date: Tue, 14 Jan 2025 10:51:54 -0500
From: Sasha Levin <sashal@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	stable@vger.kernel.org, ashutosh.dixit@intel.com,
	dri-devel@lists.freedesktop.org
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
Message-ID: <Z4aIGvAmMld_uztJ@lappy>
References: <2025010650-tuesday-motivate-5cbb@gregkh>
 <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh>
 <CAPM=9txn1x5A7xt+9YQ+nvLaQ3ycekC1Oj4J2PUpWCJwyQEL9w@mail.gmail.com>
 <CAPM=9twogjmTCc=UHBYkPPkrdHfm0PJ9VDoOg+X2jWZbdjVBww@mail.gmail.com>
 <2025011247-spoilage-hamster-28b2@gregkh>
 <CAPM=9tx1cFzhaZNz=gQOmP9Q0KEK5fMKZYSc-P0xA_f2sxoZ9w@mail.gmail.com>
 <2025011352-fox-wrangle-4d3f@gregkh>
 <CAPM=9tzkJ=dn2gq7GcvtN_C95ZzxwC7XMMXHBrwF6Ez6fYfU=g@mail.gmail.com>
 <Z4Z8rQKR2QEaWNyI@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z4Z8rQKR2QEaWNyI@phenom.ffwll.local>

On Tue, Jan 14, 2025 at 04:03:09PM +0100, Simona Vetter wrote:
>On Tue, Jan 14, 2025 at 11:01:34AM +1000, Dave Airlie wrote:
>> > > > We create a "web" when we backport commits, and mark things for "Fixes:"
>> > > > When we get those ids wrong because you all have duplicate commits for
>> > > > the same thing, everything breaks.
>> > > >
>> > > > > I just don't get what the ABI the tools expect is, and why everyone is
>> > > > > writing bespoke tools and getting it wrong, then blaming us for not
>> > > > > conforming. Fix the tools or write new ones when you realise the
>> > > > > situation is more complex than your initial ideas.
>> > > >
>> > > > All I want to see and care about is:
>> > > >
>> > > >  - for a stable commit, the id that the commit is in Linus's tree.
>> > > >  - for a Fixes: tag, the id that matches the commit in Linus's tree AND
>> > > >    the commit that got backported to stable trees.
>> > > >
>> > > > That's it, that's the whole "ABI".  The issue is that you all, for any
>> > > > number of commits, have 2 unique ids for any single commit and how are
>> > > > we supposed to figure that mess out...
>> > >
>> > > Pretty sure we've explained how a few times now, not sure we can do much more.
>> >
>> > And the same for me.
>> >
>> > > If you see a commit with a cherry-pick link in it and don't have any
>> > > sight on that commit in Linus's tree, ignore the cherry-pick link in
>> > > it, assume it's a future placeholder for that commit id. You could if
>> > > you wanted to store that info somewhere, but there shouldn't be a
>> > > need.
>> >
>> > Ok, this is "fine", I can live with it.  BUT that's not the real issue
>> > (and your own developers get confused by this, again, look at the
>> > original email that started this all, they used an invalid git id to
>> > send to us thinking that was the correct id to use.)
>>
>> I'm going to go back and look at the one you pointed out as I'm
>> missing the issue with it, I thought it was due to a future ID being
>> used.
>
>I think the issue is that with the cherry-picking we do, we don't update
>the Fixes: or Reverts: lines, so those still point at the og commit in
>-next, while the cherry-picked commit is in -fixes.
>
>The fix for that (which our own cherry-pick scripts implement iirc) is to
>keep track of the cherry-picks (which is why we add that line) and treat
>them as aliases.
>
>So if you have a Fixes: $sha1 pointing at -next, then if you do a
>full-text commit message search for (cherry picked from $sha1), you should
>be able to find it.
>
>We could try to do that lookup with the cherry-pick scripts, but a lot of
>folks hand-roll these, so it's lossy at best. Plus you already have to
>keep track of aliases anyway since you're cherry-picking to stable, so I
>was assuming that this shouldn't cause additional issues.
>
>The other part is that if you already have a cherry picked from $sha1 in
>your history, even if it wasn't done with stable cherry-pick, then you
>don't have to cherry-pick again. These should be easy to filter out.
>
>But maybe I'm also not understanding what the issue is, I guess would need
>to look at a specific example.
>
>> > > When future tools are analysing things, they will see the patch from
>> > > the merge window, the cherry-picked patches in the fixes tree, and
>> > > stable will reference the fixes, and the fixes patch will reference
>> > > the merge window one?
>> >
>> >
>> > > but I think when we cherry-pick patches from -next that fix
>> > > other patches from -next maybe the fixes lines should be reworked to
>> > > reference the previous Linus tree timeline not the future one. not
>> > > 100% sure this happens? Sima might know more.
>> >
>> > Please fix this up, if you all can.  That is the issue here.  And again,
>> > same for reverts.
>> >
>> > I think between the two, this is causing many fixes and reverts to go
>> > unresolved in the stable trees.
>> >
>> > > Now previously I think we'd be requested to remove the cherry-picks
>> > > from the -fixes commits as they were referencing things not in Linus'
>> > > tree, we said it was a bad idea, I think we did it anyways, we got
>> > > shouted at, we put it back, we get shouted that we are referencing
>> > > commits that aren't in Linus tree. Either the link is useful
>> > > information and we just assume cherry-picks of something we can't see
>> > > are a future placeholder and ignore it until it shows up in our
>> > > timeline.
>> >
>> > I still think it's lunacy to have a "cherry pick" commit refer to a
>> > commit that is NOT IN THE TREE YET and shows up in history as "IN THE
>> > FUTURE".  But hey, that's just me.
>> >
>> > Why do you have these markings at all?  Who are they helping?  Me?
>> > Someone else?
>>
>> They are for helping you. Again if the commit that goes into -next is immutable,
>> there is no way for it to reference the commit that goes into -fixes
>> ahead of it.
>>
>> The commit in -fixes needs to add the link to the future commit in
>> -next, that link is the cherry-pick statement.
>>
>> When you get the future commit into the stable queue, you look for the
>> commit id in stable history as a cherry-pick and drop it if it's
>> already there.
>>
>> I can't see any other way to do this, the future commit id is a
>> placeholder in Linus/stable tree, the commit is immutable and 99.99%
>> of the time it will arrive at some future point in time.
>>
>> I'm open to how you would make this work that isn't lunacy, but I
>> can't really see a way since git commits are immutable.
>
>Yeah the (cherry picked from $sha1) with a sha1 that's in -next and almost
>always shows up in Linus' tree in the future shouldn't be an issue. That
>part really is required for driver teams to manage their flows.
>
>> > > I think we could ask to not merge things into -next with stable cc'ed
>> > > but I think that will result in a loss of valuable fixes esp for
>> > > backporters.
>> >
>> > Again, it's the Fixes and Reverts id referencing that is all messed up
>> > here.  That needs to be resolved.  If it takes you all the effort to
>> > make up a special "stable tree only" branch/series/whatever, I'm all for
>> > it, but as it is now, what you all are doing is NOT working for me at
>> > all.
>>
>> I'll have to see if anyone is willing to consider pulling this sort of
>> feat off, it's not a small task, and it would have to be 99% automated
>> I think to be not too burdensome.
>
>It's not that hard to script, dim cherry-pick already does it. It's the
>part where we need to guarantee that we never ever let one slip through
>didn't get this treatment of replacing the sha1.
>
>The even more insideous one is when people rebase their -next or -fixes
>trees, since then the sha1 will really never ever show up. Which is why
>we're telling people to not mess with git history at all and instead
>cherry-pick. It's the lesser pain.

But this does happen with cherry picks... A few examples from what I saw
with drivers/gpu/drm/ and -stable:

5a507b7d2be1 ("drm/mst: Fix NULL pointer dereference at
drm_dp_add_payload_part2") which landed as 8a0a7b98d4b6 ("drm/mst: Fix
NULL pointer dereference at drm_dp_add_payload_part2") rather than
4545614c1d8da.

e89afb51f97a ("drm/vmwgfx: Fix a 64bit regression on svga3") which
landed as c2aaa37dc18f ("drm/vmwgfx: Fix a 64bit regression on svga3")
rather than 873601687598.

a829f033e966 ("drm/i915: Wedge the GPU if command parser setup fails")
which indicates it's a cherry-pick, but I couldn't find the equivalent
commit landing at any point later on.


Or the following 3 commits:

0811b9e4530d ("drm/amd/display: Add HUBP surface flip interrupt
handler") which has a stable tag, and no cherry-pick line.

4ded1ec8d1b3 ("drm/amd/display: Add HUBP surface flip interrupt
handler") which is a different code change than the previous commit, and
a completely different commit message, no stable tag, and no cherry-pick
line.

7af87fc1ba13 ("drm/amd/display: Add HUBP surface flip interrupt
handler") which has the same code change as above, and it has the same
commit message as 4ded1ec8d1b3 but with an added stable tag, and again -
no cherry-pick line.

-- 
Thanks,
Sasha

