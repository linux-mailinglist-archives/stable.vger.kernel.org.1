Return-Path: <stable+bounces-185897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B784BE2319
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E1814EE2F9
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7D630102C;
	Thu, 16 Oct 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1QxUbAS0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3BB2FF65D
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604094; cv=none; b=Twh+cx5u3eLFa6xLDIlwEW5g7Axcmcqaf8tU9vbN5f6NYp1zg/eljQnZyHUGP7ZGOdjkiTNl3L0EzB9qZXi7mUgedouqySDc155gGif54g1E6bPJvCtnKa3F9NvpBPIbll1bA+8rdk8JqmZzAZO4GuZhN+a1Ma2tuBja4Fy9lP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604094; c=relaxed/simple;
	bh=/aOynAN+ht+AltAFDMhUFdf+jJls5kHoOILh5YBlqv8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cduZNP7tvswoO3qi9b78TRcsBhbb5yhshLleO458QAmAeerGYx0uqbVLwesiYxLr57BeEbExaIUxx6epLl96TzBuet7Xo4lOjmQxq0c0g1hvk7Q5sXDoDt21KQnfHiuphX6a1GmRkbmyuC8jgYS3OjuOoqeCV8leKNtS37/ppi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1QxUbAS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1216C4CEF1;
	Thu, 16 Oct 2025 08:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760604094;
	bh=/aOynAN+ht+AltAFDMhUFdf+jJls5kHoOILh5YBlqv8=;
	h=Subject:To:Cc:From:Date:From;
	b=1QxUbAS0Y0ci0eZTwDhSkJj/GsltjUd2jg67uwj/nDVSy4VO9vKhqpdNveNJW9uZi
	 5WRs7ZyG9TMNY4JR40vPT7eoquwPfdJUIaxMVQFg/RXEcW6HHeS+jUDQz6UhRAKDh9
	 Tv7g941c3qhclu1umbY43nIs2DRqF2b3soXPKVS8=
Subject: FAILED: patch "[PATCH] arm64: kprobes: call set_memory_rox() for kprobe page" failed to apply to 5.10-stable tree
To: yang@os.amperecomputing.com,catalin.marinas@arm.com,stable@vger.kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 10:41:31 +0200
Message-ID: <2025101631-croon-serving-8366@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 195a1b7d8388c0ec2969a39324feb8bebf9bb907
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101631-croon-serving-8366@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 195a1b7d8388c0ec2969a39324feb8bebf9bb907 Mon Sep 17 00:00:00 2001
From: Yang Shi <yang@os.amperecomputing.com>
Date: Thu, 18 Sep 2025 09:23:49 -0700
Subject: [PATCH] arm64: kprobes: call set_memory_rox() for kprobe page

The kprobe page is allocated by execmem allocator with ROX permission.
It needs to call set_memory_rox() to set proper permission for the
direct map too. It was missed.

Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 0c5d408afd95..8ab6104a4883 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "kprobes: " fmt
 
+#include <linux/execmem.h>
 #include <linux/extable.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
@@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 static void __kprobes
 post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 
+void *alloc_insn_page(void)
+{
+	void *addr;
+
+	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
+	if (!addr)
+		return NULL;
+	set_memory_rox((unsigned long)addr, 1);
+	return addr;
+}
+
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	kprobe_opcode_t *addr = p->ainsn.xol_insn;


