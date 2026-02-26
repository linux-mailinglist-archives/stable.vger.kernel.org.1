Return-Path: <stable+bounces-219820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMyUHfNaoGlPigQAu9opvQ
	(envelope-from <stable+bounces-219820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:38:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5434F1A7B8E
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17EDB308A1DC
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387863B5304;
	Thu, 26 Feb 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="K7t2TU4n"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB43B52F4
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115493; cv=none; b=XAhSMzVbBvXs89cxd4iRLhDyhzaW5g4Va4msp6A4cSCTMlctmREC3TSagoK09UMa5d4rWM6RSBaICIQ/kfaZJLbzHDvrIKARojSg8L5M6DUxsh2OzIQnCtKd/pwmuojGtd5y/8UOFnLggVSXNgLBr3t8XvrD3MBWTpyRVAYxNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115493; c=relaxed/simple;
	bh=jBHu0PbpXWisz64Z7upJAs0O6HKKSqbwDGxPa7KDQZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b+X6ipntmF+PKPbEV8Wqs3BsdSwOj2Aow9Pz05HhppP5wLzby+rnf94PYQTvQgmhg7u9CzNJ9SMbMEXS6ZejK4rzB3WxcWnPxPENy5Oz5k9a109WSBGhKM5VrIR7vM2XlsfHcjHIvDL8zyI9nRNsD2EAAd9+2Yw9T8/m8FZIQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=K7t2TU4n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad4d639db3so4293175ad.0
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 06:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1772115491; x=1772720291; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXXHPkuaOyT/Lkk4V58fFeap91QST2S+bcIMS7/ydUs=;
        b=K7t2TU4nUbTghb62h94pCwGsYcv8oVnlJTheMMDsu9GVY/NS2KQHtkd04akqLSpVGd
         PNFvQYyAvOSqV9kQbqQiwDcGg8JN/CZR0c1UiPT/AU86rHkPPlgUApWW2iADgHpZB5YN
         HppXmM0EIZrDpZGWYg4hmaupUj2tjl300Y4W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115491; x=1772720291;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXXHPkuaOyT/Lkk4V58fFeap91QST2S+bcIMS7/ydUs=;
        b=TnfR5AXJQhXMHTTx3oQMJefvSMR0a5dxsfmimPgto4FEcN/0WfLY32sIIw00WPsBUn
         Gm6dYRnvTBK2ZHGa/w5ktkuGinT+FSOLbIXG5JVBqk+EJpRN3X8QCf+M3+JuAM2zJ0vh
         BpbfkP7wPnoZE6i5B834DL5vVJZ1QMfdWqxAIYxzyxB8gdW23Zj3eJRaUFISgJO8IHbL
         UD9o9r4ziHFtnc1UDVeduKmX6tPwb0mziBIxM6MW8HCmeahAT4YBzAJpL89alODJszjc
         4fxRqJ6OrfcSwrYMvSt8w+m22rIqHjm55xiVR8ejA3WWYIafGgBmUPxnvXVgkcm/LHOh
         aO3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9PiJATqC8taJiOUW1Gtj+2BDcHPHo71++K5+fdeEzB2nWF6u/pERf3GRMzwjDBeM9L2NRSaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8RgMtoOni3g5o7a/YFINAR0B7JONdmL+XamNlMpfZH09FmK7s
	UlaiOaORifuffetC+pte/cps/wyN9hSuHh/ebiht/xqoRQXv8qgtpiv3CemlwyGOLL4=
X-Gm-Gg: ATEYQzyOLfRFOBPVF8s9n0MaQYdURWZuxUo5wixcAd9XG8J6qgU7IywAgXORDQC+JZP
	3ck9KSc2od99Yhzix4DUf6Cuevxme1ZFFVc9AxoQrAnT06MdvDiH/H7G5Oy18sGcJ5F+jkHkCEi
	3e6Ir4wRv9yfXFW8QJd6VjbGUozG9O11grlo6SYgqgadEds0KhExlbfnLk5Lg2jr3DWdKxkSmLm
	SIXOGXg5ZaTyLyEVOylcNj7ejR8F6P+est5ECv3r70o1JiIELIKAke30krBf5iPvsKROSH6g8kG
	19gCvZlGn5KUfl1K5NhpAAqZF3joU5R4n4Cx/PKhSLgc0Vkymg7LrlhMI64vihv3veJOGgECbJf
	/Q028/c9rdvYVlC/GSQ6tzNH6b3J3WDjChT1tRGfypl+Wsz7qa6EcojCbaV3OyXnt2PPFGvX9Bl
	Zqo4cXNObxZHC4M7Xibg==
X-Received: by 2002:a17:903:1986:b0:2ad:edc4:1796 with SMTP id d9443c01a7336-2adedc422demr36518595ad.39.1772115491093;
        Thu, 26 Feb 2026 06:18:11 -0800 (PST)
Received: from localhost ([154.47.23.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c1fa8sm29415725ad.26.2026.02.26.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 06:18:10 -0800 (PST)
Date: Thu, 26 Feb 2026 22:18:03 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] selftests/mm: Add UFFDIO_MOVE huge zeropage PMD
 regression test
Message-ID: <aaBWG4fajXXbjpVN@chrisdown.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.15 (2b349c5e) (2025-10-02)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chrisdown.name,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[chrisdown.name:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chrisdown.name:+];
	TAGGED_FROM(0.00)[bounces-219820-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chris@chrisdown.name,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chrisdown.name:mid,chrisdown.name:dkim,chrisdown.name:email]
X-Rspamd-Queue-Id: 5434F1A7B8E
X-Rspamd-Action: no action

The existing uffd-unit-tests move-pmd coverage exercises PMD-sized
UFFDIO_MOVE on anonymous THPs, but it does not force the huge zeropage
PMD path in move_pages_huge_pmd().

Add a dedicated anonymous UFFDIO_MOVE PMD test that exercises this
relatively comprehensively.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 176 +++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 6f5e404a446c..372619e3906d 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -203,6 +203,62 @@ static int pagemap_open(void)
 	return fd;
 }
 
+static long uffd_pagemap_scan_get_categories_raw(int fd, char *start,
+						 struct page_region *r)
+{
+	struct pm_scan_arg arg = { 0 };
+
+	arg.start = (uintptr_t)start;
+	arg.end = (uintptr_t)(start + psize());
+	arg.vec = (uintptr_t)r;
+	arg.vec_len = 1;
+	arg.flags = 0;
+	arg.size = sizeof(struct pm_scan_arg);
+	arg.max_pages = 0;
+	arg.category_inverted = 0;
+	arg.category_mask = 0;
+	arg.category_anyof_mask = PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN |
+				  PAGE_IS_FILE | PAGE_IS_PRESENT |
+				  PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |
+				  PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY;
+	arg.return_mask = arg.category_anyof_mask;
+
+	return ioctl(fd, PAGEMAP_SCAN, &arg);
+}
+
+static bool uffd_pagemap_scan_supported(int fd, char *start)
+{
+	static int supported = -1;
+	int ret;
+
+	if (supported != -1)
+		return supported;
+
+	ret = uffd_pagemap_scan_get_categories_raw(fd, start,
+						   (struct page_region *)~0UL);
+	if (ret == 0)
+		err("PAGEMAP_SCAN succeeded unexpectedly");
+
+	supported = errno == EFAULT;
+	return supported;
+}
+
+static bool uffd_pagemap_scan_get_categories(int fd, char *start, uint64_t *categories)
+{
+	struct page_region r = { 0 };
+	long ret;
+
+	if (!uffd_pagemap_scan_supported(fd, start))
+		return false;
+
+	ret = uffd_pagemap_scan_get_categories_raw(fd, start, &r);
+	if (ret < 0)
+		err("PAGEMAP_SCAN failed: %s", strerror(errno));
+
+	*categories = ret ? r.categories : 0;
+	return true;
+}
+
 /* This macro let __LINE__ works in err() */
 #define  pagemap_check_wp(value, wp) do {				\
 		if (!!(value & PM_UFFD_WP) != wp)			\
@@ -1227,6 +1283,119 @@ static void uffd_move_pmd_test(uffd_global_test_opts_t *gopts, uffd_test_args_t
 			      uffd_move_pmd_handle_fault);
 }
 
