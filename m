Return-Path: <stable+bounces-136787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D48AA9E38A
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB0F3AAA2E
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCF31D86F2;
	Sun, 27 Apr 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fpt6oovH"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D011CAA85
	for <stable@vger.kernel.org>; Sun, 27 Apr 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745763938; cv=none; b=QRmXr8wz/ltkYeunGk1/9+0SbHmQPcIbmITr9QdcgBs+MfNyoBcFMPxx6Uiw6r/7UYVyfttqCl2AbC5GKwJ74wuDqMUz3NYzzImzYXyEvSAlh9y1enFAAUVEJhczytYv8QivOAhW3D5FMkl74uwYImGp+AqZ5rUsfwLpXJ22Yyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745763938; c=relaxed/simple;
	bh=1w2H2C99iP+VWYBXrmGdZQ9ALrTsVwpsWtw8L8F/la8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvFyQF07X/IrdQzlDTPQ+WeDe87bV96styyA4fh+NUI24NHp4KDaE0V7z7BozKulYS/ownzo38OA4k+ynPTPjNOxB1Hm/o3cs2s+L3zZn/9frhrdWYIicQc+vbTGQliUPOuLg0m9D/dCtPfLkjOipqMs70aylQyLby5/Rh5Hm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fpt6oovH; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 27 Apr 2025 10:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745763931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyLlP6GUrckZb1AH9cVw05rtmrOhGgAntLb6HhdZFFw=;
	b=fpt6oovH+5bBiwYASqXcBztqfHKx98i3/nV+T5KCcCp+3xK/guVoOHTOtoTlkzD8o69jFV
	W3suKuM2Jly95zflfzq2hcgAaJC6WFh0fWqVAdXyDDuzNIygRM5y+d7hF9XmDGyUSdoOOe
	TNoMjikFJPNatAUcqULPJzwUWdWv1DM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, Chandan Babu R <chandanbabu@kernel.org>, 
	Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, Alexey Nepomnyashih <sdl@nppct.ru>, stable@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] xfs: fix diff_two_keys calculation for cnt btree
Message-ID: <kip7kv57wpvhft65vsbrddakjva66nyld7i2lrp6cnax4t6wbw@ywc6e6yvzqwl>
References: <20250426134232.128864-1-pchelkin@ispras.ru>
 <20250426150359.GQ25675@frogsfrogsfrogs>
 <vx6bowvzlqixc4ap7vvj4mwarsuqm7y65cejg6yoc5wgpeh4j6@74rej3wf6uqq>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vx6bowvzlqixc4ap7vvj4mwarsuqm7y65cejg6yoc5wgpeh4j6@74rej3wf6uqq>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 27, 2025 at 02:56:39PM +0300, Fedor Pchelkin wrote:
> Hi,
> 
> On Sat, 26. Apr 08:03, Darrick J. Wong wrote:
> > On Sat, Apr 26, 2025 at 04:42:31PM +0300, Fedor Pchelkin wrote:
> > > Currently the difference is computed on 32-bit unsigned values although
> > > eventually it is stored in a variable of int64_t type. This gives awkward
> > > results, e.g. when the diff _should_ be negative, it is represented as
> > > some large positive int64_t value.
> > > 
> > > Perform the calculations directly in int64_t as all other diff_two_keys
> > > routines actually do.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with Svace static
> > > analysis tool.
> > > 
> > > Fixes: 08438b1e386b ("xfs: plumb in needed functions for range querying of the freespace btrees")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > > ---
> > >  fs/xfs/libxfs/xfs_alloc_btree.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_alloc_btree.c b/fs/xfs/libxfs/xfs_alloc_btree.c
> > > index a4ac37ba5d51..b3c54ae90e25 100644
> > > --- a/fs/xfs/libxfs/xfs_alloc_btree.c
> > > +++ b/fs/xfs/libxfs/xfs_alloc_btree.c
> > > @@ -238,13 +238,13 @@ xfs_cntbt_diff_two_keys(
> > >  	ASSERT(!mask || (mask->alloc.ar_blockcount &&
> > >  			 mask->alloc.ar_startblock));
> > >  
> > > -	diff =  be32_to_cpu(k1->alloc.ar_blockcount) -
> > > -		be32_to_cpu(k2->alloc.ar_blockcount);
> > > +	diff = (int64_t)be32_to_cpu(k1->alloc.ar_blockcount) -
> > > +			be32_to_cpu(k2->alloc.ar_blockcount);
> > 
> > Perhaps it's time to hoist cmp_int to include/ and refactor all these
> > things to use it?
> > 
> > #define cmp_int(l, r)          ((l > r) - (l < r))
> > 
> > --D
> > 
> 
> Thanks, that would be worth it, I think. Though the current xfs
> ***diff_two_keys() implementations try to compute and return the actual
> difference between two values, not the result of their comparison. Now
> looking at diff_two_keys() use cases, I see only the latter one is needed
> anyway so a good bit to refactor.
> 
> 
> The thing I'm pondering over now is whether the macro in its current
> form is okay to move up to include/. There is no argument restrictions and
> typechecking intended to catch up obviously misleading usage patterns
> though we'd need some if this is hoisted to a generic header and exported
> for potential use by others?
> 
> There are four places where cmp_int is defined at the moment:
> - bcachefs
> - md/bcache
> - xfs_zone_gc
> - pipe.c
> 
> bcachefs is the largest user having all kinds of different arguments
> providing to the macro, bitfields included. It also has several rather
> generic wrappers, like u64_cmp, unsigned_cmp, u8_cmp, cmp_le32 and
> others..
> 
> AF_UNIX code even has
> 
> 	#define cmp_ptr(l, r)	(((l) > (r)) - ((l) < (r)))
> 
> for pointer comparisons.
> 
> 
> So in my opinion we'd probably need to come up with something like a new
> include/linux/cmp.h header where all this stuff will be gathered in a
> generic way.
> 
> Any objections/suggestions on that? Or just moving
> 
> 	#define cmp_int(l, r)          ((l > r) - (l < r))

Ack. It avoids underflow issues when using a subtract and gcc generates
good code for it.

