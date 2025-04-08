Return-Path: <stable+bounces-130262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2719A803CF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A14717EB17
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02251269825;
	Tue,  8 Apr 2025 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="oGONPp/8"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D327B268C66;
	Tue,  8 Apr 2025 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113251; cv=none; b=cBSjvWIGqLyB/89E0KnCHKiOhR/OyxMwF8dPuC0VpmwLEInZSN2orwZJJ1fuzPXkOcXicuhwb1hEtbu8mldZxqmFTpdGtVXBwGCFOppnXnQTnUvd4n/cCscxbGYZVdQbBSr9imh7A0yGcTFsSIHnPSKwCJREIBh6dxMqrWwcNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113251; c=relaxed/simple;
	bh=P2jVHsI758z+vJQpIEP8HSzeatK4ADklkGwcrproph8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2pgyVPsyYudW5y2mSUzeYfV9oZhvUNd5CU1ajTwfwgOa5bqPg5OjV5DpnlGCurtTNIqQFS4HPLbBLfhDv7c8RgmsYe7GKB0/P9EpRysyx+42cp2occC2aMURQyuuAougoWstg44jySj6eNwOngPgj4eh67+KFDdgHqrTQfFWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=oGONPp/8; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3A9CC4076734;
	Tue,  8 Apr 2025 11:54:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3A9CC4076734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1744113246;
	bh=JyOGjE69537m8nOjE67m2ByYfIQmzkI/JFTbD1K+dYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGONPp/8rBYLgZpjCCxI71Hxa5+EIg0PbpNidhNaN9i6pWi4IzMBeaAmQzy4H6SuZ
	 /7kQWZpbTLT5/2hB1THrBtWLXuIXAdbj1veFCmxsYfnhBy69akVkVFc8Sfb/gqeI3i
	 P6XkTPS1zzQXowNAmnbsXCKLTyp7HZ5jd+4aDgz4=
Date: Tue, 8 Apr 2025 14:54:06 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Denis Arefev <arefev@swemel.ru>, 
	Alex Deucher <alexander.deucher@amd.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrey Grodzovsky <andrey.grodzovsky@amd.com>, lvc-project@linuxtesting.org, 
	Chunming Zhou <david1.zhou@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, David Airlie <airlied@gmail.com>
Subject: Re: [lvc-project] [PATCH] drm/amdgpu: check a user-provided number
 of BOs in list
Message-ID: <qc72y52kt7vuwox4lhk42zligy5bslttselfoexse42mywtpps@ebqijs2tap2t>
References: <20250408091755.10074-1-arefev@swemel.ru>
 <e6ccef21-3ca5-4b5a-b18a-3ba45859569c@amd.com>
 <bmdour3gw4tuwqgvvw764p4ot3nnltqm4e7n3edlbtpfazvp5c@cqe5dwgc66uy>
 <f8810b13-01d1-4615-b6e2-2e791c48b466@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8810b13-01d1-4615-b6e2-2e791c48b466@amd.com>

On Tue, 08. Apr 13:37, Christian König wrote:
> Am 08.04.25 um 11:39 schrieb Fedor Pchelkin:
> > On Tue, 08. Apr 11:26, Christian König wrote:
> >> Am 08.04.25 um 11:17 schrieb Denis Arefev:
> >>> The user can set any value to the variable ‘bo_number’, via the ioctl
> >>> command DRM_IOCTL_AMDGPU_BO_LIST. This will affect the arithmetic
> >>> expression ‘in->bo_number * in->bo_info_size’, which is prone to
> >>> overflow. Add a valid value check.
> >> As far as I can see that is already checked by kvmalloc_array().
> >>
> >> So adding this additional check manually is completely superfluous.
> > Note that in->bo_number is of type 'u32' while kvmalloc_array() checks for
> > an overflow in 'size_t', usually 64-bit.
> >
> > So it looks possible to pass some large 32-bit number, then multiply it by
> > (comparatively small) in->bo_info_size and still remain in 64-bit bounds.
> >
> > And later that would likely result in a WARNING in
> >
> > void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
> > {
> > ...
> > 	/* Don't even allow crazy sizes */
> > 	if (unlikely(size > INT_MAX)) {
> > 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> > 		return NULL;
> > 	}
> >
> > But the commit description lacks such details, I admit.
> 
> Yeah, so what? I'm perfectly aware that this can result in a warning, but that is just not something worth fixing.

It's a warning directly trigerrable by userspace. It's not the purpose of
kernel warnings. The WARN checks inside the allocator imply that the
in-kernel caller should be aware of what sizes he requests.

If user can request an arbitrary size value then we should use __GFP_NOWARN
and back on the allocator to return NULL in case it doesn't even try to
satisfy an enormous memory allocation request (in which case it yells in
the log without __GFP_NOWARN being passed). Maybe that would be a more
appropriate thing here?

Please see:
https://lore.kernel.org/dm-devel/CAHk-=wi8Zer6tnqO-bz+WxFpMv9sPc-LxGRm_3poOtZegjhfrg@mail.gmail.com/

On Wed, 3 Jan 2024 at 11:21, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 3 Jan 2024 at 11:15, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > Should we use __GFP_NOWARN? (but this would shut up also genuine
> > warnings).
> 
> This can only be fixed in the *caller*, which need to either
> 
>  (a) have saen limit checking that checks for an obviously safe limit
> (please don't just make it INT_MAX to handle this one case - make it
> something *reasonable*)
> 
> _or_
> 
>  (b) the __GPF_NOWARN with a very obvious "I handle a failed return
> gracefully" handling all the way out to user space (error returns
> and/or things like "fall back to smaller sizes")./
> 
> because a caller that just passes in a random value to kmalloc()
> should continue to warn if that random value is unreasonable.
> 
> Exactly *because* we want all those crazy random tester robots to
> actually find cases where people just randomly take untrusted lengths
> from user space.

