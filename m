Return-Path: <stable+bounces-7227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F241F81717F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237881C2415D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C415AC0;
	Mon, 18 Dec 2023 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKqg5MN2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D96129EC8;
	Mon, 18 Dec 2023 13:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1411C433C7;
	Mon, 18 Dec 2023 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907906;
	bh=BtDB6dSF3Mb4TJKjxalxFPIAV7YoPxTQfqQizzyUhH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKqg5MN2dj5x98WHReGJfy9zr0OAfHwqU6t4XV/5u2VRjL/csvKZtisu1vIaLtDVr
	 BOFzSjPrpLCTNrjWVuIHPBJIHZ9ISImgayJsHck6LZji78yxEn1nq7BysWjxg3CYOh
	 kx6SwDUXv0gsRXj9iFiYGcrOiG31PhV4FKEAlFhk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 089/106] drm/amdgpu: fix tear down order in amdgpu_vm_pt_free
Date: Mon, 18 Dec 2023 14:51:43 +0100
Message-ID: <20231218135058.882974768@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit ceb9a321e7639700844aa3bf234a4e0884f13b77 upstream.

When freeing PD/PT with shadows it can happen that the shadow
destruction races with detaching the PD/PT from the VM causing a NULL
pointer dereference in the invalidation code.

Fix this by detaching the the PD/PT from the VM first and then
freeing the shadow instead.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/2867
Cc: <stable@vger.kernel.org>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -631,13 +631,14 @@ static void amdgpu_vm_pt_free(struct amd
 
 	if (!entry->bo)
 		return;
+
+	entry->bo->vm_bo = NULL;
 	shadow = amdgpu_bo_shadowed(entry->bo);
 	if (shadow) {
 		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
 		amdgpu_bo_unref(&shadow);
 	}
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
-	entry->bo->vm_bo = NULL;
 
 	spin_lock(&entry->vm->status_lock);
 	list_del(&entry->vm_status);



