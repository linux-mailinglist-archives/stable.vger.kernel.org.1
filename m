Return-Path: <stable+bounces-176901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D3B3EE8A
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 21:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665D34847E1
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685B324B1B;
	Mon,  1 Sep 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mIp5z6bC"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106126AA93;
	Mon,  1 Sep 2025 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755723; cv=none; b=Vjg087XK0CBElSM2CRRY1nzNveF6uwMvUNEfujR/uGdnkEYkWGo2LQnv1Q6djZz7FVaBGv4T6wEvoqixdP3sElhJdTDjcU+pLCX5bVtD5IRy3hzd2M9YA/PFaDoksc4QTIYdcBMZPRyDB5b89n5BB2lI9qVlv4hQzfegHyxIg8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755723; c=relaxed/simple;
	bh=keFYPcsoi58SdBX3NhlcJNv+qZnJirwK4c2TZ6485gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsC/tWACIoo2BZPFmTf/VSlVZI/Fdsl80OGK7o459C0y5huQ2o0CZUPfgCD4/JWuTLK1GEysdW6Er/egTXWZLYGXcfxEx6Hxd6flPMx9pVz861wFkpZo45tN4CuWEahLvcYYyLBMIFh2om9t65CJpG0ojUhw65s6sbUFDG1Iuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mIp5z6bC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OXmQwmuMTAG2HSIdNxmQ9RuY2Q8gE5vO81foFabz8EM=; b=mIp5z6bCmDN8CVf6e95RVanZY3
	3fs7ps5/6g3Kljt72q2L9SLWFPd6uRmqzLSHOVyBQ1XFJeFs7GhbDYSVgbEThdun76IK0wEGA6i1y
	PShFtPw+wCRuzBJKLhbeBjvgHpNEZX3wpKSyd5yrL6QPcJBD2grhKasAogHUNhEGnEvUtEZeIRGT5
	KPigGs+AQXMZS8CRletpvvIge7yfv16jUqGGGJnl8uUX0Knv50WdgYiVM8KBBpE+MvtwPYbwFMIko
	Az15hxI8cb2fpnL8NqUTh78c9T8HuQHBGSgKgAm5BgNk5+VEKgRCh2Q1LjteqHDVotxnchij1EUhK
	AYRGYM8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utAPZ-00000003qbD-0LLf;
	Mon, 01 Sep 2025 19:41:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EBAB0300342; Mon, 01 Sep 2025 21:41:51 +0200 (CEST)
Date: Mon, 1 Sep 2025 21:41:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: christian.koenig@amd.com, matthew.auld@intel.com,
	jani.nikula@linux.intel.com, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, alexander.deucher@amd.com
Subject: Re: [PATCH v5 1/2] drm/buddy: Optimize free block management with RB
 tree
Message-ID: <20250901194151.GJ4067720@noisy.programming.kicks-ass.net>
References: <20250901185604.2222-1-Arunpravin.PaneerSelvam@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901185604.2222-1-Arunpravin.PaneerSelvam@amd.com>

On Tue, Sep 02, 2025 at 12:26:04AM +0530, Arunpravin Paneer Selvam wrote:
> Replace the freelist (O(n)) used for free block management with a
> red-black tree, providing more efficient O(log n) search, insert,
> and delete operations. This improves scalability and performance
> when managing large numbers of free blocks per order (e.g., hundreds
> or thousands).

Did you consider the interval tree?


