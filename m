Return-Path: <stable+bounces-128481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B65CA7D7DE
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DD6188DCCC
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33FA227E92;
	Mon,  7 Apr 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="RYJIU2hF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB3227BA5
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014571; cv=none; b=D0llYZsdvZqdmo7PoYyjB35JfuxeoBmORvFYMiwLBU+R+gsXvnpWo6VN3hModOvQlTrPoU3PLGCZ6D7G/NWxBP5HmzO4SzcNP+hHBS8GgNtzixHekRwzdc+YueAh2YGQtHl+qer8WomrOq78ghPh6ymhMtSkd8pf78rtyO/zfS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014571; c=relaxed/simple;
	bh=8Kfv/G+iVQ/sM6Lau2tiEbUkEO834j3Q9kf5WBpyi/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=es1PObs64atYh610/OuGoIsCYCqao6oM6S2gZGqFR5BI2/IzqcJ9zgM9bGeRgb/K/SRP5WWJoCNkgAlMX8MYGNROflrQREcGFaPxkv4dka1Tpq7rNHwIdm9F4oede0FEDGLQXASsxD2MO81/+4sfNXF1K+qX+yxWBEwb+V12gOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=RYJIU2hF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223f4c06e9fso35157225ad.1
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1744014568; x=1744619368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSdAs2f+FX9mxAdk7Px3JSEdrERFGwDr3y7nuD5w7Os=;
        b=RYJIU2hFLTeRYvnGplZB3TLvgq5oikg2vtHmvkRam5ORhQ7AwS6NT2SK1sOEz7P9US
         lbr6hWrc2s1CGYZXteZKNu3YJ0Ygu/N0U0ZSP0fKQI1W2K+Z+SGol3arG1L10csLhox/
         t3oyYSNTU1sLorr/xMNSUnprzO8xsQiiC4PeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744014568; x=1744619368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSdAs2f+FX9mxAdk7Px3JSEdrERFGwDr3y7nuD5w7Os=;
        b=kCqtbku/DxaA/RqSaXDlaRBtkat505orQ1yclKsgNmRu4ViNctV8EmSIGxlt+ziiPC
         0YAu3mwXVM6Bgi51gxyqijaPl0RQVFVksCUNpxCAliS1gr78EVY99IGeyxOJRNDjg7K1
         2TJA7RG2ycEl9aBcz+eHxVYv/z866ZR1uGv/MFxkwGkr+jTIIZ8IRJIpeXme2lN87Gsl
         q5FqZJ8tPSKEF+sGAVi8ARLAQZQgOWObqAY6vWfypFeJvgarqYIsn4L5mr7DkdQJuEE/
         OYhi0JXbt9TrtLBFEQI3oBTxsECMFStKYiAzzZ4ZzuPGXUyxpkq3RxZOT7KPNik9vhK3
         GgXw==
X-Gm-Message-State: AOJu0Yza9LUpDGB7af6NUZIcJX2RWpl2PFdaIxtCUWPsxbIankwkEpJz
	Lwj0LimiObViVHyhuyVovQES6OrekTbHH51D7oCS6JELz2CbJWAsOiTlYPH6xlM=
X-Gm-Gg: ASbGncup8a6oGBHTtwU4njALqsmO907LtEmwQMskwLsLzy4nlgdDbbnlI4LtGleUah+
	pkx2akVqee14R0FDCZP7SBj35nALNkjJAjWZ4AnW5IcCMaN59l8h2dT/Fl8J2scJQaTx+NFAwq9
	tP4NLUyMeiG3yNkoY85UoS3RHhM9rzuZhlInHNhwBaiXRO+nFiqV8TyOW0Z4l7TultO7MrH3MhA
	RLUfXQ4/irhON+SBJnh48YktWxn6jFXGC0DOREtqThJ7AAzOFbR+3tQQ/mGbwbX3K+OX0QNlbQt
	zKpjrk5OVgvPPA+6orQS13k0fc+Tov0p5mlFXKehstJ3S8BgrQ==
X-Google-Smtp-Source: AGHT+IF0CSzr5MZm3MP3ECWI39e3e76OnxJJystHy5NBHpjYzkDs4iGYAsXV3wu+sJhREp3R/IAdWg==
X-Received: by 2002:a17:902:d487:b0:224:3994:8a8c with SMTP id d9443c01a7336-229765bd473mr177056685ad.8.1744014567961;
        Mon, 07 Apr 2025 01:29:27 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2297865e093sm75458025ad.132.2025.04.07.01.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:29:27 -0700 (PDT)
From: Roger Pau Monne <roger.pau@citrix.com>
To: Juergen Gross <jgross@suse.com>,
	Roger Pau Monne <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH v3] x86/xen: fix balloon target initialization for PVH dom0
Date: Mon,  7 Apr 2025 10:28:37 +0200
Message-ID: <20250407082838.65495-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PVH dom0 re-uses logic from PV dom0, in which RAM ranges not assigned to
dom0 are re-used as scratch memory to map foreign and grant pages.  Such
logic relies on reporting those unpopulated ranges as RAM to Linux, and
mark them as reserved.  This way Linux creates the underlying page
structures required for metadata management.

Such approach works fine on PV because the initial balloon target is
calculated using specific Xen data, that doesn't take into account the
memory type changes described above.  However on HVM and PVH the initial
balloon target is calculated using get_num_physpages(), and that function
does take into account the unpopulated RAM regions used as scratch space
for remote domain mappings.

