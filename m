Return-Path: <stable+bounces-206216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAFFD00125
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 21:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA71C3003483
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 20:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296AD31ED7F;
	Wed,  7 Jan 2026 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BevhwU23"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBB23C8A0
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819336; cv=none; b=UZ4XdTHx8tqV61bgiXB2erVR7cHVYdU3nOs2Na3/hCyPUyccu0xW66Nfi/4+Bq3jsaWADcBYueZubsFQmhqEKPaYMbPZk3s6t/qCZM72NyawhSzVkp3ohx34hYnwlIdS0sFU/726K6ESxu9jNo9xeQfk6ULoPWCMT6YA5h7Ygjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819336; c=relaxed/simple;
	bh=vVHa3TnuOM5oauFzlAYCt88CK+OK6reclmsP1Yo6fgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=At8iERZO0gK2dK5dO2OdR79w6PFW+wshefr1i9eAuds5bSoKY3bYctYfjr//n+eBPLZnPQxUoMtC2DZjhm0FRCWvz1Q2L1R+iLi7ssHmNPDMQ8lgN3ts2N9yVHeRd6Bqn9ZYRt3KXVs7bl6eTMOiE34EwCXjA0+I0Ok5PU2F9io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BevhwU23; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=onCYdfBJPf4AnSBVwJ2/aEqS6jrss/1BLUDHPeErKyY=; b=BevhwU23jXy7xBnkUWiBMQhaqv
	R6sPWMjAr+rKAe7A0FmmrwGQv87wr6BoDLHGWK8Nirt4cOJxD5bBnI35sVUwaPAYpEyAsuiNfb3R8
	SqzrIjpgDFtsdRe2lfF8B9YclMUz2k1wbV8XvIsPjhpckjjnWI8WXoss9bqrZB9sFAvS3rNelehfw
	wssT0vUTINtXtevh7HAcwg+ZgAhiXpPf/8xaaP1iZy7/QQQKySUM9ZTwKqbpkZ+XiNH7cvzF2RSFf
	MSyWMP8oEPS4/pJTR5cK6CrokTWx04RcATzMyJd4Bzdn26Ap1tG7V7pSFRlASMD/kA9LL3FLizffP
	YnMkACxw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdaYu-0000000DwPV-0E06;
	Wed, 07 Jan 2026 20:55:24 +0000
Date: Wed, 7 Jan 2026 20:55:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm_take_all_locks: change -EINTR to -ERESTARTSYS
Message-ID: <aV7IO8-trMSI1twA@casper.infradead.org>
References: <20260107203113.690118053@debian4.vm>
 <20260107203224.969740802@debian4.vm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107203224.969740802@debian4.vm>

On Wed, Jan 07, 2026 at 09:31:14PM +0100, Mikulas Patocka wrote:
> This commit changes -EINTR to -ERESTARTSYS, so that if the signal handler
> was installed with the SA_RESTART flag, the operation is automatically
> restarted.

No, this is bonkers.  If you get a signal, you return -EINTR.

