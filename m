Return-Path: <stable+bounces-262061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PcKxCivuJmrwnQIAu9opvQ
	(envelope-from <stable+bounces-262061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 18:30:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB9D658B99
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 18:30:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=siderolabs.com header.s=google header.b=C33eqlew;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262061-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-262061-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=siderolabs.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4F193038543
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EB731ED83;
	Mon,  8 Jun 2026 15:58:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A898312832
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 15:58:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934316; cv=none; b=QCjzBWLvseowdKXfk+lOrssX7zR7M/AlmXeYqnZawqhc0ivsNdVYUrm4Ni4knUnUkeWH3w28cNPPBG05tOIqGyu5irfI3Q2zQu91FWacMDTP2tU0k0FiVUdmC1oLWOJSbew7W8RDl12jLcIstfc6/+jPZ5fVjDMNQPGZA+tx9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934316; c=relaxed/simple;
	bh=i6amtdiEHPXUj9pH4Qhp9Dvs2DHJ+EAAspzzWRZUZf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tGmXKa2OLkBaafAjbCtCK572ajlI0MdIKwkmHW1Mj1l8iJJ2zieLD6GIOCn6+zywKJqwp75Gk7ZYazZ45LJdbpijP4ATvuFyRwe8Ehz9w6j/Q6iHFjvIZIDcY9xhSw9orAJDkLAz0r34sDQCJiSvXRyydm/N2PcmjfRVJGmyW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siderolabs.com; spf=pass smtp.mailfrom=siderolabs.com; dkim=pass (2048-bit key) header.d=siderolabs.com header.i=@siderolabs.com header.b=C33eqlew; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45eea68dd6fso2311698f8f.2
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siderolabs.com; s=google; t=1780934313; x=1781539113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hiaq02sgTN+eg9Ui+NZIWW5xOwd5YS8q5QwBFbVzNCM=;
        b=C33eqlewvifflGkiJRmC2+kv/S9aaF0HIbdJxZumfIdAcTB+zbPOjOPvZ2sDyFJzVx
         idOJZxnFDEtizbg5DxMt71MJHqFgpuOAYEfvSWSuCXzc85LbRshLnIdcJhydnFQ/FLL2
         AHTmENFCiYV4A3Y49Rn07hSMDRFzzKXkZRK7MEGzDlJecmUyeltwIgeHgJovHLgFQRIB
         yun4LzKdZ1iZbTBiYYpHkZTekwAWpe219yGMXbCpidxky2Vl9z9Op3V7ywKA5sd9DKVT
         1rjWpRCBuAaDBbPpbfHlVvTCzAUFodlalDCGHzzzEzqwiZdxmqsHf3ocxLYwtWn/ItE1
         cmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934313; x=1781539113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiaq02sgTN+eg9Ui+NZIWW5xOwd5YS8q5QwBFbVzNCM=;
        b=iSQLtyeXazYBDneVvZLayrXTxH6S0ZCLj1FSwYr9IQl7YsnBp0lqmf7L2uFtwtHkRD
         c3P5GgMgq6uNcIjPuGnvXvdv5xaBVZaxEQR6arrUYSk8jfsyGmegF98vX/iisyxIsd4H
         mvWHEYOvc0TfsfvAijIKsZ9NcFg2fb1s/6KtLjuv2zDWOiRi7v7fokLFKSsYU4JuYeOC
         3I46VderIqnl5GDBTxpEfeWnatAUu/cqhoV8yyWd3s1DuS5DTbEGKV+2zd2uBgMbILvo
         4sEVTPPkq8O6iitcOQBkDmoeKEpLzNoaGsxZD1YzRP6TRl0OozxwGDk4UE7KLXZ0OjIE
         iQnw==
X-Forwarded-Encrypted: i=1; AFNElJ9rx9uI7ZzpHhdZQO3mxMELLU50YuVWs4El2wDNBui/YlSI8fUi4QiNF7c9czZa/w6ojNXDF8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwN5+NUeAl5vWtxYx4F2qdEwczASXa9agT8tXftDprgPCXE+r
	syWC/JuR7q0qG/bG37rdWU4b4Ev4dBg0vrbcD99gNMkiU1qKZyheDBkAtOAG8wqAdfpeqjBPWFZ
	tFEGlxOU=
X-Gm-Gg: Acq92OFreNtKe5So/PjHcCJAgW5THpFdeAuZW/mJN9gtchbZeSpMeZAT0TToX0w64B6
	dKxHwb797IZ68SUnfqyd6zf4//XEUBRucLmvoHF8V0tAquugSLueecOwyFtKAfiIr6l2Yqf4Drc
	7VAVpQHGzrrzXc1/hfJhqvQ/gPozBt8NG2zBlKTlouEEr/MPMl32HDG5d9o94ADUVm5ssadIYHT
	QS9hHsLGR4daV860fJIWKw4VAlas7jBsPXDzX5J7jkNsxQOnLvzt6MLlA4MT+EZinqsvgeoGIW5
	RBkp83kgkrj04WD2Iaj+Umk0GEBLphZ2+DBC5rnjG93O2/91qtEdnn1Kjit0VSV4knDEtBtWszw
	dO6oiWvPFOX7DAbKjZg52CVmuiaaTBNcQ51KA93lBnwMC7eOKa2OKK8AsVCp1UBGXQ/NHa1QtRN
	+XxQfmaq0wUejCiGSWzAZorpnNJQo36eZNA845XO+Pa591z0s=
X-Received: by 2002:a05:600c:3153:b0:490:b8c0:d46a with SMTP id 5b1f17b1804b1-490c2604790mr273388415e9.22.1780934312914;
        Mon, 08 Jun 2026 08:58:32 -0700 (PDT)
Received: from smirabuild ([2a0b:6204:2bf7:46ff:214:5616:96d9:612])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm484355775e9.9.2026.06.08.08.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:58:32 -0700 (PDT)
From: Andrey Smirnov <andrey.smirnov@siderolabs.com>
To: pasha.tatashin@soleen.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	syzbot+2b5fe617654be3d8848b@syzkaller.appspotmail.com,
	Andrey Smirnov <andrey.smirnov@siderolabs.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Andrei Vagin <avagin@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/page_table_check: do not track special (PFN-mapped) PTEs
Date: Mon,  8 Jun 2026 19:57:58 +0400
Message-ID: <20260608155758.1220420-1-andrey.smirnov@siderolabs.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siderolabs.com,none];
	R_DKIM_ALLOW(-0.20)[siderolabs.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,lists.infradead.org,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,syzkaller.appspotmail.com,siderolabs.com,linutronix.de,gmail.com,arm.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pasha.tatashin@soleen.com,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:syzbot+2b5fe617654be3d8848b@syzkaller.appspotmail.com,m:andrey.smirnov@siderolabs.com,m:tglx@linutronix.de,m:thomas.weissschuh@linutronix.de,m:avagin@gmail.com,m:luto@kernel.org,m:vincenzo.frascino@arm.com,m:stable@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262061-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrey.smirnov@siderolabs.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.smirnov@siderolabs.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[siderolabs.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,2b5fe617654be3d8848b];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAB9D658B99

The vDSO data store ("[vvar]") special mapping is created as a VM_PFNMAP
mapping and its pages are installed into userspace with vmf_insert_pfn(),
which produces special PTEs (pte_special()). On x86 and arm64 (and riscv)
pte_user_accessible_page() only tests the PRESENT/USER bits and does not
exclude special PTEs, so page_table_check accounts these PFN mappings in
the per-page anon/file map counters even though they are not rmap-managed
pages (vm_normal_page() returns NULL for them).

Most of these data pages live in the kernel image and are never freed, so
the stray accounting is invisible. The time-namespace VVAR page is the
exception: it is a real alloc_page() page that is released with
__free_page() in free_time_ns() when the last task of a time namespace
exits. Across the map / unmap / vdso_join_timens() zap transitions the
special-PTE accounting is not balanced for this page, so a non-zero
file_map_count survives to the free path and trips:

  kernel BUG at mm/page_table_check.c:143!
  __page_table_check_zero+0xfb/0x130
  __free_frozen_pages+0x52f/0x650
  free_time_ns+0x85/0xc0
  free_nsproxy+0x7f/0x130
  do_exit+0x313/0xa60
  do_group_exit+0x77/0x90

This is reliably reproducible on x86_64 and arm64 under heavy container/CI
churn that rapidly creates and destroys time namespaces (CLONE_NEWTIME via
runc / docker-init / tini), and was independently reported by syzbot on
riscv. It only manifests when CONFIG_PAGE_TABLE_CHECK is active.

Special PTEs have no struct-page rmap semantics and must never have been
tracked by page table check. Skip them in both the set and clear paths so
the counters stay balanced (always zero) for PFN-mapped pages, regardless
of how the architecture defines pte_user_accessible_page(). pte_special()
is available generically (it is a no-op returning false on architectures
without ARCH_HAS_PTE_SPECIAL), so this is a single, arch-independent fix.

Note that the v7.0 generic vDSO datastore rework in commit 05988dba1179
("vdso/datastore: Allocate data pages dynamically") incidentally avoids
the problem by switching the mapping to VM_MIXEDMAP + vmf_insert_page()
with balanced struct-page accounting. This patch fixes the still-affected
VM_PFNMAP path used by 6.18.y and earlier, and additionally makes
page_table_check robust against any future PFN-mapped user pages.

Fixes: df4e817b7108 ("mm: page table check")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reported-by: syzbot+2b5fe617654be3d8848b@syzkaller.appspotmail.com
Closes: https://github.com/siderolabs/talos/issues/13496
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrey.smirnov@siderolabs.com>
---
 mm/page_table_check.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 4eeca782b888..ee492d5389b9 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -150,9 +150,16 @@ void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte)
 	if (&init_mm == mm)
 		return;
 
-	if (pte_user_accessible_page(pte)) {
+	/*
+	 * PFN-mapped (special) PTEs - e.g. the vDSO/time-namespace "[vvar]"
+	 * mapping installed via vmf_insert_pfn() - are not rmap-managed and
+	 * must not be tracked here. Tracking them can leave a non-zero map
+	 * count on a struct page that is later freed (the time namespace VVAR
+	 * page in free_time_ns()), tripping the BUG_ON() in
+	 * __page_table_check_zero().
+	 */
+	if (pte_user_accessible_page(pte) && !pte_special(pte))
 		page_table_check_clear(pte_pfn(pte), PAGE_SIZE >> PAGE_SHIFT);
-	}
 }
 EXPORT_SYMBOL(__page_table_check_pte_clear);
 
@@ -205,7 +212,7 @@ void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
 
 	for (i = 0; i < nr; i++)
 		__page_table_check_pte_clear(mm, ptep_get(ptep + i));
-	if (pte_user_accessible_page(pte))
+	if (pte_user_accessible_page(pte) && !pte_special(pte))
 		page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
 }
 EXPORT_SYMBOL(__page_table_check_ptes_set);
-- 
2.53.0


