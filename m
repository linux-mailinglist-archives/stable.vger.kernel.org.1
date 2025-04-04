Return-Path: <stable+bounces-128272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6AA7B41C
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8AD174C67
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AC421D59A;
	Fri,  4 Apr 2025 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILCeU27G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE221D3F4;
	Fri,  4 Apr 2025 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725302; cv=none; b=nze30omg5SCQ1pR8qxbMqILigKC4VpQuw4XUk0lpMAVzP+rclMtouI0WUtX7+6AkBqTq8d58ysUq4ws7f8Q5GgBgjQE8ZVx/gKZ1VhLStenu3HEhUHcPEjzr2A3rhbGf1jdA2rkDRkXoxW6QD9brIeezXNmpjqWvvOtpv72ieoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725302; c=relaxed/simple;
	bh=C2aYYsrokTBwQEtyrgRYX4irSLiH2QgMYj8lqjuUA2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=skh39AjqBNrBqznsY5cmfZhyIuBo+5pyM/qsc2Yj+RTy9UX599a3qoRQblcj2wtc/ldmNI0iN4T7vx9ovAIu69pGaAFUDx8f98x9VmryJ2nHJJSLnr4jklhs6DVJiMd277XaP3jj7QbigyOj6moGjVQ5k2BN1sjKn3UnqxSmKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILCeU27G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A273C4CEE5;
	Fri,  4 Apr 2025 00:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725302;
	bh=C2aYYsrokTBwQEtyrgRYX4irSLiH2QgMYj8lqjuUA2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILCeU27GerhRIr6AaUVfh6M3Urb8eTU3XmnwGlLIo7kt70lVj/7d/CLHem9OEs4F0
	 FIBltROg0Zx6mGRCdGGmbolGdqQKgndJFguqr6fOF9BLm3wJ7vX7xAP136oNW3KvID
	 QrSF7qYK3Q/WKO7AgGCuuaOhfJCv8x6gnlQjuqrs4oFYpiBU1UeAndtW3rBZI1/YCw
	 opH5nGeNYLjMU5gsxoqt9cjg5/adZOiW6r+NqPbKhlMoOvtcG8cThgAtZKCrH4z2tL
	 P78PwZAVLU3rWmBylmy49J57q7YKULEL778OVfbHDScqFxKGN/H9JDGSdpt3Bjg5LM
	 yiFCUqMqbawaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/6] parisc: PDT: Fix missing prototype warning
Date: Thu,  3 Apr 2025 20:08:06 -0400
Message-Id: <20250404000809.2689525-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000809.2689525-1-sashal@kernel.org>
References: <20250404000809.2689525-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index 36434d4da381a..d1c980900cdd4 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -60,6 +60,7 @@ static unsigned long pdt_entry[MAX_PDT_ENTRIES] __page_aligned_bss;
 #define PDT_ADDR_PERM_ERR	(pdt_type != PDT_PDC ? 2UL : 0UL)
 #define PDT_ADDR_SINGLE_ERR	1UL
 
+#ifdef CONFIG_PROC_FS
 /* report PDT entries via /proc/meminfo */
 void arch_report_meminfo(struct seq_file *m)
 {
@@ -71,6 +72,7 @@ void arch_report_meminfo(struct seq_file *m)
 	seq_printf(m, "PDT_cur_entries: %7lu\n",
 			pdt_status.pdt_entries);
 }
+#endif
 
 static int get_info_pat_new(void)
 {
-- 
2.39.5


