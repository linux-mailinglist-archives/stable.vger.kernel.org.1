Return-Path: <stable+bounces-128197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE3A7B360
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B8F7A8243
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC041EEA33;
	Fri,  4 Apr 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOitS4+e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936771EE7B3;
	Fri,  4 Apr 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725122; cv=none; b=qJ7403DD5C3VYtWNmHfCD00Vu+wLXVR/suOkoT6er4I+ytOc9muFklMeYHjh2Li4+lqcajmuBLVwWcq7L2kuV1GvTJM/5eua1yQv13IRHy3g9AoaSNgMRDaDFlXwcdjiWaWunnDwbsf7Dk6Jq7RZTgH0HoFhpAxGmDQb8/+WRa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725122; c=relaxed/simple;
	bh=JeYzyS+9qEg8sDXUXVHebHJrZohuDT77IkPlS6VTL9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bo2Rkw+NkLHnONWr22IqapUKcXCM59Xm95i2iYUIGEP41Tv6NDE06cm6IEuH4H+Kj4zSCbhYadHSskc9C99TizCKTiasZyDi+kDJ5j/bWGOxcymTEeAVA4YL/c8lbZ1Yvd006TCHNXH0en7ZC6/SVw5EpRkn+lHQUn8/vHsh1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOitS4+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312A4C4CEE3;
	Fri,  4 Apr 2025 00:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725122;
	bh=JeYzyS+9qEg8sDXUXVHebHJrZohuDT77IkPlS6VTL9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GOitS4+e3X5z6WXeypkIcu/NV9MZxwTAMPvSsC6SOiWY5sANnzwXU5KSNxVWZaBlQ
	 r3uxp5qjAjz0uV5AvC7Cwkg11ew7eQlw3FNEdBusd0x/3MR+pzSCIi0XYnCoSk4qf9
	 nI88km33qmhFUKe4TriCtT6fLf1luGcYZqxL7EYRuJSgh+HiF0zfryHzNq7e3XJvyE
	 05wFxSKuY0xd3DcPoEid/Y+GeWA/Dj/8zjMT40DOHhZB9StZZgxYc4OyZhIZyFvwjp
	 tboRLVRkREL7Bs6LF2iBQkeYnZA+/pthCf0zp/Ln358S81kyvu0DHikn7zAjp/CI6O
	 WNKv9MtVjCf4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 13/22] parisc: PDT: Fix missing prototype warning
Date: Thu,  3 Apr 2025 20:04:42 -0400
Message-Id: <20250404000453.2688371-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000453.2688371-1-sashal@kernel.org>
References: <20250404000453.2688371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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


