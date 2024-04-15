Return-Path: <stable+bounces-39428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCF78A4F2C
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A5FB21037
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4EA6F07D;
	Mon, 15 Apr 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z0IXetHM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE466F513
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184596; cv=none; b=VIok1L2/tn4JuxIxHipT1n96DeWNdTpD+mtqGcW8o/J3/EVXNoVf5MWluBahKpR41dXf2nU9PSAor+SSP2Cgul2fyuMTgdUPVmetwcWh80V3lPaH7l6/W50mBqX/eQjrsdajF9zBodGBBsjEfJ1X/FjbPEX8lJ8QyMMSefoULn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184596; c=relaxed/simple;
	bh=W9MvkYHkX0Vdpk669AXGr+RX0PV3StwqoXF1QjG9UY4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G02HnXDVGqXHU91X1FvpShBHheUN9pMJoTVhcZxi69YA3B6AqeENpVVlft3Tr9hWmGqDVIVx+K2hwr625nrcBqvO2hVXsm3N2S4rPIcFSxtMgc5HRuhAxqckvtOM2Bnh6oDZaTbJLGXP8I0j/pSe3yjPbn/X+4ROCYdkpb9v7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z0IXetHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96093C2BD10;
	Mon, 15 Apr 2024 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713184596;
	bh=W9MvkYHkX0Vdpk669AXGr+RX0PV3StwqoXF1QjG9UY4=;
	h=Subject:To:Cc:From:Date:From;
	b=z0IXetHMi0wlXzbFBVf9YsagV1mBx3A9KMugbBm00Mfsx8P3OEoliy6BRP0aCqc/p
	 pveQNsC8sG6Mqs8Xugr5vCWv4qFxAvubkxJBWw/6p0BY7NeNuQLpMTHssP4Z41mjui
	 YxhnHiyatFbRnqhxZ76ggi6z+2xhD4y7vUIOQkzw=
Subject: FAILED: patch "[PATCH] kprobes: Fix possible use-after-free issue on kprobe" failed to apply to 4.19-stable tree
To: zhengyejian1@huawei.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 14:36:27 +0200
Message-ID: <2024041526-whisking-flyover-825a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 325f3fb551f8cd672dbbfc4cf58b14f9ee3fc9e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041526-whisking-flyover-825a@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


