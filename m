Return-Path: <stable+bounces-156200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FFEAE4E92
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4708C7AAADD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16585202983;
	Mon, 23 Jun 2025 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K/4AOOci"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CDB70838;
	Mon, 23 Jun 2025 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712829; cv=none; b=RpRZ+Rue7o//hmEV0E0xdSYJC8JKh+K+YVIB5QnrXlStgz4uOX0gzqEJi9L9TyqN0q7TZHSg2NVs6BVMaK2Qbnkswld8os9hkU2mFQDoMfCV8+aqE+wRTrJQj/ml1+NB8tA3uVKMK+mxUJ5srrvenHdGJEnV8ZQI5b0lrj8PMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712829; c=relaxed/simple;
	bh=WhyR74KPO1cRrKYMwn4TTVa+88VYpcnQUoM16beUx3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q72DEdLjUSSd/nRnY5IjuDQfAyXM8jeoFJISGmnigAGD+YcsC37wkDv4DWs01G33GX96RPnciiFiA6CtWWnlaHdx4wT1TCoblYlrcIFwXnpcXIAYxg4ARQTuk9V8+OqQjr4xX0Muk8I8CzxVwRy99t7E/i783oFSh9Rva8gwl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K/4AOOci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA68C4CEEA;
	Mon, 23 Jun 2025 21:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712829;
	bh=WhyR74KPO1cRrKYMwn4TTVa+88VYpcnQUoM16beUx3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/4AOOciPaGMzwcJwl6soxEjuGjZolAaOf6xrDlmUHnDfD1fRDWVLWYre0jsNbgUJ
	 4gWHTvC7a3Qra6GY5YoG2R5yLKN57X2pzKkBGJAROI7uDRrG/EZbKcu7y6R3VRDcRp
	 v4uiNWpdERNYfpmxa49/CuG+c9Em25PfIxUH/A3E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 290/592] drm/amdgpu/gfx8: fix CSIB handling
Date: Mon, 23 Jun 2025 15:04:08 +0200
Message-ID: <20250623130707.263212727@linuxfoundation.org>
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
index bfedd487efc53..fc73be4ab0685 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1248,8 +1248,6 @@ static void gfx_v8_0_get_csb_buffer(struct amdgpu_device *adev,
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




