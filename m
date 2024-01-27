Return-Path: <stable+bounces-16126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C982883F0E3
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694C01F214D9
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB41D6B8;
	Sat, 27 Jan 2024 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bqho+tjH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D91F5E7
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395023; cv=none; b=GAJcK5lwOKgzkGFjN7nDMPU2g8NJRjhiWWB8dwQQvzAlxNHZnyJgrjsZWGqWspIHsbo46gPLAK4fCgRrgdmBwJzCjoDnrq62OZLbNQwqt/sMA7Wwev9OS5bFZtJqC9szaijk85F+7cFgVE1RxF6ZkRYoMJTp1pH3jURNuq3dtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395023; c=relaxed/simple;
	bh=cDMJsTSYYFasJA4OuOUSzHq/kPNUF9Pw1Cu+Eft4yS8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pnlmdeS2tQy1QuqsjgpFk1LIBnxTdIc6jlnP/7F64foTvzPdBV/9L7/Wv4+PJtYrpOtyBdsx+CJ2BpYklLWr1CDOvquEIXd4cXdpn1yBwxkPtUWTzVazPi3ZetMvKeiJrjXNejLRLV1L32UT71txtaS2koIU3o+EjFobTWD8QRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bqho+tjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC31C433C7;
	Sat, 27 Jan 2024 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395022;
	bh=cDMJsTSYYFasJA4OuOUSzHq/kPNUF9Pw1Cu+Eft4yS8=;
	h=Subject:To:Cc:From:Date:From;
	b=Bqho+tjHtD9AcpOzmJChlD/ASK11POcGfMEnPakxSdK+3rcYoeMaNd/Vvg/6WZuFB
	 h+w7t3uEGcoLFK9PsqY+cHo2yJ14nlhHIzx84/GVYXmVK/TEPF0cYkNIrIh9envd3C
	 JuMp2X4plFXm4ZgcByBLlOmP3nhlVUQZknIRKqvY=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix tear down order in amdgpu_vm_pt_free" failed to apply to 6.7-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:37:01 -0800
Message-ID: <2024012701-seventh-excluding-8ef8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 683b8c7e7a94fb7445b8d300c7404322ad040bab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012701-seventh-excluding-8ef8@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

683b8c7e7a94 ("drm/amdgpu: fix tear down order in amdgpu_vm_pt_free")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 683b8c7e7a94fb7445b8d300c7404322ad040bab Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Fri, 8 Dec 2023 13:43:09 +0100
Subject: [PATCH] drm/amdgpu: fix tear down order in amdgpu_vm_pt_free
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a2287bb25223..a160265ddc07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -642,13 +642,14 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 
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


