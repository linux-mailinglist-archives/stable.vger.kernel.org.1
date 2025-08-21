Return-Path: <stable+bounces-172158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449FDB2FD9D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1600F64254C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88142E0B45;
	Thu, 21 Aug 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GeB8n1ZV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890952DC322
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787693; cv=none; b=VqMfD4G2xz8JST1HmsNeZRbL0JA+Cll2rPxhgM4QtCEcfR4bH0r6c4OsjAM6VaAGI/+6xKbCuY+7//7oaFGfwo+opWM4bf//M5PQk5AyXyaOD8O0mcepo3qSzjtjKLZ1L25FslpjWURPkPiQYk8ztDyKhepeNSlOd3CeSvaqN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787693; c=relaxed/simple;
	bh=7ZUPkaq4iKkc94O56izKAGjrtWATQjcD/F/cREXoSfM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UK6BCXxSVHmeHq4HtcqTXKe+3k0B0Bo+5j0vk+Xr0+kAGkj64NWC0kjXhjEQzRmfvWC8NspKDCPPsxCrDmAy1xt7Rb8n4E0teWBEKAU/LWC3MPd9V98Yd/hnUD0lQq25Y0w5eg8yqiYH2NvSiTRtTifQMoYDWDOHzL9hE9Gc+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GeB8n1ZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1344FC113CF;
	Thu, 21 Aug 2025 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755787693;
	bh=7ZUPkaq4iKkc94O56izKAGjrtWATQjcD/F/cREXoSfM=;
	h=Subject:To:Cc:From:Date:From;
	b=GeB8n1ZVFiT+CtCHPA78LdtQTdQv5BG3vBFbp0VVVyecLQtUd1ni3yfFXFmQgBHrh
	 St+8GzHtxJL1CNxX5m71azRehEbHDnM0vMWFo1nr05YOi0KTXUy9BqaEChaVtnW7Nm
	 logw7zXhz5xsUzgjHKzUpfd0N2AnegahBWg+Fl1E=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Add NULL check for asic_funcs" failed to apply to 6.16-stable tree
To: lijo.lazar@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:45:58 +0200
Message-ID: <2025082158-amigo-vixen-99e8@gregkh>
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
git cherry-pick -x c2fe914d50ab22defca14ac6fca33888bfb19843
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082158-amigo-vixen-99e8@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c2fe914d50ab22defca14ac6fca33888bfb19843 Mon Sep 17 00:00:00 2001
From: Lijo Lazar <lijo.lazar@amd.com>
Date: Fri, 18 Jul 2025 09:25:21 +0530
Subject: [PATCH] drm/amdgpu: Add NULL check for asic_funcs

If driver load fails too early, asic_funcs pointer remains unassigned.
Add NULL check to sanitize unwind path.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 582bf7c5158dce16f7dc5b8345b7876bd8031224)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index e56ba93a8df6..a974265837f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -55,7 +55,8 @@ u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev)
 
 bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev) || !adev->asic_funcs->get_pcie_replay_count ||
+	if (amdgpu_sriov_vf(adev) || !adev->asic_funcs ||
+	    !adev->asic_funcs->get_pcie_replay_count ||
 	    (!adev->nbio.funcs || !adev->nbio.funcs->get_pcie_replay_count))
 		return false;
 


