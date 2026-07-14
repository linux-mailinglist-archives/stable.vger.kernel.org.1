Return-Path: <stable+bounces-274048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tuJVEu2MVWrXpwAAu9opvQ
	(envelope-from <stable+bounces-274048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:12:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F4674FFE2
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:12:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=kBw4nZz+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274048-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274048-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F043C3020BCE
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6435235CB6F;
	Tue, 14 Jul 2026 01:11:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C235AC37;
	Tue, 14 Jul 2026 01:11:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991500; cv=none; b=mc/sc73MT5791e4gdEdvcIuhlPM/JDzrvNnGWB+GvHh5K9B25789WLEtdq84PX81+oA16ZOq1H4LvavXVgT0LfUoFHU+zYPk5LvWM0dcy0dbn9DELSqSW4G4HE1iiDWf0k0xMcjHW3t45NBXny2BQYL8hpz9IuD5pL3udav8bVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991500; c=relaxed/simple;
	bh=vYbHs9pltJAf9fQekJyJFrJwYGZJwbzoYkT7ZVAvPLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI9fmT7b5+oXLjpum5aWb53tS169P9gltgT0oylrDsBXyJLrLkphV1Ly+0jY1TrP6qwbbzIym+CIm8Visp/NYQO6ebvv4FItHpKHUtYp4VwjsciigzcX+oXu0PghCOwJ6M3E5Kdicz3unNTWqkWLTH79ccr6p0lfKK8zjiF3PQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBw4nZz+; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783991499; x=1815527499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vYbHs9pltJAf9fQekJyJFrJwYGZJwbzoYkT7ZVAvPLg=;
  b=kBw4nZz+JrF2rly2xxHFCsGZelNv01P8loqXi5koWCpPOAqsa+DP5Wxw
   v/HPapCQ2fHYc1kRgROVxIu71GEClTHs+NWG3/oLsB7vo/QQpp69dGJ5o
   j+0R5OGX6rFbuUbW1DXe7yN0eQ883nF3yQbESaBEleFYG4HTX03VqIewj
   B583b2kk/F6oFTl4RWBZSR3QMIXG4TsfswYvJMvyNMOYA6dmrCoE7VNK5
   C9AoUUVxPEzeDVG/EqDgrvoqpCYu8vyti06qt3yUb+t4SiQDDM0Ud1pLR
   twyTXPaeSuu+gBRd4Xg/M12wUhvQO2QDMtgzSmx2msrLd2N73jfDq23ny
   w==;
X-CSE-ConnectionGUID: 0oOjMIstRUmojOpXqPg5TQ==
X-CSE-MsgGUID: pqYnmIIdSTyoaXrWAMQHUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84702153"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84702153"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:11:38 -0700
X-CSE-ConnectionGUID: KLNRoagGSHGCfDleXv+TiQ==
X-CSE-MsgGUID: n+yv9uzrRqiCr5v5QaZ84Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252318610"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:11:37 -0700
Date: Mon, 13 Jul 2026 18:11:37 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.18.y 1/6] bpf: Support for hardening against JIT spraying
Message-ID: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-1-755f60c55705@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274048-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pawan.kumar.gupta@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:linux-riscv@lists.infradead.org,m:x86@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:from_mime,linux.intel.com:mid,vger.kernel.org:from_smtp,intel.com:email,intel.com:dkim,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0F4674FFE2

commit 96cce16e26dd02a8678f1e87f88a4b5cdb63b995 upstream.

The BPF JIT allocator packs many small programs into larger executable
allocations and reuses space within those allocations as programs are
loaded and freed. When fresh code is written into space that a previous
program occupied, an indirect jump into the new program can reuse a branch
prediction left behind by the old one.

Flush the indirect branch predictors before reusing JIT memory so that
indirect jumps into a newly written program don't reuse predictions from an
old program that occupied the same space.

Introduce bpf_arch_pred_flush_enabled static key and bpf_arch_pred_flush
static call for flushing the branch predictors on JIT memory reuse.
Architectures that need a flush, can update it to a predictor flush
function. By default, its a NOP and does not emit any CALL.

Allocations larger than a pack are not covered by this flush. That is safe
because cBPF programs (the unprivileged attack surface) are bounded well
below a pack size. Issue a warning if this assumption is ever violated
while the flush is active.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/filter.h | 10 ++++++++++
 kernel/bpf/core.c      | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index cf7a0bce1bb6..3c4dd718bece 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
 #include <crypto/sha1.h>
+#include <linux/static_call.h>
 #include <linux/u64_stats_sync.h>
 
 #include <net/sch_generic.h>
@@ -1266,6 +1267,15 @@ extern long bpf_jit_limit_max;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
+/*
+ * Flush the indirect branch predictors before reusing JIT memory, so that
+ * indirect jumps into a newly written program don't reuse predictions left
+ * behind by an old program that occupied the same space.
+ */
+void bpf_arch_pred_flush(void);
+DECLARE_STATIC_CALL(bpf_arch_pred_flush, bpf_arch_pred_flush);
+DECLARE_STATIC_KEY_FALSE(bpf_pred_flush_enabled);
+
 void bpf_jit_fill_hole_with_zero(void *area, unsigned int size);
 
 struct bpf_binary_header *
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 931a4ddd8530..a043fccb917e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -21,6 +21,7 @@
 #include <crypto/sha1.h>
 #include <linux/filter.h>
 #include <linux/skbuff.h>
+#include <linux/static_call.h>
 #include <linux/vmalloc.h>
 #include <linux/prandom.h>
 #include <linux/bpf.h>
@@ -864,6 +865,15 @@ void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
 	memset(area, 0, size);
 }
 
+DEFINE_STATIC_CALL_NULL(bpf_arch_pred_flush, bpf_arch_pred_flush);
+
+/*
+ * Enabled once bpf_arch_pred_flush points at a real flush routine. Lets the
+ * pack allocator test "is a predictor flush wired up at all" with a cheap
+ * static branch instead of repeatedly querying the static call target.
+ */
+DEFINE_STATIC_KEY_FALSE(bpf_pred_flush_enabled);
+
 #define BPF_PROG_SIZE_TO_NBITS(size)	(round_up(size, BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)
 
 static DEFINE_MUTEX(pack_mutex);
@@ -923,6 +933,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 
 	mutex_lock(&pack_mutex);
 	if (size > BPF_PROG_PACK_SIZE) {
+		/*
+		 * Allocations larger than a pack get their own pages, and
+		 * predictors are not flushed for such allocation. This is only
+		 * safe because cBPF programs (the unprivileged attack surface)
+		 * are bounded well below a pack size.
+		 */
+		if (static_branch_unlikely(&bpf_pred_flush_enabled))
+			pr_warn_once("BPF: Predictors not flushed for allocations greater than BPF_PROG_PACK_SIZE\n");
 		size = round_up(size, PAGE_SIZE);
 		ptr = bpf_jit_alloc_exec(size);
 		if (ptr) {
@@ -953,6 +971,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	pos = 0;
 
 found_free_area:
+	static_call_cond(bpf_arch_pred_flush)();
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 

-- 
2.43.0



