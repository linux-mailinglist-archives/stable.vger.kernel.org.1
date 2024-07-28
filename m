Return-Path: <stable+bounces-62183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310CB93E6B2
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1B41F23918
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A577111;
	Sun, 28 Jul 2024 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEPQfzcr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05EC7D071;
	Sun, 28 Jul 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181592; cv=none; b=qp2xtSrMOy2NGF/fyzDBhkCH7rpEwrd2FVbyBcjmqPEGv0K23DoSP4bairr7E26Eg5sIaCsOUkFOUlxlnVUkrtxxNv8fJ2bsr2npPC8vPFwavEEGdEfqG9EvJCuCxMp9PSCsIlf/lZHhEfBhuREcRbbhuao8Y59yU9pEEPrvvyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181592; c=relaxed/simple;
	bh=jEzhEmqGGLMTZyA3OJtr1xZIhHmbm5L8/sN4C75lmOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok4VYGOmZ6Z6HYjglVkQtVc+ZgeMMG3TbOl8HONm2IHcVyk46taYRTiFopyWShEhUMvgF+jvkYglVBe/V0Jm2syDZK3LBeru+wrDnmdVzdq674Fwdn7aBKixMe+ocZdQRDw59W7J97xlj2vFHxSLbQb3o0EPIaf0EY6vf4r2MRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEPQfzcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E0BC4AF0A;
	Sun, 28 Jul 2024 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181591;
	bh=jEzhEmqGGLMTZyA3OJtr1xZIhHmbm5L8/sN4C75lmOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEPQfzcrAnv4exIvNUvYvfNx9ao0atuEJnjWxPvD29MluIL/4NkTJr/j9/hKZuysq
	 m9ElPJQuWuvXRxIlFXK+nGQed8myE0MXoAeJw1kVvuqjnbX0DKa4QiyDbvi3+fg2Yw
	 MUE0tdYlUYuwlsHP20qzgr5DHlKALqwe51Siru4ERjXAX3Qoo3zWDtxIocU13E3QQp
	 ez91DnvHxR7JByJQ6vPXeD7PVG1V8VcoOi4416B7t1PWUiiiLNrFkB+V1XnslWjPww
	 1Y4Iw4yBzgg+VD4d+ws5fKM0liQT5P4FDhF2t4SzW7evj7yAPgNmbOQVsXCCUrVNNe
	 FYoTZeckmikPA==
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
Subject: [PATCH AUTOSEL 6.6 05/20] drm/amdgpu: Fix the null pointer dereference to ras_manager
Date: Sun, 28 Jul 2024 11:45:03 -0400
Message-ID: <20240728154605.2048490-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154605.2048490-1-sashal@kernel.org>
References: <20240728154605.2048490-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 67b75ff0f7c37..7cba98f8bbdca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1780,12 +1780,15 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
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


