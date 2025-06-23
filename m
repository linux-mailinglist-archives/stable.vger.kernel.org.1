Return-Path: <stable+bounces-156871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6C5AE5182
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD10189A10B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EBF1F3B96;
	Mon, 23 Jun 2025 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cPZwtLwk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811444409;
	Mon, 23 Jun 2025 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714470; cv=none; b=GfzyLNzIcPqIRwtVtgKbdMk7weclcUn3+diEet9BofV7APe+WZMWJdoVO1WHEaRcNUlkrwrvCIDgL+4izDo5mE2Q7VzX8qchPc71fwW6BcEv1S+DbrDmzfFSe4Zt9ARcZ6oP8uatBYJ6f9oRGz7tDNVKO/tR7cfVkcrmjGbWb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714470; c=relaxed/simple;
	bh=+OiklWF7evc6CbH/5u/om4Rq1GSYHxrt2HULJQFzl4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QePtNz3ZE0yUOBHfTzVCYy73BcAF9H/k4NjVOn8L4Wd/GGakt5hR/qZGyqDFsm8savDpJmAeGF3Tv3JgAITaXXSaz1Kmb5SHjbuObydRPEnkLi3LwBJbn+FfDpLqjTArn6WrrjaxbRph8ew/VpPuT7GT1wAmSNshUSbtvfTKSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cPZwtLwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B621C4CEEA;
	Mon, 23 Jun 2025 21:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714470;
	bh=+OiklWF7evc6CbH/5u/om4Rq1GSYHxrt2HULJQFzl4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPZwtLwkrYmXcq+DP9+n5nvVj4V4zIATdk7ESNYPXBlGNl69KcaQJixftfyXg4N5o
	 r8ReuUx9jBBD4xCyBEoueVU0azyBjTOovQwsPm1cMopEz7v5JPQfCnCsvcaykJkJaw
	 5H6RYX/fnjIK36LcwGPo72cWm4Ltlx+w9WoycrSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 230/355] drm/amdgpu/gfx10: fix CSIB handling
Date: Mon, 23 Jun 2025 15:07:11 +0200
Message-ID: <20250623130633.663373513@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 683308af030cd9b8d3f1de5cbc1ee51788878feb ]

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 72410a2d4e6bf..567183a69660c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4002,8 +4002,6 @@ static void gfx_v10_0_get_csb_buffer(struct amdgpu_device *adev,
 						PACKET3_SET_CONTEXT_REG_START);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
-- 
2.39.5




