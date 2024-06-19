Return-Path: <stable+bounces-53784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6DA90E626
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB8A1F25FD3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5687A158;
	Wed, 19 Jun 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mK2Gqbe7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC477117
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786443; cv=none; b=MUNKKOwu1xTrH0kh8RJ3UBUqseuhU7QE1zzvy/oPvHwB1eloeUq/yKLIQ/fLOIuJ4vz6pNnnKhoH4quPzM1veV0VJHKq6Nrpr4kX8jPhtgXDtix0gbIj9N08LBrTLVesYzZ6qxH6hNisSARybScTq/+d5Ssvl5JYLXLEAT/F5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786443; c=relaxed/simple;
	bh=SKHO9SdnatFte9anIRuxNcZWRGNGtQJ1QTDvvN48a8U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CGt9OcBjAj1pjBntv4TzkV33pUDNSC1pW7zsf/RTvWs9NaVI4Iq2XtNr9Gm0QZvmiYfphwt57bW5elOOprhN5pM7LZDOy6bGqzsjhpuJtaDtDi4uRwZVcnodciyzEJSoYyFpdJ7SHxTEzRvETa+0IVD7xYvyonLVAznIocMQ0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mK2Gqbe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EC5C2BBFC;
	Wed, 19 Jun 2024 08:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786443;
	bh=SKHO9SdnatFte9anIRuxNcZWRGNGtQJ1QTDvvN48a8U=;
	h=Subject:To:Cc:From:Date:From;
	b=mK2Gqbe7o/IZc3HesQA14RApfXUHuzYSPpwOZ7lgka+Re4gIrCuGjy6tdPFFdFfLO
	 tQvX9PV83IeHlOI5MDC3X+Pg0O9VXJN0Hwt50DqSsALc862Z7AZ2CgOTyT7B2UhQiX
	 ZIk4GFv2QDXPi017/6Jd8skUJo9oHZ9WC52tXKz8=
Subject: FAILED: patch "[PATCH] drm/amd: Flush GFXOFF requests in prepare stage" failed to apply to 6.9-stable tree
To: mario.limonciello@amd.com,alexander.deucher@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:40:04 +0200
Message-ID: <2024061904-relearn-chastise-3f38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 0355b24bdec3b69ba31375c83d94fa80ca2c7ae1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061904-relearn-chastise-3f38@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

0355b24bdec3 ("drm/amd: Flush GFXOFF requests in prepare stage")

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


