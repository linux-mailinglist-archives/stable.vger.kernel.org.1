Return-Path: <stable+bounces-128062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E261BA7AE91
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503597A4000
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FCB224882;
	Thu,  3 Apr 2025 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/Qmducu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210EB224253;
	Thu,  3 Apr 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707878; cv=none; b=F5uKadmcT6JhaLDh3bH+jY3cCcGvNIESoRbGimqfZ8cWBPh2G/d3mXw+oSxLVQdWkVTxz/siU+nTWBQkuQm6l/99jAcZtBRco/z54yMzqHvohFujQuuCq3CT4swHXtaecayNz/s5AYlInCvw9wl2dhPflTVNxXEncJMQb//oeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707878; c=relaxed/simple;
	bh=nRyx3VmQ3nHY0DNs36hSyb4Eipali8JfXysXiAvQ/38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VOodLHeFrok8RPABxSaeEaDSS8TI8kVvUc+zM+YNMBczv4CahxVL6PajBzTk3Bqo2+kziC4gPj1JiHgCcrfQQiQS0hPriWR6VzQ9sN6q2u+MAGVninmumlawDnokm/3qPYT/IXpkj+pygARcyVT5yuOVP0KMukxY9JQ/IvdxDCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/Qmducu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2624DC4CEE8;
	Thu,  3 Apr 2025 19:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707876;
	bh=nRyx3VmQ3nHY0DNs36hSyb4Eipali8JfXysXiAvQ/38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/QmducuhDnXwuw2XWlLM3W82S0MiqlPyXSs97TsGVpplOH0Enaq/tt8tEZX+VRzj
	 7AMbuXw0recVbEGOyyYLPrlaQW3DQnIGF/0j5DgtKoywGsqdGxlYHw/BQI0BQKiNSS
	 /uzjxXFxrrBwelmZR0rCjjtFy0Y4zL7YzEjbkauL7J3wR7ylPuUNY6qzWKtT9bPcJ8
	 xP01jAmvFvPLyi5cSjisqaxE3EuIO36cng7t/z4h5O+pm5OtRJo55NAB/FA+2L1Oes
	 jT5dzU2Vk1G6vDGoO3+Kn1HCe+MyYJd1aUDEfcQ8K77H4LPSQKb17wXVIqDNXuqpz3
	 Set2HtaQKTv+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	boyuan.zhang@amd.com,
	Jun.Ma2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 23/33] drm/amdgpu: handle amdgpu_cgs_create_device() errors in amd_powerplay_create()
Date: Thu,  3 Apr 2025 15:16:46 -0400
Message-Id: <20250403191656.2680995-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 1435e895d4fc967d64e9f5bf81e992ac32f5ac76 ]

Add error handling to propagate amdgpu_cgs_create_device() failures
to the caller. When amdgpu_cgs_create_device() fails, release hwmgr
and return -ENOMEM to prevent null pointer dereference.

[v1]->[v2]: Change error code from -EINVAL to -ENOMEM. Free hwmgr.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index a71c6117d7e54..0115d26b5af92 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -51,6 +51,11 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 	hwmgr->adev = adev;
 	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
 	hwmgr->device = amdgpu_cgs_create_device(adev);
+	if (!hwmgr->device) {
+		kfree(hwmgr);
+		return -ENOMEM;
+	}
+
 	mutex_init(&hwmgr->msg_lock);
 	hwmgr->chip_family = adev->family;
 	hwmgr->chip_id = adev->asic_type;
-- 
2.39.5


