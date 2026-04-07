Return-Path: <stable+bounces-233633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI+oCtAb1Wli0wcAu9opvQ
	(envelope-from <stable+bounces-233633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:59:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2821B3B082D
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E07B03017F35
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256DF33D4F3;
	Tue,  7 Apr 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="it+/TRYU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C024AEE2
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573855; cv=none; b=eYemadqwnDSPeshfZUA1N8OCdcWJkUbmHvSrziIcEVApCh67bF9x9BcT/GjEVBjXsrDrgvBEga8MxnV/JZF48bMPw1i+IuzEe2nxhxNR24sfqW2vlLgbA8eSAlLk1NM017b66vx0Njuyl5QLOl8iMBvQ8T9CH8R1HjTOiPD3wGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573855; c=relaxed/simple;
	bh=HcAUcmlkLv5s8qGvsZzHA2e2N6RVT6tBvvNUxYbSYog=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kBNgCLxnyUgu7I6jpZyOi3BXuY6bumUFJ42huHT47Y8XskmFPJEbb/GD+Kc3Kdpf365A8kmnI3oXzsXkq+iGv443jK249wSK5wkQ+oSDuU/3tJx/+I9f9xhfHnsudAFJeSS4Cb0As9p/j0pfBWQVyf/Vzrs1LSWwi2pzM0jZs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=it+/TRYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD89C116C6;
	Tue,  7 Apr 2026 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775573855;
	bh=HcAUcmlkLv5s8qGvsZzHA2e2N6RVT6tBvvNUxYbSYog=;
	h=Subject:To:Cc:From:Date:From;
	b=it+/TRYUJHd7AXyOV5mFPeC0gamClHGS6yVQPcqkHRuNEqKAJhyDxCEGKgbCiDX3v
	 Y0ZaMCvD5Z/fehNeGdzwzJy0Mtdq250sEBANS8H1MpLUk02vieBekhgCFhNKOD4QBY
	 /HSGO/OO1O5w+U3ItRc2DuB2r3jFKiWrhuBa/17I=
Subject: FAILED: patch "[PATCH] MIPS: mm: Rewrite TLB uniquification for the hidden bit" failed to apply to 6.1-stable tree
To: macro@orcam.me.uk,tsbogend@alpha.franken.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 16:57:31 +0200
Message-ID: <2026040731-snowbound-selected-e9db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233633-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ea.global:url,franken.de:email,linuxfoundation.org:dkim,gregkh:email,eb.global:url,orcam.me.uk:email]
X-Rspamd-Queue-Id: 2821B3B082D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 540760b77b8fc49d39d1b2b76196e5ec57711a32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040731-snowbound-selected-e9db@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 540760b77b8fc49d39d1b2b76196e5ec57711a32 Mon Sep 17 00:00:00 2001
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Date: Fri, 27 Mar 2026 18:57:30 +0000
Subject: [PATCH] MIPS: mm: Rewrite TLB uniquification for the hidden bit
 feature

Before the introduction of the EHINV feature, which lets software mark
TLB entries invalid, certain older implementations of the MIPS ISA were
equipped with an analogous bit, as a vendor extension, which however is
hidden from software and only ever set at reset, and then any software
write clears it, making the intended TLB entry valid.

This feature makes it unsafe to read a TLB entry with TLBR, modify the
page mask, and write the entry back with TLBWI, because this operation
will implicitly clear the hidden bit and this may create a duplicate
entry, as with the presence of the hidden bit there is no guarantee all
the entries across the TLB are unique each.

Usually the firmware has already uniquified TLB entries before handing
control over, in which case we only need to guarantee at bootstrap no
clash will happen with the VPN2 values chosen in local_flush_tlb_all().

However with systems such as Mikrotik RB532 we get handed the TLB as at
reset, with the hidden bit set across the entries and possibly duplicate
entries present.  This then causes a machine check exception when page
sizes are reset in r4k_tlb_uniquify() and prevents the system from
booting.

Rewrite the algorithm used in r4k_tlb_uniquify() then such as to avoid
the reuse of ASID/VPN values across the TLB.  Get rid of global entries
first as they may be blocking the entire address space, e.g. 16 256MiB
pages will exhaust the whole address space of a 32-bit CPU and a single
big page can exhaust the 32-bit compatibility space on a 64-bit CPU.

