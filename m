Return-Path: <stable+bounces-124244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA614A5EF2C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B697AA084
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7532E2661A6;
	Thu, 13 Mar 2025 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3pAwYG2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4FA2661A1
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856922; cv=none; b=Q7gCj3gvfU1yj6xxBZwnNlJ29H3SzcbSsVC3I6WFAfANliJZVWUwucmxpUDqyQRl3GWRn79Lyw/aEEQkKYKs6XqARcii/EDT5gXpwiBnyGQca+D2lk0n6RaUKEpS8TvfCXfyFrgPHk4KtAGGdJAvP5bP1Hm/BABEcdv9QV/CtFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856922; c=relaxed/simple;
	bh=9zvdt2V0W2s5Y1BNjYCVVwNQ/rEBxSbtSfpuuKkfe/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPOdr0uHGDrKELolPOC0Jc3G79AhoxR4aErwxlYk4PHba9hc4arV6OwcgitN/WiLZ16ZzFTD8kemlJn+ZNcQImX2XXI+gCagkurWyp8mdRPrZ07DGDcRjrv91QgfJ6USJmovLmcLNsCkb9pPY32Mc0dgyfG2GQfa/BEyBtKam1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3pAwYG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095BDC4CEDD;
	Thu, 13 Mar 2025 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856921;
	bh=9zvdt2V0W2s5Y1BNjYCVVwNQ/rEBxSbtSfpuuKkfe/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3pAwYG202t6u/Y+IoQZsU1S7GCPEtAO0mFdyzLmrlkoNFLPfmzzD7osuPt367Iwg
	 /FcYMTW0zTf99aK93R7ERLVnKcvEaV5EisoVwo0LR+a5F2lWMdELn48rpaZ00Zd1gb
	 FYBs5+phy5vXLQnzZYGzMgC0eojaM6eU4/h9LODP3ctKrAjaJ9HgCjHcpINF1lc8OM
	 wrCySwQ5V1YGTEGTEcZZ5aUh0VtSZrzIhiyKWEle1+lbLM91CqoF48HTqUSBvTNLMs
	 /kgnbDTF+tdsbm/m9PjANWzTgDHQND9W9HveULTRaIRHGI72xmJqbIML26EyCrv+7i
	 ApFl3lm5eml3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	revest@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2] x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes
Date: Thu, 13 Mar 2025 05:08:39 -0400
Message-Id: <20250312225058-1cc9b724b92697ce@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250310144243.861978-1-revest@chromium.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: e3e89178a9f4a80092578af3ff3c8478f9187d59

