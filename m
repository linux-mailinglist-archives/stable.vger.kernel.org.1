Return-Path: <stable+bounces-108618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CF5A10C06
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 17:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87571888DD9
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844091D3576;
	Tue, 14 Jan 2025 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="elOp0gmr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B61C5F31
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871369; cv=none; b=so7uG2SHgl3RDkUhqoUasrUFfgOY6vHrYg1ZIxZEZVjqq4LRVMj5sb72V0GDl+S4dXvEMezQvyqUcDxdTsPvx2WwJ5wDHMb6BrQ5SGnMD6Jm9VEV65mGrb7aY0Dk6GHZqVzm3hxvGPc+ZP42baL+i5zfKoZIPOPkNcPGlXNMOHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871369; c=relaxed/simple;
	bh=plNo3tKyS9lk3uMTbxdS+dYqP0/YCB1KP71YwEiI/uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6bfmpHvO/Jik7U0jXudb5DHsc65l4aSnhDaLpS8TVEwwaDGfy7j9VPZ/2bFRe9e8VyVvEVkpYln03BqGh2130fKg1FuJzR0hSfBw+aEPp4MQSSHaZWhZUHmxetJ1NUGsOl0hMKbhxBovD6awYS11T8uJLaYL6MMIjHlCqZY0ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=elOp0gmr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1116199466b.1
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1736871363; x=1737476163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy75zv0jPNz/NadWI9ulEIuyrYJnMlPP/tt3Y0Pl4XQ=;
        b=elOp0gmr1LWwKvUI5D0UGhkaLf3eujRNrxtZbnJKywv2KjXhXadFy2xzk5/WrnwRVr
         ioLSfrKv4L052686zZrBCXUTOBRZs5v0Es1Bw6hYsqcNoCp9iYftL9BzuFeN1wyEZ7Dm
         HhACQUVRvD+bS5Jj/xjvfITPWfvQnYCJSiNJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736871363; x=1737476163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hy75zv0jPNz/NadWI9ulEIuyrYJnMlPP/tt3Y0Pl4XQ=;
        b=XNugePQ5WPHCakkDbqzhaEUHzxrcWOoz7y0xOxkgMeS/Pa9IYud4Vr9kCCxoOuEJne
         2pdqRKygiiGSPdyCRySswQjvCzB6AGWOxZaaQGGRcXimbSnMDnwCo8R3E2NfbszjYDTh
         VFysTIjin4vg6aazz/ike4vtuPI5ry8vCgEqBakZvKc8FUIYXA9FWVzzYe2JRHENUhU3
         5O50Pk8pLiQ8mEexSjBTa7ZgpmPox4gP6iZYRE5latvx93LrV9mxTsuxs1U/fpT5/lnN
         JrtF/jEZeSi8dVupMhXhlEqVT4MOGn8WOyFq4ZqDtu1Bu8GS6BG2d3IUM6oojkSSwEmH
         P0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzVOhmBTvzMf22yAJtejxbJuDz10FBSqxPGPwTLs5ubc3N9G6pDNB5jmsa3JVqx+fWA7XuELE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOF+EkLVoFOqLmz7eo/5Tv06Qzi1BYkK8zHicdE59cCPRwIrPq
	egDAsK4ko0YCw601RAwbW4VYwbSLXPOB4X+Ac/PdvkXo/7KlLbGEaF081XyShO4=
X-Gm-Gg: ASbGnct8ECZrPgcTn/twDnvxm7aI5f5kcSV/gDqDutlBwfwX047EfPzaKyoTxkS0zN1
	dxUyo5dHmGcEuPoVD5K9t9F6glIYi/iHa4mAoE6TUFzNPZqKElvJl7GSds87tacKSUqUCED008/
	gWFP55MoDFce3gwm1bsjfhxvg5zjdQMExj0zPAzrftiGn98NI8fkbn0WyUYR3W73KwjstIaodQQ
	7KcwL8qt7pdYDoUGnVKi6j3l3xXjzgW1FgtEYbIkqawhjk7j1F8kSXoeH3YfY161qIz
X-Google-Smtp-Source: AGHT+IEa8aQlIaJMwuoQ73JQ3b72nneYqB3RAVByBgtJRXcY8/paCVUpEXat3jH0K1HK9c0pr/tM+g==
X-Received: by 2002:a17:906:2617:b0:ab3:30b5:fa62 with SMTP id a640c23a62f3a-ab330b5faf1mr416873966b.24.1736871363033;
        Tue, 14 Jan 2025 08:16:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90dc101sm655539766b.56.2025.01.14.08.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:16:02 -0800 (PST)
