Return-Path: <stable+bounces-237597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OlIFfgm3WlpaQkAu9opvQ
	(envelope-from <stable+bounces-237597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:25:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C962D3F1595
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D474E3058BBF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC0A34B693;
	Mon, 13 Apr 2026 17:20:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D444E347508
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100834; cv=none; b=R1bVnae1kuvevFUV1m1lIyH4yGq2DrQJrDnkj/vapvMIOcgCp0WIZLPHBTFOY52rI4Dmi3YiEOutmt2g04JCk5o5gUGBrRfFXJbn61wz6PZxN6pG8wXP9hXtoA+NybgFS7xfzhPHZ+3i+GRI/1dbkgyPwF9kH8Bn8W8JHPHJPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100834; c=relaxed/simple;
	bh=EC6MzfkL9NCVAv4Rji7kgc09UrnTZlFoS505kP0pE+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=je673sooe4iihMte1SJjVDcLKFUSUTTMJq1VJ3VRo1t0M0+7uMPe0jY0PXxuN4g4mFdKADEH3HLPT4FwLv6+l3+0EklTFzwy+RK9AI7pvtH4k8VqTyBjNiF8yVYDejzXYwWM8gm/oWjd7baVodOGQm4NnSdcF1Ickyf6M74KqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 81FE992009E; Mon, 13 Apr 2026 19:20:29 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: stable@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH 5.15.y v2 1/5] MIPS: mm: kmalloc tlb_vpn array to avoid stack overflow
Date: Mon, 13 Apr 2026 18:20:00 +0100
Message-Id: <20260413172004.31485-1-macro@orcam.me.uk>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237597-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[alpha.franken.de,orcam.me.uk,bootlin.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.799];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,franken.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,orcam.me.uk:email,orcam.me.uk:mid]
X-Rspamd-Queue-Id: C962D3F1595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

commit 841ecc979b18d3227fad5e2d6a1e6f92688776b5 upstream.

Owing to Config4.MMUSizeExt and VTLB/FTLB MMU features later MIPSr2+
cores can have more than 64 TLB entries.  Therefore allocate an array
for uniquification instead of placing too an small array on the stack.

Fixes: 35ad7e181541 ("MIPS: mm: tlb-r4k: Uniquify TLB entries on init")
Co-developed-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v6.17+: 9f048fa48740: MIPS: mm: Prevent a TLB shutdown on initial uniquification
Cc: stable@vger.kernel.org # v6.17+
Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Tested-by: Klara Modin <klarasmodin@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
[ Use memblock_free_ptr() for 5.15.y. ]
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 arch/mips/mm/tlb-r4k.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index d9a5ede8869b..78e1420471b4 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/export.h>
@@ -512,17 +513,26 @@ static int r4k_vpn_cmp(const void *a, const void *b)
  * Initialise all TLB entries with unique values that do not clash with
  * what we have been handed over and what we'll be using ourselves.
  */
-static void r4k_tlb_uniquify(void)
+static void __ref r4k_tlb_uniquify(void)
 {
-	unsigned long tlb_vpns[1 << MIPS_CONF1_TLBS_SIZE];
 	int tlbsize = current_cpu_data.tlbsize;
+	bool use_slab = slab_is_available();
 	int start = num_wired_entries();
+	phys_addr_t tlb_vpn_size;
+	unsigned long *tlb_vpns;
 	unsigned long vpn_mask;
 	int cnt, ent, idx, i;
 
 	vpn_mask = GENMASK(cpu_vmbits - 1, 13);
 	vpn_mask |= IS_ENABLED(CONFIG_64BIT) ? 3ULL << 62 : 1 << 31;
 
+	tlb_vpn_size = tlbsize * sizeof(*tlb_vpns);
+	tlb_vpns = (use_slab ?
+		    kmalloc(tlb_vpn_size, GFP_KERNEL) :
+		    memblock_alloc_raw(tlb_vpn_size, sizeof(*tlb_vpns)));
+	if (WARN_ON(!tlb_vpns))
+		return; /* Pray local_flush_tlb_all() is good enough. */
+
 	htw_stop();
 
 	for (i = start, cnt = 0; i < tlbsize; i++, cnt++) {
@@ -575,6 +585,10 @@ static void r4k_tlb_uniquify(void)
 	tlbw_use_hazard();
 	htw_start();
 	flush_micro_tlb();
+	if (use_slab)
+		kfree(tlb_vpns);
+	else
+		memblock_free_ptr(tlb_vpns, tlb_vpn_size);
 }
 
 /*
-- 
2.20.1


