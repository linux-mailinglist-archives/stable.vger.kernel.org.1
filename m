Return-Path: <stable+bounces-65105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C6B943E78
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26641C22665
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EE81A4B31;
	Thu,  1 Aug 2024 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GORfFS/z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71C14AD3B;
	Thu,  1 Aug 2024 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472446; cv=none; b=k0WWDgPz3aL10HAqyD6cm/U7IAQyeebfZBZlChHVZu6tp3J2Ng9gviemJ9bDtiVWxDTBzys2Ud81O4A9QB9I9c8OB0ms6Meckr66g5GJlhYPBrweqii1i40r1uP1U6tsFSNgF0isxqEUMBxcQVBS4quFxa5N+pzRFWImLeXMGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472446; c=relaxed/simple;
	bh=mQFDcamehEfy+f2y7/ZwAoCbZU9PhaS/IPvu8IR89nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ud3gIwm689F72WGwnggZq7hc3jANhkSWn6AjRPuen9lH3whlm8lmyRSOw+k8NdIxlSteYFRtN1XYdyB92gqnXLCJcfNVQjcBJDFwppdlG8Yq6IlOizmnDfoQvhxCigQz7KMQwQ5iDYXNIqSlcY1imNUvi9s0uhQpQO++VDU+3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GORfFS/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC395C32786;
	Thu,  1 Aug 2024 00:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472446;
	bh=mQFDcamehEfy+f2y7/ZwAoCbZU9PhaS/IPvu8IR89nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GORfFS/zJATPQ1N4uFXpQeTAnplZQqRd8p3N6XdDkO2iX1boX1HixnbH12MMk33zQ
	 FG7P8iTzUW7fyPtlacFqkzFwZUaDGdIyr47mWPvkRbbUeuxRNPA9EOvWdsrxbD7JfG
	 ujTWEIHXuvq8v6HWFknyW70WOUcPpseBIkwGYTxXh6IxrtYAFdKeGtz9vTtkEMLD0Q
	 O2EOHtZFRE6VFrlnhFHw8j30TzzZFKpJpcnFHPLCTV2imeNs6NyylF/paFTBotQEGe
	 xE5vmsvEzhstqpsrw8XRVA6WOkgxWYCsqlWp0m72nn8+ZK0jBRcgAim83syIuIARD8
	 9+ZTxdanw9qRw==
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
Subject: [PATCH AUTOSEL 5.15 15/47] drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number
Date: Wed, 31 Jul 2024 20:31:05 -0400
Message-ID: <20240801003256.3937416-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 2d01ac0d4c11b..2f5af5ddc5cae 100644
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


