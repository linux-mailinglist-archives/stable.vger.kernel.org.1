Return-Path: <stable+bounces-212482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEdwHzM6emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:32:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA66A5CB7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D981B30D2665
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CDE2DF155;
	Wed, 28 Jan 2026 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w1DH/R9M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C522E2DF4;
	Wed, 28 Jan 2026 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615666; cv=none; b=siv9euI90GKVpkFHjy7w4EGU2pR8OBCAxZp67YgRnFzJBXC9PyVWN9+kI2Dyq5DTDYVKywUTqLSvCGQ9DFLlJt1qiPST9sjtFlYi2MrNtrVVBOZyzb0Nhn8pGj/QpguGNYKBI2B0STCquGgQSmwYGQBMIKJuSA5Cd/iZQATfqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615666; c=relaxed/simple;
	bh=JH3fdT9tchRJTgiN5nfFtg08PdnmjkbCw+SC1lRp2CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMkCrLnLmU9eSz7RNGJeirohRRKV5eJ1BvKurZB5RgWF8yPR3EpNAuzHY3tK6Hx86lJYABBwQ6T5dsjb+gGC7qXQ9xbuXkDQQgTfSqxRTRc3F94KtuaR9fLsEAYAEDzBxUmPVkmuEP585asmi33eKCseeVYGpfvWQC20vf7YbdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w1DH/R9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64C1C4CEF1;
	Wed, 28 Jan 2026 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615666;
	bh=JH3fdT9tchRJTgiN5nfFtg08PdnmjkbCw+SC1lRp2CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w1DH/R9MDRj08Adg5o/nhbX8NRYULVkMAQaotB+XlvIurDr2p32VwbMSOh0/VJzfG
	 O8ZdZ66uPfPjOchIXSPFqw7q0dCtRimPdnEWyI2E0oHrYPN4HxwnMakOSUfikQ6bBg
	 02LLI43LKSZLzcpV96hqqKZJTJ+tRXuNsThI/aQU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 078/227] mm: restore per-memcg proactive reclaim with !CONFIG_NUMA
Date: Wed, 28 Jan 2026 16:22:03 +0100
Message-ID: <20260128145347.150482229@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212482-lists,stable=lfdr.de];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux-foundation.org:email,suse.com:email,suse.cz:email,cmpxchg.org:email]
X-Rspamd-Queue-Id: DFA66A5CB7
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yosry Ahmed <yosry.ahmed@linux.dev>

commit 16aca2c98a6fdf071e5a1a765a295995d7c7e346 upstream.

Commit 2b7226af730c ("mm/memcg: make memory.reclaim interface generic")
moved proactive reclaim logic from memory.reclaim handler to a generic
user_proactive_reclaim() helper to be used for per-node proactive reclaim.

However, user_proactive_reclaim() was only defined under CONFIG_NUMA, with
a stub always returning 0 otherwise.  This broke memory.reclaim on
!CONFIG_NUMA configs, causing it to report success without actually
attempting reclaim.

Move the definition of user_proactive_reclaim() outside CONFIG_NUMA, and
instead define a stub for __node_reclaim() in the !CONFIG_NUMA case.
__node_reclaim() is only called from user_proactive_reclaim() when a write
is made to sys/devices/system/node/nodeX/reclaim, which is only defined
with CONFIG_NUMA.

Link: https://lkml.kernel.org/r/20260116205247.928004-1-yosry.ahmed@linux.dev
Fixes: 2b7226af730c ("mm/memcg: make memory.reclaim interface generic")
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/internal.h |    8 --------
 mm/vmscan.c   |   13 +++++++++++--
 2 files changed, 11 insertions(+), 10 deletions(-)

--- a/mm/internal.h
+++ b/mm/internal.h
@@ -538,16 +538,8 @@ extern unsigned long highest_memmap_pfn;
 bool folio_isolate_lru(struct folio *folio);
 void folio_putback_lru(struct folio *folio);
 extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
-#ifdef CONFIG_NUMA
 int user_proactive_reclaim(char *buf,
 			   struct mem_cgroup *memcg, pg_data_t *pgdat);
-#else
-static inline int user_proactive_reclaim(char *buf,
-			   struct mem_cgroup *memcg, pg_data_t *pgdat)
-{
-	return 0;
-}
-#endif
 
 /*
  * in mm/rmap.c:
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7740,6 +7740,17 @@ int node_reclaim(struct pglist_data *pgd
 	return ret;
 }
 
+#else
+
+static unsigned long __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask,
+				    unsigned long nr_pages,
+				    struct scan_control *sc)
+{
+	return 0;
+}
+
+#endif
+
 enum {
 	MEMORY_RECLAIM_SWAPPINESS = 0,
 	MEMORY_RECLAIM_SWAPPINESS_MAX,
@@ -7847,8 +7858,6 @@ int user_proactive_reclaim(char *buf,
 	return 0;
 }
 
-#endif
-
 /**
  * check_move_unevictable_folios - Move evictable folios to appropriate zone
  * lru list



