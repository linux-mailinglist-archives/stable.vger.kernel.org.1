Return-Path: <stable+bounces-105547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF729FA487
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 08:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51EE18851A1
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 07:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E085C158DC4;
	Sun, 22 Dec 2024 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S1HMf7zj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBE2F43
	for <stable@vger.kernel.org>; Sun, 22 Dec 2024 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852461; cv=none; b=OnfdBwx6+jmrZiIfU6lzmzNkQtuTpzAkSwovyIxNTbezCjXa9blnixZkFO31PDtOF4sqwxBgsAmzPlgVxEN1LdQZexUbAdfgtTUuZWdk5cqfhcPQi2hoPwKvu1RzXeciBYXFwYOCqBLVfm+vCuwkWvYGB6svdLeqHmQKwc5XZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852461; c=relaxed/simple;
	bh=bmYExTWbX0lyVQz6fpD2WQBzhwRpd/S1JCoiEInOHBM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y2tjJKrpKEyF37JExATLeoU1l0rI+d06RGeRiCm/GNtVWsPuI1NXdrpRW4El6T+oQWiJtM00a3sAe1xgHVJ1EFYkwlRY2h77YmtGlvO2KdNEzl9lQULjeVlBuPbbKYamp97FGLgpIjTbSdUodeNWqNPfqcKpjIYyDRaCp4dY4W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S1HMf7zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73004C4CECD;
	Sun, 22 Dec 2024 07:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734852460;
	bh=bmYExTWbX0lyVQz6fpD2WQBzhwRpd/S1JCoiEInOHBM=;
	h=Subject:To:Cc:From:Date:From;
	b=S1HMf7zjYZCadwvEQD1OmsKgTc/QWK0OgmC1UTae6EaGtXT1q0Pe8hUg3jsN/YYcP
	 XGJo+7VDoc2/8FB3RpyRK3lNYsawVeIHGUK3cWr70VvBcy8y+4NY/+Lbu7XggFJ2RC
	 0ttIHmB7+gdMlokSSuRwBWyuMlfK9LoyHdN9cVO4=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Handle NULL bo->tbo.resource (again) in" failed to apply to 6.1-stable tree
To: mdaenzer@redhat.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 22 Dec 2024 08:27:29 +0100
Message-ID: <2024122229-detergent-refurbish-946d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 85230ee36d88e7a09fb062d43203035659dd10a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122229-detergent-refurbish-946d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


