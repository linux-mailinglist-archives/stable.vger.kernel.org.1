Return-Path: <stable+bounces-62226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F393E72E
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE6C1F2534E
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D813A869;
	Sun, 28 Jul 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMaz6eYN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3147BB15;
	Sun, 28 Jul 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181818; cv=none; b=tOXBpXm2MfRd0ekzT4BHNcu3J8VpBwh04GeBq123avONHXivOjN6o71MEbNHlpPJSNP0zChGgTctugPizIMyw/guYV4OL0djbqoxXxIowsL6pKfeg9dPflnTVINq0PsjIkBESG/AFoRvjGpQDAKIMXe2mM9dUjlDjxFCCNIlUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181818; c=relaxed/simple;
	bh=JGsjm2mSWIPmoNW4I3j8FcvEHbK+k0jSfyDEkRqo08o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJ102EDLSaipMy8+stPBj/9eyM7OpsdTZkXy6x0l3rCoK6f1JmJ+eS9HT2ihNQLD5MpCXCQo4V9Ojn2vquUm6QRVA2gySM56c0HUG8XOM2hShzX5s1bn8twN5BeuUkTtaVAPHjnnHQwNV0gpQwhwnOAaFBWB7vQxdFxwQEmb2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMaz6eYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B62C116B1;
	Sun, 28 Jul 2024 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181818;
	bh=JGsjm2mSWIPmoNW4I3j8FcvEHbK+k0jSfyDEkRqo08o=;
	h=From:To:Cc:Subject:Date:From;
	b=nMaz6eYNE+byWnMom04LnnHcrjT4gLcWBY+slQjfkAhSr8ZyAAPTRjQQkQrxvArZa
	 8hT7HS8dPReYhfIMCUaotqtu+/loAq6YH2VPQszaYnfr2YHbFxHPo/ZyldhW6ovAXz
	 bzDasW5THREudsdhhsJJa+s+8nLhLLLRYza0pkaNALn73E3z5NcNy9hgxnmcm5LeIO
	 cL9/rfHjtZd0kGJgxUtvi18A4g9D03RbAAlBsmZGeb9CabYsXXh2kBVR6yKUzeLWjO
	 1uid5wDai50i72NcVFNvGGpTXxu0EzYtTlZX4rHSbl9D9ps2/p64ufLzxyw2baJvoi
	 Xjje0VY/SnVmg==
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
Subject: [PATCH AUTOSEL 5.10 1/7] drm/amdgpu: Fix the null pointer dereference to ras_manager
Date: Sun, 28 Jul 2024 11:49:55 -0400
Message-ID: <20240728155014.2050414-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index e971d2b9e3c00..56f10679a26d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1351,12 +1351,15 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
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


