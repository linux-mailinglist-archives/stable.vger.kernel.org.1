Return-Path: <stable+bounces-139611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA32DAA8D51
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEE316C58F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF7D5BAF0;
	Mon,  5 May 2025 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pgt3ORHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F231ACEDA
	for <stable@vger.kernel.org>; Mon,  5 May 2025 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431350; cv=none; b=c2DxFTd8yuEyeTDJKPGQQAMbzoFrl7e8cU2FTtEC13Q3yxJkE0jPhecYmpwjEVFoDHppKIEk2+JciuOIDUCNUQ7T9rQ/dygmq1vDFAb9vOG4xbyW7SeC7rIUq47C3ThfkB8Prxn8pwOEF/X/QD4HwaE/FkzkZjeM1jO3znQ9NJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431350; c=relaxed/simple;
	bh=BKYN0NWRGSuoZE7Nf/WXQ9EJtlXQnZRorZI7xcTg0Wg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ke2lz0isX5b83/tlP6FpZ7jx3+t5UbK4M62d+Y3SgJiXAZVXEEOpIdoS6tWX+BToByf3IDthNSl3ufkwrGspmgsjdJHbnLKxll7wgLmYqakfyUwlu8rdj+ZYW6bv8nNSXiD34dp54hGuB07Qn6V5V/uA6eyCPC0OVb1Xf0c4hxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pgt3ORHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09ADC4CEE4;
	Mon,  5 May 2025 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746431350;
	bh=BKYN0NWRGSuoZE7Nf/WXQ9EJtlXQnZRorZI7xcTg0Wg=;
	h=Subject:To:Cc:From:Date:From;
	b=pgt3ORHIPg3r6Qruejb7Q5zFnXMN+rfyJxM+xYltEYJpOaaWdjuOLMyJ4rv1msaqV
	 Ourg6XqR6WBQV3DeoEYugSuRgymIumJsNs9BNxx9gyDHdku4N+WCOV/t7oSf3g/pLF
	 3I8F3Cmzks3VdkTR24IBjCr/cMkGubE5aPtFAF5o=
Subject: FAILED: patch "[PATCH] drm: Select DRM_KMS_HELPER from" failed to apply to 5.10-stable tree
To: j@jannau.net,alyssa@rosenzweig.io,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 09:48:57 +0200
Message-ID: <2025050556-copier-vengeful-2f43@gregkh>
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
git cherry-pick -x 32dce6b1949a696dc7abddc04de8cbe35c260217
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050556-copier-vengeful-2f43@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32dce6b1949a696dc7abddc04de8cbe35c260217 Mon Sep 17 00:00:00 2001
From: Janne Grunau <j@jannau.net>
Date: Tue, 4 Mar 2025 20:12:14 +0100
Subject: [PATCH] drm: Select DRM_KMS_HELPER from
 DRM_DEBUG_DP_MST_TOPOLOGY_REFS

Using "depends on" and "select" for the same Kconfig symbol is known to
cause circular dependencies (cmp. "Kconfig recursive dependency
limitations" in Documentation/kbuild/kconfig-language.rst.
DRM drivers are selecting drm helpers so do the same for
DRM_DEBUG_DP_MST_TOPOLOGY_REFS.
Fixes following circular dependency reported on x86 for the downstream
Asahi Linux tree:

error: recursive dependency detected!
  symbol DRM_KMS_HELPER is selected by DRM_GEM_SHMEM_HELPER
  symbol DRM_GEM_SHMEM_HELPER is selected by RUST_DRM_GEM_SHMEM_HELPER
  symbol RUST_DRM_GEM_SHMEM_HELPER is selected by DRM_ASAHI
  symbol DRM_ASAHI depends on RUST
  symbol RUST depends on CALL_PADDING
  symbol CALL_PADDING depends on OBJTOOL
  symbol OBJTOOL is selected by STACK_VALIDATION
  symbol STACK_VALIDATION depends on UNWINDER_FRAME_POINTER
  symbol UNWINDER_FRAME_POINTER is part of choice block at arch/x86/Kconfig.debug:224
  symbol <choice> unknown is visible depending on UNWINDER_GUESS
  symbol UNWINDER_GUESS prompt is visible depending on STACKDEPOT
  symbol STACKDEPOT is selected by DRM_DEBUG_DP_MST_TOPOLOGY_REFS
  symbol DRM_DEBUG_DP_MST_TOPOLOGY_REFS depends on DRM_KMS_HELPER

Fixes: 12a280c72868 ("drm/dp_mst: Add topology ref history tracking for debugging")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/r/20250304-drm_debug_dp_mst_topo_kconfig-v1-1-e16fd152f258@jannau.net
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 2cba2b6ebe1c..f01925ed8176 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -188,7 +188,7 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
         bool "Enable refcount backtrace history in the DP MST helpers"
 	depends on STACKTRACE_SUPPORT
         select STACKDEPOT
-        depends on DRM_KMS_HELPER
+        select DRM_KMS_HELPER
         depends on DEBUG_KERNEL
         depends on EXPERT
         help


