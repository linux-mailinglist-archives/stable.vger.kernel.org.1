Return-Path: <stable+bounces-249624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEggHYB+DGoSiQUAu9opvQ
	(envelope-from <stable+bounces-249624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:15:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD07581375
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1C7F305B2FF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153431E828;
	Tue, 19 May 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1F4C+vB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6B2BCF46
	for <stable@vger.kernel.org>; Tue, 19 May 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203426; cv=none; b=YfiX4glSMZaQ6y6HEEc43cGYUmlbd81mDz81eC8EMs1tb0DcvC6ZOA3cp57HzoDS/ZuzZwdTk9ezHDa+okE7hAtvFiWa182BNnS84zHTqL2a4Ye6HY4ifGAfCS1F0s86zKgpzSZVdHhWcqGi7ZPqzEvoiCN8+xa/H3ICAErx2To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203426; c=relaxed/simple;
	bh=XGcc2JVzH99KOlr4mv66ep9fGd0a2+n6kDv1XuMSCDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PynFFpC8WbT9UptvaAG2aHEUOUQ2r8FmcbYZ1QyveMEtir7trxQdoJou2JxJnrkAScvzf7lQbXqrYdGDV5SGsUa30OrmsH59eI0cgt5Wcok1UiUxxwzDYUOYVMAYzilRxp82ZorWNm4fboVuHszc7BpNzGNfHgY54pvZhAeHPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1F4C+vB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bd266f6fc0so17845775ad.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779203419; x=1779808219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dNsRRNdoq/mh7bkgCE6Fn2FhIJG533x7ld3bg4XFCu8=;
        b=g1F4C+vByBZc3uB6bBk0PC8Ci3W9cwsaCxmeCbaaOU5I3uYxfjq2fpCJhUS0rzVEKl
         ogS9QVh+czg0OWJkplZRwuaY8tCGY+lDWbKmKp++aoYSCF8pipNxLzW1j6fQx1zNeggf
         PuhADEoDVFTcadtm8eUEICAuL42czVhJlRqGEHyykqPsNnPdosF0Wgk7kSTy9tJbmKf+
         SPD79BKcWFxf2P7GuWWMCYYsZSmLaq0gTStj1S06EdIyahxWnCG5g0yO07NtFeU+ef24
         rZ1kbM2IdAMcV6fWmND1HcWjSG2q34a4gk/LTJGYwPAlekIV8iqTz8FksErhiWfWHrPH
         t6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203419; x=1779808219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNsRRNdoq/mh7bkgCE6Fn2FhIJG533x7ld3bg4XFCu8=;
        b=WynxkOZvIZDX66OCuQTtnITr8KnB2G0CDiM+sjNFrJwNWdc1G4TApqZYkef5apYRtg
         D3lY++H7GeC9ZJsZB/mbVlbSvVpKLODLCzVLhhG3hgrz+o1wab8xR7C5vinBJTUrzRdt
         +NSHnn3QrwvUh6sxop2euMWBTjqgTpAXTsh9mKP58r4c3eI0IOqZ0A9AnbHIyfj+55eZ
         CgOdowMavGoydz5AoC1X7WHIAGPbtzNGurUfYtQAgoU5ebOkRHag5C9cLvzEwVm7fHnL
         HatWhEQ7RuonEgwndpiKwntfZ4gX/+BvQQdd2/MW9G2Q35IPw7tCfGnC3WKNkJzSGo/Z
         7Vcw==
X-Forwarded-Encrypted: i=1; AFNElJ8wvLOQo3FQMcGnds3tF0pKG5Mt5zMcMTlIucBHyf7lKtGkcKmWtbZEuZ8Z9HleUyJx9UBxsjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtoHxLqTinm4OGSqvzQNFcfVJnmTM+FY2ZkJVw9g5Wm74phbEc
	8qZR5IxQsB76KNEWYs6w8beMYbQthRiwimdeYZEoZHwpBJ9bQbRkpr25
X-Gm-Gg: Acq92OHrQ88s4uOGGdjuU3ceSYPrVgsveY6qxKI6Zg+iTEsGcfrMSZm7eYtW8WNIUp6
	EhPKH8DwqNc/tOGC7Ime+CbWv8zuPP2ylAJJ/f2JAJpTWVzthyCIKpWVnHVk0dhHpIfo70msgiK
	YTgK1+IcpFiTUpKjOwqmRjpjcnKweyz5gShpV2J6Fbc/xJcSTT1iW3SQIJqCKTp3IrYMsWC1cUc
	Gi9shyL641CuqsStw2Hk4p11phN66vf2anepdOSeNvOiTH/P7GjvjjD7INATdiHOSyZQJ1ESXfN
	XezhLqgpRQLbRQHTIdSh/h1YXEGRytqs6vYhGNRReTYj0SK4aruaQOgRFV2GpcoddpyFUMSseC9
	X1jmUHQlySS32gG4xc7AtbnuUQGetSgEX4BsEj5IJUj88uEOUUlSXHUtt/eXoXa4TDVsxBxDJOZ
	KYckEXYed1K6j1Dq1g9iLn0dg4FSUeXEDt7si+FqQyHH1XWebI1AWs2yyS
X-Received: by 2002:a17:903:90e:b0:2bd:e452:a484 with SMTP id d9443c01a7336-2bde452a535mr99470535ad.33.1779203419298;
        Tue, 19 May 2026 08:10:19 -0700 (PDT)
Received: from arter97-x1 ([58.124.177.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11ce67sm193784595ad.74.2026.05.19.08.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:10:18 -0700 (PDT)
From: Juhyung Park <qkrwngud825@gmail.com>
To: linux-mm@kvack.org
Cc: Juhyung Park <qkrwngud825@gmail.com>,
	stable@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: [PATCH] x86/mm: fix vmemmap leak on memory hot-remove
Date: Wed, 20 May 2026 00:10:08 +0900
Message-ID: <20260519151008.1399226-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249624-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linux.intel.com,nvidia.com,kernel.org,suse.de,linux-foundation.org,infradead.org,redhat.com,alien8.de,intel.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qkrwngud825@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DCD07581375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

free_pagetable() is called via free_hugepage_table() with
get_order(PMD_SIZE) = 9 to free the 2 MB vmemmap PMD leaves that back
struct page arrays on x86_64. After commit bf9e4e30f353 ("x86/mm: use
pagetable_free()"), it goes through pagetable_free() instead of
__free_pages(), and pagetable_free() ultimately calls
__free_pages(page, compound_order()) which ignores the explicit order
argument and infers it from the page's compound metadata.

The vmemmap PMD chunks are allocated by vmemmap_alloc_block() using
alloc_pages_node() without __GFP_COMP, so PG_head is not set and
compound_order() returns 0. Only the first of 512 pages of each PMD
chunk is returned to the buddy allocator on hot-remove; the remaining
511 pages stay allocated and become unreachable. Generalized: roughly
16 MB leaked per GB of hot-removed memory per cycle.

The leak affects every memory hot-remove path on x86_64 when
memmap_on_memory=N (the default), including dax_kmem, virtio-mem,
balloon drivers, ACPI memory hotplug, and direct sysfs offline+remove.
memmap_on_memory=Y avoids it because free_hugepage_table() then takes
the altmap branch and does not call free_pagetable().

Reproduced with CXL memory toggled through DAX in a loop:

  daxctl reconfigure-device --mode=system-ram dax0.0 --force
  daxctl reconfigure-device --mode=devdax    dax0.0 --force

Fixes: bf9e4e30f353 ("x86/mm: use pagetable_free()")
Cc: stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <djbw@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
---
 arch/x86/mm/init_64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index df2261fa4f98..a2301bddb647 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1024,7 +1024,12 @@ static void __meminit free_pagetable(struct page *page, int order)
 		free_reserved_pages(page, nr_pages);
 #endif
 	} else {
-		pagetable_free(page_ptdesc(page));
+		/*
+		 * Use __free_pages() to honor @order: vmemmap PMD leaves
+		 * freed here are not compound pages, so pagetable_free()
+		 * would lose leak 511 of 512 pages per 2 MB chunk.
+		 */
+		__free_pages(page, order);
 	}
 }
 
-- 
2.54.0


