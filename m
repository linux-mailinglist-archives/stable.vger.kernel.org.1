Return-Path: <stable+bounces-52647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BA890C6E2
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D5A1C22263
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 10:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46E1A01C7;
	Tue, 18 Jun 2024 08:14:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F913AA37;
	Tue, 18 Jun 2024 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698446; cv=none; b=MjzMsNUD1Dzl8pil1P6vO00JCZtn4hNAl3N9e/Nn/+Vv1b2pqSs5pkdN/lIEMoKC6eTT5PFWq8uB9necQGzw5ihyony4u/RiSg9p+IL+07VtIMIugLHIlLyiHJuq+qsW7GGN5RRp+VTdqtrVsLhs0POswv3yKna5TaMfTl3sxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698446; c=relaxed/simple;
	bh=kPdBCmlMWBn+IZLlVV3NgKy7HzxVhDpmBE7BSyumcuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8SW1RZ4knxxGxvyTparCOCdxpJr/86A+PXHgdFxlA4j2HQaiwDLXcH4BumMKV4PTPp/YibYZuFbRwIyhryJdM0GhbjdDa30igMK3e+wJDkS89hStugl42H2FKRE6EetD93+OWyk2omtFOAuaE6XcYg2frxy1b8yQj4eNfFVzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51050C3277B;
	Tue, 18 Jun 2024 08:14:04 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] cpu: Fix broken cmdline "nosmp" and "maxcpus=0"
Date: Tue, 18 Jun 2024 16:13:36 +0800
Message-ID: <20240618081336.3996825-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the reworking of "Parallel CPU bringup", the cmdline "nosmp" and
"maxcpus=0" is broken. Because these parameters make setup_max_cpus be
zero, and setup_max_cpus is the "max_cpus" of bringup_nonboot_cpus().
In this case, "if (!--ncpus)" will not be true in cpuhp_bringup_mask(),
and the result is all the possible cpus are brought up.

We can fix it by changing "if (!--ncpus)" to "if (!ncpus--)". But to
make logic more clear and save some cpu cycles, it is better to check
"max_cpus" in bringup_nonboot_cpus(), return early if it is zero.

Cc: stable@vger.kernel.org
Fixes: 18415f33e2ac4ab382 ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
Fixes: 06c6796e0304234da6 ("cpu/hotplug: Fix off by one in cpuhp_bringup_mask()")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 kernel/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 563877d6c28b..200974a31de8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1859,6 +1859,9 @@ static inline bool cpuhp_bringup_cpus_parallel(unsigned int ncpus) { return fals
 
 void __init bringup_nonboot_cpus(unsigned int max_cpus)
 {
+	if (!max_cpus)
+		return;
+
 	/* Try parallel bringup optimization if enabled */
 	if (cpuhp_bringup_cpus_parallel(max_cpus))
 		return;
-- 
2.43.0