This leads to PVH dom0 having an incorrect initial balloon target, which
causes malfunction (excessive memory freeing) of the balloon driver if the
dom0 memory target is later adjusted from the toolstack.

Fix this by using xen_released_pages to account for any pages that are part
of the memory map, but are already unpopulated when the balloon driver is
initialized.  This accounts for any regions used for scratch remote
mappings.  Note on x86 xen_released_pages definition is moved to
enlighten.c so it's uniformly available for all Xen-enabled builds.

Take the opportunity to unify PV with PVH/HVM guests regarding the usage of
get_num_physpages(), as that avoids having to add different logic for PV vs
PVH in both balloon_add_regions() and arch_xen_unpopulated_init().

Much like a6aa4eb994ee, the code in this changeset should have been part of
38620fc4e893.

Fixes: a6aa4eb994ee ('xen/x86: add extra pages to unpopulated-alloc if available')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org
---
Changes since v2:
 - For x86: Move xen_released_pages definition from setup.c (PV specific)
   to enlighten.c (shared between all guest modes).

Changes since v1:
 - Replace BUG_ON() with a WARN and failure to initialize the balloon
   driver.
---
 arch/x86/xen/enlighten.c | 10 ++++++++++
 arch/x86/xen/setup.c     |  3 ---
 drivers/xen/balloon.c    | 34 ++++++++++++++++++++++++----------
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 43dcd8c7badc..1b7710bd0d05 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -70,6 +70,9 @@ EXPORT_SYMBOL(xen_start_flags);
  */
 struct shared_info *HYPERVISOR_shared_info = &xen_dummy_shared_info;
 
+/* Number of pages released from the initial allocation. */
+unsigned long xen_released_pages;
+
 static __ref void xen_get_vendor(void)
 {
 	init_cpu_devs();
@@ -466,6 +469,13 @@ int __init arch_xen_unpopulated_init(struct resource **res)
 			xen_free_unpopulated_pages(1, &pg);
 		}
 
+		/*
+		 * Account for the region being in the physmap but unpopulated.
+		 * The value in xen_released_pages is used by the balloon
+		 * driver to know how much of the physmap is unpopulated and
+		 * set an accurate initial memory target.
+		 */
+		xen_released_pages += xen_extra_mem[i].n_pfns;
 		/* Zero so region is not also added to the balloon driver. */
 		xen_extra_mem[i].n_pfns = 0;
 	}
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index c3db71d96c43..3823e52aef52 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -37,9 +37,6 @@
 
 #define GB(x) ((uint64_t)(x) * 1024 * 1024 * 1024)
 
-/* Number of pages released from the initial allocation. */
-unsigned long xen_released_pages;
-
 /* Memory map would allow PCI passthrough. */
 bool xen_pv_pci_possible;
 
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 163f7f1d70f1..ee165f4f7fe6 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -675,7 +675,7 @@ void xen_free_ballooned_pages(unsigned int nr_pages, struct page **pages)
 }
 EXPORT_SYMBOL(xen_free_ballooned_pages);
 
-static void __init balloon_add_regions(void)
+static int __init balloon_add_regions(void)
 {
 	unsigned long start_pfn, pages;
 	unsigned long pfn, extra_pfn_end;
@@ -698,26 +698,38 @@ static void __init balloon_add_regions(void)
 		for (pfn = start_pfn; pfn < extra_pfn_end; pfn++)
 			balloon_append(pfn_to_page(pfn));
 
-		balloon_stats.total_pages += extra_pfn_end - start_pfn;
+		/*
+		 * Extra regions are accounted for in the physmap, but need
+		 * decreasing from current_pages to balloon down the initial
+		 * allocation, because they are already accounted for in
+		 * total_pages.
+		 */
+		if (extra_pfn_end - start_pfn >= balloon_stats.current_pages) {
+			WARN(1, "Extra pages underflow current target");
+			return -ERANGE;
+		}
+		balloon_stats.current_pages -= extra_pfn_end - start_pfn;
 	}
+
+	return 0;
 }
 
 static int __init balloon_init(void)
 {
 	struct task_struct *task;
+	int rc;
 
 	if (!xen_domain())
 		return -ENODEV;
 
 	pr_info("Initialising balloon driver\n");
 
-#ifdef CONFIG_XEN_PV
-	balloon_stats.current_pages = xen_pv_domain()
-		? min(xen_start_info->nr_pages - xen_released_pages, max_pfn)
-		: get_num_physpages();
-#else
-	balloon_stats.current_pages = get_num_physpages();
-#endif
+	if (xen_released_pages >= get_num_physpages()) {
+		WARN(1, "Released pages underflow current target");
+		return -ERANGE;
+	}
+
+	balloon_stats.current_pages = get_num_physpages() - xen_released_pages;
 	balloon_stats.target_pages  = balloon_stats.current_pages;
 	balloon_stats.balloon_low   = 0;
 	balloon_stats.balloon_high  = 0;
@@ -734,7 +746,9 @@ static int __init balloon_init(void)
 	register_sysctl_init("xen/balloon", balloon_table);
 #endif
 
-	balloon_add_regions();
+	rc = balloon_add_regions();
+	if (rc)
+		return rc;
 
 	task = kthread_run(balloon_thread, NULL, "xen-balloon");
 	if (IS_ERR(task)) {
-- 
2.48.1


