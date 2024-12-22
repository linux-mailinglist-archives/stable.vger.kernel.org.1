Return-Path: <stable+bounces-105546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A409FA486
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 08:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A69165B4B
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 07:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95923158D80;
	Sun, 22 Dec 2024 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hf8aHxbA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B92F43
	for <stable@vger.kernel.org>; Sun, 22 Dec 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852453; cv=none; b=M/GDxdB2Bi6b+k3rV+EZ7AFWgYTKRAV27wzTJKK3vdPBg55upEra++RHgP7k1Q5arXnaEbcNOWwAVpmc9iFP6ky8b29gjXF34DyC0+papYRlZnoiYskBAvKVCoTED2jzzIEwGFJuhUCeItslXcl6N98fRrxSwo0PNlM1wGZ/+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852453; c=relaxed/simple;
	bh=8MGtSG8PCK6unAy7A7d+yuApqC7TABakL2dSQBErJgk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YK3cink/yrnNVdeqX0yBr/fzLY4CJ9JzLFwnmicYKv4bxsOHc2fXfNAEktYs/wWjmQMGC+tfNgiP+LoKg4af+/Ht1XZU3I5RQ8K+h3TbDtaW8n+ZXBUAVv7sauJOoo9ZoWVARF3tQWxRFgU6g/4UDGKz2tokM1Mk60/sjMkllO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hf8aHxbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EC6C4CECD;
	Sun, 22 Dec 2024 07:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734852452;
	bh=8MGtSG8PCK6unAy7A7d+yuApqC7TABakL2dSQBErJgk=;
	h=Subject:To:Cc:From:Date:From;
	b=Hf8aHxbARdxHH/19HKbbj1iZ2rfX1YGNvUYPoFjKZ9M8eZjIYgEM0+nMVyBnOCbcx
	 dFy13aTswSZKQkqWPwqRloN5yYr6/CM3O9VqmeabOoZK1FncR9a9MibYFRslBmWsM7
	 c8DyH/sJEsWd2GrL3JkP0tRY2gVfNJ4j6Pd1+KUc=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Handle NULL bo->tbo.resource (again) in" failed to apply to 6.6-stable tree
To: mdaenzer@redhat.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 22 Dec 2024 08:27:29 +0100
Message-ID: <2024122229-excusable-sample-91cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 85230ee36d88e7a09fb062d43203035659dd10a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122229-excusable-sample-91cf@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


