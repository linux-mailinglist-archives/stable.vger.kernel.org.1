Return-Path: <stable+bounces-65553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0050594A980
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9831D1F28679
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291A82C69B;
	Wed,  7 Aug 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j9bNJBTX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA55820E
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039826; cv=none; b=BWey9h1TxKkI9Cuas4k1KzjndFSNse60PB8uTbg5PjCkjPw280+jr8z8q5pXVikvZLFCwkJEtxxUeRKAH0c+lFZsQoR7CFTSaf/w3NbKj/u/OTIaWzutUZuITsxGAnmbNG1YX3YlmfgRi2+hGVgTYMdbP2iTi5QCBtjw9q1d6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039826; c=relaxed/simple;
	bh=GYvfZ9eeV4Ocr3qKwjwotra32fDT/DvPBvhc54L0JL8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oYHUY8uCCppo9chILKXuRfre3q1MdgQtaXzwaLOfvxb3H10n63JJE5MF5fp6FX74bq8Czum2WbDg1apdG0oKHMcWxWsoXCT1iqx91M61CrKLb6ARUI/wQpK3YQOobqp9r+YeVy5TZlKm1NmMce2u7mU/SZ7imCgx8XnIZp4YOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j9bNJBTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72B2C32782;
	Wed,  7 Aug 2024 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039826;
	bh=GYvfZ9eeV4Ocr3qKwjwotra32fDT/DvPBvhc54L0JL8=;
	h=Subject:To:Cc:From:Date:From;
	b=j9bNJBTX4cMBB8syNs/qbCUwGOnIAigEPUHbpT2Wh3rtxtCNgtEQ6+PYShL7lwQVU
	 Tm5u817k9BGGuObTxIoZRQOjWciPYa7h7EbLhp1EVV11I8WxIc7Q5stjAZTYMJKvrr
	 tNH00v5T82W6ZVdZZ/RL0ElbAQid72uRIWBgidTk=
Subject: FAILED: patch "[PATCH] nouveau: set placement to original placement on uvmm" failed to apply to 6.6-stable tree
To: airlied@redhat.com,dakr@kernel.org,dakr@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:10:22 +0200
Message-ID: <2024080722-overlying-unmasking-3eb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9c685f61722d30a22d55bb8a48f7a48bb2e19bcc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080722-overlying-unmasking-3eb7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

9c685f61722d ("nouveau: set placement to original placement on uvmm validate.")
014f831abcb8 ("drm/nouveau: use GPUVM common infrastructure")
94bc2249f08e ("drm/gpuvm: add an abstraction for a VM / BO combination")
8af72338dd81 ("drm/gpuvm: reference count drm_gpuvm structures")
266f7618e761 ("drm/nouveau: separately allocate struct nouveau_uvmm")
809ef191ee60 ("drm/gpuvm: add drm_gpuvm_flags to drm_gpuvm")
6118411428a3 ("drm/nouveau: make use of the GPUVM's shared dma-resv")
bbe8458037e7 ("drm/gpuvm: add common dma-resv per struct drm_gpuvm")
b41e297abd23 ("drm/nouveau: make use of drm_gpuvm_range_valid()")
546ca4d35dcc ("drm/gpuvm: convert WARN() to drm_WARN() variants")
78f54469b871 ("drm/nouveau: uvmm: rename 'umgr' to 'base'")
f72c2db47080 ("drm/gpuvm: rename struct drm_gpuva_manager to struct drm_gpuvm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9c685f61722d30a22d55bb8a48f7a48bb2e19bcc Mon Sep 17 00:00:00 2001
From: Dave Airlie <airlied@redhat.com>
Date: Wed, 15 May 2024 12:55:41 +1000
Subject: [PATCH] nouveau: set placement to original placement on uvmm
 validate.

When a buffer is evicted for memory pressure or TTM evict all,
the placement is set to the eviction domain, this means the
buffer never gets revalidated on the next exec to the correct domain.

I think this should be fine to use the initial domain from the
object creation, as least with VM_BIND this won't change after
init so this should be the correct answer.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: <stable@vger.kernel.org> # v6.6
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240515025542.2156774-1-airlied@gmail.com

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 9402fa320a7e..48f105239f42 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1803,6 +1803,7 @@ nouveau_uvmm_bo_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
 {
 	struct nouveau_bo *nvbo = nouveau_gem_object(vm_bo->obj);
 
+	nouveau_bo_placement_set(nvbo, nvbo->valid_domains, 0);
 	return nouveau_bo_validate(nvbo, true, false);
 }
 


