Return-Path: <stable+bounces-141174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06634AAB126
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7397B17AFA2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928993327F9;
	Tue,  6 May 2025 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G68lYuCk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A87F377790;
	Mon,  5 May 2025 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485380; cv=none; b=Cl9rqtSHWV0kA9deNaeBNuuuE0FXIFcyfgsVkBUrPKWHF7DaMsAB1jSPUbvclNC2Db07UA0w5g3prmfz4vDh9Z8mLmOrMQnahg3MamsSOVioRfm6l0GIjIA41Z0sc/5vi1iqLY25oe1C17c1ghA9XoFM8FKkk/xTT/jwiFleG+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485380; c=relaxed/simple;
	bh=9OI6dHYLc8ecmfWf4k9XnmNSY3qVfYkQeVldy1ZXJ2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQnl2fdwNhbNee8oofSaW/5hBv7jiQpKi6iUF+FsXh5lsnhYlsh8Vj/yguhLEoWHiS6FPfkIIOWQon9w2ptutPvRPqfqQMMNW1o1tXPhyEzcwF5/A+bxLEBRhR0UOjqFbGut/9r98TloLOM9UmEZU34rBcYHQ5wAiLIJeOyNGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G68lYuCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAD6C4CEED;
	Mon,  5 May 2025 22:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485379;
	bh=9OI6dHYLc8ecmfWf4k9XnmNSY3qVfYkQeVldy1ZXJ2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G68lYuCkX2zBeusSMzMDeozjIekCzUMYF8y9mkeFUmhWpIQXC5Sh31yOP+TKLjHPG
	 27Qi3IzXhBwh430frIYcC2a/JSo1wiK+czE6LH7LkcqW3CW1zB1BkfpvTvPKtHY1Ag
	 AExVYRFiTstOnCr8xZAbpGLux/Vgc/FeuydWoK6RZmK0HcbEfYfKd5vIEr7BROW2D0
	 I4WlURCd18+hQpXjq801W3LNovcA1jaP6FFhNh5yif2BYFBuJEyT9yPJMPMDNoePji
	 SFx0Kqt6SyeoCLbWNifDlb98NFnSAswR3jxNCP2NvrwXRBA8MA2Eg8VLhFwcimSfQf
	 VY0aAN5Fv0Apg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	boyuan.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 299/486] drm/amd/pm: Fetch current power limit from PMFW
Date: Mon,  5 May 2025 18:36:15 -0400
Message-Id: <20250505223922.2682012-299-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit b2a9e562dfa156bd53e62ce571f3f8f65d243f14 ]

On SMU v13.0.12, always query the firmware to get the current power
limit as it could be updated through other means also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 99d2d3092ea54..3fd8da5dc761e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2772,6 +2772,7 @@ int smu_get_power_limit(void *handle,
 			switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 			case IP_VERSION(13, 0, 2):
 			case IP_VERSION(13, 0, 6):
+			case IP_VERSION(13, 0, 12):
 			case IP_VERSION(13, 0, 14):
 			case IP_VERSION(11, 0, 7):
 			case IP_VERSION(11, 0, 11):
-- 
2.39.5


