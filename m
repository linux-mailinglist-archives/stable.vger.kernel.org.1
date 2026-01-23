Return-Path: <stable+bounces-211341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAj3Iwwbc2mwsAAAu9opvQ
	(envelope-from <stable+bounces-211341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 07:54:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677471395
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 07:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 047AD30214F0
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 06:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01275332EBC;
	Fri, 23 Jan 2026 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zgvEHHPy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gHQhmfuW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ToZZ/BfT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K6pbeq4M"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865732D44F
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151195; cv=none; b=sDLqe4cIPnK89gD/stJ3plT2owfTbIIrWLi9SL2BzZ1IjCftEifIHf67ZM9kSl8EAc8d5YY33h66mlRdMsZFKbeG9PPm/Rv+Q/SIZ2SWH7yXzI5n9ZTMlPV7g2+JPCt6IsT4qLhfIMCb3thduwIaBIoBsy5qYzqMedJRlUT7s7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151195; c=relaxed/simple;
	bh=E26E8yiAzndBAW9zw2+25zeYDnfroJjbXi/8QjcbhyQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sVmfV8kTjvEfudtkWPG+sByUvF9sCaVb425n5n4pnZatN00AGoC95IxbY2lT2XI6vpIfVD6QVNvAiZoiLIjsD51uLZ6nMg3j//XUV+k5hBQZmqpswnSsn9k0qu3S1pkpXykWAWHEWSluK6tHrIu7jm2gi6qJcNt8a3jLaQjzzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zgvEHHPy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gHQhmfuW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ToZZ/BfT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K6pbeq4M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3953C33768;
	Fri, 23 Jan 2026 06:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769151190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xHBC7+XIDKcDoXobVjIIeaJAGTBPlExl+xM4MpgZv40=;
	b=zgvEHHPy66Pe3rtCqtFAlD/T0SFtfIkyxHp/2jGbNuWivkgsODJS+GB3rTyJNdBQHar97c
	sVm/AXjAPZ5uQPERzlxQuVNOH7cVpTMu5hBAdgpBzT2vGeTkd+bMle170/98KuVYb/J+cW
	oDALmTnPKb+gF1t00DYBWfwm/XjlF6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769151190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xHBC7+XIDKcDoXobVjIIeaJAGTBPlExl+xM4MpgZv40=;
	b=gHQhmfuWotNYLJuejhYX3dxwwfRYJvYYMhnYv7Laye0/yDAzbmLXYqCYnjP4I1LEQZHmCG
	A1ZPbR8VaFf+GeCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769151189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xHBC7+XIDKcDoXobVjIIeaJAGTBPlExl+xM4MpgZv40=;
	b=ToZZ/BfTv62as/fot31mnxaZmixLhnkGocIYQRRAdYgnwsl7CsXu4WojwsA5SXTDgZ+Dz4
	m2EtAaA982iGbCPhmEdr+UvakVto6xCGIYXWgknW7KUguIi/6AOE+7QqOMrCbu7j36Tiqn
	1vNp+dBhgA5BoJk1Q/nawV2GLF4BLsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769151189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xHBC7+XIDKcDoXobVjIIeaJAGTBPlExl+xM4MpgZv40=;
	b=K6pbeq4MyJ0jv8OvZFU821QP3Qr9O0rFmSjHF2nLtGR8Lgx/18gnDuZZGw8wx0o2fvg3t4
	jn59EWj4p1ZIHjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06A8B1395E;
	Fri, 23 Jan 2026 06:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +aDbANUac2k4YgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Jan 2026 06:53:09 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 00/22] slab: replace cpu (partial) slabs with sheaves
