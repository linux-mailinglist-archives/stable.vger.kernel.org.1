Return-Path: <stable+bounces-196562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA21C7B605
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECD3F3658AB
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8FB22D793;
	Fri, 21 Nov 2025 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAc+SWeN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98E21D3F4
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763750726; cv=none; b=LWTt6/sbTB9ZdZj/dzqNcbUsgQHKiqHz+0OZ5kkaEBaqnlc5cvXrcDtaSuSH2axtQYAfZ7XUG3hYG+g2w6WqORJUDugVENhh1uiTpqtW/2hsYNC5+mGUAJMNkQIflSl/4vLrjJZJkJt6Ms1DmV5VQo6bTP517JoX/2mzE0pBm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763750726; c=relaxed/simple;
	bh=BNrHVI3WRf+ofQ0kFOWsvyt6lc+PqgBGlFb/oW4mPFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7WxHkZozpsP2wrKjHzVeclyTMLc2X3TmmaKBNlgOWMmL4uN77rMkcZxMm1FA8W48GvVA9wRUfPpEFujJ6d4NOQyFo5NAUBfZsy7dzeIeHdlyLHSNtTIB82Fobyeb4zfVPBR56JTaNdPDX90k+2lr6VrzQfXDIl9rR3gT1bcLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAc+SWeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB41BC116D0;
	Fri, 21 Nov 2025 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763750726;
	bh=BNrHVI3WRf+ofQ0kFOWsvyt6lc+PqgBGlFb/oW4mPFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAc+SWeNlnUhbhEmp+Uln5SmUt+nzjZMSVXsIhpxUTT+wXA/lAs71bbLCjBt4kDNr
	 2WUJ7olBjzjUmiKUw5iz+kmirNFMPQ/2cINPCuIRvDV/1/AhVToiPPw28PVszfQytC
	 pVe23W0frROG4zdCF9PZNeBoubSwGBh/LmxDsMI/EZlKI/kBb38nThrX1subFD6v+H
	 rOBSiFw5f16vxm3Ht8uN8hsnNuF80yPacmB6JfnJovSB2/NCRX0TiTcX5kmtN+FOyg
	 DClRuIoVW1/Elutm+OQUDAwWALTB/spzD7wtN04hUc/14yMkrP6ObcB056Y5/xYrBN
	 dxy/Fw4CLVYgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/2] drm/amdgpu/jpeg: Add parse_cs for JPEG5_0_1
Date: Fri, 21 Nov 2025 13:45:22 -0500
Message-ID: <20251121184522.2650460-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121184522.2650460-1-sashal@kernel.org>
References: <2025112053-unifier-drove-b0a8@gregkh>
 <20251121184522.2650460-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sathishkumar S <sathishkumar.sundararaju@amd.com>

[ Upstream commit bbe3c115030da431c9ec843c18d5583e59482dd2 ]

enable parse_cs callback for JPEG5_0_1.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 547985579932c1de13f57f8bcf62cd9361b9d3d3)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 7731ef262d39f..b126d115800e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -878,6 +878,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v5_0_1_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_1_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_1_dec_ring_set_wptr,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
-- 
2.51.0


