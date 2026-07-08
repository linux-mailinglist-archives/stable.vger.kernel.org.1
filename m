Return-Path: <stable+bounces-272542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vl9mNFzOTWqY+QEAu9opvQ
	(envelope-from <stable+bounces-272542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 06:13:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 589097218D6
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 06:13:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=UCEZEhKb;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272542-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272542-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C56F5300D366
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 04:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911D337A843;
	Wed,  8 Jul 2026 04:13:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8CB282F22
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 04:13:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483994; cv=none; b=OzYYe4uDI4JArgJFgwFiuKQwtTBpO5bQZLOvFJpfUJIZl51UFITJsbn5qWpRWT0Jy02BZJTknFz5QMGyqJL0zHtOBRyAaNgHcyWG1vqF8Te8a+14qRWE8CWb7glBJM5Vfc/VmYm6a9RCYARUfUA95o99m134Ue3TKo8xp7IGnY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483994; c=relaxed/simple;
	bh=BY43jJdoDHic7q32e8pfnv+cyvyGa/sRjfjMh0rHVCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrU37KtMHEEFmnkCDWnSzAAi43DutMPaYt+iF6atADCfT5jN5jH9w5lSEpvwBo8qkJ6984gdgG17tNE2falZtNWIKFFMAMYT5EnDPJGhem0e5a/U4LAdWxq3MIgOLSUC4Yp+SvyTvCkOZxAKJ2h/mhDsS4gsvCGRD+czsFj3joA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UCEZEhKb; arc=none smtp.client-ip=91.218.175.188
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783483980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JgCF/d1GzpHoQKC1qhkhHRFZUTixiHjHsF4UG1qii78=;
	b=UCEZEhKbX1dlK8CTrdLBo+EbszDWU9fQk1ecn+HXPsx6OtoBHPR+eExQ7BoZfUFlrQ65KK
	MMLe9Daz2f5ZX/BppB246vI1n8S9CcG6HjYg7nlKm4VopaL2mOFEN9hyOW4AczVNFUdC+T
	V3fd0oNUO6yYwI4YFXwkYVexyT6CvhM=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: stable@vger.kernel.org,
	linux-mm@kvack.org
Cc: jiayuan.chen@shopee.com,
	jiayuan.chen@linux.dev,
	yingfu.zhou@shopee.com,
	willy@infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y 6.1.y 6.6.y 0/1] mm/vmscan: flush deferred TLB before freeing large folios in reclaim
Date: Wed,  8 Jul 2026 12:12:35 +0800
Message-ID: <20260708041237.289026-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272542-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-mm@kvack.org,m:jiayuan.chen@shopee.com,m:jiayuan.chen@linux.dev,m:yingfu.zhou@shopee.com,m:willy@infradead.org,m:akpm@linux-foundation.org,m:ying.huang@intel.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 589097218D6

Hi,

We were chasing random user-space segfaults on our production kernels.
They were fully non-deterministic, and the fault address reported for each
SIGSEGV was itself random and had nothing to do with the code that was
actually running -- which smells like a stale TLB entry, not corrupted
data.

We managed to reproduce it with stress-ng: under memory pressure the
workers take random SIGSEGV/SIGILL too, again at random fault addresses.

It turns out we're missing a TLB flush. In reclaim, shrink_folio_list()
tears down the PTEs with a deferred, batched flush. Order-0 folios are
collected and only freed after that batch is flushed by
try_to_unmap_flush(). Large folios, though, are freed right away at the
free_it label via destroy_large_folio(), which runs *before* the flush. So
a large folio's pages can go back to the allocator and get reused while
some other CPU still has a stale TLB entry pointing at them -- and that CPU
then reads or executes through the old translation into a page that now
belongs to someone else. When it's executable text mapped as a large
folio, the CPU literally fetches instructions out of a reused page, which
is where the random crashes come from. (This is about file-backed large
folios, not anonymous THP, so transparent_hugepage=never doesn't help.)

How we reproduce it:
- Make a cgroup and set memory.high.
- Run ~45 stress-ng workers in it (e.g. --cpu N --cpu-method all).
- Alongside, run a tiny program that keeps allocating anonymous memory to
  push the cgroup over memory.high and keep reclaim busy.
Dropping caches first (echo 3 > /proc/sys/vm/drop_caches) makes the text
refault as large folios and reproduces it much faster.

To be 100% sure about the mechanism, we filled every reclaimed large folio
with 0xCC (INT3) and held onto it instead of freeing it. Under the repro,
stress-ng workers immediately hit INT3 at instruction pointers inside their
own text -- i.e. CPUs were fetching instructions through stale TLB entries
from freed, poisoned pages. stress-ng has no INT3 in its binary, so the
only way to execute one is through a stale translation into a freed page.
Several CPUs hit it within the same microsecond, which lines up nicely with
a single batched unmap whose flush was skipped on more than one CPU.

Upstream this got fixed as a side effect of
commit bc2ff4cbc329 ("mm: free folios in a batch in shrink_folio_list()")
which sends large folios down the same flush-before-free batch path.

The patch below is the minimal fix: just flush the deferred batch before
freeing a large folio inline.

Jiayuan Chen (1):
  mm/vmscan: flush deferred TLB before freeing large folios

 mm/vmscan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.43.0


