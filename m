Return-Path: <stable+bounces-204768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A50CF3D3D
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB69319B38E
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9D320FAA4;
	Mon,  5 Jan 2026 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P1QsROrE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D79A1DC9B5
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619133; cv=none; b=AWlYCeZdYDmys9pJftddVl6kWBySu0CzkWFV1GcqV+n4OAA+Zy6FLccC78B1AOtFEGZPLsTDarJaCKFXRnaApBENsBllW30V/SfNlJGD41D1NmRaQ7t0i8wvkaYrl6Jtyamaeb7AwB1yg1SPzD/uyCQyKtcYdHjd2URtxBSc0vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619133; c=relaxed/simple;
	bh=hFufQDmsF12hsvkpTm62MXxV7w4tGdKfSFhwI3ux5nc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PyzbQCtSpj/+MBfD79mwkBa/m6K4cI3hEVIlMpgFav/8o2AApTH0I9rK93ym9y7QNiZCwB01QveeV81hscCw7jrpWSf7wEr0TRld/NdY31VJsJISgo/5t3xcDQde9nfJ76sI1kIUl6SXJmOYgLi+2DG42Croa/mSe7wRXcHNJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P1QsROrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBEAC116D0;
	Mon,  5 Jan 2026 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619132;
	bh=hFufQDmsF12hsvkpTm62MXxV7w4tGdKfSFhwI3ux5nc=;
	h=Subject:To:Cc:From:Date:From;
	b=P1QsROrE1TbzB0F2jj254Kfu0Aox9XI4ozgXPqY/VxaR9TGJlIB9WMUT+eSR/+45J
	 7f+kWOYZeYjMJXrPFjfXYv61kJLj23nl5rjbGcAC9S5B0ZDX/2lAzk6rgfJ9Dp45K5
	 cD6y4FABCnT5yU0oDtu0tWSkQg3i7pDFIeuq9r8Q=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Forward VMID reservation errors" failed to apply to 6.12-stable tree
To: natalie.vock@gmx.de,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:18:49 +0100
Message-ID: <2026010549-ensnare-embassy-d32e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8defb4f081a5feccc3ea8372d0c7af3522124e1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010549-ensnare-embassy-d32e@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8defb4f081a5feccc3ea8372d0c7af3522124e1f Mon Sep 17 00:00:00 2001
From: Natalie Vock <natalie.vock@gmx.de>
Date: Mon, 1 Dec 2025 12:52:38 -0500
Subject: [PATCH] drm/amdgpu: Forward VMID reservation errors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Otherwise userspace may be fooled into believing it has a reserved VMID
when in reality it doesn't, ultimately leading to GPU hangs when SPM is
used.

Fixes: 80e709ee6ecc ("drm/amdgpu: add option params to enforce process isolation between graphics and compute")
Cc: stable@vger.kernel.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d7cd84d33018..a67285118c37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2916,8 +2916,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
-		amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
-		break;
+		return amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
 		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;