Details of the algorithm chosen are given across the code itself.

Fixes: 9f048fa48740 ("MIPS: mm: Prevent a TLB shutdown on initial uniquification")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 27bb64469604..08c3e65bf0f2 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/memblock.h>
+#include <linux/minmax.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/export.h>
@@ -24,6 +25,7 @@
 #include <asm/hazards.h>
 #include <asm/mmu_context.h>
 #include <asm/tlb.h>
+#include <asm/tlbdebug.h>
 #include <asm/tlbex.h>
 #include <asm/tlbmisc.h>
 #include <asm/setup.h>
@@ -511,12 +513,229 @@ static int __init set_ntlb(char *str)
 __setup("ntlb=", set_ntlb);
 
 
-/* Comparison function for EntryHi VPN fields.  */
-static int r4k_vpn_cmp(const void *a, const void *b)
+/* The start bit position of VPN2 and Mask in EntryHi/PageMask registers.  */
+#define VPN2_SHIFT 13
+
+/* Read full EntryHi even with CONFIG_32BIT.  */
+static inline unsigned long long read_c0_entryhi_native(void)
 {
-	long v = *(unsigned long *)a - *(unsigned long *)b;
-	int s = sizeof(long) > sizeof(int) ? sizeof(long) * 8 - 1: 0;
-	return s ? (v != 0) | v >> s : v;
+	return cpu_has_64bits ? read_c0_entryhi_64() : read_c0_entryhi();
+}
+
+/* Write full EntryHi even with CONFIG_32BIT.  */
+static inline void write_c0_entryhi_native(unsigned long long v)
+{
+	if (cpu_has_64bits)
+		write_c0_entryhi_64(v);
+	else
+		write_c0_entryhi(v);
+}
+
+/* TLB entry state for uniquification.  */
+struct tlbent {
+	unsigned long long wired:1;
+	unsigned long long global:1;
+	unsigned long long asid:10;
+	unsigned long long vpn:51;
+	unsigned long long pagesz:5;
+	unsigned long long index:14;
+};
+
+/*
+ * Comparison function for TLB entry sorting.  Place wired entries first,
+ * then global entries, then order by the increasing VPN/ASID and the
+ * decreasing page size.  This lets us avoid clashes with wired entries
+ * easily and get entries for larger pages out of the way first.
+ *
+ * We could group bits so as to reduce the number of comparisons, but this
+ * is seldom executed and not performance-critical, so prefer legibility.
+ */
+static int r4k_entry_cmp(const void *a, const void *b)
+{
+	struct tlbent ea = *(struct tlbent *)a, eb = *(struct tlbent *)b;
+
+	if (ea.wired > eb.wired)
+		return -1;
+	else if (ea.wired < eb.wired)
+		return 1;
+	else if (ea.global > eb.global)
+		return -1;
+	else if (ea.global < eb.global)
+		return 1;
+	else if (ea.vpn < eb.vpn)
+		return -1;
+	else if (ea.vpn > eb.vpn)
+		return 1;
+	else if (ea.asid < eb.asid)
+		return -1;
+	else if (ea.asid > eb.asid)
+		return 1;
+	else if (ea.pagesz > eb.pagesz)
+		return -1;
+	else if (ea.pagesz < eb.pagesz)
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * Fetch all the TLB entries.  Mask individual VPN values retrieved with
+ * the corresponding page mask and ignoring any 1KiB extension as we'll
+ * be using 4KiB pages for uniquification.
+ */
+static void __ref r4k_tlb_uniquify_read(struct tlbent *tlb_vpns, int tlbsize)
+{
+	int start = num_wired_entries();
+	unsigned long long vpn_mask;
+	bool global;
+	int i;
+
+	vpn_mask = GENMASK(current_cpu_data.vmbits - 1, VPN2_SHIFT);
+	vpn_mask |= cpu_has_64bits ? 3ULL << 62 : 1 << 31;
+
+	for (i = 0; i < tlbsize; i++) {
+		unsigned long long entryhi, vpn, mask, asid;
+		unsigned int pagesz;
+
+		write_c0_index(i);
+		mtc0_tlbr_hazard();
+		tlb_read();
+		tlb_read_hazard();
+
+		global = !!(read_c0_entrylo0() & ENTRYLO_G);
+		entryhi = read_c0_entryhi_native();
+		mask = read_c0_pagemask();
+
+		asid = entryhi & cpu_asid_mask(&current_cpu_data);
+		vpn = (entryhi & vpn_mask & ~mask) >> VPN2_SHIFT;
+		pagesz = ilog2((mask >> VPN2_SHIFT) + 1);
+
+		tlb_vpns[i].global = global;
+		tlb_vpns[i].asid = global ? 0 : asid;
+		tlb_vpns[i].vpn = vpn;
+		tlb_vpns[i].pagesz = pagesz;
+		tlb_vpns[i].wired = i < start;
+		tlb_vpns[i].index = i;
+	}
+}
+
+/*
+ * Write unique values to all but the wired TLB entries each, using
+ * the 4KiB page size.  This size might not be supported with R6, but
+ * EHINV is mandatory for R6, so we won't ever be called in that case.
+ *
+ * A sorted table is supplied with any wired entries at the beginning,
+ * followed by any global entries, and then finally regular entries.
+ * We start at the VPN and ASID values of zero and only assign user
+ * addresses, therefore guaranteeing no clash with addresses produced
+ * by UNIQUE_ENTRYHI.  We avoid any VPN values used by wired or global
+ * entries, by increasing the VPN value beyond the span of such entry.
+ *
+ * When a VPN/ASID clash is found with a regular entry we increment the
+ * ASID instead until no VPN/ASID clash has been found or the ASID space
+ * has been exhausted, in which case we increase the VPN value beyond
+ * the span of the largest clashing entry.
+ *
+ * We do not need to be concerned about FTLB or MMID configurations as
+ * those are required to implement the EHINV feature.
+ */
+static void __ref r4k_tlb_uniquify_write(struct tlbent *tlb_vpns, int tlbsize)
+{
+	unsigned long long asid, vpn, vpn_size, pagesz;
+	int widx, gidx, idx, sidx, lidx, i;
+
+	vpn_size = 1ULL << (current_cpu_data.vmbits - VPN2_SHIFT);
+	pagesz = ilog2((PM_4K >> VPN2_SHIFT) + 1);
+
+	write_c0_pagemask(PM_4K);
+	write_c0_entrylo0(0);
+	write_c0_entrylo1(0);
+
+	asid = 0;
+	vpn = 0;
+	widx = 0;
+	gidx = 0;
+	for (sidx = 0; sidx < tlbsize && tlb_vpns[sidx].wired; sidx++)
+		;
+	for (lidx = sidx; lidx < tlbsize && tlb_vpns[lidx].global; lidx++)
+		;
+	idx = gidx = sidx + 1;
+	for (i = sidx; i < tlbsize; i++) {
+		unsigned long long entryhi, vpn_pagesz = 0;
+
+		while (1) {
+			if (WARN_ON(vpn >= vpn_size)) {
+				dump_tlb_all();
+				/* Pray local_flush_tlb_all() will cope.  */
+				return;
+			}
+
+			/* VPN must be below the next wired entry.  */
+			if (widx < sidx && vpn >= tlb_vpns[widx].vpn) {
+				vpn = max(vpn,
+					  (tlb_vpns[widx].vpn +
+					   (1ULL << tlb_vpns[widx].pagesz)));
+				asid = 0;
+				widx++;
+				continue;
+			}
+			/* VPN must be below the next global entry.  */
+			if (gidx < lidx && vpn >= tlb_vpns[gidx].vpn) {
+				vpn = max(vpn,
+					  (tlb_vpns[gidx].vpn +
+					   (1ULL << tlb_vpns[gidx].pagesz)));
+				asid = 0;
+				gidx++;
+				continue;
+			}
+			/* Try to find a free ASID so as to conserve VPNs.  */
+			if (idx < tlbsize && vpn == tlb_vpns[idx].vpn &&
+			    asid == tlb_vpns[idx].asid) {
+				unsigned long long idx_pagesz;
+
+				idx_pagesz = tlb_vpns[idx].pagesz;
+				vpn_pagesz = max(vpn_pagesz, idx_pagesz);
+				do
+					idx++;
+				while (idx < tlbsize &&
+				       vpn == tlb_vpns[idx].vpn &&
+				       asid == tlb_vpns[idx].asid);
+				asid++;
+				if (asid > cpu_asid_mask(&current_cpu_data)) {
+					vpn += vpn_pagesz;
+					asid = 0;
+					vpn_pagesz = 0;
+				}
+				continue;
+			}
+			/* VPN mustn't be above the next regular entry.  */
+			if (idx < tlbsize && vpn > tlb_vpns[idx].vpn) {
+				vpn = max(vpn,
+					  (tlb_vpns[idx].vpn +
+					   (1ULL << tlb_vpns[idx].pagesz)));
+				asid = 0;
+				idx++;
+				continue;
+			}
+			break;
+		}
+
+		entryhi = (vpn << VPN2_SHIFT) | asid;
+		write_c0_entryhi_native(entryhi);
+		write_c0_index(tlb_vpns[i].index);
+		mtc0_tlbw_hazard();
+		tlb_write_indexed();
+
+		tlb_vpns[i].asid = asid;
+		tlb_vpns[i].vpn = vpn;
+		tlb_vpns[i].pagesz = pagesz;
+
+		asid++;
+		if (asid > cpu_asid_mask(&current_cpu_data)) {
+			vpn += 1ULL << pagesz;
+			asid = 0;
+		}
+	}
 }
 
 /*
@@ -527,14 +746,8 @@ static void __ref r4k_tlb_uniquify(void)
 {
 	int tlbsize = current_cpu_data.tlbsize;
 	bool use_slab = slab_is_available();
-	int start = num_wired_entries();
 	phys_addr_t tlb_vpn_size;
-	unsigned long *tlb_vpns;
-	unsigned long vpn_mask;
-	int cnt, ent, idx, i;
-
-	vpn_mask = GENMASK(cpu_vmbits - 1, 13);
-	vpn_mask |= IS_ENABLED(CONFIG_64BIT) ? 3ULL << 62 : 1 << 31;
+	struct tlbent *tlb_vpns;
 
 	tlb_vpn_size = tlbsize * sizeof(*tlb_vpns);
 	tlb_vpns = (use_slab ?
@@ -545,52 +758,13 @@ static void __ref r4k_tlb_uniquify(void)
 
 	htw_stop();
 
-	for (i = start, cnt = 0; i < tlbsize; i++, cnt++) {
-		unsigned long vpn;
+	r4k_tlb_uniquify_read(tlb_vpns, tlbsize);
 
-		write_c0_index(i);
-		mtc0_tlbr_hazard();
-		tlb_read();
-		tlb_read_hazard();
-		vpn = read_c0_entryhi();
-		vpn &= vpn_mask & PAGE_MASK;
-		tlb_vpns[cnt] = vpn;
+	sort(tlb_vpns, tlbsize, sizeof(*tlb_vpns), r4k_entry_cmp, NULL);
 
-		/* Prevent any large pages from overlapping regular ones.  */
-		write_c0_pagemask(read_c0_pagemask() & PM_DEFAULT_MASK);
-		mtc0_tlbw_hazard();
-		tlb_write_indexed();
-		tlbw_use_hazard();
-	}
-
-	sort(tlb_vpns, cnt, sizeof(tlb_vpns[0]), r4k_vpn_cmp, NULL);
+	r4k_tlb_uniquify_write(tlb_vpns, tlbsize);
 
 	write_c0_pagemask(PM_DEFAULT_MASK);
-	write_c0_entrylo0(0);
-	write_c0_entrylo1(0);
-
-	idx = 0;
-	ent = tlbsize;
-	for (i = start; i < tlbsize; i++)
-		while (1) {
-			unsigned long entryhi, vpn;
-
-			entryhi = UNIQUE_ENTRYHI(ent);
-			vpn = entryhi & vpn_mask & PAGE_MASK;
-
-			if (idx >= cnt || vpn < tlb_vpns[idx]) {
-				write_c0_entryhi(entryhi);
-				write_c0_index(i);
-				mtc0_tlbw_hazard();
-				tlb_write_indexed();
-				ent++;
-				break;
-			} else if (vpn == tlb_vpns[idx]) {
-				ent++;
-			} else {
-				idx++;
-			}
-		}
 
 	tlbw_use_hazard();
 	htw_start();