> @@ -41,23 +43,53 @@ static void drm_block_free(struct drm_buddy *mm,
>  	kmem_cache_free(slab_blocks, block);
>  }
>  
> -static void list_insert_sorted(struct drm_buddy *mm,
> -			       struct drm_buddy_block *block)
> +static void rbtree_insert(struct drm_buddy *mm,
> +			  struct drm_buddy_block *block)
>  {
> +	struct rb_root *root = &mm->free_tree[drm_buddy_block_order(block)];
> +	struct rb_node **link = &root->rb_node;
> +	struct rb_node *parent = NULL;
>  	struct drm_buddy_block *node;
> -	struct list_head *head;
> +	u64 offset;
> +
> +	offset = drm_buddy_block_offset(block);
>  
> -	head = &mm->free_list[drm_buddy_block_order(block)];
> -	if (list_empty(head)) {
> -		list_add(&block->link, head);
> -		return;
> +	while (*link) {
> +		parent = *link;
> +		node = rb_entry(parent, struct drm_buddy_block, rb);
> +
> +		if (offset < drm_buddy_block_offset(node))
> +			link = &parent->rb_left;
> +		else
> +			link = &parent->rb_right;
>  	}
>  
> -	list_for_each_entry(node, head, link)
> -		if (drm_buddy_block_offset(block) < drm_buddy_block_offset(node))
> -			break;
> +	rb_link_node(&block->rb, parent, link);
> +	rb_insert_color(&block->rb, root);
> +}

static inline bool __drm_bb_less(const struct drm_buddy_block *a,
				 const struct drm_buddy_block *b)
{
	return drm_buddy_block_offset(a) < drm_buddy_block_offset(b);
}

#define __node_2_drm_bb(node) rb_entry((node), struct drm_buddy_block, rb)

static inline bool rb_drm_bb_less(struct rb_node *a, const struct rb_node *b)
{
	return __drm_bb_less(__node_2_drm_bb(a), __node_2_drm_bb(b));
}

static void rbtree_insert(struct drm_buddy *mm, struct drm_buddy_block *block)
{
	rb_add(block->rb, &mm->free_tree[drm_buddy_block_order(block)], rb_drm_bb_less);
}

> +
> +static void rbtree_remove(struct drm_buddy *mm,
> +			  struct drm_buddy_block *block)
> +{
> +	struct rb_root *root;
> +
> +	root = &mm->free_tree[drm_buddy_block_order(block)];
> +	rb_erase(&block->rb, root);
>  
> -	__list_add(&block->link, node->link.prev, &node->link);
> +	RB_CLEAR_NODE(&block->rb);
> +}
> +
> +static inline struct drm_buddy_block *
> +rbtree_last_entry(struct drm_buddy *mm, unsigned int order)
> +{
> +	struct rb_node *node = rb_last(&mm->free_tree[order]);
> +
> +	return node ? rb_entry(node, struct drm_buddy_block, rb) : NULL;
> +}

rb_add_cached() caches the leftmost entry, if you invert the key, the
last is first.

> diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
> index 8d2ba3749866..17190bb4837c 100644
> --- a/include/linux/rbtree.h
> +++ b/include/linux/rbtree.h
> @@ -79,6 +79,62 @@ static inline void rb_link_node_rcu(struct rb_node *node, struct rb_node *parent
>  	   ____ptr ? rb_entry(____ptr, type, member) : NULL; \
>  	})
>  
> +/**
> + * rbtree_for_each_entry - iterate in-order over rb_root of given type
> + *
> + * @pos:	the 'type *' to use as a loop cursor.
> + * @root:	'rb_root *' of the rbtree.
> + * @member:	the name of the rb_node field within 'type'.
> + */
> +#define rbtree_for_each_entry(pos, root, member) \
> +	for ((pos) = rb_entry_safe(rb_first(root), typeof(*(pos)), member); \
> +	     (pos); \
> +	     (pos) = rb_entry_safe(rb_next(&(pos)->member), typeof(*(pos)), member))
> +
> +/**
> + * rbtree_reverse_for_each_entry - iterate in reverse in-order over rb_root
> + * of given type
> + *
> + * @pos:	the 'type *' to use as a loop cursor.
> + * @root:	'rb_root *' of the rbtree.
> + * @member:	the name of the rb_node field within 'type'.
> + */
> +#define rbtree_reverse_for_each_entry(pos, root, member) \
> +	for ((pos) = rb_entry_safe(rb_last(root), typeof(*(pos)), member); \
> +	     (pos); \
> +	     (pos) = rb_entry_safe(rb_prev(&(pos)->member), typeof(*(pos)), member))
> +
> +/**
> + * rbtree_for_each_entry_safe - iterate in-order over rb_root safe against removal
> + *
> + * @pos:	the 'type *' to use as a loop cursor
> + * @n:		another 'type *' to use as temporary storage
> + * @root:	'rb_root *' of the rbtree
> + * @member:	the name of the rb_node field within 'type'
> + */
> +#define rbtree_for_each_entry_safe(pos, n, root, member) \
> +	for ((pos) = rb_entry_safe(rb_first(root), typeof(*(pos)), member), \
> +	     (n) = (pos) ? rb_entry_safe(rb_next(&(pos)->member), typeof(*(pos)), member) : NULL; \
> +	     (pos); \
> +	     (pos) = (n), \
> +	     (n) = (pos) ? rb_entry_safe(rb_next(&(pos)->member), typeof(*(pos)), member) : NULL)
> +
> +/**
> + * rbtree_reverse_for_each_entry_safe - iterate in reverse in-order over rb_root
> + * safe against removal
> + *
> + * @pos:	the struct type * to use as a loop cursor.
> + * @n:		another struct type * to use as temporary storage.
> + * @root:	pointer to struct rb_root to iterate.
> + * @member:	name of the rb_node field within the struct.
> + */
> +#define rbtree_reverse_for_each_entry_safe(pos, n, root, member) \
> +	for ((pos) = rb_entry_safe(rb_last(root), typeof(*(pos)), member), \
> +	     (n) = (pos) ? rb_entry_safe(rb_prev(&(pos)->member), typeof(*(pos)), member) : NULL; \
> +	     (pos); \
> +	     (pos) = (n), \
> +	     (n) = (pos) ? rb_entry_safe(rb_prev(&(pos)->member), typeof(*(pos)), member) : NULL)
> +

Not really a fan of these. That's typically a sign you're doing it
wrong. Full tree iteration is actually slower than linked list.