Date: Fri, 23 Jan 2026 07:52:38 +0100
Message-Id: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYac2kC/2XOTQ7CIBCG4as0rMUMQ+mPK+9hXNApWJLGGlCiN
 r27tNGo6fIjed5hZMF4ZwLbZSPzJrrghnMa+SZj1OnzyXDXps0QUAkA5KEzOprA7eC57nteFZq
 EbCkvtWJJXbyx7r4UD8e0Oxeug38sB6KYX98tlKtWFBx4Ya1GqutcEOzDLZgtPdlcivjRBQix/
 knEpOsKUZFtFJD91/JXF2stk1aqVtQAQFniV0/T9AKIqE+lKAEAAA==
X-Change-ID: 20251002-sheaves-for-all-86ac13dc47a5
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
 stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: b4 0.14.3
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211341-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz,intel.com];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid,msgid.link:url]
X-Rspamd-Queue-Id: 0677471395
X-Rspamd-Action: no action

Percpu sheaves caching was introduced as opt-in but the goal was to
eventually move all caches to them. This is the next step, enabling
sheaves for all caches (except the two bootstrap ones) and then removing
the per cpu (partial) slabs and lots of associated code.

Besides (hopefully) improved performance, this removes the rather
complicated code related to the lockless fastpaths (using
this_cpu_try_cmpxchg128/64) and its complications with PREEMPT_RT or
kmalloc_nolock().

The lockless slab freelist+counters update operation using
try_cmpxchg128/64 remains and is crucial for freeing remote NUMA objects
without repeating the "alien" array flushing of SLUB, and to allow
flushing objects from sheaves to slabs mostly without the node
list_lock.

Sending this v4 because various changes accumulated in the branch due to
review and -next exposure (see the list below). Thanks for all the
reviews!

Git branch for the v4
  https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=sheaves-for-all-v4

Which is a snapshot of:
  https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/sheaves-for-all

Based on:
  https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-7.0/sheaves-base
  - includes a sheaves optimization that seemed minor but there was lkp
    test robot result with significant improvements:
    https://lore.kernel.org/all/202512291555.56ce2e53-lkp@intel.com/
    (could be an uncommon corner case workload though)
  - includes the kmalloc_nolock() fix commit a4ae75d1b6a2 that is undone
    as part of this series

Significant (but not critical) remaining TODOs:
- Integration of rcu sheaves handling with kfree_rcu batching.
  - Currently the kfree_rcu batching is almost completely bypassed. I'm
    thinking it could be adjusted to handle rcu sheaves in addition to
    individual objects, to get the best of both.
- Performance evaluation. Petr Tesarik has been doing that on the RFC
  with some promising results (thanks!) and also found a memory leak.

Note that as many things, this caching scheme change is a tradeoff, as
summarized by Christoph:

  https://lore.kernel.org/all/f7c33974-e520-387e-9e2f-1e523bfe1545@gentwo.org/

