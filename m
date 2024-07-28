Return-Path: <stable+bounces-62201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694C93E6E1
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5436F1C21397
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41CA84A35;
	Sun, 28 Jul 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q97uIHFg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617CF83A17;
	Sun, 28 Jul 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181698; cv=none; b=S2DNFG1X6A/6ATfbqWBT0eStF5fIzOezFj4LK7vamf1CZo+mIv7sfNBYvVWHOTVepgvGaRRxDYm0Z+hcdXli0q/Hvj0zO2uzB1Yx0yensY56lboGRv/uGR8QJ7FwCjPue7o6UDbEEjDYT0SWm8a+teul4y3+RwXw/Zt2N1AUbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181698; c=relaxed/simple;
	bh=ID8h/18SB9GckBBJF5tN/yg9b942XvfP4BGpr1F9sG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbRr17lf65xGRZxrP//S6YKqKD3axoooz3twHP7Z9CFqK1ZrMwsosKcIBpXDDelnBHgObiJZZDiIZiu448OE91XqQyYnbyUlGcIEwoGKgRFgXjVbrAsqlFSPUU0xTYS/SASBEFhKDMoFeEmf2FTv+C9U9Pf/NcsVULKpgx7/qlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q97uIHFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6D2C32782;
	Sun, 28 Jul 2024 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181698;
	bh=ID8h/18SB9GckBBJF5tN/yg9b942XvfP4BGpr1F9sG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q97uIHFgYccLhDmP6BH2XzrRyZMmpaQEi+UwnyYDospx2bk909l7HEHY9YgLChZyR
	 yMr96vI25AtWMK3aT91L1i4uOe8+wQ4Tt98J+zYE3VYqdasdBPmM/Hto/8UQoitj8U
	 GRtwPFbrSI6sKckKwohvILIJ2vLD/JSJ/ulRnafgk98F2wB9KcZO6/pDPzifFsrOHK
	 HRKc/eP0vKJBBzDZ7cnFYIOr5vuLBFJb6m5TzXeNSjK2f1txlKF8c9t5bXZn7DxnTN
	 Nrn+O8v+IjI7s0qLttBsKvcidAkZ2uzQxjiOS1eHN3z8mob8cbC6mF/gpi6lENnB87
	 kEWxs7McMmuWg==
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
Subject: [PATCH AUTOSEL 6.1 03/17] drm/amdgpu: Fix the null pointer dereference to ras_manager
Date: Sun, 28 Jul 2024 11:47:13 -0400
Message-ID: <20240728154805.2049226-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154805.2049226-1-sashal@kernel.org>
References: <20240728154805.2049226-1-sashal@kernel.org>
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
index ee83d282b49a8..4b7b3278a05f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1679,12 +1679,15 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
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