Note: The patch differs from the upstream commit:
---
1:  e3e89178a9f4a ! 1:  dc33caa61204c x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes
    @@ Metadata
      ## Commit message ##
         x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes
     
    -    Currently, load_microcode_amd() iterates over all NUMA nodes, retrieves their
    -    CPU masks and unconditionally accesses per-CPU data for the first CPU of each
    -    mask.
    +    Currently, load_microcode_amd() iterates over all NUMA nodes, retrieves
    +    their CPU masks and unconditonally accesses per-CPU data for the first
    +    CPU of each mask.
     
    -    According to Documentation/admin-guide/mm/numaperf.rst:
    -
    -      "Some memory may share the same node as a CPU, and others are provided as
    -      memory only nodes."
    -
    -    Therefore, some node CPU masks may be empty and wouldn't have a "first CPU".
    +    According to Documentation/admin-guide/mm/numaperf.rst: "Some memory may
    +    share the same node as a CPU, and others are provided as memory only
    +    nodes." Therefore, some node CPU masks may be empty and wouldn't have a
    +    "first CPU".
     
         On a machine with far memory (and therefore CPU-less NUMA nodes):
         - cpumask_of_node(nid) is 0
    @@ Commit message
           index that is 1 out of bounds
     
         This does not have any security implications since flashing microcode is
    -    a privileged operation but I believe this has reliability implications by
    -    potentially corrupting memory while flashing a microcode update.
    -
    -    When booting with CONFIG_UBSAN_BOUNDS=y on an AMD machine that flashes
    -    a microcode update. I get the following splat:
    -
    -      UBSAN: array-index-out-of-bounds in arch/x86/kernel/cpu/microcode/amd.c:X:Y
    -      index 512 is out of range for type 'unsigned long[512]'
    -      [...]
    -      Call Trace:
    -       dump_stack
    -       __ubsan_handle_out_of_bounds
    -       load_microcode_amd
    -       request_microcode_amd
    -       reload_store
    -       kernfs_fop_write_iter
    -       vfs_write
    -       ksys_write
    -       do_syscall_64
    -       entry_SYSCALL_64_after_hwframe
    -
    -    Change the loop to go over only NUMA nodes which have CPUs before determining
    -    whether the first CPU on the respective node needs microcode update.
    -
    -      [ bp: Massage commit message, fix typo. ]
    +    a privileged operation but I believe this has reliability implications
    +    by potentially corrupting memory while flashing a microcode update.
    +
    +    When booting with CONFIG_UBSAN_BOUNDS=y on an AMD machine that flashes a
    +    microcode update. I get the following splat:
    +
    +    UBSAN: array-index-out-of-bounds in arch/x86/kernel/cpu/microcode/amd.c:X:Y
    +    index 512 is out of range for type 'unsigned long[512]'
    +    [...]
    +    Call Trace:
    +     dump_stack+0xdb/0x143
    +     __ubsan_handle_out_of_bounds+0xf5/0x120
    +     load_microcode_amd+0x58f/0x6b0
    +     request_microcode_amd+0x17c/0x250
    +     reload_store+0x174/0x2b0
    +     kernfs_fop_write_iter+0x227/0x2d0
    +     vfs_write+0x322/0x510
    +     ksys_write+0xb5/0x160
    +     do_syscall_64+0x6b/0xa0
    +     entry_SYSCALL_64_after_hwframe+0x67/0xd1
    +
    +    This changes the iteration to only loop on NUMA nodes which have CPUs
    +    before attempting to update their microcodes.
     
         Fixes: 7ff6edf4fef3 ("x86/microcode/AMD: Fix mixed steppings support")
         Signed-off-by: Florent Revest <revest@chromium.org>
    -    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
         Cc: stable@vger.kernel.org
    -    Link: https://lore.kernel.org/r/20250310144243.861978-1-revest@chromium.org
     
      ## arch/x86/kernel/cpu/microcode/amd.c ##
     @@ arch/x86/kernel/cpu/microcode/amd.c: static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.1.y. Reject:

diff a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c	(rejected hunks)
@@ -1068,7 +1068,7 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 	if (ret != UCODE_OK)
 		return ret;
 
-	for_each_node(nid) {
+	for_each_node_with_cpus(nid) {
 		cpu = cpumask_first(cpumask_of_node(nid));
 		c = &cpu_data(cpu);
 
Patch failed to apply on stable/linux-5.15.y. Reject:

diff a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c	(rejected hunks)
@@ -1068,7 +1068,7 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 	if (ret != UCODE_OK)
 		return ret;
 
-	for_each_node(nid) {
+	for_each_node_with_cpus(nid) {
 		cpu = cpumask_first(cpumask_of_node(nid));
 		c = &cpu_data(cpu);
 
Patch failed to apply on stable/linux-5.10.y. Reject:

diff a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c	(rejected hunks)
@@ -1068,7 +1068,7 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 	if (ret != UCODE_OK)
 		return ret;
 
-	for_each_node(nid) {
+	for_each_node_with_cpus(nid) {
 		cpu = cpumask_first(cpumask_of_node(nid));
 		c = &cpu_data(cpu);
 
Patch failed to apply on stable/linux-5.4.y. Reject:

diff a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c	(rejected hunks)
@@ -1068,7 +1068,7 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 	if (ret != UCODE_OK)
 		return ret;
 
-	for_each_node(nid) {
+	for_each_node_with_cpus(nid) {
 		cpu = cpumask_first(cpumask_of_node(nid));
 		c = &cpu_data(cpu);
 

