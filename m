Return-Path: <stable+bounces-139609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65668AA8D4F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC94167973
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED21ACEDA;
	Mon,  5 May 2025 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufXvzF5S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E4176AC8
	for <stable@vger.kernel.org>; Mon,  5 May 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431339; cv=none; b=n4qqh/ZH6XAtkQaaOD1RZV9IqzDcPJkzrFvAtY4p+d24xi2HGGKZqNpyx+Br0IX+uk8pigjMJVIUS0ClvJOqzVND7CymNz0Cj7tCaW10qpQlo+gJpWmoKQ+2CzTILbPrEvucNMEpr1zHX3OjSdFmzvqeA5pn6Z8MR0t+4NHgTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431339; c=relaxed/simple;
	bh=w1Q/O1s84GMI1Nir3nR3FtrnGv3zYc6liQPB3et/M9Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ta5cmEyjH1P/ulV+9+hl1QATNHK7tsyQ8jm02cqBnZQIeHlOn3SI7faRre4n4Td0FEf/WiSdd8SSmDtmHpLKu9iy75Npown9OYLRHoGmxZxO9+XSTmwA09bczHJcPNKi6ooAHsqfwvHieFx0edV4B0zdOmytiR7bYFo9cfwCTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufXvzF5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0257C4CEE4;
	Mon,  5 May 2025 07:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746431338;
	bh=w1Q/O1s84GMI1Nir3nR3FtrnGv3zYc6liQPB3et/M9Q=;
	h=Subject:To:Cc:From:Date:From;
	b=ufXvzF5SlJ8lCIrSukagV7rnChS7muH1O1deAByr7GxIEmpbUBuPHofao9Z9emetM
	 +0NuO1crMTEWicbYGtijJH5LJYw7JewLWIXYRttaYPjxTv8CKppOh/P8PVXaLUzHGf
	 u+rEHmeZ36N/SdxLtjCNZ4jvu2LyT1PizFBQ8EKc=
Subject: FAILED: patch "[PATCH] drm: Select DRM_KMS_HELPER from" failed to apply to 6.1-stable tree
To: j@jannau.net,alyssa@rosenzweig.io,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 09:48:55 +0200
Message-ID: <2025050555-pulse-ended-2cea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 32dce6b1949a696dc7abddc04de8cbe35c260217
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050555-pulse-ended-2cea@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