Date: Tue, 14 Jan 2025 17:16:00 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Sasha Levin <sashal@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	stable@vger.kernel.org, ashutosh.dixit@intel.com,
	dri-devel@lists.freedesktop.org
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
Message-ID: <Z4aNwGys3epVzf7G@phenom.ffwll.local>
References: <2025010650-tuesday-motivate-5cbb@gregkh>
 <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh>
 <CAPM=9txn1x5A7xt+9YQ+nvLaQ3ycekC1Oj4J2PUpWCJwyQEL9w@mail.gmail.com>
 <CAPM=9twogjmTCc=UHBYkPPkrdHfm0PJ9VDoOg+X2jWZbdjVBww@mail.gmail.com>
 <2025011247-spoilage-hamster-28b2@gregkh>
 <CAPM=9tx1cFzhaZNz=gQOmP9Q0KEK5fMKZYSc-P0xA_f2sxoZ9w@mail.gmail.com>
 <Z4WKIbVzo8d-nln3@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4WKIbVzo8d-nln3@lappy>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Mon, Jan 13, 2025 at 04:48:17PM -0500, Sasha Levin wrote:
> On Mon, Jan 13, 2025 at 10:44:41AM +1000, Dave Airlie wrote:
> > Pretty sure we've explained how a few times now, not sure we can do much more.
> > 
> > If you see a commit with a cherry-pick link in it and don't have any
> > sight on that commit in Linus's tree, ignore the cherry-pick link in
> > it, assume it's a future placeholder for that commit id. You could if
> > you wanted to store that info somewhere, but there shouldn't be a
> > need.
> > 
> > When the initial commit enters during the next merge window, you look
> > for that subject or commit id in the stable tree already, if it
> > exists, dump the latest Linus patch on the floor, it's already in
> > stable your job is done.
> 
> We can't rely too heavily on the subject line. Consider the following two
> very different commits that have the same subject line:
> 
> 	3119668c0e0a ("drm/amd/display: avoid disable otg when dig was disabled")
> 	218784049f4b ("drm/amd/display: avoid disable otg when dig was disabled")
> 
> Now, if a new commit lands and it has the following "Fixes:" tag:
> 
> 	Fixes: abcdef12345 ("drm/amd/display: avoid disable otg when dig was disabled")

This is why we're asking people to include the cherry-picked from line, so
you're scripts can handle this automatically.

Because then you get two cherry-picked from lines in your stable commits:
- one from the drm cherry-pick
- one from the stable cherry-pick

And instead of only checking the stable cherry-pick line you just check
both if you want an answer to the "do I have this one already?" question.
There's two cases:

- You have a backport candidate, but want to check if you have it already.
  When that happens with the 2nd commit your scripts will try to apply
  that patch (because it doesn't match the cherry-picked from you've added
  yourself), which will fail and result in an angry mail to dri-devel.

  But if you instead check against both your and the drm cherry-pick
  lines, you'd know that you have this patch already and can drop it
  automatically.

- You get a Fixes: line like above, and want to know whether you need that
  patch. You already have to consult all the stable cherry-pick lines to
  make sure (because stable doesn't have that sha1 if the broken commit
  was itself cherry-picked). If you instead check against both the drm and
  stable cherry-pick lines then the tooling will do the right job.

Which is why Dave&me want these cherry-pick lines, but Alex has removed
them again because of the last round of shouting about this. Because
without cherry-pick lines you're down to guessing by title, which goes
wrong.

So the only thing that's needed in the tooling is that instead of only
looking at your own cherry-pick lines in stable commits to figure out
whether you need a backport or have it already, or whether you need that
bugfix or don't have the broken commit, is to look at all cherry-pick
lines. And ask Alex to again add them.

> Does it refer to one of the older commits? Or a new commit that will
> show up during the merge window?
> 
> Or... What happens if a new commit with the very same subject line shows
> up, and it has a cherry-pick link that points to a completely different
> commit that is not in the tree yet? :)
> 
> But just in general, there are so many odd combinations of commits where
> trying to follow the suggestion you've made will just break...
> 
> Something like these two identical commits which are not tagged for stable:
> 
> 	21afc872fbc2 ("drm/amd/display: Add monitor patch for specific eDP")
> 	3d71a8726e05 ("drm/amd/display: Add monitor patch for specific eDP")
 
Yeah sometimes people forget to add cc: stable. It happens. I don't think
anything else is going on here.

> And the following two identical ones which are tagged for stable:
> 
> 	b7cdccc6a849 ("drm/amd/display: Add monitor patch for specific eDP")
> 	04a59c547575 ("drm/amd/display: Add monitor patch for specific eDP")

Yeah this is just standard bugfix cherry-picking, except because you
shouted about the cherry-pick lines last time around they're now gone, so
you have no idea what's going on here.

Imo we should add the cherry-pick lines back and then this would be all
clear.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

