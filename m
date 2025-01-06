Return-Path: <stable+bounces-107507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D9A02C5E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF183A744F
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0CB1DED57;
	Mon,  6 Jan 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BI0rG8Ew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F11D7999;
	Mon,  6 Jan 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178681; cv=none; b=jdNCioiazVCnAeOoJvOmsmDzuLrqdCgP1EVslky3nCbo+AYO54w81ZCTKykUY1jwt8ceYirwOJP42fcDdTSWAi4QTRIlPCwzVo9pAiQl5mTcqAh9Awl5Qe8uL+OSMNN4GkBCu4rNbG6kLtODiWXzK1vuz3C4eN5iPGrEdsFCy/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178681; c=relaxed/simple;
	bh=0oBYiCZn8osFPqF6GpOL2CCTcVDVPHjOyMplRGmInBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oK3hQ3oXbBPZ5CIebTzEowro//NGCYY2v/4tuMDwfgREbIpkjMb2RZ0r90UV5GX29ebHG/bJYc+btlqXFSJewqCgjjweruyXPQJ0QqDlEpYsJY4XBI+q6vDyxoOATMSytFA0oy3YjXXRVpVn0nHyQsjI7mBmKquozDQsnidJQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BI0rG8Ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA777C4CED2;
	Mon,  6 Jan 2025 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178681;
	bh=0oBYiCZn8osFPqF6GpOL2CCTcVDVPHjOyMplRGmInBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BI0rG8EwUAP7A9oBXmOevDOi9YVnjHt4mruEEChivd5rZAQsVcBDPJ/NG48F8ugsD
	 nNlySNHJ8qY70kA84TqtrAwodR80ejqL0k547nFT8YO9h5eN9b1QxrU49vCr7KoNbx
	 lC2qfwZ+2qJVLrx2qFtc+zqkSKbg7nlIlTj0mne8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 056/168] drm/amdgpu: Handle NULL bo->tbo.resource (again) in amdgpu_vm_bo_update
Date: Mon,  6 Jan 2025 16:16:04 +0100
Message-ID: <20250106151140.579305093@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Dänzer <mdaenzer@redhat.com>

commit 85230ee36d88e7a09fb062d43203035659dd10a5 upstream.

Third time's the charm, I hope?

Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3837
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 695c2c745e5dff201b75da8a1d237ce403600d04)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1958,10 +1958,9 @@ int amdgpu_vm_bo_update(struct amdgpu_de
 	 * next command submission.
 	 */
 	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
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



