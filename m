Return-Path: <stable+bounces-219676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPpYMhwvn2lXZQQAu9opvQ
	(envelope-from <stable+bounces-219676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:19:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4140119B6EC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADECB3096DB4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFC73D649D;
	Wed, 25 Feb 2026 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YX82Y4nb"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC63AEF54
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039901; cv=none; b=KrCJ7Ve1EVMkhXmeqjwaOrD4KqoFy/4QKq7aeySlYuj9c2FjbmvYGSraHILqHtG3G2aUE5yWg7/tQYyySrSpqENs3eI9yBTBdnfWRk3lgMS/iA9pPDo9jCAeHQUtN1bOanom+/lAi8NjcWLGGTklEtZ0a4aaJ/mfgob/iJCO9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039901; c=relaxed/simple;
	bh=p+q9PiS71rtVwHPbd9+Dvz8QAx7LxNBrgBG0KqSL+go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFn+dsXxyltvNfM3v+Fh5NrF5qaml2ZMDs6La+lbrvFGWbrR5UfVdIHsMxxzFK5MsDBcqSNCAyhxV5NBG8uo2++XgBojTeWn8MpQnzuHaaR65ff1Lqvia//U74XS2aMYdoNt79YXfyJe9T9Pi/extFL2FSGMTRpAmI0/7aV1/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YX82Y4nb; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Feb 2026 09:18:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772039898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=23hLqUqZfb0l8tMGYPwGo0r3f7npeoJfW5VD98Q2BVM=;
	b=YX82Y4nbN56zvalwnSX4B06QpBK6Gkz2W3LObAqpusvYzGWRtdMDO7XCeQpLqyddb+ZI8/
	dSWSlpSuQq0eWaYOWsaCwT689Fpca6PLhWXO563ZSRvNyUJJ+kr8jKm6RxykD2FdVfXrsj
	scA2lrFSqv6w9aRWimPW1czr9lytm2k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev
Subject: Re: [PATCH] Revert "ptdesc: remove references to folios from
 __pagetable_ctor() and pagetable_dtor()"
Message-ID: <aZ8twGY8HEhV3-Mw@linux.dev>
References: <20260225002434.2953895-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225002434.2953895-1-axelrasmussen@google.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219676-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 4140119B6EC
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 04:24:34PM -0800, Axel Rasmussen wrote:
> This change swapped out mod_node_page_state for lruvec_stat_add_folio.
> But, these two APIs are not interchangeable: the lruvec version also
> increments memcg stats, in addition to "global" pgdat stats.
> 
> So after this change, the "pagetables" memcg stat in memory.stat always
> yields "0", which is a userspace visible regression.
> 
> I tried to look for a refactor where we add a variant of
> lruvec_stat_mod_folio which takes a pgdat and a memcg instead of a
> folio, to try to adhere to the spirit of the original patch. But at the
> end of the day this just means we have to call
> folio_memcg(ptdesc_folio(ptdesc)) anyway, which doesn't really
> accomplish much.
> 
> This regression is visible in master as well as 6.18 stable, so CC
> stable too.
> 
> Fixes: f0c92726e89f ("ptdesc: remove references to folios from __pagetable_ctor() and pagetable_dtor()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


