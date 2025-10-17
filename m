Return-Path: <stable+bounces-187109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F10CFBEA1CD
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 097555A2F0C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C54336EFE;
	Fri, 17 Oct 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Szq5Tn0u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB812336EF8;
	Fri, 17 Oct 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715144; cv=none; b=W2c+K2YX0+jq+azwpUFp9oXLr8TgJQUTpmQ0GQWhteF01jtRD6xxMHYuI7u4Kspq1TH2AG0UHfTNeC6G2LLJDj73LKTCHjgIxBXTiDr3FsnDPI2dXLI561qfpLRKBH3LxLuzFkecBNU7ewu7C5SBUOf20ZeW5pXyUEBw+LYSvRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715144; c=relaxed/simple;
	bh=BetPScECIQ+oQz0LT8K+T5dNNGkVdwPasqGeL6hVhLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBAdJnsZuUNJvhUmi65x26UgccWNLK/EzmxTT4OSH9f+1b5NuwvRPFjB4aK1LXiYQdUJmcmZQ8WPj7qDnVLtzH5zAKaIvp21QPs6ETQiv3IooTakcUKlmdvl7OTM4HjFDRmBc1rx++SzdagYo7jwOF+wJjHRLlzMJ+oKeE4WuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Szq5Tn0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51563C4CEE7;
	Fri, 17 Oct 2025 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715144;
	bh=BetPScECIQ+oQz0LT8K+T5dNNGkVdwPasqGeL6hVhLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Szq5Tn0u9bafAdk3JAhdkpFpm0QUSaKkEAPnMReXG68k9h4FtW59w/+epSr5WK3pA
	 KbSByKDieaAIBb554xeUXXEgLdvJgw6ND3TPxPCx1sl/3LrwpQTgMEkocYyKixnmKC
	 /MzZ1APQcKS8dNi0rOrtkEJpUGhXqgedNFyLEJy8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 113/371] drm/amdkfd: Fix kfd process ref leaking when userptr unmapping
Date: Fri, 17 Oct 2025 16:51:28 +0200
Message-ID: <20251017145206.026023560@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 58e6fc2fb94f0f409447e5d46cf6a417b6397fbc ]

kfd_lookup_process_by_pid hold the kfd process reference to ensure it
doesn't get destroyed while sending the segfault event to user space.

Calling kfd_lookup_process_by_pid as function parameter leaks the kfd
process refcount and miss the NULL pointer check if app process is
already destroyed.

Fixes: 2d274bf7099b ("amd/amdkfd: Trigger segfault for early userptr unmmapping")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b16cce7c22c37..d5f9d48bf8842 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2583,12 +2583,17 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			 * from the KFD, trigger a segmentation fault in VM debug mode.
 			 */
 			if (amdgpu_ttm_adev(bo->tbo.bdev)->debug_vm_userptr) {
+				struct kfd_process *p;
+
 				pr_err("Pid %d unmapped memory before destroying userptr at GPU addr 0x%llx\n",
 								pid_nr(process_info->pid), mem->va);
 
 				// Send GPU VM fault to user space
-				kfd_signal_vm_fault_event_with_userptr(kfd_lookup_process_by_pid(process_info->pid),
-								mem->va);
+				p = kfd_lookup_process_by_pid(process_info->pid);
+				if (p) {
+					kfd_signal_vm_fault_event_with_userptr(p, mem->va);
+					kfd_unref_process(p);
+				}
 			}
 
 			ret = 0;
-- 
2.51.0




