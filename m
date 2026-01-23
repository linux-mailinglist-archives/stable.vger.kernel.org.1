Return-Path: <stable+bounces-211340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GPrHuMac2mwsAAAu9opvQ
	(envelope-from <stable+bounces-211340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 07:53:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B02712D0
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 07:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 768E43009532
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 06:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73273334C34;
	Fri, 23 Jan 2026 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TwaNSJ22";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SNEpdW+c"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97496306B0A
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151194; cv=none; b=duI088Mjt8SRWRPbIWZ2CvgUz5S54hScbuv8Ork5mgGErUjF3o0Iqz2XRgiF/mhlDXr5HIPXuQVvk/Kk0oYKyp6NyF+28mTy8f7HZuol3A2zPjHgzUmjB9GbUU8ka20kaHWhOqAOI/nmH2Tv2Ze/Qb6G7fIKe+GxcaI/oAsUm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151194; c=relaxed/simple;
	bh=2dxN373nd33A36HYKm5zAqxbXMPp7koH+IgdNry5g9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qn6OnCXZbpJ0SMIdqYRP7uaAUjScRd/wYX0HN2+vUyqzySCYMAGrzjHAUFFs5X4wRALQ1m3o5pp9CauXoapnlrzs2oSPPMVZ6PKv8Xu7x7BWXGacedGZbCXKHetCtct5AD2zWjDRk99hEDq/Dmlgi+IN+zlwUbEqhHaV6ISh2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TwaNSJ22; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SNEpdW+c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5590D5BCC7;
	Fri, 23 Jan 2026 06:53:09 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769151189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3DPRc87aFtnpwc8583i8li1YmCTDsn4GBRi/xoPavM=;
	b=TwaNSJ22lUVkujoTIcvlmVUlFpzLKghPixm3xazahkIhiI/v4TrTd+WtWioUyaylUhhp7T
	FRbngh8djjheSnvOCQ6NZhq46zfaMkyu/7bpHDVUruTcSaryiQM9w+Ug1fc7wqbN7O6Mrp
	E6bNPUFcj3w4jWxip5wq5q8xY6i26Ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769151189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3DPRc87aFtnpwc8583i8li1YmCTDsn4GBRi/xoPavM=;
	b=SNEpdW+ctprfZkkprEqg/5KnB8JO8nS631UuFA1jSQ0f0vyJgC0E2/s9y3iaX05lqkGrNb
	bJ9qxNkxCKfWBwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 277A7139E8;
	Fri, 23 Jan 2026 06:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0O5fCdUac2k4YgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Jan 2026 06:53:09 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Jan 2026 07:52:39 +0100
Subject: [PATCH v4 01/22] mm/slab: add rcu_barrier() to
 kvfree_rcu_barrier_on_cache()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-sheaves-for-all-v4-1-041323d506f7@suse.cz>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
In-Reply-To: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
To: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 Vlastimil Babka <vbabka@suse.cz>, kernel test robot <oliver.sang@intel.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211340-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz,intel.com];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:email,suse.cz:dkim,suse.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D0B02712D0
X-Rspamd-Action: no action

After we submit the rcu_free sheaves to call_rcu() we need to make sure
the rcu callbacks complete. kvfree_rcu_barrier() does that via
flush_all_rcu_sheaves() but kvfree_rcu_barrier_on_cache() doesn't. Fix
that.

This currently causes no issues because the caches with sheaves we have
are never destroyed. The problem flagged by kernel test robot was
reported for a patch that enables sheaves for (almost) all caches, and
occurred only with CONFIG_KASAN. Harry Yoo found the root cause [1]:

  It turns out the object freed by sheaf_flush_unused() was in KASAN
  percpu quarantine list (confirmed by dumping the list) by the time
  __kmem_cache_shutdown() returns an error.

  Quarantined objects are supposed to be flushed by kasan_cache_shutdown(),
  but things go wrong if the rcu callback (rcu_free_sheaf_nobarn()) is
  processed after kasan_cache_shutdown() finishes.

  That's why rcu_barrier() in __kmem_cache_shutdown() didn't help,
  because it's called after kasan_cache_shutdown().

  Calling rcu_barrier() in kvfree_rcu_barrier_on_cache() guarantees
  that it'll be added to the quarantine list before kasan_cache_shutdown()
  is called. So it's a valid fix!

[1] https://lore.kernel.org/all/aWd6f3jERlrB5yeF@hyeyoo/

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202601121442.c530bed3-lkp@intel.com
Fixes: 0f35040de593 ("mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction")
Cc: stable@vger.kernel.org
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Tested-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index eed7ea556cb1..ee994ec7f251 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -2133,8 +2133,11 @@ EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
  */
 void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
 {
-	if (s->cpu_sheaves)
+	if (s->cpu_sheaves) {
 		flush_rcu_sheaves_on_cache(s);
+		rcu_barrier();
+	}
+
 	/*
 	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
 	 * on a specific slab cache.

-- 
2.52.0


