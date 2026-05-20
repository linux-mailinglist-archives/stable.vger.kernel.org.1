Return-Path: <stable+bounces-249770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFH+AIViDWquwgUAu9opvQ
	(envelope-from <stable+bounces-249770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:28:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EE3588F18
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C21483013625
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482A36A009;
	Wed, 20 May 2026 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUbzXZ1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A534366073;
	Wed, 20 May 2026 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262080; cv=none; b=cb6V61UJIzbFurRGPj+0VOjif2Kqlnk+6BCxz7Qm3F03+akLuSMdjpjQjkWc7cWi0RsJuBLY1aFOaKaa/eq2xWVO819YVLITEAE4GiMpKTOa3MUdos0jxnE4yNbWF/Yw0GoQwHgmcvIPf9Tei1T1U0gA5xvjK7MPVpaQIbOyHd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262080; c=relaxed/simple;
	bh=2PzME0qcq3GBYdrG2wVFhfEhY2yBN1xjMPqwd7pN1tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xohp+l0ixGBl47OHtw+2psX7ksokmYhWh0RHIEuzs+AqB5hlxXz31YSSA8iteG+vuBY9owOgSHY0C0eC8jkpmgA4v8OKW3qg80qs53HpadvpvyDr0ePNKGRFU8QusjxbzkN9/mjL2WNUlkHZjLDGTvU/cbeK4QSSZkzLpQJSiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUbzXZ1J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9087B1F000E9;
	Wed, 20 May 2026 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779262078;
	bh=fdNCyqGV74cbHs7F0SZMzIf3smavh74AddJTHydkYMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cUbzXZ1JQE9hOplo14fkRNL1KuiWzGuRXRatg7w4mliawFyYBAIT8SlveWysOloIH
	 5lsvkPIjDYo2xKQ59XA9is5RnZx90YB7apK/CD4ELVmCZACojyipxSMedutkuFPl7a
	 5WaM6J/Bi2OlPn3tT+zoCGXxUWvoolz+zajgfamRmzJn2IGLUnbVRoXt0PjnieyiHh
	 XsgYxMEQ5edJSdkNxW5+CgjAPBwiv3aoKxwbZnI3kCozH5/ZJJMOqlhZIB7nc5Set/
	 OoBJptdK9TNOW5b+BnqMZ9hGfjpCKziUSc1i0/KLl0LOBrBxQ4BAX8mD9qV73KIi68
	 Z/hnm4+QqVurw==
Date: Wed, 20 May 2026 09:27:44 +0200
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
	Stefan Strogin <stefan.strogin@gmail.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Michal Nazarewicz <mina86@mina86.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [PATCH] mm/cma_debug: fix invalid accesses for inactive CMA areas
Message-ID: <ag1icL5DPMVXwRta@localhost.localdomain>
References: <20260520061025.3971821-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520061025.3971821-1-songmuchun@bytedance.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249770-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,infradead.org,google.com,suse.com,gmail.com,mina86.com,vger.kernel.org,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osalvador@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,localhost.localdomain:mid]
X-Rspamd-Queue-Id: 97EE3588F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 02:10:25PM +0800, Muchun Song wrote:
> cma_activate_area() can fail after allocating range bitmaps. Its cleanup
> path frees those bitmaps, but only clears cma->count and
> cma->available_count. It leaves cma->nranges and each range's count in
> place, so cma_debugfs_init() can still register debugfs files for an area
> that never activated successfully.
> 
> That exposes two problems. Reading the bitmap file can make debugfs walk a
> freed range bitmap and trigger an invalid memory access. Reading maxchunk
> can also take cma->lock even though that lock is initialized only on the
> successful activation path.
> 
> Fix this by creating debugfs entries only for CMA areas that reached
> CMA_ACTIVATED.
> 
> Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
> Fixes: 2e32b947606d ("mm: cma: add functions to get region pages counters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

For the change:

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

About Fixes, does this mean that before c009da4258f9 ("mm, cma: support
multiple contiguous ranges, if requested"), this was already triggerable
after 2e32b947606d?
 

-- 
Oscar Salvador
SUSE Labs

