Return-Path: <stable+bounces-65046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FC6943DD0
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8505E283037
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813211CEE31;
	Thu,  1 Aug 2024 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2p5t8jG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9EF1CEE10;
	Thu,  1 Aug 2024 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472164; cv=none; b=WgyCi8M+2neQieVXoSdAsbvMUUOIP1VFEookjFjZQ1LRMCB/4OrdJYNVAnX9H8xioa6l+3eliFMgQnmzgSx8FFRKdN4AYa3v1WaEze361e+xju9r71zzpzO0l7s+15LY7Yzb3H3tFVO+Xm4DeGXpZzDCNb0Ft9xpahnhmLpCmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472164; c=relaxed/simple;
	bh=R1OzeU8fOoMZmSJ11c9Yzmj9YSBwTx5EEoER6jZfRkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vi2TUVL9iwA4lF0+dyHzkvgDPhNUWPxOWx5Svpb0kDnDFeH6StmxFFsc5/6IHxFbqKPxzf/alQ9RzslIxG6lG9V9QIYksu2Ok4WdLAxgnOJas3F2p7dHJ8rGFUJfbCScdPMHoUJY+pDPJNvHXZXxZiH32GJNUtl3d7D0nYkuq7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2p5t8jG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A631CC32786;
	Thu,  1 Aug 2024 00:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472164;
	bh=R1OzeU8fOoMZmSJ11c9Yzmj9YSBwTx5EEoER6jZfRkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2p5t8jGDG30bqlyB4755UVQtsDxrEl1JwLnWWCg8ysxkjbuEN23/FQB8yeaj2qKx
	 SGR7zh7WkoKrsci+Jn8dSV4tSBViIqiDL8ozGgljslE0CEYoK5AgBul0aHaozX6HKV
	 Wf8f54rBXhQeeNaJHTTa0Yc21/z/BroOM28oSY2JZy5HeHMdSIPXLUh8KlHm4RreLp
	 zmBUHS7oCrpb7w2wPKjo5gXz5p93Wvb6oJJICK+CquBoimBOTfY+V1+Q5VTqWbmWE3
	 /YdwSMjYLQVZE/BdKubbvHBbDqq9CN7BUELgSbSyxD7K/+e3FgzBAoIqxX4bLJjMdC
	 OruWcxE1FVbwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 17/61] drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number
Date: Wed, 31 Jul 2024 20:25:35 -0400
Message-ID: <20240801002803.3935985-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit d768394fa99467bcf2703bde74ddc96eeb0b71fa ]

Check the fb_channel_number range to avoid the array out-of-bounds
read error

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
index b991609f46c10..d4909ee97cd21 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
@@ -70,6 +70,8 @@ static u32 df_v1_7_get_hbm_channel_number(struct amdgpu_device *adev)
 	int fb_channel_number;
 
 	fb_channel_number = adev->df.funcs->get_fb_channel_number(adev);
+	if (fb_channel_number >= ARRAY_SIZE(df_v1_7_channel_number))
+		fb_channel_number = 0;
 
 	return df_v1_7_channel_number[fb_channel_number];
 }
-- 
2.43.0


