Return-Path: <stable+bounces-39427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4F28A4F28
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2911C211C2
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD16CDD3;
	Mon, 15 Apr 2024 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NtvDJ2UZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851EB6F06A
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184593; cv=none; b=Igm3hb26hPp7PAve77K3fyiY9Lsp8Svg21keEek6P31Ryk29yNjqZaHw1Xa8X+LRjEBtaQtW3bmsJ8R1fW+fDwy1PCNk4qHNFQJRbcjDp3SgkAjdV8tT4D3MpUP/D2/1BUIWfM/iOWh4lEEChgFgK9Tr7wX/DR4W/3B6Q3GoYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184593; c=relaxed/simple;
	bh=rL1IMEDL16lNgRKyuDFZAXIIFbBfH12HhbKQ5vWrbqg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FTX+PeqEMCrpL4HIpABZZ5adM2rYX8+pPKrG2Z/rS1NO2BInYBFlgXU2MRNT0rVoPMVIwRCuaK56PQVZCawnRHYskV9ctCUP8oj+ssS969ujba3jAyDK9QRu1a3w9unonhlZoau4lq9tjMajTPJbYeVCAxTC0BObzSut+CHk7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NtvDJ2UZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C232C113CC;
	Mon, 15 Apr 2024 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713184593;
	bh=rL1IMEDL16lNgRKyuDFZAXIIFbBfH12HhbKQ5vWrbqg=;
	h=Subject:To:Cc:From:Date:From;
	b=NtvDJ2UZEHLmJ14OzCC9Agx7zbquCpWTOJmg0933BRxG4QL9KfZ5ahrpxRSRzjOZq
	 eY59glkXq71JaSK55pYlWNTbF1ZQq5m1VGXLMbe5MeFMFSmRQvrI5kfqz4GNOT/wLE
	 M9J5HSB60CZOVroq2j1aPcBi9yn23dO7rcPHir5w=
Subject: FAILED: patch "[PATCH] kprobes: Fix possible use-after-free issue on kprobe" failed to apply to 5.4-stable tree
To: zhengyejian1@huawei.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 14:36:26 +0200
Message-ID: <2024041525-compel-delta-953a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 325f3fb551f8cd672dbbfc4cf58b14f9ee3fc9e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041525-compel-delta-953a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

325f3fb551f8 ("kprobes: Fix possible use-after-free issue on kprobe registration")
1efda38d6f9b ("kprobes: Prohibit probes in gate area")
28f6c37a2910 ("kprobes: Forbid probing on trampoline and BPF code areas")
223a76b268c9 ("kprobes: Fix coding style issues")
9c89bb8e3272 ("kprobes: treewide: Cleanup the error messages for kprobes")
02afb8d6048d ("kprobe: Simplify prepare_kprobe() by dropping redundant version")
9840cfcb97fc ("Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 325f3fb551f8cd672dbbfc4cf58b14f9ee3fc9e8 Mon Sep 17 00:00:00 2001
From: Zheng Yejian <zhengyejian1@huawei.com>
Date: Wed, 10 Apr 2024 09:58:02 +0800
Subject: [PATCH] kprobes: Fix possible use-after-free issue on kprobe
 registration

When unloading a module, its state is changing MODULE_STATE_LIVE ->
 MODULE_STATE_GOING -> MODULE_STATE_UNFORMED. Each change will take
a time. `is_module_text_address()` and `__module_text_address()`
works with MODULE_STATE_LIVE and MODULE_STATE_GOING.
If we use `is_module_text_address()` and `__module_text_address()`
separately, there is a chance that the first one is succeeded but the
next one is failed because module->state becomes MODULE_STATE_UNFORMED
between those operations.

In `check_kprobe_address_safe()`, if the second `__module_text_address()`
is failed, that is ignored because it expected a kernel_text address.
But it may have failed simply because module->state has been changed
to MODULE_STATE_UNFORMED. In this case, arm_kprobe() will try to modify
non-exist module text address (use-after-free).

To fix this problem, we should not use separated `is_module_text_address()`
and `__module_text_address()`, but use only `__module_text_address()`
once and do `try_module_get(module)` which is only available with
MODULE_STATE_LIVE.

Link: https://lore.kernel.org/all/20240410015802.265220-1-zhengyejian1@huawei.com/

Fixes: 28f6c37a2910 ("kprobes: Forbid probing on trampoline and BPF code areas")
Cc: stable@vger.kernel.org
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9d9095e81792..65adc815fc6e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1567,10 +1567,17 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	jump_label_lock();
 	preempt_disable();
 
-	/* Ensure it is not in reserved area nor out of text */
-	if (!(core_kernel_text((unsigned long) p->addr) ||
-	    is_module_text_address((unsigned long) p->addr)) ||
-	    in_gate_area_no_mm((unsigned long) p->addr) ||
+	/* Ensure the address is in a text area, and find a module if exists. */
+	*probed_mod = NULL;
+	if (!core_kernel_text((unsigned long) p->addr)) {
+		*probed_mod = __module_text_address((unsigned long) p->addr);
+		if (!(*probed_mod)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+	/* Ensure it is not in reserved area. */
+	if (in_gate_area_no_mm((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
@@ -1580,8 +1587,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		goto out;
 	}
 
-	/* Check if 'p' is probing a module. */
-	*probed_mod = __module_text_address((unsigned long) p->addr);
+	/* Get module refcount and reject __init functions for loaded modules. */
 	if (*probed_mod) {
 		/*
 		 * We must hold a refcount of the probed module while updating


