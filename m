Return-Path: <stable+bounces-237600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDfBBs0p3WmVaQkAu9opvQ
	(envelope-from <stable+bounces-237600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:37:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1D73F1911
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C40A30DD89E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14619279334;
	Mon, 13 Apr 2026 17:21:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3FF34A3C1
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100889; cv=none; b=oerNeD+cWZgoN5LYxZJf8nP+bNaEa5pmcdoMG1Ahnh2iVovx7QEsRVd+aZ0OmAGO+WXeRIzTxRD5J87aUplGFu7eHNXcw3wL0wDG/967tHwy1gtinUb67rYlDYqm54Y1eKAkgwvk4wTbJmlUuPKtNb/oiuxpFJmEc6W2QcuyzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100889; c=relaxed/simple;
	bh=kwNuVgc2pYMGXzRIMq6WWjvG/qlQVAlE4GhKUeChd/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYQgbn6M3dbCOn8+dFpvy2We5pH7nymBxQatiXzYAObiHWnmdQ9vHY+PP5Jt3MXfFFWPwoMocsSpNlS9JAmCkUn18EirD8+1APe6cp4soO5TzJXhe+8ZEYuyE/TN8DcmZIeNNIqtbVR5gB1wRGx6DwvTdW7Urz0Gl4P9RiR2H9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 49FB192009D; Mon, 13 Apr 2026 19:21:25 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: stable@vger.kernel.org
Cc: Stefan Wiehler <stefan.wiehler@nokia.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y v2 2/5] mips: mm: Allocate tlb_vpn array atomically
Date: Mon, 13 Apr 2026 18:21:20 +0100
Message-Id: <20260413172123.31717-2-macro@orcam.me.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260413172123.31717-1-macro@orcam.me.uk>
References: <20260413172123.31717-1-macro@orcam.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237600-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[franken.de:email,orcam.me.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia.com:email,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 6D1D73F1911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stefan Wiehler <stefan.wiehler@nokia.com>

commit 01cc50ea5167bb14117257ec084637abe9e5f691 upstream.

Found by DEBUG_ATOMIC_SLEEP:

  BUG: sleeping function called from invalid context at /include/linux/sched/mm.h:306
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
  preempt_count: 1, expected: 0
  RCU nest depth: 0, expected: 0
  no locks held by swapper/1/0.
  irq event stamp: 0
  hardirqs last  enabled at (0): [<0000000000000000>] 0x0
  hardirqs last disabled at (0): [<ffffffff801477fc>] copy_process+0x75c/0x1b68
  softirqs last  enabled at (0): [<ffffffff801477fc>] copy_process+0x75c/0x1b68
  softirqs last disabled at (0): [<0000000000000000>] 0x0
  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.119-d79e757675ec-fct #1
  Stack : 800000000290bad8 0000000000000000 0000000000000008 800000000290bae8
          800000000290bae8 800000000290bc78 0000000000000000 0000000000000000
          ffffffff80c80000 0000000000000001 ffffffff80d8dee8 ffffffff810d09c0
          784bb2a7ec10647d 0000000000000010 ffffffff80a6fd60 8000000001d8a9c0
          0000000000000000 0000000000000000 ffffffff80d90000 0000000000000000
          ffffffff80c9e0e8 0000000007ffffff 0000000000000cc0 0000000000000400
          ffffffffffffffff 0000000000000001 0000000000000002 ffffffffc0149ed8
          fffffffffffffffe 8000000002908000 800000000290bae0 ffffffff80a81b74
          ffffffff80129fb0 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 0000000000000000 ffffffff80129fd0 0000000000000000
          ...
  Call Trace:
  [<ffffffff80129fd0>] show_stack+0x60/0x158
  [<ffffffff80a7f894>] dump_stack_lvl+0x88/0xbc
  [<ffffffff8018d3c8>] __might_resched+0x268/0x288
  [<ffffffff803648b0>] __kmem_cache_alloc_node+0x2e0/0x330
  [<ffffffff80302788>] __kmalloc+0x58/0xd0
  [<ffffffff80a81b74>] r4k_tlb_uniquify+0x7c/0x428
  [<ffffffff80143e8c>] tlb_init+0x7c/0x110
  [<ffffffff8012bdb4>] per_cpu_trap_init+0x16c/0x1d0
  [<ffffffff80133258>] start_secondary+0x28/0x128

Fixes: 231ac951faba ("MIPS: mm: kmalloc tlb_vpn array to avoid stack overflow")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/mm/tlb-r4k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 8bc98c311ca6..3aef6acd57bd 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -528,7 +528,7 @@ static void __ref r4k_tlb_uniquify(void)
 
 	tlb_vpn_size = tlbsize * sizeof(*tlb_vpns);
 	tlb_vpns = (use_slab ?
-		    kmalloc(tlb_vpn_size, GFP_KERNEL) :
+		    kmalloc(tlb_vpn_size, GFP_ATOMIC) :
 		    memblock_alloc_raw(tlb_vpn_size, sizeof(*tlb_vpns)));
 	if (WARN_ON(!tlb_vpns))
 		return; /* Pray local_flush_tlb_all() is good enough. */
-- 
2.20.1


