Return-Path: <stable+bounces-64869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E26D943B46
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87B41F212B2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D877416EB51;
	Thu,  1 Aug 2024 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsfcIpFZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5614374D;
	Thu,  1 Aug 2024 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471220; cv=none; b=CQhVruFipqZDJsmbbTXq9kmIajRli6aA7S7jQlYWRKGexv5z6OtdDufKSLrrxRYEacLRiJ15+uRswmBUECnKyfffS4vBDHPi/xeFdu07WCVQMNBN+pVp2K582/IJmShJ5v0LJw/8ysv7ryfG+VsSk7e/e8jOwnnnJ22bXnQzxAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471220; c=relaxed/simple;
	bh=s0cShORdRMOA69u4SPXLtsQO7L++wk/ue0mxtTkLzsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsGbxPZGLx4YljiXdR0m68tEAoTDD3igWjyJVl+c8Egk8+VXzRBECQqHMCDSaY2AdTSeGJfQx9OEy7wleRlqQAH27Dst3SMnn0Hzlj3JZwC07lJxsJw/AZDmup9GPVw17FU8IMQSbqmNUwMnbQcxp2xM9qqxELmurizGi2aKF0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsfcIpFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF01C4AF0C;
	Thu,  1 Aug 2024 00:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471220;
	bh=s0cShORdRMOA69u4SPXLtsQO7L++wk/ue0mxtTkLzsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jsfcIpFZsK05SsK4AoFqJBldyo8H6s+1SncTZWa4QnWDAf5yllHRr7Aid9d3NT8AX
	 /prdI6x8CIC6dRiU3MzgXvP8lJ7aS4g/52XmKLMUte6CjUV4/0MNLISW9MbHfUUNe5
	 ZDRWYI5WmXKnwpIuSsbebMetwGxqpjphAnIqAlm8MG/L2Z95C8c5BeH95zWqpP4kDo
	 7+FvKY5uXcqCepUqDdch/ucWJhsjGu2Hh/RZaPGuSbCuENB+nYPajMvkXY3sqLjIJk
	 FCaIESxdNkHe8UzamUjduu+QFWmQJPmn2c5IWg2g81m9kJdPur6T6KA1ClF+4tIiKv
	 /MQ5dIwQea/rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	asad.kamal@amd.com,
	rajneesh.bhardwaj@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 044/121] drm/amdgpu: Fix the warning division or modulo by zero
Date: Wed, 31 Jul 2024 19:59:42 -0400
Message-ID: <20240801000834.3930818-44-sashal@kernel.org>
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

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 1a00f2ac82d6bc6689388c7edcd2a4bd82664f3c ]

Checks the partition mode and returns an error for an invalid mode.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index d4e2aed2efa33..2c9a0aa41e2d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -501,6 +501,12 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 
 	if (mode == AMDGPU_AUTO_COMPUTE_PARTITION_MODE) {
 		mode = __aqua_vanjaram_get_auto_mode(xcp_mgr);
+		if (mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) {
+			dev_err(adev->dev,
+				"Invalid config, no compatible compute partition mode found, available memory partitions: %d",
+				adev->gmc.num_mem_partitions);
+			return -EINVAL;
+		}
 	} else if (!__aqua_vanjaram_is_valid_mode(xcp_mgr, mode)) {
 		dev_err(adev->dev,
 			"Invalid compute partition mode requested, requested: %s, available memory partitions: %d",
-- 
2.43.0


