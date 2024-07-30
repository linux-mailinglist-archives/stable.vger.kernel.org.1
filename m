Return-Path: <stable+bounces-63687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3E9941A24
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7591C21FFC
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF6418455C;
	Tue, 30 Jul 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uedl2vFL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57982757FC;
	Tue, 30 Jul 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357634; cv=none; b=ohZLRwYGS9YJUPFdqpOw2WircXLBX2rFy1Sz7rWP+wcLG8xkFn+/Fp2ToYreCt1hAK2EhvyKaMuofdEYdJpQE5UA21Y/ZRfOvYXH1EtLBBh3bxSvX/kdOO5HRzuHqSB2AXFw+10Ntj+dazuXbpQpFD2osv8M+zGjXG6kOf2H09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357634; c=relaxed/simple;
	bh=iw/VVV/UzG1Kjjp2yeaUA34h+UC+Bp29x6AxM95IEsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmL9fvJxTpfAiXW6PNDcf+OyRlmUrmTYGWnaOtgdSQ33p3xtBlc5tO9la7CT8k5cIkYKsjXpwCui3O0jrU+IMCkfPWJK9+RhY1bljJUkSfLzlqn2FDE6v01JK4wjI0HxvVBA/JIsGLN6/xLnLCprHKemqXLhwtDUWF0TvF5IyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uedl2vFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BB0C32782;
	Tue, 30 Jul 2024 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357633;
	bh=iw/VVV/UzG1Kjjp2yeaUA34h+UC+Bp29x6AxM95IEsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uedl2vFLPNWesJ62lDg0xWoQWv2mfQpfxN0Tjaz+E99dwaVHaJzo8wkMcLyR0efRU
	 pG3hWklEiIeHlzQ5U8Q6eDAYf08fJPfmCF+Aerpen9Ne1ZoYQq9Hg0DNBgTMT68vBy
	 nb8mvrUJMyOAxrRrpmMvMuy3UbmtRdy+0WTvhzRk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lijo Lazar <lijo.lazar@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Le Ma <le.ma@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 274/809] drm/amdgpu: Fix memory range calculation
Date: Tue, 30 Jul 2024 17:42:30 +0200
Message-ID: <20240730151735.414333491@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit ce798376ef6764de51d8f4684ae525b55df295fa ]

Consider the 16M reserved region also before range calculation for GMC
9.4.3 SOCs.

Fixes: a433f1f59484 ("drm/amdgpu: Initialize memory ranges for GC 9.4.3")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c4ec1358f3aa6..f7f4924751020 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1910,7 +1910,7 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 		break;
 	}
 
-	size = adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT;
+	size = (adev->gmc.real_vram_size + SZ_16M) >> AMDGPU_GPU_PAGE_SHIFT;
 	size /= adev->gmc.num_mem_partitions;
 
 	for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
-- 
2.43.0