- Objects allocated from sheaves should have better temporal locality
  (likely recently freed, thus cache hot) but worse spatial locality
  (likely from many different slabs, increasing memory usage and
  possibly TLB pressure on kernel's direct map).

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes in v4:
- Fix up both missing and spurious r-b tags from v3, and add new ones
  (big thanks to Hao Li, Harry, and Suren!)
- Fix infinite recursion with kmemleak (Breno Leitao)
- Use cache_has_sheaves() in pcs_destroy() (Suren)
- Use cache_has_sheaves() in kvfree_rcu_barrier_on_cache() (Hao Li)
- Bypass sheaf for remote object free also in kfree_nolock() (Harry)
- WRITE_ONCE slab->counters in __update_freelist_slow() so
  get_partial_node_bulk() can stop being paranoid (Harry)
- Tweak conditions in alloc_from_new_slab() (Hao Li, Suren)
- Rename get_partial*() functions to get_from_partial*() (Suren)
- Rename variable freelist to object in ___slab_alloc() (Suren)
- Separate struct partial_bulk_context instead of extending.
- Rename flush_cpu_slab() to flush_cpu_sheaves() (Hao Li)
- Add "mm/slab: fix false lockdep warning in __kfree_rcu_sheaf()" from
  Harry.
- Add counting of FREE_SLOWPATH stat to some missing places (Suren, Hao
  Li)
- Link to v3: https://patch.msgid.link/20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz

Changes in v3:
- Rebase to current slab/for-7.0/sheaves which itself is rebased to
  slab/for-next-fixes to include commit a4ae75d1b6a2 ("slab: fix
  kmalloc_nolock() context check for PREEMPT_RT")
- Revert a4ae75d1b6a2 as part of "slab: simplify kmalloc_nolock()" as
  it's no longer necessary.
- Add cache_has_sheaves() helper to test for s->sheaf_capacity, use it
  in more places instead of s->cpu_sheaves tests that were missed
  (Hao Li)
- Fix a bug where kmalloc_nolock() could end up trying to allocate empty
  sheaf (not compatible with !allow_spin) in __pcs_replace_full_main()
  (Hao Li)
- Fix missing inc_slabs_node() in ___slab_alloc() ->
  alloc_from_new_slab() path. (Hao Li)
  - Also a bug where refill_objects() -> alloc_from_new_slab ->
    free_new_slab_nolock() (previously defer_deactivate_slab()) would
    do inc_slabs_node() without matching dec_slabs_node()
- Make __free_slab call free_frozen_pages_nolock() when !allow_spin.
  This was correct in the first RFC. (Hao Li)
- Add patch to make SLAB_CONSISTENCY_CHECKS prevent merging.
- Add tags from sveral people (thanks!)
- Fix checkpatch warnings.
- Link to v2: https://patch.msgid.link/20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz

Changes in v2:
- Rebased to v6.19-rc1+slab.git slab/for-7.0/sheaves
  - Some of the preliminary patches from the RFC went in there.
- Incorporate feedback/reports from many people (thanks!), including:
  - Make caches with sheaves mergeable.
  - Fix a major memory leak.
- Cleanup of stat items.
- Link to v1: https://patch.msgid.link/20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz

---
Harry Yoo (1):
      mm/slab: fix false lockdep warning in __kfree_rcu_sheaf()

Vlastimil Babka (21):
      mm/slab: add rcu_barrier() to kvfree_rcu_barrier_on_cache()
      slab: add SLAB_CONSISTENCY_CHECKS to SLAB_NEVER_MERGE
      mm/slab: move and refactor __kmem_cache_alias()
      mm/slab: make caches with sheaves mergeable
      slab: add sheaves to most caches
      slab: introduce percpu sheaves bootstrap
      slab: make percpu sheaves compatible with kmalloc_nolock()/kfree_nolock()
      slab: handle kmalloc sheaves bootstrap
      slab: add optimized sheaf refill from partial list
      slab: remove cpu (partial) slabs usage from allocation paths
      slab: remove SLUB_CPU_PARTIAL
      slab: remove the do_slab_free() fastpath
      slab: remove defer_deactivate_slab()
      slab: simplify kmalloc_nolock()
      slab: remove struct kmem_cache_cpu
      slab: remove unused PREEMPT_RT specific macros
      slab: refill sheaves from all nodes
      slab: update overview comments
      slab: remove frozen slab checks from __slab_free()
      mm/slub: remove DEACTIVATE_TO_* stat items
      mm/slub: cleanup and repurpose some stat items

 include/linux/slab.h |    6 -
 mm/Kconfig           |   11 -
 mm/internal.h        |    1 +
 mm/page_alloc.c      |    5 +
 mm/slab.h            |   65 +-
 mm/slab_common.c     |   61 +-
 mm/slub.c            | 2689 ++++++++++++++++++--------------------------------
 7 files changed, 1031 insertions(+), 1807 deletions(-)
---
base-commit: a66f9c0f1ba2dd05fa994c800ebc63f265155f91
change-id: 20251002-sheaves-for-all-86ac13dc47a5

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