+static void uffd_move_pmd_huge_zeropage_test(uffd_global_test_opts_t *gopts,
+					     uffd_test_args_t *targs)
+{
+	unsigned long pmd_size = read_pmd_pagesize();
+	unsigned long pmd_pages;
+	unsigned long bytes = gopts->nr_pages * gopts->page_size;
+	char *orig_area_src = gopts->area_src, *orig_area_dst = gopts->area_dst;
+	char *aligned_src, *aligned_dst;
+	unsigned long src_offs, dst_offs, max_offs;
+	pthread_t uffd_mon;
+	struct uffd_args args = { 0 };
+	char c = '\0';
+	int pagemap_fd;
+	uint64_t categories;
+	unsigned long i;
+
+	if (pmd_size <= gopts->page_size) {
+		uffd_test_skip("huge page size is 0, feature missing?");
+		return;
+	}
+	if (!detect_huge_zeropage()) {
+		uffd_test_skip("transparent huge zeropage disabled");
+		return;
+	}
+
+	pmd_pages = pmd_size / gopts->page_size;
+	if (bytes < pmd_size) {
+		uffd_test_skip("not enough pages for one PMD-sized move");
+		return;
+	}
+
+	aligned_src = ALIGN_UP(orig_area_src, pmd_size);
+	aligned_dst = ALIGN_UP(orig_area_dst, pmd_size);
+	src_offs = (aligned_src - orig_area_src) / gopts->page_size;
+	dst_offs = (aligned_dst - orig_area_dst) / gopts->page_size;
+	max_offs = src_offs > dst_offs ? src_offs : dst_offs;
+	if (max_offs + pmd_pages > gopts->nr_pages) {
+		uffd_test_skip("could not find aligned PMD-sized src/dst window");
+		return;
+	}
+
+	if (madvise(orig_area_dst, bytes, MADV_HUGEPAGE))
+		err("madvise(MADV_HUGEPAGE) failure");
+	if (madvise(orig_area_src, bytes, MADV_DONTFORK))
+		err("madvise(MADV_DONTFORK) failure");
+	if (madvise(aligned_src, pmd_size, MADV_DONTNEED))
+		err("madvise(MADV_DONTNEED) failure");
+
+	/* Materialise a PMD-sized huge zeropage mapping in the source. */
+	force_read_pages(aligned_src, pmd_pages, gopts->page_size);
+
+	pagemap_fd = pagemap_open();
+	if (!uffd_pagemap_scan_get_categories(pagemap_fd, aligned_src, &categories)) {
+		close(pagemap_fd);
+		uffd_test_skip("PAGEMAP_SCAN unsupported");
+		return;
+	}
+	if ((categories & (PAGE_IS_PRESENT | PAGE_IS_PFNZERO | PAGE_IS_HUGE)) !=
+	    (PAGE_IS_PRESENT | PAGE_IS_PFNZERO | PAGE_IS_HUGE)) {
+		close(pagemap_fd);
+		uffd_test_skip("could not materialise a huge zeropage PMD mapping");
+		return;
+	}
+	gopts->area_src = aligned_src;
+	gopts->area_dst = aligned_dst;
+
+	if (uffd_register(gopts->uffd, gopts->area_dst, pmd_size, true, false, false))
+		err("register failure");
+
+	args.gopts = gopts;
+	args.handle_fault = uffd_move_pmd_handle_fault;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
+		err("uffd_poll_thread create");
+
+	/*
+	 * One fault on dst should trigger a single PMD-sized UFFDIO_MOVE from
+	 * the huge zeropage PMD we populated in the source.
+	 */
+	force_read_pages(gopts->area_dst, pmd_pages, gopts->page_size);
+
+	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
+	if (pthread_join(uffd_mon, NULL))
+		err("join() failed");
+
+	if (args.missing_faults != 1 || args.minor_faults != 0) {
+		uffd_test_fail("stats check error");
+	} else if (!uffd_pagemap_scan_get_categories(pagemap_fd, gopts->area_dst,
+						     &categories)) {
+		uffd_test_fail("PAGEMAP_SCAN unsupported");
+	} else if ((categories & (PAGE_IS_PRESENT | PAGE_IS_PFNZERO |
+				  PAGE_IS_HUGE)) !=
+			(PAGE_IS_PRESENT | PAGE_IS_PFNZERO | PAGE_IS_HUGE)) {
+		uffd_test_fail("moved destination is not a huge zeropage PMD");
+	} else if (!check_huge_anon(gopts->area_dst, 0, pmd_size)) {
+		/* vm_normal_page_pmd() must continue to treat the moved PMD as special. */
+		uffd_test_fail("moved huge zeropage PMD counted as AnonHugePages");
+	} else {
+		for (i = 0; i < pmd_size; i++) {
+			if (gopts->area_dst[i]) {
+				uffd_test_fail("moved huge zeropage PMD data is not zero");
+				goto out_restore;
+			}
+		}
+		uffd_test_pass();
+	}
+
+out_restore:
+	gopts->area_src = orig_area_src;
+	gopts->area_dst = orig_area_dst;
+	close(pagemap_fd);
+}
+
 static void uffd_move_pmd_split_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
 {
 	if (madvise(gopts->area_dst, gopts->nr_pages * gopts->page_size, MADV_NOHUGEPAGE))
@@ -1550,6 +1719,13 @@ uffd_test_case_t uffd_tests[] = {
 		.uffd_feature_required = UFFD_FEATURE_MOVE,
 		.test_case_ops = &uffd_move_test_pmd_case_ops,
 	},
+	{
+		.name = "move-pmd-huge-zeropage",
+		.uffd_fn = uffd_move_pmd_huge_zeropage_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = UFFD_FEATURE_MOVE,
+		.test_case_ops = &uffd_move_test_pmd_case_ops,
+	},
 	{
 		.name = "move-pmd-split",
 		.uffd_fn = uffd_move_pmd_split_test,
-- 
2.51.2


