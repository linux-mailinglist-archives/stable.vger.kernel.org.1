Return-Path: <stable+bounces-128055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773D1A7AEC1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCB31624D5
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B0F2222CF;
	Thu,  3 Apr 2025 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhH5IKV2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AEF2222C7;
	Thu,  3 Apr 2025 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707864; cv=none; b=V1ddqyi7G9EiJk3R+4+czA+YmJJaAFDUjl4DLKgxXBzCQRFTXJx1Tsbp+k+taePq9IE0IZy9laRYEPwDkxK+M94D0UaFzqHmnYNstxsjYJBQ9jsBFfoQOTvSLGUNgUDryBs/jsddYICax5hGeXMXVS7coCctQLEmNwLIHS4mEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707864; c=relaxed/simple;
	bh=LCNhUTbieaiLydBr7Mr2/ls9JdbCnwel2v755q98RRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4yUROSUrdAmVZeVg8VNj1i0Bzt1NFsne8GwbB1+6F1tnDbRcF/jiOKYGOT34TUVS4Y2uYnL6mTKG09dbCWwVdd0GSvTg6qcB/5yep2xChZC+W1eMOQoT6PqUWJVnlB43Hmwf7k00onRXnlJww1+yc+bQ9uR81UDFamDFpLdNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhH5IKV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A33C4CEE9;
	Thu,  3 Apr 2025 19:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707863;
	bh=LCNhUTbieaiLydBr7Mr2/ls9JdbCnwel2v755q98RRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhH5IKV2QiQouD47nb0AA/NYgDPiq0WH2f2kGxcGcD8X5MhgqzddfdrZrD6vCOwwz
	 YACrb0Q/klw8GTYmV7Il3n2gwF5SAPu9Cu6j4F5xjnf+Zt8DSzmyhTTMUfnolIChLj
	 opOVolUCd13tgtkRxUsbFGrA5XUNuy8YuOKjVQttsLgyo5r+qwEcig/VKWyZNqHTGD
	 7vErecL9Lvq+8HHMM1052pT8DmFR92QB94APEif69HRjgk5lScIfCNIXvZKmsgBpd4
	 nt2IeP9ySyNUw5mCQqVrbn2Z0l+DNxX4XvnAsDFf214F37QYKlE+NA8nJ3zmnoZuDL
	 W1YXeQvbFyzng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 17/33] drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
Date: Thu,  3 Apr 2025 15:16:40 -0400
Message-Id: <20250403191656.2680995-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

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
index 42fd7669ac7d3..8e687731a49a3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -530,7 +530,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 		kfd_procfs_del_queue(pqn->q);
-- 
2.39.5


