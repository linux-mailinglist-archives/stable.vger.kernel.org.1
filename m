Return-Path: <stable+bounces-239982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBdPFktz5mnKwgEAu9opvQ
	(envelope-from <stable+bounces-239982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:41:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2959432FDE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD21A300C02F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419013AA4FA;
	Mon, 20 Apr 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uxw8dq3M"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEEA3B19A5;
	Mon, 20 Apr 2026 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710471; cv=none; b=h0ZXU6UBorT6oQtegnzoXVOF7IyABjB5oufHvXaK00WYrbMPKyfcGITCawY6NYJ3qvcxWGhQHgaOSO+dwl4UGNlyg6fslFt5QP2GbipYKHfUz24hBGhSfbZhXUPVBPrApude+Ibrt9sMc+q5DDfUUjzQQOmgzYJSe7/5zuKElxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710471; c=relaxed/simple;
	bh=koIsUOiW6uhsoaE26yJZoZKBgb6/CEJrDeBMb910ceU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQDV1hVHbMv/q4iTajfWpMr3mlqiRwTh4aq4IpIQSSyo3/vuLVzAYz7NVX79KjAfGmAl+bu15bRecyuXSjJ7W6ETatZA7WNzV4cBLf/bbAEIoXskUWl0/L81ibdd2fQU+0a2PhZAGRkWkgm8OWuCBJXBn6Ov5ggob7KEI4Gh8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Uxw8dq3M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=US7xk5FxdqbPrtNDg67ilQoyRup65Jv5pMgq4MufUEM=; b=Uxw8dq3MdMz8mXBvJk8pRiEKn1
	inBCGK8of1iaOkAOH8Q5SLMr9p+3iW9qIQ8VWWQtQsyHX6nwUex+PY9yVzSVVgA3yXPfUiZPwLRqM
	ifRYOL01IYQ533ffUK5FqeBZw8iaqD+nHhNWjrG/IDhJ7AqvE2UjNA/Mp+KgioX/2xx3GZ4lVQKgG
	VWDRAR8/tUtwx2bd3UPIqeK61prrotV4e9ab/HuIliklfa2kXB2i9m88KnHIrn33QIunjlcdGlkdb
	DLOpWdWmXYDYW5q9O/JWD9++JoreSB0f7kYG9O2n8UM1rFHqSwbOzkwCYYOV0vySueq0pgy5x0HyQ
	593oZOZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEtYN-00000008sKB-3rpU;
	Mon, 20 Apr 2026 18:41:04 +0000
Date: Mon, 20 Apr 2026 19:41:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Salvatore Dipietro <dipiets@amazon.it>, linux-kernel@vger.kernel.org,
	ritesh.list@gmail.com, abuehaze@amazon.com, alisaidi@amazon.com,
	blakgeof@amazon.com, brauner@kernel.org,
	dipietro.salvatore@gmail.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] mm/filemap: avoid costly reclaim for high-order folio
 allocations
Message-ID: <aeZzP6iQel-tkZOu@casper.infradead.org>
References: <20260420161404.642-1-dipiets@amazon.it>
 <20260420095106.86ecdb685cd31e0847362512@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420095106.86ecdb685cd31e0847362512@linux-foundation.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239982-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amazon.it,vger.kernel.org,gmail.com,amazon.com,kernel.org,kvack.org,suse.cz];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.it:email,infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,casper.infradead.org:mid]
X-Rspamd-Queue-Id: F2959432FDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 09:51:06AM -0700, Andrew Morton wrote:
> On Mon, 20 Apr 2026 16:14:03 +0000 Salvatore Dipietro <dipiets@amazon.it> wrote:
> > Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> > introduced high-order folio allocations in the buffered write path.

No it didn't.  5d8edfb900d5 only allows the use of larger folios if they
already existed in the page cache.  d6bb59a9444d allows the creation of
large folios.

> > When memory is fragmented, each failed allocation above
> > PAGE_ALLOC_COSTLY_ORDER triggers compaction and drain_all_pages() via
> > __alloc_pages_slowpath(), causing a 0.75x throughput drop on pgbench
> > (simple-update) with  1024 clients on a 96-vCPU arm64 system.

Why are you pretending this is new instead of already being the source
of much recent discussion?

https://lore.kernel.org/all/20260403193535.9970-1-dipiets@amazon.it/

> "Good money after bad"?  Prove me wrong!
> 
> Instead of performing weird fragile hard-to-maintain party tricks with
> the page allocator to work around the damage, plan B is to simply
> revert 5d8edfb900d5.

lol.  best of luck with that.  you'd break a lot of other things if you
did.

> 5d8edfb900d5 came with no performance testing results.  Does anyone
> have any evidence that it improved anything?  By how much?

Christoph reported it doubled write performance with NFS once NFS was
converted to use it.

