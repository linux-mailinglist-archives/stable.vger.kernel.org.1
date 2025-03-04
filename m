Return-Path: <stable+bounces-120284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A25A4E73E
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B1B1881842
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5625F976;
	Tue,  4 Mar 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UA2Ilzvl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903825DCEC
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105915; cv=none; b=SDdj/3HInZY/hXaRnR9qW9SuUuHZOPM/zpUtC1to79TruWcvhJ0rKAyfrfJjDKtTxy/DX7qlUP4MmqLqMjL1oB3Es4Zk8+G1xAJe65phFzDKZOGl2qoaEeUQ2lGBS4CiDI8yxgGrmhIu8f1VM4JmSojHFhctRGFDN6gvQPnfdpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105915; c=relaxed/simple;
	bh=icz/wa7o8KKbEV8zrMViBumcne/g+TfUz11i1T98vxY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FGIMFXjwfBr+AZwiYw7sBGJ2rZGmw2uU/rVr7YEVvrSHy57rOSNr5Sy0miHnFWPdCKT2FgnJf7w1lCHcS9y4g3ohHwen0xUBkqR4/AIpmmkmT99Ox2LjrCheAfgtihhojwjMXkRS87Sjv5GF8569QMiEcTWvRKt1h2adf8BBcnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UA2Ilzvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47B6C4CEE7;
	Tue,  4 Mar 2025 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741105915;
	bh=icz/wa7o8KKbEV8zrMViBumcne/g+TfUz11i1T98vxY=;
	h=Subject:To:Cc:From:Date:From;
	b=UA2IlzvllbxOMqfTXdz89rYAy458yf1t0spImYO2w5507qBa0hVVYRFNmeiy025tr
	 ZdAPD6M1dcjrNZl4jpgtpUgfF3GZH0/glm3pFys4FQlu+55hlURUDop3X0inRgcyOZ
	 urrS9CUDEbwzkFEQLu4rF2KTc5+gxUpZqG9xki/4=
Subject: FAILED: patch "[PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE" failed to apply to 5.10-stable tree
To: alexander.deucher@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:31:42 +0100
Message-ID: <2025030442-improve-sector-ba84@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 099bffc7cadff40bfab1517c3461c53a7a38a0d7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030442-improve-sector-ba84@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 099bffc7cadff40bfab1517c3461c53a7a38a0d7 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Mon, 17 Feb 2025 10:55:05 -0500
Subject: [PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE

There was a quirk added to add a workaround for a Sapphire
RX 5600 XT Pulse that didn't allow BAR resizing.  However,
the quirk caused a regression with runtime pm on Dell laptops
using those chips, rather than narrowing the scope of the
resizing quirk, add a quirk to prevent amdgpu from resizing
the BAR on those Dell platforms unless runtime pm is disabled.

v2: update commit message, add runpm check

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5235053f443cef4210606e5fb71f99b915a9723d)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d100bb7a137c..018dfccd771b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1638,6 +1638,13 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	/* resizing on Dell G5 SE platforms causes problems with runtime pm */
+	if ((amdgpu_runtime_pm != 0) &&
+	    adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
+	    adev->pdev->device == 0x731f &&
+	    adev->pdev->subsystem_vendor == PCI_VENDOR_ID_DELL)
+		return 0;
+
 	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
 	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
 		DRM_WARN("System can't access extended configuration space, please check!!\n");


