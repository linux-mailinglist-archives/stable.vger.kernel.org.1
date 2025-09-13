Return-Path: <stable+bounces-179479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379D0B560DD
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF62A56610A
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF772ECD27;
	Sat, 13 Sep 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dvHsNHAm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80994194124
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757767207; cv=none; b=PzPPCxN85yhc59Z0N6k8go2RN3Jfxgtm1EfQOcjV73iaLpMRWD3yO56R5UrPLlXWuCzB33SOhe2gJ4MI0FQepZlaHWkET5tj0zfB1CaSJO6kxd+4/UBQNikH45LCLxUsdGTh/DbmJBTsnfEIyQvkBfZo3nTyfPt8/8r6QEcjRvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757767207; c=relaxed/simple;
	bh=VtxOMDvn2M49MMEhPD5v2zAmpr2CyYpXrbWlN7mB0/M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Le8+6JoEfYgp9m5L5NNgh3a0xPVHWNTaok1+zzGShxtlWqGcxiNCcyikPWoZflfOu7IoVh5ZgdMtFa386oP9ZOxE0qjVjy7zahRD5rI8Kmi/RtfXWwmQLMc88H6H5Aptx5KWDrY099Rg57OAtuhc3NW5GclJq2IpBZbZDpNojcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dvHsNHAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE15DC4CEEB;
	Sat, 13 Sep 2025 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757767207;
	bh=VtxOMDvn2M49MMEhPD5v2zAmpr2CyYpXrbWlN7mB0/M=;
	h=Subject:To:Cc:From:Date:From;
	b=dvHsNHAmf+8YrzYxwsJp7YNpEwWEDXOpK3bwMIM1Fyj8zqEXR1KnzuGywxtTT59ds
	 K+Dvtb5V/c0tRpph0lY/t4llVZ7A9bLkE+EdMiyUgSrEBkoevr0KNuhVV3yefNbxEA
	 eI7yj7qAT7CI1sDPoAlnrQTGl77Sn1Ox+Yb+Unyk=
Subject: FAILED: patch "[PATCH] drm/amd/amdgpu: Declare isp firmware binary file" failed to apply to 6.16-stable tree
To: pratap.nirujogi@amd.com,alexander.deucher@amd.com,mario.limonciello@amd.com,xglooom@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:40:03 +0200
Message-ID: <2025091303-unstaffed-specimen-7319@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 857ccfc19f9be1269716f3d681650c1bd149a656
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091303-unstaffed-specimen-7319@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 857ccfc19f9be1269716f3d681650c1bd149a656 Mon Sep 17 00:00:00 2001
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
Date: Wed, 3 Sep 2025 16:00:24 -0400
Subject: [PATCH] drm/amd/amdgpu: Declare isp firmware binary file

Declare isp firmware file isp_4_1_1.bin required by isp4.1.1 device.

Suggested-by: Alexey Zagorodnikov <xglooom@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d97b74a833eba1f4f69f67198fd98ef036c0e5f9)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index a887df520414..4258d3e0b706 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -29,6 +29,8 @@
 #include "amdgpu.h"
 #include "isp_v4_1_1.h"
 
+MODULE_FIRMWARE("amdgpu/isp_4_1_1.bin");
+
 #define ISP_PERFORMANCE_STATE_LOW 0
 #define ISP_PERFORMANCE_STATE_HIGH 1
 


