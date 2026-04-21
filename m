Return-Path: <stable+bounces-240071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHClKfcr52nv4wEAu9opvQ
	(envelope-from <stable+bounces-240071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:49:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D72437D81
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96D4F3023D8A
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4BE301474;
	Tue, 21 Apr 2026 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qBtAk1+n"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898C1FB1
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757633; cv=none; b=ennh7y+TLhqDASjZ5hDX7rSwwqL1KFtoLgjPlq8fNV+zGb29oyWZ+4fs5dN4Sh2DGlyriMjhyUfiQCC8M0QZzqyrBolz2Uw5yyGCmmWGdI+tA/J2Qft5jA5SZ2W1jCXxf17jw43XnLj9ypcmnLRdOYnXHJjSGKNNVf2F1F/1/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757633; c=relaxed/simple;
	bh=pwLYsZ1hj4BhebbyXGH7ndw+0vhnMN7D2DVlWGwcad8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/qN8qaaS5OIZs46YCVXfcRg1V44d56lL9o1tOtkfQ0kKgo45mSs4GmiQCKgPOLR21PkYfLUcVBjzDQEY1/GNgOK2k2vGh1XbAAsyrNaAutAiXeouVMDtRPLU7KkRla+IkWWzg5IZ15WG9QrAtUQPr3Rf7Ypd6G7T/qJdBn8zMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qBtAk1+n; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776757619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tf1/Nczyer/GJCIPDHmGkMVMbW3+J8WCh6h++SMiyOA=;
	b=qBtAk1+nNzp4Kl8q08RFuv48IsTFWM+xt/tlv/kUr3tpqfe5xYPcqNG/NSCwj3GwEDrPKS
	Tjr5tT3APq2SB/EiN7Ju/Bzjfsc+cB8DPKdlY5NB+DfHxzv1EkzgASI+y8IFrTqVl8uJdT
	d269iHpA5/QvNdycBlZjGdhfBEdJHB0=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix initialization of tags of the huge zero folio with init_on_free
Date: Tue, 21 Apr 2026 15:46:30 +0800
Message-Id: <20260421074630.72451-1-lance.yang@linux.dev>
In-Reply-To: <20260420-zerotags-v1-1-3edc93e95bb4@kernel.org>
References: <20260420-zerotags-v1-1-3edc93e95bb4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240071-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43D72437D81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, Apr 20, 2026 at 11:16:46PM +0200, David Hildenbrand (Arm) wrote:
>__GFP_ZEROTAGS semantics are currently a bit weird, but effectively this
>flag is only ever set alongside __GFP_ZERO and __GFP_SKIP_KASAN.
>
>If we run with init_on_free, we will zero out pages during
>__free_pages_prepare(), to skip zeroing on the allocation path.
>
>However, when allocating with __GFP_ZEROTAG set, post_alloc_hook() will
>consequently not only skip clearing page content, but also skip
>clearing tag memory.
>
>Not clearing tags through __GFP_ZEROTAGS is irrelevant for most pages that
>will get mapped to user space through set_pte_at() later: set_pte_at() and
>friends will detect that the tags have not been initialized yet
>(PG_mte_tagged not set), and initialize them.
>
>However, for the huge zero folio, which will be mapped through a PMD
>marked as special, this initialization will not be performed, ending up
>exposing whatever tags were still set for the pages.
>
>The docs (Documentation/arch/arm64/memory-tagging-extension.rst) state
>that allocation tags are set to 0 when a page is first mapped to user
>space. That no longer holds with the huge zero folio when init_on_free
>is enabled.
>
>Fix it by decoupling __GFP_ZEROTAGS from __GFP_ZERO, passing to
>tag_clear_highpages() whether we want to also clear page content.
>
>As we are touching the interface either way, just clean it up by
>only calling it when HW tags are enabled, dropping the return value, and
>dropping the common code stub.
>
>Reproduced with the huge zero folio by modifying the check_buffer_fill
>arm64/mte selftest to use a 2 MiB area, after making sure that pages have
>a non-0 tag set when freeing (note that, during boot, we will not
>actually initialize tags, but only set KASAN_TAG_KERNEL in the page
>flags).

Good catch!

I can reproduce it reliably with this small debug change:

---8<---
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 970e077019b7..d5b6e2474f47 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -225,8 +225,7 @@ static bool get_huge_zero_folio(void)
        if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
                return true;

-       zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS) &
-                                ~__GFP_MOVABLE,
+       zero_folio = folio_alloc(GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS,
                        HPAGE_PMD_ORDER);
        if (!zero_folio) {
                count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
---

That makes it much easier to hit. Userspace can seed tagged 2 MB folios,
but only as __GFP_MOVABLE.

The original huge zero folio allocation uses "& ~__GFP_MOVABLE", so it
will only reach these folios through fallback, which is hard to force
reliably from userspace :(

Will get back once testing is done :P

Cheers,
Lance

