Return-Path: <stable+bounces-53786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE090E628
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02500B212A2
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728397A705;
	Wed, 19 Jun 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="scs9tNfC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1577117
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786449; cv=none; b=q8y/ydI/vkrkpQqBLIGqpOcGaLjuKLdD/k9J/IKpRgCmp7qjKMJ/6VEUVJe3hiA4Yxyuhc93Zno9AV7w9jJA7R9ACGoAeOGSlXUuc83Yk6wNyBkWcakVh8/GcBDJFNOpjNXMVrQLXSNsKUaSACwJcZliX1im6HENfgfSRpM+FsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786449; c=relaxed/simple;
	bh=XzfTru8y16RAaS2AlmwFSBRHt6wqyNDr1w05po+h7cM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mor9ndSL01eQtZYD7Pg9wuoZgtpCyIiAB9RSqom0ArNoOr77GAe5+cTtjzLERsYczplxA/qq/kRyhFmOn4GKAwz2kU1WsZs1ujO5JF99gzgLQVMNRFVv5bp76ffVqxn3sNRNdEPoVaVBsbQQQXzIcqjxzW3+FCNG8WBTiU2wc2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=scs9tNfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD1BC2BBFC;
	Wed, 19 Jun 2024 08:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786449;
	bh=XzfTru8y16RAaS2AlmwFSBRHt6wqyNDr1w05po+h7cM=;
	h=Subject:To:Cc:From:Date:From;
	b=scs9tNfCwJladoTVBEkVxBQGgT6dAFLMOUt35XHKaC3jv074pAgs60b9YGqPsQLcU
	 wMAFPPPuOeO5YV5ig4oHOzlk+e9x7N64C06w8LebKDJBfF3zW+j4dfv6WSZEXHbYRC
	 kSauQi9CIbq6ELVEsG55UP3y57yyNRsTlMoAK0Xc=
Subject: FAILED: patch "[PATCH] drm/amd: Flush GFXOFF requests in prepare stage" failed to apply to 6.1-stable tree
To: mario.limonciello@amd.com,alexander.deucher@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:40:06 +0200
Message-ID: <2024061906-sepia-jaws-3711@gregkh>
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
git cherry-pick -x 0355b24bdec3b69ba31375c83d94fa80ca2c7ae1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061906-sepia-jaws-3711@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


