Return-Path: <stable+bounces-273209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2a4YHh3hUGoT6wIAu9opvQ
	(envelope-from <stable+bounces-273209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 14:10:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D290073A891
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 14:10:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fUW7DbAD;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273209-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273209-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50FAD311D956
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C48D42CB0B;
	Fri, 10 Jul 2026 11:57:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919D426EAA;
	Fri, 10 Jul 2026 11:57:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684656; cv=none; b=Nj/geA4TQPbzToDuMYOAvtKqbh1qJFxpLN+vsGMQN9yfCdWd1BU83ODR/FbFMDHXdbnV3V/JPMdTVbudmXtIpgJ/URuzQR/2NJp1vu9Ebp/FmZj0JTJbM8NSX4LEY2S9/7Ek+Z//gNobA4yMKYEiNtkClUT3QaOX+w4M0pzSi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684656; c=relaxed/simple;
	bh=gx21zkGMFU8tNTBc3mSAQnclVYeMYuGYggt/VeL9ls8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fDvDg5NSQhMaTe5lWayzG4HdAWY32qTkIwI04HW2LUM1b+O/TCCBhSDxKConosC5tmV30P4ddHCJmyp2VZurPuAr8+M87vnELhQ/xTNMlzPJVwKKobt1pf6Rx8buamnFmZluOCGkNnuMey3JapZqPmH8jvgAQGkn/kJfA/dESgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUW7DbAD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C941F000E9;
	Fri, 10 Jul 2026 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783684644;
	bh=dieG9UC8DK2iL6zyM2fmkYyIvNrYkz6CFno/58d7W3A=;
	h=From:Date:Subject:To:Cc;
	b=fUW7DbAD/dY8hB9yFnkwjt6yegf5eXnziSTbsCo38yx3/RGgx1ak9f53gyoCTBGvR
	 Y2wxHx17jBby3rdzhh6EKjQ7RscPtUoOlVijTZox7msbOvRRw8EUlB5wOfOID7L+gh
	 NKM4TAbfk0J69ZsxdT0fNBg5+nOOZGUnTPTen4FMeCgT+i4CEPWDu9LxbSj23jQs8D
	 1op0Cltv1ZGANowhSOVcXV6i63vZUVgTt/ITmJ3R3vTW6bgv+h+jVlUOJuO0R+aKlW
	 EFcjW7QxIr/ac/1ZVS71VpsRdUy+ldc66MwWG3bfXJHfO6gf5aYbukAnVaEDOwBrhb
	 djsvRIt4EJUnQ==
From: Lorenzo Stoakes <ljs@kernel.org>
Date: Fri, 10 Jul 2026 12:56:40 +0100
Subject: [PATCH] x86/mm/pat: acquire mmap lock on page table free to avoid
 ptdump UAF
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPfdUGoC/yXM3QpAQBCG4VvRHJta5Ce3IgdjdzAK2y5Scu8Wh
 09933uBZyfsoY4ucHyIl3UJSOII9EjLwCgmGFKVFqpMFPZyoraEdjP7bNGRZlREWVfkpiorA+F
 pHYfZV23a337vJtbbm4L7fgC3dRCWdwAAAA==
X-Change-ID: 20260710-fix-cpa-ptdump-race-0aa3b65d878d
To: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Carlier <devnexen@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ljs@kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3019; i=ljs@kernel.org;
 h=from:subject:message-id; bh=gx21zkGMFU8tNTBc3mSAQnclVYeMYuGYggt/VeL9ls8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIC7omVvl7usurgiVWfZc1kfKO31EoF39WPyOiY7r/np
 MdlbtM7HaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZiIoxzDX8G8nrkMc3UN4+t4
 Ksyso1Q4+8U1Auf/XLiR3Tbo09wrLxgZJpfp3T2z7OV1XzbV/k93mD3mZWw6kOOnrH0iqkZCsaq
 KFQA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273209-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:rppt@kernel.org,m:kas@kernel.org,m:akpm@linux-foundation.org,m:devnexen@gmail.com,m:vbabka@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:ljs@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.org,infradead.org,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D290073A891

x86 implements page attribute modification using its Change Page
Attributes (CPA) mechanism.

This tracks properties of ranges such as cache mode through x86 page
attributes, and as part of that logic manipulates kernel page tables.

Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
fragmentation") ranges of kernel page table entries can be collapsed into
huge page table entries as part of this logic.

As part of this collapse, it frees the page tables which the collapsed
entries previously pointed to, and it does so without any relevant locks
being held to preclude concurrent kernel page table walkers.

The only way this code can be reached is if CPA_COLLAPSE is specified, and
this is only set in set_memory_rox() via:

set_memory_rox()
-> change_page_attr_set_clr()
-> cpa_flush()
-> cpa_collapse_large_pages()

Notable users of this are execmem and bpf when manipulating executable
mappings.

However, this is problematic for ptdump, as it walks ranges it does not own
and thus runs the risk of a use-after-free on page tables freed underneath
it.

This patch resolves the issue by acquiring the mmap read lock on init_mm to
provide mutual exclusion against ptdump, which acquires the init_mm write
lock.

It is safe to acquire a sleeping lock as all the callers invoke
set_memory_rox() from process context and in any case,
change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
mutex, disallowing atomic context here.

We also include cleanup.h in order to use a scoped_guard() to implement
this cleanly.

Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d023a40a1e03..4c4b8244502f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -22,6 +22,7 @@
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
 #include <linux/memregion.h>
+#include <linux/cleanup.h>
 
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -436,9 +437,16 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
 
 	flush_tlb_all();
 
-	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
-		list_del(&ptdesc->pt_list);
-		pagetable_free(ptdesc);
+	/*
+	 * ptdump might read these page tables, so avoid a use-after-free by
+	 * acquiring the mmap read lock on init_mm (ptdump acquires the mmap
+	 * write lock).
+	 */
+	scoped_guard(mmap_read_lock, &init_mm) {
+		list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
+			list_del(&ptdesc->pt_list);
+			pagetable_free(ptdesc);
+		}
 	}
 }
 

---
base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
change-id: 20260710-fix-cpa-ptdump-race-0aa3b65d878d

Cheers,
-- 
Lorenzo Stoakes <ljs@kernel.org>


