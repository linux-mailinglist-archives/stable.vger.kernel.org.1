Return-Path: <stable+bounces-39807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D758A54D8
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669491C22241
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1682D89;
	Mon, 15 Apr 2024 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aG+kr0LG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB581205;
	Mon, 15 Apr 2024 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191873; cv=none; b=YUtCiUUx5zI9KuEFdgGaDJuMmhnhgRG7+lF3cskNlubSxcslBzPapcxtcOZbC+wR34mlMWBP07lDCPFytdiaok0NNXNOORvyRR8F/43zdCFR3y4p17mKzkeCEHOhNOjQRBT6CF02hhGpM8Ztl/GrAY3wmIpR50khBteJDEJuuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191873; c=relaxed/simple;
	bh=JDI+UU/5HIKci4X6xShBnL70Iw1yej7PIUqWNLH8ZHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRpjv8PDEPDsNey75XOxv9T4k1vjDoFWxVjPPcWuSrDenUBjVq6vYlo3Wg5gsaLd5nD5K0OuPHKFLybT7brxm4esIiQfOg34rejScQmjGDEA0EJB5zjeqVbISM/VuK7nMLyUPPOwfSdVTybiHPxZhtu4ELQEaGhivD/CBMD5JyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aG+kr0LG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3190C113CC;
	Mon, 15 Apr 2024 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191873;
	bh=JDI+UU/5HIKci4X6xShBnL70Iw1yej7PIUqWNLH8ZHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aG+kr0LGAUQNXWyDjH9cY2DGMRbLT7oTiTMZ2gygqIvUKRaOQf/9cABMCOGZuCZc4
	 1nvcpNRfUtR+9fcAKQRuZme4ALXjLqjWQwEe2C9IgnhdeqZxzTq8qqw33nmr/Dqhf+
	 HNHHK6R2Kj2nSaxE3VcB1sptUyge4b6ArEPs9yUQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.6 113/122] x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto
Date: Mon, 15 Apr 2024 16:21:18 +0200
Message-ID: <20240415141956.762609959@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
References: <20240415141953.365222063@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

commit 36d4fe147c870f6d3f6602befd7ef44393a1c87a upstream.

Unlike most other mitigations' "auto" options, spectre_bhi=auto only
mitigates newer systems, which is confusing and not particularly useful.

Remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/412e9dc87971b622bbbaf64740ebc1f140bff343.1712813475.git.jpoimboe@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/hw-vuln/spectre.rst   |    4 ----
 Documentation/admin-guide/kernel-parameters.txt |    3 ---
 arch/x86/Kconfig                                |    4 ----
 arch/x86/kernel/cpu/bugs.c                      |   10 +---------
 4 files changed, 1 insertion(+), 20 deletions(-)

--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -669,10 +669,6 @@ kernel command line.
 			needed.
 		off
 			Disable the mitigation.
-		auto
-			Enable the HW mitigation if needed, but
-			*don't* enable the SW mitigation except for KVM.
-			The system may be vulnerable.
 
 For spectre_v2_user see Documentation/admin-guide/kernel-parameters.txt
 
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5929,9 +5929,6 @@
 			on   - (default) Enable the HW or SW mitigation
 			       as needed.
 			off  - Disable the mitigation.
-			auto - Enable the HW mitigation if needed, but
-			       *don't* enable the SW mitigation except
-			       for KVM.  The system may be vulnerable.
 
 	spectre_v2=	[X86] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2584,10 +2584,6 @@ config SPECTRE_BHI_OFF
 	bool "off"
 	help
 	  Equivalent to setting spectre_bhi=off command line parameter.
-config SPECTRE_BHI_AUTO
-	bool "auto"
-	help
-	  Equivalent to setting spectre_bhi=auto command line parameter.
 
 endchoice
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1624,13 +1624,10 @@ static bool __init spec_ctrl_bhi_dis(voi
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
 	BHI_MITIGATION_ON,
-	BHI_MITIGATION_AUTO,
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_SPECTRE_BHI_ON)  ? BHI_MITIGATION_ON  :
-	IS_ENABLED(CONFIG_SPECTRE_BHI_OFF) ? BHI_MITIGATION_OFF :
-					     BHI_MITIGATION_AUTO;
+	IS_ENABLED(CONFIG_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {
@@ -1641,8 +1638,6 @@ static int __init spectre_bhi_parse_cmdl
 		bhi_mitigation = BHI_MITIGATION_OFF;
 	else if (!strcmp(str, "on"))
 		bhi_mitigation = BHI_MITIGATION_ON;
-	else if (!strcmp(str, "auto"))
-		bhi_mitigation = BHI_MITIGATION_AUTO;
 	else
 		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
 
@@ -1672,9 +1667,6 @@ static void __init bhi_select_mitigation
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
 
-	if (bhi_mitigation == BHI_MITIGATION_AUTO)
-		return;
-
 	/* Mitigate syscalls when the mitigation is forced =on */
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");



