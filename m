Return-Path: <stable+bounces-195363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0049C756E5
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 807504E93A7
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0DF366574;
	Thu, 20 Nov 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q8YO6eq6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2E35CB72
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656431; cv=none; b=u7tjMQDOw34eShZBsAbi2ylsJPNaqijwa6/8sqQcptw6Vl22ZXuLvIVcl711NPY45A2iHH6LA27SFGw/Wk0vnz0jvclGBkD703xLilzEj2AQbZ6TZBMWQYjPEof5/37YM/s1ekC6iesecAbtQDXihK3prDJYB3J1wLAC2JJH47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656431; c=relaxed/simple;
	bh=0zpLVQDYskAWsIp7cVs1T9FrE4M715E62uzp59rG3mA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CnIaYRovLFCElZfvw+KF/+FdzoymDWhrxgTDkwM2dfriszI/r7Ulr27zescxZTfYQvXv3wZ6Xg34UXSxspDCWNhhwHFPlKgOlhqP/S/OKtx8UjrKOFX29Nfm77DTSbRILBzv0dxD1EWfZN1r2ccgTRvPKOkp+c+5DV0vk2T9TIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q8YO6eq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E88C4CEF1;
	Thu, 20 Nov 2025 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763656431;
	bh=0zpLVQDYskAWsIp7cVs1T9FrE4M715E62uzp59rG3mA=;
	h=Subject:To:Cc:From:Date:From;
	b=q8YO6eq6ui0hZKuaWf0nDsyd7BZVnvOallRQGTuW+N7vASIlfCKi3U2yT6djqNSZh
	 kkXD4LUUscBFZd07UpcAcCzv97wtxS28jbMJV+C6OmXdoqvX71Dv7icqBk2ZeMlW54
	 O7/1PXL7QGCRcat7U4zmSACvVugzuej4ec3LbpfE=
Subject: FAILED: patch "[PATCH] drm/amdgpu/jpeg: Add parse_cs for JPEG5_0_1" failed to apply to 6.17-stable tree
To: sathishkumar.sundararaju@amd.com,alexander.deucher@amd.com,leo.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:32:53 +0100
Message-ID: <2025112053-unifier-drove-b0a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x bbe3c115030da431c9ec843c18d5583e59482dd2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112053-unifier-drove-b0a8@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bbe3c115030da431c9ec843c18d5583e59482dd2 Mon Sep 17 00:00:00 2001
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Date: Tue, 7 Oct 2025 13:17:51 +0530
Subject: [PATCH] drm/amdgpu/jpeg: Add parse_cs for JPEG5_0_1

enable parse_cs callback for JPEG5_0_1.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 547985579932c1de13f57f8bcf62cd9361b9d3d3)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index baf097d2e1ac..ab0bf880d3d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -878,6 +878,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v5_0_1_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_1_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_1_dec_ring_set_wptr,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +


