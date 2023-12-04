Return-Path: <stable+bounces-3930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB58803F9E
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95ADCB20AE9
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D3B3418F;
	Mon,  4 Dec 2023 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDlYXIPH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857639FC5
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 20:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175EEC433CA;
	Mon,  4 Dec 2023 20:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722066;
	bh=cq6q6SprEF7TJmOidVjn7rV5ZJdddDKd2dLoRMiSmoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDlYXIPH9DbNeq9VNJJD0VyE1rVxcOQ2qb7hrlojgSvYw6RuQdVIyx7+yag1i629i
	 5tfkVwFZtFe/iP8n+Panfat4rI5wYcv3M6SRF06IFZq/hBI2H/Be2prtisLUukh2Ji
	 XYfBQhV84rWs6qoknLbsuvh2T82K1dWv/xa2+qecdtYbWjL2Y/CvV/fNOGOgVsxzIw
	 LB3BvCqHGiN7mqPFuCL+YGzYDbYSqzT+HLpKSOBxSKJky17WuVp6IqDidK9wObwwx+
	 323DflnPy6vug4u1yGQXRfiIqvTZiDyUM73YM8UIYmNM6dXtuiZOD7Tq0mDsNbC85/
	 Dgn/DUfKCCWxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hawking Zhang <Hawking.Zhang@amd.com>,
	Stanley Yang <Stanley.Yang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	le.ma@amd.com,
	Felix.Kuehling@amd.com,
	James.Zhu@amd.com,
	tao.zhou1@amd.com,
	asad.kamal@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 23/32] drm/amdgpu: Do not issue gpu reset from nbio v7_9 bif interrupt
Date: Mon,  4 Dec 2023 15:32:43 -0500
Message-ID: <20231204203317.2092321-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Hawking Zhang <Hawking.Zhang@amd.com>

[ Upstream commit 884e9b0827e889a8742e203ccd052101fb0b945d ]

In nbio v7_9, host driver should not issu gpu reset

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley Yang <Stanley.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index f85eec05d2181..ae45656eb8779 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -604,11 +604,6 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 
 		dev_info(adev->dev, "RAS controller interrupt triggered "
 					"by NBIF error\n");
-
-		/* ras_controller_int is dedicated for nbif ras error,
-		 * not the global interrupt for sync flood
-		 */
-		amdgpu_ras_reset_gpu(adev);
 	}
 }
 
-- 
2.42.0


