Return-Path: <stable+bounces-128248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D51A7B3E5
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBA417BEB9
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A92066E5;
	Fri,  4 Apr 2025 00:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZP9xrg7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16792066DD;
	Fri,  4 Apr 2025 00:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725238; cv=none; b=hc4Y7QAkxs4+ePmdvv1SfpszydZ9DReJ3TUwGkKKVcyuRj5WPK1tEY+Ruh3ouQL1m73chEPszURFV012OuTNZSMYJLy32vJczuXAge8G2ZM0dH5tl67J8HILwaYGRGwL3RKIR722qS3SyqFUjgmBWFiBUs/LsufSJnzuDmlSGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725238; c=relaxed/simple;
	bh=6eKsFR3Cj7BscP4StJYnGlYEqUNFzKdHa4LmC6vXErc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sv61tSM0pEFSh8Vu+Wnea+fFxqMCc9bR8b2iNisQHXyIvpzESljRWbIrBAO3ryYSk2zBttXPsgKxu04qLqqfBQrg10OLmSkhs/bB68UCw6wxDDFC0e6yVopVAn8GUUIIilKg3/rH/mGsUO/VwotYVJgTyzw9IEIpEdCvwQXKqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZP9xrg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E2AC4CEE5;
	Fri,  4 Apr 2025 00:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725238;
	bh=6eKsFR3Cj7BscP4StJYnGlYEqUNFzKdHa4LmC6vXErc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZP9xrg71/OMGfh3C6FngCwa17V3EW5BqDt233HcVg6dIccMrrw+oLPF/Vhe7ClsS
	 YE+FWajfBvSZtFZTPtUyl2AnTbcWQoQpuhlEeyI7O6eEYFQOb9SE6LxbiOmqjzN8Qj
	 bw69nl9A5w7w+uaTOCcMX0ivAwYoxCXNsjwUJtHujKQBb5zAvpEm96BWrXbj9jv1yD
	 ONHtwae4p0x8W2Yg33SCZb9AX6BAcdzxRpDZ92U8x/MZELBz22OoEWiYWneTJR64di
	 BNDXdBNWinckJBzYFBAGZe5xfl1CG42yijhui4d6tAVJBO8NNW8urkX8hdfIpkJdmF
	 4VuhxRvFYeBDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/10] parisc: PDT: Fix missing prototype warning
Date: Thu,  3 Apr 2025 20:06:57 -0400
Message-Id: <20250404000700.2689158-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000700.2689158-1-sashal@kernel.org>
References: <20250404000700.2689158-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index e391b175f5ece..7dbb241a9fb77 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -62,6 +62,7 @@ static unsigned long pdt_entry[MAX_PDT_ENTRIES] __page_aligned_bss;
 #define PDT_ADDR_PERM_ERR	(pdt_type != PDT_PDC ? 2UL : 0UL)
 #define PDT_ADDR_SINGLE_ERR	1UL
 
+#ifdef CONFIG_PROC_FS
 /* report PDT entries via /proc/meminfo */
 void arch_report_meminfo(struct seq_file *m)
 {
@@ -73,6 +74,7 @@ void arch_report_meminfo(struct seq_file *m)
 	seq_printf(m, "PDT_cur_entries: %7lu\n",
 			pdt_status.pdt_entries);
 }
+#endif
 
 static int get_info_pat_new(void)
 {
-- 
2.39.5


