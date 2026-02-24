Return-Path: <stable+bounces-217915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLLeAjyonWmgQwQAu9opvQ
	(envelope-from <stable+bounces-217915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 14:31:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A231187B68
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 14:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A303F314D162
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4614739B48E;
	Tue, 24 Feb 2026 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGlVViMM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E931690A
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939423; cv=none; b=tha7hPKMYwxredBQPY3WcOfNiKQhEQzxY2ZCatStrKKqYEkWVvVatQsMnZZyt4RTAY86hmNg00YvTZJX7JUiqzShQU7JLy2LN/hSEv0lH0pkN0MawpCzNX7nVVgrGxYy/dHOUPB4vx7ixlf7owD4O3m/IulBL1jYftRGwBT+Dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939423; c=relaxed/simple;
	bh=0tCb4shhbifTON9N+cDCjQQ3qS0h3WHeh3RlNB4suhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P626iq+p6UQhyO9E58qwc+EyfOFApR4neUorjgG8SX9R3kS9aU3//jDOKheNs6V9022VjAUWHoGRRT+41NsTMLcfofuhQ0aSU2bFUIuIAg5tgdDBY7sZUaQ9OXVPbXBv3kgRT0dDwpBn9/Fomp88F9Z2uFdycvlBgD7305XMEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGlVViMM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aae4816912so38297275ad.2
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771939421; x=1772544221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/vTWhMTFB0Dk21wQu2UrghHtfm/CBbtvTcuyWrVL08=;
        b=SGlVViMMNQlKNl7YE72DeuMOqMioyVvu7zghLJptNQb3oq/J0ymbX5EX/RktsVrRm/
         JLSOuRoIoSJxgvyPeok1ztqAkPS5M8k2+wgQPl1q0SuHHSZnpvkRTLZprmW5Rjou6EeO
         VMgO0BsQkeRzItKdcCMNlLVz0LGwwShhoQ5BYCLv9JQ/WSIPqDqzkNIJ+dPm3tmn6H+P
         sm/aZtydpvur620B1nNY2807TH+RzuFjyNsHv9sT9kA+tGNugp2EMbhCGprMVVU8s9Bn
         Qde4R6bPr1GVE2kF5kueY8A8v8PTM18QGGuVZ/ClIrSu14vrhaAKaTtgIYur5DDIezLI
         D59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771939421; x=1772544221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/vTWhMTFB0Dk21wQu2UrghHtfm/CBbtvTcuyWrVL08=;
        b=Ulk+3SZwhLPYD5GDYTahwQSkHFkMuF9DmF0hJughWJUW71n9y9RDOV2mq78Bb5qoHf
         z461mFw4Ru6Eq5rzDUr9bd0rih42UYb0SurI6qB+iQP10Q0/RbBvFIwdJhPjZiNe1X58
         KHrZwBWz7SjSW4OWOx8fmygMJG84lbzej9Y6aymO0SBYwYJzTIrVS2r6Epm4N75Hb8WE
         hl7OSvoDMvpT2RkPMQFPDQ6xt4Ooh+yXJ0ebow0QWP/2QCLdfQKfs+JC+lkQ5nbqSB5G
         gjjGfolum4OPgJ3p6dzOhqLyy/BN0dk9KClK9Mx3m5JPu2MsiwHJ404QNfymzWWEvizD
         hw+A==
X-Forwarded-Encrypted: i=1; AJvYcCWOJWiTsh5CxzKmEI0MwRVgrS2m8dLlH78Mx/mxSiMqff1bISbBIxce2qukUVjdvunb5CZalCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYmyDo1yhLjiw8nE27EB1J83BnWqE1DVRj68fiPNbkOYXSK3t
	oUgY7gxt/QbRwK5RzFmtieOG/Xcbew2Qwtp50idsNOZPFHTCRDoWI9N+
X-Gm-Gg: ATEYQzzwZReEyUwlfnFPPFh95lrrfhUJP400MvdXfoFgwnkv0mIsZM9rmZVxHK6A5IL
	ipvxrdQs6WP6kgajsUkZyPb1wU8dJleqBlBHJJoOk8Yix8FG9IjZar12FCG9BHcDJejpJ9LytTg
	75ts7efvndNYQZiMrdcBhshvccGfxgS85tNuAHuSvujoVlEHoZczk+Rp6jPIkaaXXkrpALIOhYO
	slWRfhZRId3WyZ69JOL9ti2Tfo/sWT9RdPGeGuR6BmUnBm3aX1idEQmsKIvKoCfVbob3X7vQbcI
	Jr997R9oGvMCJ8NUqDHxSzy8l5M5QFLMFa0GnzNRu0oa4d+aF7Mg6kM9qgT9cBeCHTnyekFl25z
	Val1wSigC8GKEPU7FUaG9WYCfQAwocndhiyDefowAuBjlk1CCqGcqHYg2WS9P9LEEvWv2fBEghx
	LQwO6cHqdBiGwKbbNmlA==
X-Received: by 2002:a17:902:e787:b0:2a9:3396:738 with SMTP id d9443c01a7336-2ad74547d8dmr105272735ad.44.1771939420973;
        Tue, 24 Feb 2026 05:23:40 -0800 (PST)
Received: from dw-tp ([203.81.243.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e1cbsm96620195ad.50.2026.02.24.05.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:23:40 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linuxppc-dev@lists.ozlabs.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v2] mm/kasan: Fix double free for kasan pXds
Date: Tue, 24 Feb 2026 18:53:16 +0530
Message-ID: <2f9135c7866c6e0d06e960993b8a5674a9ebc7ec.1771938394.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217915-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,google.com,arm.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A231187B68
X-Rspamd-Action: no action

kasan_free_pxd() assumes the page table is always struct page aligned.
But that's not always the case for all architectures. E.g. In case of
powerpc with 64K pagesize, PUD table (of size 4096) comes from slab
cache named pgtable-2^9. Hence instead of page_to_virt(pxd_page()) let's
just directly pass the start of the pxd table which is passed as the 1st
argument.

This fixes the below double free kasan issue seen with PMEM:

radix-mmu: Mapped 0x0000047d10000000-0x0000047f90000000 with 2.00 MiB pages
==================================================================
BUG: KASAN: double-free in kasan_remove_zero_shadow+0x9c4/0xa20
Free of addr c0000003c38e0000 by task ndctl/2164

CPU: 34 UID: 0 PID: 2164 Comm: ndctl Not tainted 6.19.0-rc1-00048-gea1013c15392 #157 VOLUNTARY
Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
Call Trace:
 dump_stack_lvl+0x88/0xc4 (unreliable)
 print_report+0x214/0x63c
 kasan_report_invalid_free+0xe4/0x110
 check_slab_allocation+0x100/0x150
 kmem_cache_free+0x128/0x6e0
 kasan_remove_zero_shadow+0x9c4/0xa20
 memunmap_pages+0x2b8/0x5c0
 devm_action_release+0x54/0x70
 release_nodes+0xc8/0x1a0
 devres_release_all+0xe0/0x140
 device_unbind_cleanup+0x30/0x120
 device_release_driver_internal+0x3e4/0x450
 unbind_store+0xfc/0x110
 drv_attr_store+0x78/0xb0
 sysfs_kf_write+0x114/0x140
 kernfs_fop_write_iter+0x264/0x3f0
 vfs_write+0x3bc/0x7d0
 ksys_write+0xa4/0x190
 system_call_exception+0x190/0x480
 system_call_vectored_common+0x15c/0x2ec
---- interrupt: 3000 at 0x7fff93b3d3f4
NIP:  00007fff93b3d3f4 LR: 00007fff93b3d3f4 CTR: 0000000000000000
REGS: c0000003f1b07e80 TRAP: 3000   Not tainted  (6.19.0-rc1-00048-gea1013c15392)
MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48888208  XER: 00000000
<...>
NIP [00007fff93b3d3f4] 0x7fff93b3d3f4
LR [00007fff93b3d3f4] 0x7fff93b3d3f4
---- interrupt: 3000

 The buggy address belongs to the object at c0000003c38e0000
  which belongs to the cache pgtable-2^9 of size 4096
 The buggy address is located 0 bytes inside of
  4096-byte region [c0000003c38e0000, c0000003c38e1000)

 The buggy address belongs to the physical page:
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3c38c
 head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 memcg:c0000003bfd63e01
 flags: 0x63ffff800000040(head|node=6|zone=0|lastcpupid=0x7ffff)
 page_type: f5(slab)
 raw: 063ffff800000040 c000000140058980 5deadbeef0000122 0000000000000000
 raw: 0000000000000000 0000000080200020 00000000f5000000 c0000003bfd63e01
 head: 063ffff800000040 c000000140058980 5deadbeef0000122 0000000000000000
 head: 0000000000000000 0000000080200020 00000000f5000000 c0000003bfd63e01
 head: 063ffff800000002 c00c000000f0e301 00000000ffffffff 00000000ffffffff
 head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
 page dumped because: kasan: bad access detected

[  138.953636] [   T2164] Memory state around the buggy address:
[  138.953643] [   T2164]  c0000003c38dff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  138.953652] [   T2164]  c0000003c38dff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  138.953661] [   T2164] >c0000003c38e0000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  138.953669] [   T2164]                    ^
[  138.953675] [   T2164]  c0000003c38e0080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  138.953684] [   T2164]  c0000003c38e0100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  138.953692] [   T2164] ==================================================================
[  138.953701] [   T2164] Disabling lock debugging due to kernel taint

Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
Cc: stable@vger.kernel.org
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---

