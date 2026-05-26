Return-Path: <stable+bounces-254343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABNeFlSaFWrnWgcAu9opvQ
	(envelope-from <stable+bounces-254343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:04:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF055D602A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E7FD3016DA9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98A3D3326;
	Tue, 26 May 2026 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UPOjpcEJ"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1777391835
	for <stable@vger.kernel.org>; Tue, 26 May 2026 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800436; cv=none; b=Tp5T6Uv7gIIwq+zcNCwpVfwTvfJ5ImeokNM5liEdxHfyZbrWJ1aH9zt6H0GfEL3JFc1XUaOXkbRkjeFM8wdjBJzWLVg7hqdq/f6IlrXJq7mswE+sYYtdY9+URBeFXcFJFLjU8d2l59vzI1OznfmntuTdoL9zUOfa9XsvFWC0sl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800436; c=relaxed/simple;
	bh=DvvLRt3F5ORP7dlAdhtBqO4qrwFJRT7s3Reb5HxK6k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCddaNKz5dj5fzpu+WfnNtm9tMwBKY2pbcuoej8GNikyuIHhomON2nmSewJagwYITHlbVw37B5uBn+Dt9pmHAhlUoIMspqLNaa1XPV9TOLsKIIDqxw1gqCl1dE32DYlYMUMwy1D2uQbswhgqPPuBaRDqLGna6RTUpjgdsJdh1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UPOjpcEJ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779800432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqRAcpX+3JOcvVi4m9jMhaxftvCUQ9zppcLisuvJR1I=;
	b=UPOjpcEJWndGHzC2ELYwgruh15sSq4mQI7oByMYoO7O9/299xlLZuMnojhcNFoD2Wrmaez
	U3DRab8XDCYasgGLBuOp9fGzAP9fRTUlocJOrMu1kUe5QNBOKApY/nT3RnQRhMnhL84Ns2
	DvrVl0na3WVlsRfBH/4NweaRYxXT6CM=
From: Usama Arif <usama.arif@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Frank van der Linden <fvdl@google.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [PATCH v2] mm/cma: fix reserved page leak on activation failure
Date: Tue, 26 May 2026 06:00:25 -0700
Message-ID: <20260526130026.3881822-1-usama.arif@linux.dev>
In-Reply-To: <20260523060123.2207992-1-songmuchun@bytedance.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254343-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5FF055D602A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 14:01:23 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

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

Acked-by: Usama Arif <usama.arif@linux.dev>
 

