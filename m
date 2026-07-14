Return-Path: <stable+bounces-274475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 26o+GjVxVmqI5gAAu9opvQ
	(envelope-from <stable+bounces-274475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:26:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E0375764A
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:26:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A+kxTrnX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274475-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274475-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16D5B3113141
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69D49219D;
	Tue, 14 Jul 2026 17:25:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE522AD37;
	Tue, 14 Jul 2026 17:24:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049900; cv=none; b=KBdoeUjr/f3/a5zIe0pi+Pd76xgJHfwkz6dekM6FkckLRtrvRds3llDqJW30Ygshvcsogqf6v5uXguucr8BC9Kve5xqqMaNfdTt+wk9bqNzqHPM63QnrGroYoeMg4fALzVjm6NpQGTr4U1W0V9bXbyHcmN2pXtzvYS3PBHjNYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049900; c=relaxed/simple;
	bh=1IRMkBuBSJn8c0dhLGk5dFenOrN5JSkDTuylzdcXQUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7JVg0Y10h8y25IlqNU+tG9ohad3PTKmkCyJ16Lg2EGm/1y/EPCTyra7LbsZfwp62tNIdPDnrp7VJ9QF+eXBfiWNp8/0QulEZidfTaN/wjOzrveJssZ0QGvngZYcUIb2YWJsyiISFtlYJSmuSGKxAV6lIFgYxWdEyNzj2YOXf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+kxTrnX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DF91F00A3D;
	Tue, 14 Jul 2026 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784049899;
	bh=BYfKvJYN8Ofzx4ZcF2C0yaTq6AqCLt0T09rDQbFZEtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A+kxTrnXg6Io/GxtciuQ8gUMV/UHNsl8xfZDXmio287Uq1eq0AB/sirE9DHnMeL55
	 spsQknwWtzixnvri9S7+b1ZoAHYYaoFXquGjVStimNk5YfB9wHH/WVtgglXU3m54/D
	 7HYTFusEKpmBvCPbd4aZRaHdwPEMj/1rc52yjuPKNBmynU58cfrjReDxBCNQAsOKf9
	 l2V7BFZBr3kQwXUAKTXb9gQvLFdPLqECx0sI83DZqFtL0EoaGwK8xDcM5AGefLIoII
	 BpcW0cq5ehnHH5qa1pzpq2VMVA3bIawmGGCJt8ifvxADVJGyqCLUEF07ptVJjY1LZi
	 IRz8CTEyXAAGg==
From: Lorenzo Stoakes <ljs@kernel.org>
Date: Tue, 14 Jul 2026 18:24:24 +0100
Subject: [PATCH mm-hotfixes v3 2/4] x86/mm/pat: acquire mmap lock on page
 table free to avoid ptdump UAF
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-series-vmap-race-fix-v3-2-b812eccfa0f9@kernel.org>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
In-Reply-To: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: David Carlier <devnexen@gmail.com>, ljs@kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2859; i=ljs@kernel.org;
 h=from:subject:message-id; bh=1IRMkBuBSJn8c0dhLGk5dFenOrN5JSkDTuylzdcXQUQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLCCs6x5etcWPDhb4c5X+Hv5b1Xc349/WTx8ort+4YT0
 yXsZVYt7ihlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBE9j9m+B8ld9rf4Hmdcmzz
 8kB317VWRsGfPI89nX/E8NeTTrmkaE2G/9HXsroSfPSfSCpkf2OZzvbr7yzG+tCfR6s18mKfGs9
 OZgQA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:kas@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:dev.jain@arm.com,m:ryan.roberts@arm.com,m:devnexen@gmail.com,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_TO(0.00)[linux-foundation.org,google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,linux.intel.com,redhat.com,alien8.de,zytor.com,arm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274475-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,kvack.org,vger.kernel.org,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8E0375764A

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

However, this is problematic for ptdump as it walks ranges it does not own
and thus runs the risk of a use-after-free on page tables freed underneath
it.

Resolve the issue by acquiring the mmap read lock on init_mm which prevents
a concurrent ptdump as it acquires the write lock.

It is safe to acquire a sleeping lock as all the callers invoke
set_memory_rox() from process context and in any case,
change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
mutex, disallowing atomic context here.

Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
Cc: stable@vger.kernel.org
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
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
 

-- 
2.55.0