v1 -> v2:
1. cc'd linux-mm
2. Added tags (Fixes, CC, Reported).

 mm/kasan/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index f084e7a5df1e..9c880f607c6a 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -292,7 +292,7 @@ static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
 			return;
 	}

-	pte_free_kernel(&init_mm, (pte_t *)page_to_virt(pmd_page(*pmd)));
+	pte_free_kernel(&init_mm, pte_start);
 	pmd_clear(pmd);
 }

@@ -307,7 +307,7 @@ static void kasan_free_pmd(pmd_t *pmd_start, pud_t *pud)
 			return;
 	}

-	pmd_free(&init_mm, (pmd_t *)page_to_virt(pud_page(*pud)));
+	pmd_free(&init_mm, pmd_start);
 	pud_clear(pud);
 }

@@ -322,7 +322,7 @@ static void kasan_free_pud(pud_t *pud_start, p4d_t *p4d)
 			return;
 	}

-	pud_free(&init_mm, (pud_t *)page_to_virt(p4d_page(*p4d)));
+	pud_free(&init_mm, pud_start);
 	p4d_clear(p4d);
 }

@@ -337,7 +337,7 @@ static void kasan_free_p4d(p4d_t *p4d_start, pgd_t *pgd)
 			return;
 	}

-	p4d_free(&init_mm, (p4d_t *)page_to_virt(pgd_page(*pgd)));
+	p4d_free(&init_mm, p4d_start);
 	pgd_clear(pgd);
 }

--
2.53.0


