Return-Path: <stable+bounces-156267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C5EAE4EDC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E8E3BE966
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C21F3FF8;
	Mon, 23 Jun 2025 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cZsibhmr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53F70838;
	Mon, 23 Jun 2025 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712995; cv=none; b=R+vl1g+ETIN0iFfPt9eJAvz/c8l2XOYpKRfyguZuQJfqyZCrX/Detcq8gODWBBfGoWrwvVyVXBmYJoLlUZ2w0+Fv68UgnAd0iYfZWbfeq+5CJ/vAcgtc3tezVbZChK4GGuDTgOOYTP5oBZbQjYzSf0QK0LBk5ZPwdf0Ecmt81LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712995; c=relaxed/simple;
	bh=y8buJQi5asKC/xAA/Y7KnFCcMbfYmRASqv57rNxbYL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTldwVsEeYkOrEv41ufOZCUHqUFenl/H8n4/psu/33ru3cFJ21C19oH1j4feh+QktI8fQba1hXR5AJyBptqLm1sv4/inlRaO29oQtkui7L3GGBPY8cEumKYBv6onS14p2JKVpjDUB3BUpkcvpjNSWMBXpE2Tz+KSDgC834MsTQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cZsibhmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BEBC4CEEA;
	Mon, 23 Jun 2025 21:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712995;
	bh=y8buJQi5asKC/xAA/Y7KnFCcMbfYmRASqv57rNxbYL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZsibhmrPz4Vj9g2VQj2ofDY5pB1pVPjlCFGQK+yFHpw6Xm2Zm13MmiIkBdD3Va6B
	 HS0FbbPfB7dyJyBhrqZd3lQzXt6oBi+oXZgJwbg9A0H92Yo8TWEoqQR2iZNAiXGDLZ
	 qqy8Mz1D/9qX53sL27feuK0s/q6IitwkPf+LXRIQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 292/592] drm/amdgpu/gfx9: fix CSIB handling
Date: Mon, 23 Jun 2025 15:04:10 +0200
Message-ID: <20250623130707.317163394@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit a4a4c0ae6742ec7d6bf1548d2c6828de440814a0 ]

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d7db4cb907ae5..d725e2e230a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1649,8 +1649,6 @@ static void gfx_v9_0_get_csb_buffer(struct amdgpu_device *adev,
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




