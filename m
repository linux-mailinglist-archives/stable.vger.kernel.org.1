Return-Path: <stable+bounces-53785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D91A90E627
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070691F2602A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFC97B3E5;
	Wed, 19 Jun 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aMVwR/fq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3F577117
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786446; cv=none; b=DSh6GC9w6ErHXGJfIuPBg+aD1J7UIo6Xi7mV7kxpr0UJ+DsmLI+RTetZW86HtvmurxeYkT7HR8ip7nV/97r8EcTf+7xfkr3mK2HkR6k/fNM0NEJhp0B4I66lkNdBx2l806SEVcQ2JDvOOjGttPSAK53gRTTigD97GgrIGtwfOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786446; c=relaxed/simple;
	bh=2dzK9HX32zLwp3V4cV1jPxe/AJK7tdcujoJP2bEfbgQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PQXd17atezhqTZDwUtoiwtITH4XkgY7v/9/6mDItus9bhU9xkTFaqzK08z0wRzZ0S+5UC34Upb54PR59aNVwJJ44SThYy8jZ4SwQ7uvNR6MArmBCLnNOJj/cj4d8T2sd/lk4LM4nWqvB3fQRKGy7nVitmrwqwYBO+jQZL8zuC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aMVwR/fq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B815CC2BBFC;
	Wed, 19 Jun 2024 08:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786446;
	bh=2dzK9HX32zLwp3V4cV1jPxe/AJK7tdcujoJP2bEfbgQ=;
	h=Subject:To:Cc:From:Date:From;
	b=aMVwR/fqAXn7UU2mQ2N6M8jtb4hXOHdA8J/hPP2ECVppvApwuK7UVRg3DFiOvBIA5
	 Xil+Z0ROMAcADGk1llzpydGdzf8u/wODNC9wTWyj4t8Doio4huQDy1/iUOy8pD0vOI
	 921Qa13zuN068VQM+mLJEByz/b0EgALfyp8umK8Q=
Subject: FAILED: patch "[PATCH] drm/amd: Flush GFXOFF requests in prepare stage" failed to apply to 6.6-stable tree
To: mario.limonciello@amd.com,alexander.deucher@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:40:05 +0200
Message-ID: <2024061905-stardom-chance-e059@gregkh>
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
git cherry-pick -x 0355b24bdec3b69ba31375c83d94fa80ca2c7ae1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061905-stardom-chance-e059@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0355b24bdec3 ("drm/amd: Flush GFXOFF requests in prepare stage")
cb11ca3233aa ("drm/amd: Add concept of running prepare_suspend() sequence for IP blocks")
5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0355b24bdec3b69ba31375c83d94fa80ca2c7ae1 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 20 Mar 2024 13:32:21 -0500
Subject: [PATCH] drm/amd: Flush GFXOFF requests in prepare stage

If the system hasn't entered GFXOFF when suspend starts it can cause
hangs accessing GC and RLC during the suspend stage.

Cc: <stable@vger.kernel.org> # 6.1.y: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")
Cc: <stable@vger.kernel.org> # 6.1.y: cb11ca3233aa ("drm/amd: Add concept of running prepare_suspend() sequence for IP blocks")
Cc: <stable@vger.kernel.org> # 6.1.y: 2ceec37b0e3d ("drm/amd: Add missing kernel doc for prepare_suspend()")
Cc: <stable@vger.kernel.org> # 6.1.y: 3a9626c816db ("drm/amd: Stop evicting resources on APUs in suspend")
Cc: <stable@vger.kernel.org> # 6.6.y: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")
Cc: <stable@vger.kernel.org> # 6.6.y: cb11ca3233aa ("drm/amd: Add concept of running prepare_suspend() sequence for IP blocks")
Cc: <stable@vger.kernel.org> # 6.6.y: 2ceec37b0e3d ("drm/amd: Add missing kernel doc for prepare_suspend()")
Cc: <stable@vger.kernel.org> # 6.6.y: 3a9626c816db ("drm/amd: Stop evicting resources on APUs in suspend")
Cc: <stable@vger.kernel.org> # 6.1+
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3132
Fixes: ab4750332dbe ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f771b2042a43..12dc71a6b5db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4542,6 +4542,8 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	if (r)
 		goto unprepare;
 
+	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
+
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.valid)
 			continue;


