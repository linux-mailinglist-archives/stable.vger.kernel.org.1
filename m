Return-Path: <stable+bounces-179102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47530B500F1
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070FD5E189D
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BD2F0689;
	Tue,  9 Sep 2025 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K3+M3w31"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741423E356
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431339; cv=none; b=A+/4ti7sJJagUDnlVLg1NW8syZWQKixGOpwSwsAUtKleCA28PzRLRNkNsDVyNdTSVQMv2+TAYLm8elA2rNgcLIr1vmMl04eo0g9u1NGKrxFuGCXMnlbQBL6QsYWhzhr7K1KRBtPL04wYpWCxIbPULK0rNWzVcy+Jf4+aFNHJP/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431339; c=relaxed/simple;
	bh=AJ9KdYBJk2J+jdn0ZeuNXmEuMqygFDXmhbgIO8U3mFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNy3NuKzpUIbkNZXnJdIGe8P25i8osIhVhrK7X3/4ByFl9Y8379Jb1Xirvd3uAsgawCu/EwMbcXmuPcTurh2GDYeUQL/pUznmPqcL20DHUDE4C8/oo7g5MHkN47PBeRxN2jJIuLr9vHGeKRjC+H2qu0HHU5ZJT79C4Isj/eDRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K3+M3w31; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2bJb9r9WRkh2TAMgOyJeg6yuzlP1Z0g5WcvmBSdw5jw=; b=K3+M3w31oZcBuYI9a7tM1Wo4ID
	BPiBqB+/2QDy58bY7Sc9535axphYxgvKiFquwU0TlajgwlRtUwRspA0xVmD9BAHJLz/l+jeRZjyjR
	Unw1uOLgfY+EjPa0Itj9WptPWEi19neifkYJniy3Wf2hlEbdwOSuG2acrNEVToC0OeJ1sZs5T1nnK
	gXGBKfpb0jyqvC2yHxEbiNlRGTIi8PdJLlcATpL1HoYOoKskBQ4MjK5mFv/WtG5JC72p01/TzMbra
	BkITS1U0QdkexZxcKSJB91r2uD2hrSHqab+CbXgy+JPrmtyOmqb15KRnsWDBSvIaUTLwYUljo7s4o
	cH/Dx2Kw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw0Aa-00000005OZD-2Xxf;
	Tue, 09 Sep 2025 15:22:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D7323002EB; Tue, 09 Sep 2025 16:05:19 +0200 (CEST)
Date: Tue, 9 Sep 2025 16:05:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	matthew.auld@intel.com, jani.nikula@linux.intel.com,
	samuel.pitoiset@gmail.com, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, alexander.deucher@amd.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] drm/buddy: Optimize free block management with RB
 tree
Message-ID: <20250909140519.GK4067720@noisy.programming.kicks-ass.net>
References: <20250909095621.489833-1-Arunpravin.PaneerSelvam@amd.com>
 <6f6841a7-57bd-49de-9b55-b5b0514a2749@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f6841a7-57bd-49de-9b55-b5b0514a2749@amd.com>

On Tue, Sep 09, 2025 at 02:04:30PM +0200, Christian König wrote:
> Hi Arun,
> 
> On 09.09.25 11:56, Arunpravin Paneer Selvam wrote:
> [SNIP]
> 
> > +/**
> > + * rbtree_for_each_entry_safe - iterate in-order over rb_root safe against removal
> > + *
> > + * @pos:	the 'type *' to use as a loop cursor
> > + * @n:		another 'type *' to use as temporary storage
> > + * @root:	'rb_root *' of the rbtree
> > + * @member:	the name of the rb_node field within 'type'
> > + */
> > +#define rbtree_for_each_entry_safe(pos, n, root, member) \
> > +	for ((pos) = rb_entry_safe(rb_first(root), typeof(*(pos)), member), \
> > +	     (n) = (pos) ? rb_entry_safe(rb_next(&(pos)->member), typeof(*(pos)), member) : NULL; \
> > +	     (pos); \
> > +	     (pos) = (n), \
> > +	     (n) = (pos) ? rb_entry_safe(rb_next(&(pos)->member), typeof(*(pos)), member) : NULL)
> 
> As far as I know exactly that operation does not work on an R/B tree.
> 
> See the _safe() variants of the for_each_ macros are usually used to iterate over a container while being able to remove entries.
> 
> But because of the potential re-balance storing just the next entry is not sufficient for an R/B tree to do that as far as I know.
> 
> Please explain how exactly you want to use this macro.

So I don't much like these iterators; I've said so before. Either we
should introduce a properly threaded rb-tree (where the NULL child
pointers encode a linked list), or simply keep a list_head next to the
rb_node and use that.

The rb_{next,prev}() things are O(ln n), in the worst case they do a
full traversal up the tree and a full traversal down the other branch.

That said; given 'next' will remain an existing node, only the 'pos'
node gets removed, rb_next() will still work correctly, even in the face
of rebalance.



