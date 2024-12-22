Return-Path: <stable+bounces-105548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131399FA488
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 08:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367EE1885246
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DED15B97D;
	Sun, 22 Dec 2024 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ddJwCVRX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04AA2F43
	for <stable@vger.kernel.org>; Sun, 22 Dec 2024 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852464; cv=none; b=sLPSvhAEvC23xLUJsvZaFt1s4GvhbH6VUOH9eknR4MLSywfv7NC3EoIhL9DlYJaRrai/hFHan5L2wuev7eOk59OsA4r4naMbj738I+tmEBeb17Dfa8W2wS8UHXSf1uFZyY5dgCdJ3LgTunIxlccxLxWhbTCQVT/71wpDVo0gnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852464; c=relaxed/simple;
	bh=AZyOxNT8K9xHk/wsYR6g7Vic410EdP0syhFBqyeA+Zk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gZ6BOZEF7dnXlRNZF2xnxhtYh0dlfaimSDHclfFhzSGjJ+mrFOq6hZkoSWVaKgb1h1dmaGImJd7K7Fl+ZySmf/t8D7Rr13uhnlAB0uokVrKQVf1tzf0KkpxBoN2WGgo5ISmzyJe98ERNzhdiEs5vEcev+WMj0FTkYrKEokps7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ddJwCVRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2CBC4CECD;
	Sun, 22 Dec 2024 07:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734852464;
	bh=AZyOxNT8K9xHk/wsYR6g7Vic410EdP0syhFBqyeA+Zk=;
	h=Subject:To:Cc:From:Date:From;
	b=ddJwCVRXd2WIB2qoGegHsD6P+X/vuNt8MmMfP93kEwslnxFvv70Ld9LXgh8HqRwpA
	 jJHc1/wW2kPnyC+4BkGSaZXcZHGa7m/oxDbI1Q+pR0d5sLN6I3MaVbW6aKjiXN5f7N
	 3NLWCzcJ/dEMFgXt0OeBXf6a4ukf69z9Lv/5AV7E=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Handle NULL bo->tbo.resource (again) in" failed to apply to 5.15-stable tree
To: mdaenzer@redhat.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 22 Dec 2024 08:27:30 +0100
Message-ID: <2024122230-rectangle-bridged-474d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 85230ee36d88e7a09fb062d43203035659dd10a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122230-rectangle-bridged-474d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85230ee36d88e7a09fb062d43203035659dd10a5 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>
Date: Tue, 17 Dec 2024 18:22:56 +0100
Subject: [PATCH] drm/amdgpu: Handle NULL bo->tbo.resource (again) in
 amdgpu_vm_bo_update
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Third time's the charm, I hope?

Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3837
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 695c2c745e5dff201b75da8a1d237ce403600d04)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ddd7f05e4db9..c9c48b782ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1266,10 +1266,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	 * next command submission.
 	 */
 	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
-		uint32_t mem_type = bo->tbo.resource->mem_type;
-
-		if (!(bo->preferred_domains &
-		      amdgpu_mem_type_to_domain(mem_type)))
+		if (bo->tbo.resource &&
+		    !(bo->preferred_domains &
+		      amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type)))
 			amdgpu_vm_bo_evicted(&bo_va->base);
 		else
 			amdgpu_vm_bo_idle(&bo_va->base);


