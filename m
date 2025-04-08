Return-Path: <stable+bounces-131016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF92A80723
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25517AF5A4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309326A0A8;
	Tue,  8 Apr 2025 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R9ffv3yw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4541B268C6B;
	Tue,  8 Apr 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115266; cv=none; b=lBH5SJQf6WgU5m+zSfVLdE44n3H3jgAEmSuRI41rbmwfquNkr188eCl8HgwO/kMO6Z68aTqHv3pajh3byhKAKu2aMj4Fz9Ol2jL+zJyuWcjmDkTuGUnXdJkN8YIMdrl8kzTG1Y7pFMoPAnSgvMMEaudysZOG0irLQn3evhXoq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115266; c=relaxed/simple;
	bh=S2YanniDEG9feOP9Jh2LI1qc5e5Q9e0dpsCUIbspz1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNpS3DexOPHtAl468vZUC0AotavCJm7KCAdL/UYNbW3mk4AcDOt+QPBUT7XaqVXiuFbdakRPn+2ycoh9QUCkYZbj59tipJt/xRmRbPdibeEsMs6yL9Y78/GzC7cGi24LCmODHS+R5j3j++uJ8sHyKkiVoHN+gyrFTanIepqyoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R9ffv3yw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D91AC4CEEE;
	Tue,  8 Apr 2025 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115265;
	bh=S2YanniDEG9feOP9Jh2LI1qc5e5Q9e0dpsCUIbspz1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9ffv3yw1CVTBOndc9lOQyZc0vOD9ixhHGmyN6KHJcNZnE40RJb1eOZOAGytpCE4E
	 idMf8FbSUU3cvleqTYiEmMWo6z18puTY1lEXy65VMaoIa3uVtMZ/aEV6DRkCzEuTtQ
	 kucvS9lFqUvul3a+nKhoKduipqxZI4tZTBsH8pKA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sunil Khatri <sunil.khatri@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 409/499] drm/amdgpu/gfx12: fix num_mec
Date: Tue,  8 Apr 2025 12:50:21 +0200
Message-ID: <20250408104901.425764672@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit dce8bd9137b88735dd0efc4e2693213d98c15913 ]

GC12 only has 1 mec.

Fixes: 52cb80c12e8a ("drm/amdgpu: Add gfx v12_0 ip block support (v6)")
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d4218e9e43b56..a0df3baaf2b40 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1332,7 +1332,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
-		adev->gfx.mec.num_mec = 2;
+		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 2;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		break;
-- 
2.39.5




