Return-Path: <stable+bounces-254349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAm6Gw6cFWr9WgcAu9opvQ
	(envelope-from <stable+bounces-254349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:11:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7966F5D6213
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6621300ADB0
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C370B3DB99C;
	Tue, 26 May 2026 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f11GtvcZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7263D8101;
	Tue, 26 May 2026 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801075; cv=none; b=dSu7u7wvlz3mlcGjU1ihBF1BL8rp7uEFlD8xQKsX8P+Z0i/ZLHqRMs1YfDo5/Aom7PYI4NahnqtqhSrBoXRcUNHW+PGOKDYmb+h4wSJu7ii2SE78HFlBkKLzdxO3hZlICvOW90h/SiR4kYhRha4HOx3RBuhwln+yfAuhOVqziP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801075; c=relaxed/simple;
	bh=R63qm+J27hUn34B4CQsgjkn02thfmsimX0H9ceT42uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eibRBSo/2V0fzmEUSAKmdbKYrRFQyACnarJ/4MsjIjuKPg5dN+1vKh6wwn3EU6F7GBfjyEGVNjdFrbInlS2TICkkMmn1AC9XCEbkg66Avvw2a5fbVUUz2b/Bu65FvNZB0SwDKgfLaXuiYtV3ezlJ39Wrp6L1OBzJfe9+NCL9J8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f11GtvcZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB1B1F000E9;
	Tue, 26 May 2026 13:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779801074;
	bh=NLRxZs5V+Xs9xqYGiEg8hW6pN2SYk32SRlLoQ0q4z48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f11GtvcZxkf03mTF0kMhig0MOy+SLr4+uLQnFm3aMunR1kizOq/vSLNl0quYjWDYP
	 jneHF/5xyTIH+DCM8AqXkxvlnYdixmvb9DIXneSc53uw+3UoTQnaVrJmOyA5Y1PVey
	 G8yGtmd2UeTthx19hW8bkKGOWtuvnrE9tJ2jvFGtSqzuwugZVc+SCkfpPnscLpJ6V6
	 GPDyGyhvYBPyAaU/kv+VePggfepTr9Xkc3JJ4f5Nskg8xy171w3psMX73pvWa01fJQ
	 DwvilQDlg64atNguzsAV8G++XdKGr/LPObLmau77BGZdbhX1hH5R9Viz6rh9QrZWq3
	 xwPkXKCXNG2yA==
Date: Tue, 26 May 2026 15:11:07 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Frank van der Linden <fvdl@google.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [PATCH v2] mm/cma: fix reserved page leak on activation failure
Message-ID: <ahWb68NflaCtQ3mr@localhost.localdomain>
References: <20260523060123.2207992-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523060123.2207992-1-songmuchun@bytedance.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254349-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[bytedance.com:server fail,sin.lore.kernel.org:server fail,localhost.localdomain:server fail];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osalvador@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bytedance.com:email,localhost.localdomain:mid]
X-Rspamd-Queue-Id: 7966F5D6213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 02:01:23PM +0800, Muchun Song wrote:
> If cma_activate_area() fails after allocating only part of the range
> bitmaps, the cleanup path still has to release the reserved pages when
> CMA_RESERVE_PAGES_ON_ERROR is clear.
> 
> That is still worth doing even in this __init path. A bitmap_zalloc()
> failure does not necessarily mean the system cannot make further progress:
> freeing the reserved CMA pages can return a substantial amount of memory
> to the buddy allocator and may relieve the temporary memory shortage that
> caused the allocation failure in the first place.
> 
> However, the cleanup path currently uses the bitmap-freeing bound for page
> release as well. That is only correct for ranges whose bitmap allocation
> already succeeded. The failed range and all later ranges still keep their
> reserved pages, so a partial bitmap allocation failure can permanently
> leak them.
> 
> Fix this by releasing reserved pages for all ranges. Use the saved
> early_pfn[] value for ranges whose bitmap allocation already succeeded and
> for the failed range, and use cmr->early_pfn for later ranges whose bitmap
> allocation was never attempted.
> 
> Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs

