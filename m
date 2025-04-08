Return-Path: <stable+bounces-131015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17620A80721
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E2B7AF1D6
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F426A0EB;
	Tue,  8 Apr 2025 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FrlLvXAL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EB268FDE;
	Tue,  8 Apr 2025 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115263; cv=none; b=j+zGRwVXG1V7KdjUEPg2Moo1UvFbbtaaieDMp1occ1u0gStCyqVPUI/dV1jjNE77phuWWHVOvnR0I2b4zXEPFCYT6KRcKLd4v3F73r0Su0/In/JMzPWVqX4ceXTIpBML73aI/cCAi4P5HN8oiaAOtWmKO89KP6xAd48/g1muE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115263; c=relaxed/simple;
	bh=+adt78YNmlSDIyZgiYt/p9VH/Jh9mnrCJT+Bb54yfHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdZ0jHnFMvbjmaYdrjkWe6NYDY8MYMPM31PFnS6qz6nAZSUPkJWF7URYFj264jN+3MXxTtFRjySmVs408o/uKl4To1bGX2YVNjgfAAxl7dR2qvtEyzFNHcTgk6fN9VKNVdM+8AXUf4I3j8eFrFP6AysFIozQk+G1Wcczynn3wo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FrlLvXAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5ABC4CEE5;
	Tue,  8 Apr 2025 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115263;
	bh=+adt78YNmlSDIyZgiYt/p9VH/Jh9mnrCJT+Bb54yfHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FrlLvXALwB6YvDu3sMWgd4zUNh8SV+DeKIAs9c4Wh6fAZvQmjN/f25bs8M3HueN3u
	 qzkZUyIi0ln2JbE87TtsNEbWdG8ZUx3/XT6cVvl8xkPTW5/6vOyK7xPx2pgeaIydBu
	 VhasnlVWCNTTOtTiU7a5F7p7ntIIrXDLgpyxX9zQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sunil Khatri <sunil.khatri@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 408/499] drm/amdgpu/gfx11: fix num_mec
Date: Tue,  8 Apr 2025 12:50:20 +0200
Message-ID: <20250408104901.400796636@linuxfoundation.org>
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

[ Upstream commit 4161050d47e1b083a7e1b0b875c9907e1a6f1f1f ]

GC11 only has 1 mec.

Fixes: 3d879e81f0f9 ("drm/amdgpu: add init support for GFX11 (v2)")
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2ae058a224f4d..a24119b386db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1553,7 +1553,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
-		adev->gfx.mec.num_mec = 2;
+		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		break;
-- 
2.39.5




