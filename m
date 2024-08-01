Return-Path: <stable+bounces-64990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758CC943D4F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D021F2057B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710FA1C4D84;
	Thu,  1 Aug 2024 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG8Sx59c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8C1C4D7F;
	Thu,  1 Aug 2024 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471868; cv=none; b=KmAU7DKIpEqYNIWmTI1oBEeBhuk3zVZhXU1tHpnGqIzauEiLwyFB6+DlnhU9LCGBYj3n7bnVh3jby2/9H7TyG086xzQBVG4l3SkANrF/jx+YBClyoXKyIAX5/XBg7H9jUdwlA0ZlvEXgcFsGT/hcuqozvOE/xSS6qtWD+Ru6gG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471868; c=relaxed/simple;
	bh=Sg9juNjHIxJttJHw0Hg9nZupDMqinDn9jneDyOle8zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtibC2FmPv9Km10kDHipdn5sdwFG/KFNlGY8088z9kXmoxeiw/RrDmt1eVmjGceEVmyIbh8w/Gzc3Ki4t0H3zex43AT/hitBD2d0//Vf2NIepkdGEidXblgJx1Jm0SB0hNXYonyXgrKB8XM2XJXjIhHqadJvkf8wTS1+LQ0GFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG8Sx59c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3892C116B1;
	Thu,  1 Aug 2024 00:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471868;
	bh=Sg9juNjHIxJttJHw0Hg9nZupDMqinDn9jneDyOle8zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XG8Sx59cD8sfIU8Xzk6ekY/HJfwfahp3TgueKp+pKtw2cp2VpRanp6FBL5eTNpHKW
	 E/vuiYRtwd/zQhRG/ZuTNwSA7x9kve/Mk85KqNvUC6GB0+LOAleOTrgp+4/e1gJZP9
	 dHPCK0gwiu+NNKPXBymnubRW5Tec+O9+QKWZC6BSwbZctQNJDCNtKfok+HuCPFLmsI
	 Ai8fUwD2qC9IZ2wytJZ884ooP6hPKP6eZejuVPiwge0+53iF1MDCwJfW4cs2nF6Uqg
	 bTADAfL56wTUBzZfCTJkpUovG1CGhTCGHCJAhdlKJGTTj/f7u7hImZPYBtg5FYHNEB
	 C8jd+2MoMGPjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	yifan1.zhang@amd.com,
	Likun.Gao@amd.com,
	le.ma@amd.com,
	Prike.Liang@amd.com,
	Lang.Yu@amd.com,
	lijo.lazar@amd.com,
	victorchengchi.lu@amd.com,
	Jun.Ma2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 44/83] drm/amdgu: fix Unintentional integer overflow for mall size
Date: Wed, 31 Jul 2024 20:17:59 -0400
Message-ID: <20240801002107.3934037-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit c09d2eff81a997c169e0cacacd6b60c5e3aa33f2 ]

Potentially overflowing expression mall_size_per_umc * adev->gmc.num_umc with type unsigned int (32 bits, unsigned)
is evaluated using 32-bit arithmetic,and then used in a context that expects an expression of type u64 (64 bits, unsigned).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index cf2faeae1d0db..b04d789bfd100 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1550,7 +1550,7 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 		break;
 	case 2:
 		mall_size_per_umc = le32_to_cpu(mall_info->v2.mall_size_per_umc);
-		adev->gmc.mall_size = mall_size_per_umc * adev->gmc.num_umc;
+		adev->gmc.mall_size = (uint64_t)mall_size_per_umc * adev->gmc.num_umc;
 		break;
 	default:
 		dev_err(adev->dev,
-- 
2.43.0


