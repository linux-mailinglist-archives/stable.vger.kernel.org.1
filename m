Return-Path: <stable+bounces-62233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 632AE93E744
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E258AB22CBE
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9774B13B299;
	Sun, 28 Jul 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLvJ7Umd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D737708;
	Sun, 28 Jul 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181849; cv=none; b=KMQgUgTRM+hqYy1nCqYdMJ2Zf9iGQbixjHqCpbLeF6AsGIIGu6MBV4oiBs2J2QrGkAngSp6AeJANlukW97bhDpV5ClQn7HZdYhFohTt2BMElA0PT3ZkquDOqhU9XJ69cRIZWhr9dSNshBpeItNRc+7bfdLgQ1MrGSAoxlQBTGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181849; c=relaxed/simple;
	bh=KALLrYV+Zxa0bQhiA9biUBgvIiyIfY5GNyLwImNTXOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCjq4TsElSuhWl34Qb0jLPBMNNg/A6t0fFancUhY/32rjnWtPSrFKF3EiLGLKrRmu2Fv1dloYXLBEtkO2TVyijUbCDCflJlSyRe7BJzNv+T1H4BMqJz3hzQwbvOybhwo+QO2dwnvQloL5btm+ga8H9PDrX1HL0YLbgFwJO5T868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLvJ7Umd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BDDC116B1;
	Sun, 28 Jul 2024 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181849;
	bh=KALLrYV+Zxa0bQhiA9biUBgvIiyIfY5GNyLwImNTXOE=;
	h=From:To:Cc:Subject:Date:From;
	b=vLvJ7UmdAKAGIuyIgn+llb8bEhBUjJ8JIv3XLRukhOwbSFoJHbbLtCa/1A/jx8Fg1
	 oYDFySPoR2LXiX2mZ3IJE0TwhprXg4+PQUKLsSlSnBG101BYmkmrYAQNDp3ZjUtzQN
	 a2b3GNg2c4Oxp5+lYVvvSRGfTim6xWJWJ2PRiGPfUWTpwg91ioVx3HfmuC4PQt9JuN
	 u72XpoVke2WVdkmRwrKtXgFsncltny7hz77/AzzwKXdkuruzAzfXRKoC4vjN7eooGm
	 jdnW6V9NQepetrDNpCaNrlxsuwxI9kdL6m/waJS+r8j1UPvnKR90t7oPUMff0QfKvX
	 YX7xDg4KHtVmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	tao.zhou1@amd.com,
	kevinyang.wang@amd.com,
	YiPeng.Chai@amd.com,
	Stanley.Yang@amd.com,
	candice.li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 1/6] drm/amdgpu: Fix the null pointer dereference to ras_manager
Date: Sun, 28 Jul 2024 11:50:33 -0400
Message-ID: <20240728155045.2050587-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit 4c11d30c95576937c6c35e6f29884761f2dddb43 ]

Check ras_manager before using it

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b6fc191c353a7..96aad6cc83b1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1053,12 +1053,15 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
 int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
 		struct ras_dispatch_if *info)
 {
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
-	struct ras_ih_data *data = &obj->ih_data;
+	struct ras_manager *obj;
+	struct ras_ih_data *data;
 
+	obj = amdgpu_ras_find_obj(adev, &info->head);
 	if (!obj)
 		return -EINVAL;
 
+	data = &obj->ih_data;
+
 	if (data->inuse == 0)
 		return 0;
 
-- 
2.43.0


