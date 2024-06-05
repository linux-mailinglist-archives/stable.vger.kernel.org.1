Return-Path: <stable+bounces-48148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA29B8FCCFD
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A61B2537A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD5D1C1595;
	Wed,  5 Jun 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cegeb1HP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1559E1C158B;
	Wed,  5 Jun 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588983; cv=none; b=XM9IQ52oaVqdr4SX8ZUHsp6wpEoZKIQnmgBY7VRJeNZ2T+x4v5fQUiVZtsYINUTvnuTJfm/FjNWnQ0F0/UgmzQTTkRr+r6/Nzwk9C3WMdl1KciaVg6RPhXxbq0XxbEWbbMQjtgzly43zUqLBiCMznQdeqCTfSCfW3nGAT6UHICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588983; c=relaxed/simple;
	bh=zKphogx/8wYxjzGfOYOpMTs9aysgexbDswaF4oPT8KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LT2bbtmBkHv8n/Ot8B81oa0YQ5r5l2ebJwfO+LjyseVlCBCbo67WN0wgRZzXmXQYjdd8Umxz2i/tO3ZF9lLrQDKWlv1FDMlqnvu/cgd0xhv6+XgyNrPoTzFVOqckHiNq4C0dqjccHvDBqGg/A1LSmQ/6fUhi/ynZhlTnf5I7JNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cegeb1HP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B7AC32786;
	Wed,  5 Jun 2024 12:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588983;
	bh=zKphogx/8wYxjzGfOYOpMTs9aysgexbDswaF4oPT8KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cegeb1HPeeJXgdaBxlkr8llciIflxHKuyz5agMRtVDKyRnLe5lKd4bIK7wbIKu+jw
	 B14BI37p6+mVzC2T/JMMtl5y/uD5rTXxfWpuF0Auq8Um0H+NFlNsKg5y32HQfy4fh0
	 y32cwXn4JnqFpB+jeHJ+Ek3ZJlPAruGBDA44KChZYVxxCK2miKx3szV575vdu3WR8C
	 tZlilqaFTeuOn3L5eTeSS7FypyLISwg5oF3O/IkvsNqC/YvYlb/YteQcA4YsnlWFKT
	 6ddEv6c4hbbDMWTjE6JcHmqb47GsvvcuFY41MVMIW321xc0A4AZpHq+5+aDYMG4Evr
	 +51VgoaI1EhMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Feifei Xu <Feifei.Xu@amd.com>,
	Feifei Xu <feifei.xu@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nathan@kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.9 21/23] Revert "drm/amdkfd: fix gfx_target_version for certain 11.0.3 devices"
Date: Wed,  5 Jun 2024 08:02:04 -0400
Message-ID: <20240605120220.2966127-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit dd2b75fd9a79bf418e088656822af06fc253dbe3 ]

This reverts commit 28ebbb4981cb1fad12e0b1227dbecc88810b1ee8.

Revert this commit as apparently the LLVM code to take advantage of
this never landed.

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Feifei Xu <feifei.xu@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 719d6d365e150..ff01610fbce3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -408,15 +408,8 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			f2g = &gfx_v11_kfd2kgd;
 			break;
 		case IP_VERSION(11, 0, 3):
-			if ((adev->pdev->device == 0x7460 &&
-			     adev->pdev->revision == 0x00) ||
-			    (adev->pdev->device == 0x7461 &&
-			     adev->pdev->revision == 0x00))
-				/* Note: Compiler version is 11.0.5 while HW version is 11.0.3 */
-				gfx_target_version = 110005;
-			else
-				/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
-				gfx_target_version = 110001;
+			/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
+			gfx_target_version = 110001;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
 		case IP_VERSION(11, 5, 0):
-- 
2.43.0


