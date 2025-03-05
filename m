Return-Path: <stable+bounces-120766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF9BA50837
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B25B165F53
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32F24C07D;
	Wed,  5 Mar 2025 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q7Ez4IHf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5819067C;
	Wed,  5 Mar 2025 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197911; cv=none; b=t7ULsu5tSTi0CSB10ObXTooTkirn+ktqxGbhgvadr/c9G8ZETqpy+2K+HnhMMAsJXa6cU+UjOJa7rI/2MYhBVXev/mMhbsOiJLaPy2vLc89jqFZIONin030uqBRiIIHPLwhKuIbAR5g9dXDL+z3dqA8quoUbTJMCiiwUu7wK7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197911; c=relaxed/simple;
	bh=lNoycixYT77py6N6Tqw7mC99kphzkdY87/OItPJADu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT7/wLGqqwXVYllHwynQRwUKgAzPKyEt3+pzwenGS+RwfUXWInZFq1PEyz478LvHkmZC51UjW7tREyZXDfxLfNg4zkdOhAc6ZSjvGGtXA7p5s/PKmIaDYVXANTlvyDAvKPnvHQQqxDaSb3ZQEXoMeJ3iKZinkqjOGGYtZ2NmZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q7Ez4IHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43F3C4CED1;
	Wed,  5 Mar 2025 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197911;
	bh=lNoycixYT77py6N6Tqw7mC99kphzkdY87/OItPJADu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7Ez4IHfjR7/588gkJ1brxert8VgGCbTpa9h6tCjT8MULP9d37X8UYWLSQ4NWcgFq
	 cDi2Tlm2FkUCx0ruJgOHKmin0K9kDmJZYoOMNaOr3/E9cHxbYoB+v0ajJ3VShOl6FB
	 cRVguGO0wGpjKQUN9alJbxA3AZSFWSPZ2jhqLg4g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.6 110/142] x86/microcode/amd: Use correct per CPU ucode_cpu_info
Date: Wed,  5 Mar 2025 18:48:49 +0100
Message-ID: <20250305174504.748108065@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Thomas Gleixner <tglx@linutronix.de>

commit ecfd41089348fa4cc767dc588367e9fdf8cb6b9d upstream

find_blobs_in_containers() is invoked on every CPU but overwrites
unconditionally ucode_cpu_info of CPU0.

Fix this by using the proper CPU data and move the assignment into the
call site apply_ucode_from_containers() so that the function can be
reused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231010150702.433454320@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/microcode/amd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -503,9 +503,6 @@ static void find_blobs_in_containers(uns
 	if (!get_builtin_microcode(&cp, x86_family(cpuid_1_eax)))
 		cp = find_microcode_in_initrd(ucode_path);
 
-	/* Needed in load_microcode_amd() */
-	ucode_cpu_info->cpu_sig.sig = cpuid_1_eax;
-
 	*ret = cp;
 }
 
@@ -513,6 +510,9 @@ static void apply_ucode_from_containers(
 {
 	struct cpio_data cp = { };
 
+	/* Needed in load_microcode_amd() */
+	ucode_cpu_info[smp_processor_id()].cpu_sig.sig = cpuid_1_eax;
+
 	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
 		return;



