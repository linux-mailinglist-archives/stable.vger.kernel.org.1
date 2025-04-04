Return-Path: <stable+bounces-128234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8DFA7B3C0
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9839817B7E4
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A4A20127C;
	Fri,  4 Apr 2025 00:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thVAqFIT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2213202970;
	Fri,  4 Apr 2025 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725206; cv=none; b=GWYqSkyj80zvFdbcBHDrX3k1WA6OqOy0/McPMffEcxCLWKRERKrPRR+IhC7BdhyyMIZtbkWaRQ3DxjfyWnZx15h13BNZTvQIx3VnNmXFlcuJ3R3nrLAnwS9irgi5reCr0RhPgkuOwuHSs7Xh92fTX2VC6f2ZY1CY0EgWSDe8/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725206; c=relaxed/simple;
	bh=JeYzyS+9qEg8sDXUXVHebHJrZohuDT77IkPlS6VTL9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZs5hSSJVvheWmd2dalvx+4pTHd54bIeVWGYrMrV1nTKerFv4cFylGx2R+lN58szvGsuBhGUwr7/8znAfAEsMnAZaK/UFe2C4mhBi2B3XwhQTHPU2UIVywsO2wu/UG5V9CEoEqT/rhluD4B9M/B7EfZ+nP6Y1RntDxYHn6+oXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thVAqFIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F88AC4CEE3;
	Fri,  4 Apr 2025 00:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725204;
	bh=JeYzyS+9qEg8sDXUXVHebHJrZohuDT77IkPlS6VTL9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thVAqFIT0uZhlNScv/44vjtx4/sYQ8N6M397HeCrZRdXsIVsx3fSnAARO/78PJZm+
	 vrS7tQEt2uJS+lutL4Qd1yAQ86Zg/8WIvuzPF+2ra2MXlz/UH+XHRzXQKlukDI++CM
	 dEu9dc5I4ax3VQBV7aFMsvIDBna9DmT2um/MRLJAjPNBsVADOjYOIdndhtAgJ6r9dt
	 yKxpADQ+E1VvfKasJlVDx6co6viP45wnkcFmGkMRvV7O/4cideSu0vBUKglVGEm1OS
	 h/NIMK9X6tzGnC5Alh5B++MA+R+fN+UlI9j44Bd/Xf2Nz3J11SctUFS3Be0f02R9dG
	 xi6LZyAav7nKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/16] parisc: PDT: Fix missing prototype warning
Date: Thu,  3 Apr 2025 20:06:16 -0400
Message-Id: <20250404000624.2688940-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000624.2688940-1-sashal@kernel.org>
References: <20250404000624.2688940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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


