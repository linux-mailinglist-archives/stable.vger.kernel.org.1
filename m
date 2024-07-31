Return-Path: <stable+bounces-64859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6641E943AF6
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9797A1C20DC0
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B13115572E;
	Thu,  1 Aug 2024 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOYA+5rZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162613D8A4;
	Thu,  1 Aug 2024 00:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471154; cv=none; b=tCQVUQdZ0yqKY3SFRCu163gS8rmewgs4vG9hj5Bky5cEwdlsSDMWs3nQpRGPaUdvYdw/4c8vt8zPF8w2HE/Om9IsYeYyfL5Qvne6xgSBilf8nH1G+AI7PYkD7RjISuFiamthM3lho8KZVhjUyptPwEsPHrBj9MUi1J1fS7aCjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471154; c=relaxed/simple;
	bh=+3L1MknO07wOY49inR3xzFOkxj/UaQNw3ONi5j/xy+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gnpcq/hzmt0DWoBseH22ghTlcOKMtB32nM0DD5wxwQkHgYPG9X3WO38hYCN5DwfjbMGmFQ0ZxoMElVgoNPT8I5dklcLPl+N/kDS+QnE/XQwMf3pM895qTeabPhRr7WofZrrzGRK5DktozkFDcMZnUbyoneN0zGpX5h64PIuqRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOYA+5rZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F81CC4AF0C;
	Thu,  1 Aug 2024 00:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471153;
	bh=+3L1MknO07wOY49inR3xzFOkxj/UaQNw3ONi5j/xy+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOYA+5rZn+N9JGMWWRGTgtpnPwmqh8PlMgp/pxfEEchHe8Toj9apBxY+pF6+eswC2
	 mhwWgZL0k5AaY+dWDJIrO5kEcEXzESnygCDRMf5i9Byu1i8HSpEnuc33/tFgO7xqC3
	 DPgTNgU+oUrez56OjFiQy/TVRloEglVWbQV1TmCslDvvdGGhm5jL44uJVGsCgmYuh4
	 VOvjm6PHb+a6AYhkhQaZmgBmyJcBlPnyr1yD/acMiCvl894c7nSJRJmUFn9D9N8jDR
	 WgXNyJeXU1Xz1QqYzVG//SLxMJ+4j6aOCnwiPqlMNhM+mFX+cCOa+fUjVHZbJJUn2F
	 ePPp4BAIernmA==
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
Subject: [PATCH AUTOSEL 6.10 034/121] drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number
Date: Wed, 31 Jul 2024 19:59:32 -0400
Message-ID: <20240801000834.3930818-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 5dfab80ffff21..cd298556f7a60 100644
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


