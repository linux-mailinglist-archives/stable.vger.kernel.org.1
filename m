Return-Path: <stable+bounces-212887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGJAOjDEfGmgOgIAu9opvQ
	(envelope-from <stable+bounces-212887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 15:46:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0C2BBB66
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 15:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B59AC30086E3
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052B18FDBE;
	Fri, 30 Jan 2026 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0fkowIi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562B487BE
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784361; cv=none; b=Y1N4m/zWFyIEdg2Nm0StXRDwi42INAy69K9mos6eW9FG4vy/fcAxv+Fv4CCc3lQxmF9eSFJ+3uNVtCIsRbmo0/6lclpmHXrjEp11Ao3mOEYZ8sU7gzK3d+3UrDgPcdAqKZwCl7+Vvw3KH0YRjuiLBcsNK7YCQoXTWG0ie1llyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784361; c=relaxed/simple;
	bh=15Hl+K7cKkodTSwPvhoZK9Gww0RwmQIdjPmcrj08khs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IEyX1BqNtwvJHeaNo5XpwY4IofBZ6j09YorepTRlgeM4LeE4BoGgJXngKC7+knvlzSTZfaCEYfr/6pHoPG6FF/dWeMucu+4tAEihzlOuFSBToYl2034Hpf/qvBiW0o3dg48rY7T9mUAOORzTJzeXNT9ghMc+/JFh0ly2CCm/ogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0fkowIi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769784360; x=1801320360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=15Hl+K7cKkodTSwPvhoZK9Gww0RwmQIdjPmcrj08khs=;
  b=O0fkowIiOLzysmm1Vos6EacA2gn2W0zDL54lIFnawwn+sPNyrI72AMGP
   4BrPB5bUFZq8angbAOdzhjsKgq2lIoWatgLY/KHABUzCcAQETSv93A3iS
   xyrbzfp56MzKSVDfcxgomu5t/R5l3Wte2Sp6VzpJLm0DYYFH+TSH4MCub
   txLagF1Vk7cVSJoqFPXV4QiSFGK3qqonLMVwudhbkLDS3D2EJ18mSPDT6
   s+eWa8AeZU7ir0UD8rpr/NRT/eU8mt5r6uzzQSa/jdIn5IBlKAT4cUSQ5
   5Ko8XtUnrhTVK1YkcMOf1AyBWfUZjxW0ztLKvavaTLRdrZEVQjsE84Jzv
   g==;
X-CSE-ConnectionGUID: TTBzQnN1R9eslQhpav1yPQ==
X-CSE-MsgGUID: q+k2voF5SsizU27/wubwJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="96495807"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="96495807"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 06:45:59 -0800
X-CSE-ConnectionGUID: XMz+iAomQ36BwmT6wZEAQw==
X-CSE-MsgGUID: dqWyryrwSxaMxaCisrfI1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="209224967"
Received: from rvuia-mobl.ger.corp.intel.com (HELO fedora) ([10.245.244.13])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 06:45:56 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Brost <matthew.brost@intel.com>,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] mm/hmm: Fix a hmm_range_fault() livelock / starvation problem
Date: Fri, 30 Jan 2026 15:45:29 +0100
Message-ID: <20260130144529.79909-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-212887-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: 6B0C2BBB66
X-Rspamd-Action: no action

If hmm_range_fault() fails a folio_trylock() in do_swap_page,
trying to acquire the lock of a device-private folio for migration,
to ram, the function will spin until it succeeds grabbing the lock.

However, if the process holding the lock is depending on a work
item to be completed, which is scheduled on the same CPU as the
spinning hmm_range_fault(), that work item might be starved and
we end up in a livelock / starvation situation which is never
resolved.

This can happen, for example if the process holding the
device-private folio lock is stuck in
   migrate_device_unmap()->lru_add_drain_all()
The lru_add_drain_all() function requires a short work-item
to be run on all online cpus to complete.

A prerequisite for this to happen is:
a) Both zone device and system memory folios are considered in
   migrate_device_unmap(), so that there is a reason to call
   lru_add_drain_all() for a system memory folio while a
   folio lock is held on a zone device folio.
b) The zone device folio has an initial mapcount > 1 which causes
   at least one migration PTE entry insertion to be deferred to
   try_to_migrate(), which can happen after the call to
   lru_add_drain_all().
c) No or voluntary only preemption.

This all seems pretty unlikely to happen, but indeed is hit by
the "xe_exec_system_allocator" igt test.

Resolve this using a cond_resched() after each iteration in
hmm_range_fault(). Future code improvements might consider moving
the lru_add_drain_all() call in migrate_device_unmap() out of the
folio locked region.

Also, hmm_range_fault() can be a very long-running function
so a cond_resched() at the end of each iteration can be
motivated even in the absence of an -EBUSY.

Fixes: d28c2c9a4877 ("mm/hmm: make full use of walk_page_range()")
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: linux-mm@kvack.org
Cc: <stable@vger.kernel.org> # v5.5+
Cc: <dri-devel@lists.freedesktop.org>
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 mm/hmm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hmm.c b/mm/hmm.c
index 4ec74c18bef6..160c9e4e5a92 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -674,6 +674,13 @@ int hmm_range_fault(struct hmm_range *range)
 			return -EBUSY;
 		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
 				      &hmm_walk_ops, &hmm_vma_walk);
+		/*
+		 * Conditionally reschedule to let other work items get
+		 * a chance to unlock device-private pages whose locks
+		 * we're spinning on.
+		 */
+		cond_resched();
+
 		/*
 		 * When -EBUSY is returned the loop restarts with
 		 * hmm_vma_walk.last set to an address that has not been stored
-- 
2.52.0


