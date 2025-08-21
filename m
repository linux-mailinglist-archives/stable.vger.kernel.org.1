Return-Path: <stable+bounces-172143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8471B2FD1F
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5891D246EC
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6862343C2;
	Thu, 21 Aug 2025 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GraH3TMB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4F229B21
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786866; cv=none; b=AkbgSc+UnhYe/XGmzEmtL0Nq/+cNbQ5Gmp7BcN2L+kjYDFWIzl8H3+mY0yBvFPzymsqgtRcYHJjUbFEjjRq1goeW+kG0L8xQRFF/k+YOGT8eIhLtBJvQZNrJUYbCu7HOnPAa/wX4no3+LQJ/EhjN+eLPTMt1OV87npT1bvGXOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786866; c=relaxed/simple;
	bh=PfJuvv6kD0C0HK07Xc/koHziJ7m1cu8w4zKkU/HYUps=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VlCw80pBvT+BPXxXqbCB1URvo6nFJwqYhRH6iofMtg4a6knf5twOUghitPJs3kICX5QrAq7IctpSr76/PvnKilYgdZWddPqU0G4tQAzYQ8j7RxN3/T0YP0C7f5ZELxvoIRzCL1FeDyMYLobq3+evbkDuweV0EriB4wSuatNV6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GraH3TMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8FDC4CEED;
	Thu, 21 Aug 2025 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786866;
	bh=PfJuvv6kD0C0HK07Xc/koHziJ7m1cu8w4zKkU/HYUps=;
	h=Subject:To:Cc:From:Date:From;
	b=GraH3TMB4J0yDflIwld6q8ar83t5DiiKnNOYuSkNy4gU7TIQYf3EmF3b97SWUGHJn
	 8yPnaox4OqC2WcYN6/oKOy8AP5TTET93PjNzaNfYcGcnB1cvWvQ+FlI8ojizHOWM60
	 tQA+xu6L4IlR4A/3YjGkYTLYVS4hU+CZN801KLVo=
Subject: FAILED: patch "[PATCH] drm/gpusvm: Introduce devmem_only flag for allocation" failed to apply to 6.16-stable tree
To: himal.prasad.ghimiray@intel.com,matthew.brost@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:34:12 +0200
Message-ID: <2025082112-ecologist-starry-b438@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 8a9b978ebd47df9e0694c34748c2d6fa0c31eb4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082112-ecologist-starry-b438@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a9b978ebd47df9e0694c34748c2d6fa0c31eb4d Mon Sep 17 00:00:00 2001
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Date: Mon, 12 May 2025 06:54:55 -0700
Subject: [PATCH] drm/gpusvm: Introduce devmem_only flag for allocation

This commit adds a new flag, devmem_only, to the drm_gpusvm structure. The
purpose of this flag is to ensure that the get_pages function allocates
memory exclusively from the device's memory. If the allocation from
device memory fails, the function will return an -EFAULT error.

Required for shared CPU and GPU atomics on certain devices.

v3:
 - s/vram_only/devmem_only/

Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://lore.kernel.org/r/20250512135500.1405019-2-matthew.brost@intel.com

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index de424e670995..a58d03e6cac2 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1454,6 +1454,11 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
 				goto err_unmap;
 			}
 
+			if (ctx->devmem_only) {
+				err = -EFAULT;
+				goto err_unmap;
+			}
+
 			addr = dma_map_page(gpusvm->drm->dev,
 					    page, 0,
 					    PAGE_SIZE << order,
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index df120b4d1f83..9fd25fc880a4 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -286,6 +286,7 @@ struct drm_gpusvm {
  * @in_notifier: entering from a MMU notifier
  * @read_only: operating on read-only memory
  * @devmem_possible: possible to use device memory
+ * @devmem_only: use only device memory
  *
  * Context that is DRM GPUSVM is operating in (i.e. user arguments).
  */
@@ -294,6 +295,7 @@ struct drm_gpusvm_ctx {
 	unsigned int in_notifier :1;
 	unsigned int read_only :1;
 	unsigned int devmem_possible :1;
+	unsigned int devmem_only :1;
 };
 
 int drm_gpusvm_init(struct drm_gpusvm *gpusvm,


