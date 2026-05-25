Return-Path: <stable+bounces-254187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DIWpMgWHFGqIOAcAu9opvQ
	(envelope-from <stable+bounces-254187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 19:29:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484C5CD612
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 19:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 226FF300FC5A
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1311F2D9787;
	Mon, 25 May 2026 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX74LKJq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A623BD02;
	Mon, 25 May 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779730174; cv=none; b=pj2HdT8yNqECLHjoQOjaLCpSHjgo3NBHTUIgldnICa5BxpygMa6v65u4uyWw9I0sz/P95PbUziDH7/xeAKkCYquNIl1EBiFEIcdoc4pTiv33150mSfj0lxYO3nPx+qr7vbw7GA3/ZhlVsYdqzZRpXe+bQKpGaWvo8dorrVhufko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779730174; c=relaxed/simple;
	bh=v6XB4mPPpGyKOjrzpe4Q6U5GbUalkA5ofLc0LmAuyMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYwf4BKbW0ohdoJiVw86vKa6a0YVrqt7v7qipOBhsNdJKITCcXMSv8GlibxGn/z0B32goiPVaAW1US/gBlWegM3usTtFnuKOuCVN5Goj1ZN1plReK8r1nnWiInIIi0Mz7XwKtbICnwsLv5eRhY9/hLu5uCd/ash62NW+3Ty+NuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX74LKJq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6A81F000E9;
	Mon, 25 May 2026 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779730173;
	bh=3paURfHuzbm+zxGp4fe8y83ocd0xA8H387UcFSHOVuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NX74LKJq/IjUDVEmxYUJwJ1ISe2v0ECqFGIT4e4f0KgSYNfV9C+7CKD3fGy0nHuhL
	 WdruTXRaEshe6RqKjS8eJHUizxDyH/k4gZNZTaDZFsOXbLU+eMlDyetEF+fTQ1a/qL
	 /Z/IADSkxqwxWyS8KVGTZniyyEmo5vymXF7R79K/tiJUHjo4pzOo4R6qKSMJWJPSYV
	 WpS5bOzZdSU9sqZWkqk5Rst73jagSk3nko+eO5vZedPM+zNwFfElsSOK05eODEyY60
	 QsHkPsWTVXzxgf5UJWiQzqZJZokKKSSKUGsKtIJ42D6iKCk43AdPItdTfFWJpWlgWs
	 V6IkYsZnlXaxg==
Date: Mon, 25 May 2026 19:29:25 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [PATCH] mm/cma: fix reserved page leak on activation failure
Message-ID: <ahSG9Wl7PVIz_Ugt@localhost.localdomain>
References: <20260522062658.4095405-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522062658.4095405-1-songmuchun@bytedance.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254187-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osalvador@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,localhost.localdomain:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2484C5CD612
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 02:26:58PM +0800, Muchun Song wrote:
> If cma_activate_area() fails after allocating only part of the range
> bitmaps, its cleanup path frees the bitmaps for the ranges below
> allocrange and then releases reserved pages using the same bound.
> 
> That bound is only correct for bitmap freeing. Pages in ranges that did
> not reach bitmap allocation are still reserved and should also be
> returned to the buddy when CMA_RESERVE_PAGES_ON_ERROR is clear. As a
> result, a partial bitmap allocation failure can permanently leak the
> reserved pages from the failed range and all later ranges.
> 
> Fix this by releasing reserved pages for all ranges. For ranges whose
> bitmap allocation succeeded, use the early_pfn[] snapshot saved before
> the bitmap pointer overwrote the union field. For later ranges, continue
> to use cmr->early_pfn directly.
> 
> Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>


-- 
Oscar Salvador
SUSE Labs

