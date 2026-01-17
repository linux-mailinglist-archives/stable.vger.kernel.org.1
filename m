Return-Path: <stable+bounces-210180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EBDD39073
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 20:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0934630194F8
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0E527E7F0;
	Sat, 17 Jan 2026 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UZUj950c"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA13500941
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768676852; cv=none; b=ptPEiBFD2yv3QXo5d1aZTkkkgTReljDFP20ODIyJcVrnMv9hPXy4Xgja0ee6VPOLLiA2UMLML3gjhNwxgASaLimTS1PcW3KXiWWn5VQz0e0Rm3rfYfKKbSjuDTjR03gWNn4K3qrSNcrpBaJGRsjuJLonfGP+LiePfrLab9u4oVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768676852; c=relaxed/simple;
	bh=fOr6S+Nr0FL5LzD5dnr5L5yvFlFWMJGeFVhrGfyYSfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKz0M8pQXhNTyzQ+MR3wz+EpU+Xk5nAuRJO5qBQwP8XrYfuD76A/WnghfoWmb1wtV4WsSV5oBAE8qeeQUhIfy0M+8ZrOyZnizUVZWF7Au93uydFLGzMAVpHhBVOh3Q1ys/TO9PQq4/E4ZyV95l0k4IekhvA67EAZeX7A+wm+SE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UZUj950c; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Jan 2026 11:07:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768676847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M9AsgKoyuk5x5jqoqUUIpz4N+GGQWQ6kYKehHA6kLds=;
	b=UZUj950cYM2sG20WuMnfBLNltdFlln/CD5j6vZQXpuBTpi9FW+vhC6TBKMzhqgKjcqCBA5
	0mMrHzOBQ2mUM6b6fm6AfAuvFHFCipucaZOaq4cg3arU/XUoZutB9BGyaLCxJ0KCQq+SM5
	fCyds5QIg5zAVFS+AHxYdi7LaExhBW8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Davidlohr Bueso <dave@stgolabs.net>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Restore per-memcg proactive reclaim with !CONFIG_NUMA
Message-ID: <nqhi5o3viu4dv7wgjklmh6ssvpimjuecnmsf4hhjxvr3u23epg@iaau6lairrkb>
References: <20260116205247.928004-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116205247.928004-1-yosry.ahmed@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 08:52:47PM +0000, Yosry Ahmed wrote:
> Commit 2b7226af730c ("mm/memcg: make memory.reclaim interface generic")
> moved proactive reclaim logic from memory.reclaim handler to a generic
> user_proactive_reclaim() helper to be used for per-node proactive
> reclaim.
> 
> However, user_proactive_reclaim() was only defined under CONFIG_NUMA,
> with a stub always returning 0 otherwise. This broke memory.reclaim on
> !CONFIG_NUMA configs, causing it to report success without actually
> attempting reclaim.
> 
> Move the definition of user_proactive_reclaim() outside CONFIG_NUMA, and
> instead define a stub for __node_reclaim() in the !CONFIG_NUMA case.
> __node_reclaim() is only called from user_proactive_reclaim() when a
> write is made to sys/devices/system/node/nodeX/reclaim, which is only
> defined with CONFIG_NUMA.
> 
> Fixes: 2b7226af730c ("mm/memcg: make memory.reclaim interface generic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

