Return-Path: <stable+bounces-156205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42679AE4E97
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1657B189F600
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B5A21CA07;
	Mon, 23 Jun 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AsG8jsky"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6E1EE019;
	Mon, 23 Jun 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712842; cv=none; b=YN17ESn5ILV5/xOLQD/L8IFDbakD+UpAwyzHFdxkZclTVAgz+JmHcAG+b4OiUTcDElIa3QEjcjrjo0BRW6YyfW6yxlrAoMLlbjVGZwaaxCckSitu/NSNv2NmX96YTJTlVjtDbMYM9GWRwgkJe1/H1dt6mIfrYS5bsD6XVi5PA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712842; c=relaxed/simple;
	bh=gujvYEoeYIxqzTgPcM/xIrtobfIsWGNioNAMZYV9HCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CW2lctia1D+P+WvQilKKAxJCKqKWkXS2xcV1oRzZktgdajo8dL8GBq4qGpgeYGFFEBuprw/EvkeUpXHqVQ6Ee4JvyMdpSLxjugv6r2Nx0DxAv8qbpNW6BXoLkeTpxkblw0Gwm3fv5KONY1CqhdVG1EqeJLFE5J/oP8Yw3/wcSyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AsG8jsky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C782C4CEF0;
	Mon, 23 Jun 2025 21:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712841;
	bh=gujvYEoeYIxqzTgPcM/xIrtobfIsWGNioNAMZYV9HCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsG8jskyPMVPmAiNKdAHPvgyaTAVHnGPTIlUOYhNFVyskY/KwWSnRd32h9B7RsHpC
	 Oz/Z1O4TCwM7ykhx9jB2XyS19LzTQAzsiofUkcvDKBUZtx3FqsWSjSfFOkr9bQKISK
	 o/JMsnc9lcjpkS6WvnZindBMtUD4dHPvPWskOGEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 151/222] drm/amdgpu/gfx8: fix CSIB handling
Date: Mon, 23 Jun 2025 15:08:06 +0200
Message-ID: <20250623130616.628336848@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit c8b8d7a4f1c5cdfbd61d75302fb3e3cdefb1a7ab ]

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 467ed7fca884d..79347df0620d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1267,8 +1267,6 @@ static void gfx_v8_0_get_csb_buffer(struct amdgpu_device *adev,
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




