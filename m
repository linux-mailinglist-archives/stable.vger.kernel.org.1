Return-Path: <stable+bounces-135697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E0AA98F5D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1647AE937
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A738C288C93;
	Wed, 23 Apr 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TSj03wWp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63694288C8D;
	Wed, 23 Apr 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420606; cv=none; b=eDNb79Lk6gAM8Y4htESCcOfV3onuEPhcDiFOSYs1pNLJnL3cBR0llaQ4l5lzCib0Bp8/f50yWC1KF4+TkFLoiPLPjTcyADz2oJAWor2Jfk6/LrYQhGxGmWHqLkXc2v2M/j4ZPH1szCPrH5SobuguUExLl5ea/3qA5o3RZm3Huc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420606; c=relaxed/simple;
	bh=03Q/jjH3qANNEtI3QsCvdXdkBh/A1xQpm3+11zc7Ao0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3EYu4YDrfFspknWdSSRH3HpqP7DMwAMsW3NckmBljkxpQOO3KYzF1J48JSup7Qzo25n+KL+TlcbQ5TcC6j/91T5p9FcBpULj+RvEZ7mF8Itg4u4ENtGUfy75+BDoctD2RLgCIK2811wuw+/3P9hP3RpuirnYd7aa6b87JDfrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TSj03wWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6414C4CEE2;
	Wed, 23 Apr 2025 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420606;
	bh=03Q/jjH3qANNEtI3QsCvdXdkBh/A1xQpm3+11zc7Ao0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSj03wWpcPffwj55w+clQiP2mVHnTjMqihWNFdaKYui3KdaxzCw9dxQz7kgzn7PNl
	 NoXNDAiDC7c6uue8SKmVS500RoD01iKvJE493EmhXqXsYs1+x9Xh6CGs5WJiOlBPtI
	 nAMRToMcDnejBaJHd6r3T1GhBRl3zs0QKwpmpvmY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 064/291] drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
Date: Wed, 23 Apr 2025 16:40:53 +0200
Message-ID: <20250423142626.991708030@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 7919b4cad5545ed93778f11881ceee72e4dbed66 ]

If GPU in reset, destroy_queue return -EIO, pqm_destroy_queue should
delete the queue from process_queue_list and free the resource.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 1918a3c06ac86..a15bf1e382767 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -429,7 +429,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 
-- 
2.39.5




