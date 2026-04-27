Return-Path: <stable+bounces-241237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKsvDnsM72kq4wAAu9opvQ
	(envelope-from <stable+bounces-241237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:12:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0C846E29F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C8DA302A6D5
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4037390CBE;
	Mon, 27 Apr 2026 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpQ94iUW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C99390CAD;
	Mon, 27 Apr 2026 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273831; cv=none; b=iDU2TLqsdomPwo1jsjFkDo4dcYC6iOYqG6tO17wDsXTbp8cEQ+T3FUKaW5ly/0x9TIBlhW3feU0UdUlMbolbFW1BXo32v5np9DpaSqsTs82vrdd+Mw7tZVfWxpliyZkGje6xXsc3NDKaYf4LnicwUoIG8SR7JptkkME6iQhFANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273831; c=relaxed/simple;
	bh=f8fG+Ov6SZaQufkiq2WTLEXvbWtRIw+ej5o9FaRUj7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwyyKJ2VzG5tyzmbAAMMoDBmFtj9b2xDQ9xhtnfowpHeYAhFM13THZC6SU0bb4k99ERfsDIrnpVKSvJiHjzpuUT13kKPas9o8WRf7AHEMaNaMf8ruycrjg6ghB78dXDF4YAH2R197bC/fnWc3OToVpoGgzbz+WT79I9IvQsaHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpQ94iUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF42DC2BCB6;
	Mon, 27 Apr 2026 07:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777273831;
	bh=f8fG+Ov6SZaQufkiq2WTLEXvbWtRIw+ej5o9FaRUj7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HpQ94iUW1FbbntkG34+YyOJJC9K2Y2MHX/jxzhKTKmDo09P24Xb5Ooc83YMCCx5Lv
	 d5LIJRQjP4415ffHTQSCb2lrmoJOfR/ymo+0xLt5caMimpAp/V2E9gjfBAWVq2Lk0m
	 mldUw9d6THL96fsm8pVmf7Uq9VviaKy9GGteLan6talPR85+5izDAmqO4j9DoAx2MR
	 QG1NIznIkt9z/DHrnxkkzMtUWvvbWbASBundbjw+RobXJr5/UhWB+5U0CGSCDf7ypL
	 7DDDsmlJwMoaP2991byEXTVHcjT40y3P2BZVpyr3qVUJ8nUE4jpSQVh5MxZV1Ev/Is
	 KM9ISIPSgfRcA==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Mon, 27 Apr 2026 16:09:52 +0900
Subject: [PATCH mm-hotfixes v2 1/2] mm/page_alloc: return NULL early from
 alloc_frozen_pages_nolock() in NMI on UP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nolock-api-fix-v2-1-a6b83a92d9a4@kernel.org>
References: <20260427-nolock-api-fix-v2-0-a6b83a92d9a4@kernel.org>
In-Reply-To: <20260427-nolock-api-fix-v2-0-a6b83a92d9a4@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Harry Yoo <harry@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Queue-Id: CA0C846E29F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241237-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On UP kernels (!CONFIG_SMP), spin_trylock() is a no-op that
unconditionally succeeds even when the lock is already held. As a
result, alloc_frozen_pages_nolock() called from NMI context can
re-enter rmqueue() and acquire the zone lock that the interrupted
context is already holding, corrupting the freelists.

With CONFIG_DEBUG_SPINLOCK on UP, the following BUG is triggered with
the slub_kunit test module:

  BUG: spinlock trylock failure on UP on CPU#0, kunit_try_catch/243
  [...]
  Call Trace:
   <NMI>
   dump_stack_lvl+0x3f/0x60
   do_raw_spin_trylock+0x41/0x50
   _raw_spin_trylock+0x24/0x50
   rmqueue.isra.0+0x2a9/0xa70
   get_page_from_freelist+0xeb/0x450
   alloc_frozen_pages_nolock_noprof+0x111/0x1e0
   allocate_slab+0x42a/0x500
   ___slab_alloc+0xa7/0x4c0
   kmalloc_nolock_noprof+0x164/0x310
   [...]
   </NMI>

Fix this by returning NULL early when invoked from NMI on a UP kernel.

Link: https://lore.kernel.org/linux-mm/ad_cqe51pvr1WaDg@hyeyoo
Cc: <stable@vger.kernel.org>
Fixes: d7242af86434 ("mm: Introduce alloc_frozen_pages_nolock()")
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 71859993dd54..23c7298d3be2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7737,6 +7737,11 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
 		return NULL;
+
+	/* On UP, spin_trylock() always succeeds even when it is locked */
+	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
+		return NULL;
+
 	if (!pcp_allowed_order(order))
 		return NULL;
 

-- 
2.43.0


