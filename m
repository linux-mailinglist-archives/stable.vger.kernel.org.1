Return-Path: <stable+bounces-39425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9421B8A4F27
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161CFB20F40
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9396D6EB5B;
	Mon, 15 Apr 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sYrKeVdA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A96F076
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184587; cv=none; b=oifJdXBgJm4ij4HTnf4qR7jg3BLHadIPkLT8TLM8jjwDRfkr2rzEdJ2lYj0OcZ5aMFdif/QbGo/Fa0GECvpPJWINm2P8DNttT7yQpIqdtHABGc7UhhF+OuFNwXtngqAds1EOHiyZEc70WTO9rRoRTNza8lHqwhqJTYbyCJvJ8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184587; c=relaxed/simple;
	bh=KzfXrrv2tmpyu+VJ8eApN0ThXYxAIpoiWcwIfbE/J3s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Gj5K1mYRqrhPbuFfzyazH4o6kcpGiXvFdP6gCSJvBbU256ErPQcAZYHyO9NuDfRJFBcYBDybwT9Ijl8r9mGn9UXgcu/FvIUFw+Bmo6lU5Eboh6Z3msifwNp7LP9BchkYCTjeVvL5UJHMwDlYyBpAKIuQH50asj5ZvQslfiA/my4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sYrKeVdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86110C113CC;
	Mon, 15 Apr 2024 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713184586;
	bh=KzfXrrv2tmpyu+VJ8eApN0ThXYxAIpoiWcwIfbE/J3s=;
	h=Subject:To:Cc:From:Date:From;
	b=sYrKeVdAW3EzoMNg800brp0Q8CAPD7NlMjAmp4f7bc1m6I8kav5oEGfSP/Ar89oA5
	 fLy5SKz+tNCYrkNU+n16zY1pWgSeRiqLSPBSgL3nNkAkL8iIt6hNmmO0dyXXARnx83
	 JmEL4Tixjp7Ru+6wmyOOxV57NIuGjFQYqUqZpmGw=
Subject: FAILED: patch "[PATCH] kprobes: Fix possible use-after-free issue on kprobe" failed to apply to 5.15-stable tree
To: zhengyejian1@huawei.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 14:36:24 +0200
Message-ID: <2024041524-monoxide-kilobyte-1c44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 325f3fb551f8cd672dbbfc4cf58b14f9ee3fc9e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041524-monoxide-kilobyte-1c44@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

325f3fb551f8 ("kprobes: Fix possible use-after-free issue on kprobe registration")
1efda38d6f9b ("kprobes: Prohibit probes in gate area")
28f6c37a2910 ("kprobes: Forbid probing on trampoline and BPF code areas")
223a76b268c9 ("kprobes: Fix coding style issues")
9c89bb8e3272 ("kprobes: treewide: Cleanup the error messages for kprobes")
02afb8d6048d ("kprobe: Simplify prepare_kprobe() by dropping redundant version")

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


