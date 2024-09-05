Return-Path: <stable+bounces-73275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E7696D41A
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA9F1F274C5
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0801991CA;
	Thu,  5 Sep 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vqy+iEsD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287D198E77;
	Thu,  5 Sep 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529702; cv=none; b=LFb1ygdmpskJ/JQLJ2bIbcjkFsFwaAoJHpxO/yMHo3DJ6xkLDeJ23Q3g5e1W6z1C/W7G8OjbSTKzo9rAJHaG/AcAoz/CafLKKmgUszUrHTRQu6dxUp3MTq5I30bs8OMqcbyl/UMOyo+R8iSFyMyagdSXsHNoQO/a+/IvOqgEJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529702; c=relaxed/simple;
	bh=sLCq/3ac6z+KZ3urSf4yxXxakRhVNxlUzYxxkr4uTRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npT72qTtdP+KQi2VTUouKpx3bPSWoU46o9Y8CTlL3bqj4sXI5W6us440Ap1bqLy1TkYRkyAMr5TndQRhvoI2a6j94aBp9ZNgi2FZ/Tj0PFs2aN6YkKQfrAvkEXfhI/u2qK4ZDXyZvKrkTGiLa6E1cs2SMS35ciinIDc6jVqL7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vqy+iEsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACC4C4CEC3;
	Thu,  5 Sep 2024 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529702;
	bh=sLCq/3ac6z+KZ3urSf4yxXxakRhVNxlUzYxxkr4uTRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vqy+iEsD91cBhgbzw1W3ouZWKz4jYeSVEjq0TsO7g199I9xV7y3ZHn9FjZdoqDDtz
	 ly3PRIqhq+sivlr5Yx8lqEu8SAyjK2gRT2xYsp8+5ScOhcUgwoSH+0KmupDOvNRHXf
	 UT56tCJrVFOpZVhRdMsFYTHhC+pnBQDFg+E37dKk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Victor Skvortsov <victor.skvortsov@amd.com>,
	Zhigang Luo <zhigang.luo@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 116/184] drm/amdgpu: Queue KFD reset workitem in VF FED
Date: Thu,  5 Sep 2024 11:40:29 +0200
Message-ID: <20240905093736.759129867@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Skvortsov <victor.skvortsov@amd.com>

[ Upstream commit 5434bc03f52de2ec57d6ce684b1853928f508cbc ]

The guest recovery sequence is buggy in Fatal Error when both
FLR & KFD reset workitems are queued at the same time. In addition,
FLR guest recovery sequence is out of order when PF/VF communication
breaks due to a GPU fatal error

As a temporary work around, perform a KFD style reset (Initiate reset
request from the guest) inside the pf2vf thread on FED.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 761fff80ec1f..923d51f16ec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -602,7 +602,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
 			amdgpu_ras_set_fed(adev, true);
 			if (amdgpu_reset_domain_schedule(adev->reset_domain,
-							  &adev->virt.flr_work))
+							  &adev->kfd.reset_work))
 				return;
 			else
 				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
-- 
2.43.0




