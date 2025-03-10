Return-Path: <stable+bounces-121718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30A1A599B4
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E55916AE9E
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097E122D4D9;
	Mon, 10 Mar 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kbB96ZpT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GtkcfSU2"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C37227EA0;
	Mon, 10 Mar 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619870; cv=none; b=KGICZMhZhvKd96YB53Z0fZ33MekjzodOImj89HeAv2cc+Ta+jgLT0V7YUfJXI80EYkS4a53eI8dh2uAwZa+EEw8Mcs32Sk4hmU/ZpyZdsr70zAw8zbc8TQxvygkzmkR6q9fRy9miwUgioS287j0e4X48ofrmfTxWnyHubAsId3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619870; c=relaxed/simple;
	bh=cq5Im/NgOcTZ4rtPa09PGi4z5bXY7vuDuSLx3ZWUD2Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nDldyR4z+86hAnkuDy/giQ8PwJab25twEr+9B7y7yIFuiIEiAic5SJJ4WcMvyVMqYy71h9SZ7dW1XQSgm8JH0a57p2mGP29oONHncl57p2t6jAcgVL0lf4gbrSEh55oUsa+BJKWuQTXveW2PxTCfY3lwJWW+e9PLnJCFB4V2a0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kbB96ZpT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GtkcfSU2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 15:17:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741619867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjCXVwpRpL1HkRl3NKPzVuAOudC0kOAalJB1yrlrCZE=;
	b=kbB96ZpTbWOWEtTRHu/8OmDeRE+k8DuRxNLyzRNxwveydC5UDjliZOzmkXhaevffLF541u
	pnwWnCP64sQ31aXJfdkgKPDhN1VEZdLeI4Q6wpsoEbOhm0ARd/lIGZraW9SZARHc9h4HZy
	qaEBz4m4AAO+YnOMGbsde+60vfok6Cws3XY3VQmMp+RfmPAow2WWRpmhCe4yXUYzFy6DX/
	0YdrP+CIhJ5SK8/HRZZ6HB7SL2nxcQ349tbe19I35SrQDoUfF68qXV+ywZw0LlIdFFc4MS
	E+H9PHyKTyRJwBGFKYm9B3su0jKYble22iYcWrYe6H9zdP5336JymGvd/+FmrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741619867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjCXVwpRpL1HkRl3NKPzVuAOudC0kOAalJB1yrlrCZE=;
	b=GtkcfSU28f+3GgA4ByOMml9NAr9hZfj5wacArlLtZxkvKkZH1mHxS74f5rMDmqc8BTNDf2
	c/KZQCIIs8s0gQAg==
From: "tip-bot2 for Florent Revest" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/AMD: Fix out-of-bounds on systems
 with CPU-less NUMA nodes
Cc: Florent Revest <revest@chromium.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310144243.861978-1-revest@chromium.org>
References: <20250310144243.861978-1-revest@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174161986360.14745.5442918704046363367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e3e89178a9f4a80092578af3ff3c8478f9187d59
Gitweb:        https://git.kernel.org/tip/e3e89178a9f4a80092578af3ff3c8478f9187d59
Author:        Florent Revest <revest@chromium.org>
AuthorDate:    Mon, 10 Mar 2025 15:42:43 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 10 Mar 2025 16:02:54 +01:00

x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes

Currently, load_microcode_amd() iterates over all NUMA nodes, retrieves their
CPU masks and unconditionally accesses per-CPU data for the first CPU of each
mask.

According to Documentation/admin-guide/mm/numaperf.rst:

  "Some memory may share the same node as a CPU, and others are provided as
  memory only nodes."

Therefore, some node CPU masks may be empty and wouldn't have a "first CPU".

On a machine with far memory (and therefore CPU-less NUMA nodes):
- cpumask_of_node(nid) is 0
- cpumask_first(0) is CONFIG_NR_CPUS
- cpu_data(CONFIG_NR_CPUS) accesses the cpu_info per-CPU array at an
  index that is 1 out of bounds

This does not have any security implications since flashing microcode is
a privileged operation but I believe this has reliability implications by
potentially corrupting memory while flashing a microcode update.

When booting with CONFIG_UBSAN_BOUNDS=y on an AMD machine that flashes
a microcode update. I get the following splat:

  UBSAN: array-index-out-of-bounds in arch/x86/kernel/cpu/microcode/amd.c:X:Y
  index 512 is out of range for type 'unsigned long[512]'
  [...]
  Call Trace:
   dump_stack
   __ubsan_handle_out_of_bounds
   load_microcode_amd
   request_microcode_amd
   reload_store
   kernfs_fop_write_iter
   vfs_write
   ksys_write
   do_syscall_64
   entry_SYSCALL_64_after_hwframe

Change the loop to go over only NUMA nodes which have CPUs before determining
whether the first CPU on the respective node needs microcode update.

  [ bp: Massage commit message, fix typo. ]

Fixes: 7ff6edf4fef3 ("x86/microcode/AMD: Fix mixed steppings support")
Signed-off-by: Florent Revest <revest@chromium.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250310144243.861978-1-revest@chromium.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index c69b1bc..138689b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -1074,7 +1074,7 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 	if (ret != UCODE_OK)
 		return ret;
 
-	for_each_node(nid) {
+	for_each_node_with_cpus(nid) {
 		cpu = cpumask_first(cpumask_of_node(nid));
 		c = &cpu_data(cpu);
 

