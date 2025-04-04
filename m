Return-Path: <stable+bounces-128218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A4AA7B37A
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCE8189CF29
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA91FAC56;
	Fri,  4 Apr 2025 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt9f15ej"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0A1FAC33;
	Fri,  4 Apr 2025 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725168; cv=none; b=CCAqxi+ZtnfrbaMsDFh/YVHLXtg2jFQTVHqFj21Hf+Y6iWj79Yclbdz8/xj+RhPrDI8wWqH55LwE6O4mo2IipQsSHVkJZz7RQ8T5vPP4EtPyeGGisGPqFFtMgkSEKK59n4Jrj84leFRUUoLe3byjM+FvfZzle60Z+i60wC2d2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725168; c=relaxed/simple;
	bh=JeYzyS+9qEg8sDXUXVHebHJrZohuDT77IkPlS6VTL9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HqhU6Yh1cq3HzTPtGIqeiPU3kaw+CR0gAuwA8RVjuo+julKJnGq3CgOKFHSPmFI8GzuY/SBr8tqhbkn7gJQ6xX8g5GY0gDAsKCEPty9/P+Q+Ndj0d6stuvxcwUuBPS0BbbwoUuIpaYlyeC9NBZ4OKFDLZRWYWywjHH8p33ZRTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pt9f15ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC14C4CEE3;
	Fri,  4 Apr 2025 00:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725168;
	bh=JeYzyS+9qEg8sDXUXVHebHJrZohuDT77IkPlS6VTL9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pt9f15eji4rKDcwMfYxVFzx11KbYlEExYE1zXc/nAITyFgKENGil68aNm0PMokd33
	 0kOEGbKywdoMXTTX+VU2dlya4rXUtO0QGSTmKVLfrKg7NGgTKZdt+8R9skKk+cUKTO
	 x/NIY8ps4KgVMTR0mhO8aUpPi1yRNSVcdzX2kR1Y3OuX4kMQ9EXidTqzGwk74MKuk7
	 AUA9viZ6QPpDPTQawR8sTTEQmDURHYq0fOyPe3Osc0m6VyQ9wpl4qaiSUvc6PxryX2
	 nH9Wnx/Gh3RA/xZbr80QMK7vS1WuKRTuBMCsR4QjYj33vj8hQAviOTdBh9RX3IPU2t
	 RGYixV/hQzE9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 12/20] parisc: PDT: Fix missing prototype warning
Date: Thu,  3 Apr 2025 20:05:32 -0400
Message-Id: <20250404000541.2688670-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000541.2688670-1-sashal@kernel.org>
References: <20250404000541.2688670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Yu-Chun Lin <eleanor15x@gmail.com>

[ Upstream commit b899981750dcb958ceffa4462d903963ee494aa2 ]

As reported by the kernel test robot, the following error occurs:

arch/parisc/kernel/pdt.c:65:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      65 | void arch_report_meminfo(struct seq_file *m)
         |      ^~~~~~~~~~~~~~~~~~~

arch_report_meminfo() is declared in include/linux/proc_fs.h and only
defined when CONFIG_PROC_FS is enabled. Wrap its definition in #ifdef
CONFIG_PROC_FS to fix the -Wmissing-prototypes warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502082315.IPaHaTyM-lkp@intel.com/
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/pdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index 0f9b3b5914cf6..b70b67adb855f 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -63,6 +63,7 @@ static unsigned long pdt_entry[MAX_PDT_ENTRIES] __page_aligned_bss;
 #define PDT_ADDR_PERM_ERR	(pdt_type != PDT_PDC ? 2UL : 0UL)
 #define PDT_ADDR_SINGLE_ERR	1UL
 
+#ifdef CONFIG_PROC_FS
 /* report PDT entries via /proc/meminfo */
 void arch_report_meminfo(struct seq_file *m)
 {
@@ -74,6 +75,7 @@ void arch_report_meminfo(struct seq_file *m)
 	seq_printf(m, "PDT_cur_entries: %7lu\n",
 			pdt_status.pdt_entries);
 }
+#endif
 
 static int get_info_pat_new(void)
 {
-- 
2.39.5


