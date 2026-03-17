Return-Path: <stable+bounces-226385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIK8JEeHuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:54:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E62AEA02
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91052300CA0D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5993F23DD;
	Tue, 17 Mar 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XRR8w/Yf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106B2DE70D;
	Tue, 17 Mar 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766466; cv=none; b=HkC4SO17feWR0gLDFO1kTDBS2BUrPbvg/fXxebebGyB8deK5+HGRaeU3RvEYApgKT2RUSD4K+VRNiNSjDO8ZznrXwglntuWzocQtTZLdbjdoJwQa3KWDtxDpxoZ+MisEjOVnNhgd/EBjL7eQqgieEdiHqWTCVoNPty5BKQxlcO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766466; c=relaxed/simple;
	bh=D+TBFfG/ngyS7n95019FfmXQ8FoEgUWsBaddZSgIsOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWlsI1/uHoi9QB3b8horQa/cGlfTQLsfbgAjrU91kJxy9xBUJsYRm01twR9Fa/gx+SuHsTF3d76XoxTu+7bWngbrq8wqmkNZn9RnGggrbtefepRuh4H+3nrwjqPlSGMJYEmpqWUPWVb9ks8/cmXOnvJastKwpJ7hiznNAILlvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XRR8w/Yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16E1C4CEF7;
	Tue, 17 Mar 2026 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766466;
	bh=D+TBFfG/ngyS7n95019FfmXQ8FoEgUWsBaddZSgIsOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRR8w/Yfu0wlC2Il1TO2ps6p87FMbrNVHZ+jV4EV126f3rDwLxpUQb04hRepZHq4U
	 7KdwPBheRMWCAwGlqoteeJsV2DnpBKWb3rxO4PwFc1rRHbQEEjTDituxDn3P+AiMDm
	 6J4lxGxgnmsTC27TUqLeL/bvnkBbxppAV+0wlfLg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zw Tang <shicenci@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH 6.19 252/378] mm/slab: fix an incorrect check in obj_exts_alloc_size()
Date: Tue, 17 Mar 2026 17:33:29 +0100
Message-ID: <20260317163016.292600622@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226385-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oracle.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 429E62AEA02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Yoo <harry.yoo@oracle.com>

commit 8dafa9f5900c4855a65dbfee51e3bd00636deee1 upstream.

obj_exts_alloc_size() prevents recursive allocation of slabobj_ext
array from the same cache, to avoid creating slabs that are never freed.

There is one mistake that returns the original size when memory
allocation profiling is disabled. The assumption was that
memcg-triggered slabobj_ext allocation is always served from
KMALLOC_CGROUP type. But this is wrong [1]: when the caller specifies
both __GFP_RECLAIMABLE and __GFP_ACCOUNT with SLUB_TINY enabled, the
allocation is served from normal kmalloc. This is because kmalloc_type()
prioritizes __GFP_RECLAIMABLE over __GFP_ACCOUNT, and SLUB_TINY aliases
KMALLOC_RECLAIM with KMALLOC_NORMAL.

As a result, the recursion guard is bypassed and the problematic slabs
can be created. Fix this by removing the mem_alloc_profiling_enabled()
check entirely. The remaining is_kmalloc_normal() check is still
sufficient to detect whether the cache is of KMALLOC_NORMAL type and
avoid bumping the size if it's not.

Without SLUB_TINY, no functional change intended.
With SLUB_TINY, allocations with __GFP_ACCOUNT|__GFP_RECLAIMABLE
now allocate a larger array if the sizes equal.

Reported-by: Zw Tang <shicenci@gmail.com>
Fixes: 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from its own slab")
Closes: https://lore.kernel.org/linux-mm/CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C0gFxC6xGOG0ZLHgPmnA@mail.gmail.com [1]
Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Link: https://patch.msgid.link/20260309072219.22653-1-harry.yoo@oracle.com
Tested-by: Zw Tang <shicenci@gmail.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slub.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2113,13 +2113,6 @@ static inline size_t obj_exts_alloc_size
 	size_t sz = sizeof(struct slabobj_ext) * slab->objects;
 	struct kmem_cache *obj_exts_cache;
 
-	/*
-	 * slabobj_ext array for KMALLOC_CGROUP allocations
-	 * are served from KMALLOC_NORMAL caches.
-	 */
-	if (!mem_alloc_profiling_enabled())
-		return sz;
-
 	if (sz > KMALLOC_MAX_CACHE_SIZE)
 		return sz;
 



