Return-Path: <stable+bounces-16131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C469E83F0E9
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6684DB26E49
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E31DDD6;
	Sat, 27 Jan 2024 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fu7D+NJJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7554C1D6B8
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395075; cv=none; b=bw4XhBMGe7fNtSvBjNlvlhmkQX6F4TlRSk8fS7RO86oTtMt5lmf6unaIcLy68NU7q3sZsIEEfjG2pW6DvC4l8OtVuAnqwkslIecp6PM/+glb3EVP1sNTh2L0udYowjWoRyYFaZ8Lbc1Svuq8iFK6hdOQX7Uo2SEH9iF2CI3ZOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395075; c=relaxed/simple;
	bh=45fCedvMBHdooAS89C3L69ebpRWRAqSnQLO6AKbxMws=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sMbPoNCDPElEUOOf1TldFC0V/cVQz9IjrvEvexslxNVkIbySmPicQXBXRJJiwNTGCCmzfYk0ZSAqZYs3P9MKY3/SKOp4juJj3ENpF23TWlbelfso+UrrAkxtAqdMPLOWePMN2Ct82glhK8FO7D63v7k8OZpY8wHCC4IBD8vIQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fu7D+NJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55DAC433F1;
	Sat, 27 Jan 2024 22:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395074;
	bh=45fCedvMBHdooAS89C3L69ebpRWRAqSnQLO6AKbxMws=;
	h=Subject:To:Cc:From:Date:From;
	b=fu7D+NJJnuUxCY8qNyjbB8BsL4RZQgQt4KpidKoBjd7m9epllqE1Zw4yrggM6f0To
	 J+w/NIMN6pHUM1vWFzt9eV/AQNfKO64ChUuBkX9FtjLJIA9ZeMX3ycLpXVeweq+r5A
	 5puTWnKI7E/7rfF0fm1FkKvWXe24CKSL92eMUqzs=
Subject: FAILED: patch "[PATCH] drm/amdgpu: disable MCBP by default" failed to apply to 6.7-stable tree
To: Jiadong.Zhu@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:37:53 -0800
Message-ID: <2024012753-stable-reappear-4d32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x fd2ef5fa3556549c565f5b7a07776d899a8ed8b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012753-stable-reappear-4d32@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

fd2ef5fa3556 ("drm/amdgpu: disable MCBP by default")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd2ef5fa3556549c565f5b7a07776d899a8ed8b7 Mon Sep 17 00:00:00 2001
From: Jiadong Zhu <Jiadong.Zhu@amd.com>
Date: Fri, 1 Dec 2023 08:38:15 +0800
Subject: [PATCH] drm/amdgpu: disable MCBP by default

Disable MCBP(mid command buffer preemption) by default as old Mesa
hangs with it. We shall not enable the feature that breaks old usermode
driver.

Fixes: 50a7c8765ca6 ("drm/amdgpu: enable mcbp by default on gfx9")
Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6c0cf64d465a..d5b950fd1d85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3861,10 +3861,6 @@ static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 		adev->gfx.mcbp = true;
 	else if (amdgpu_mcbp == 0)
 		adev->gfx.mcbp = false;
-	else if ((amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 0, 0)) &&
-		 (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 0, 0)) &&
-		 adev->gfx.num_gfx_rings)
-		adev->gfx.mcbp = true;
 
 	if (amdgpu_sriov_vf(adev))
 		adev->gfx.mcbp = true;


