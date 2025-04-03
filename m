Return-Path: <stable+bounces-128109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233DCA7AF50
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28823B0136
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3524EF84;
	Thu,  3 Apr 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evsnJNW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5423E352;
	Thu,  3 Apr 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707989; cv=none; b=qFfAL8Lv3Ei6Dl+nKFNwKgwaZ4gmU0w7LQkG9JnnkFD5VrYMcISCnmW97JPnpna4XQ3+BjY9cNFH7kyGGiXHeH3DqNqsI438VvqsVhW6gjcFGVe1GpXQqFW5hUTDCPGEVUblzeaeVHZIvagyyd01G0J6uxLbB79YViidWWSKyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707989; c=relaxed/simple;
	bh=M+LD18HVsFl5z7d34huX864eZca3XD7hkoqhhzG8Cjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eedCg6FedF0Bvyx8oVkgorr3pGShUN0RXRCgRRn6oOfQvUUwhS6V1zZt6YencbrPv5hLrY09KneccnH0nUbAhcpUs4UlCCbk/Rgg4jQKMclNcYY5DRnVXfeM+EQn3qomKjZsK8oQAWjgfF7HhpJkPJadUo5a18RSZOdqGdmxAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evsnJNW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7029CC4CEE3;
	Thu,  3 Apr 2025 19:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707988;
	bh=M+LD18HVsFl5z7d34huX864eZca3XD7hkoqhhzG8Cjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evsnJNW2fye9gAKoqHlqhhbbBtCSFKVuNz0ahPpCcfN05/If0rNerpuum403Mcvkv
	 N9k4jNiX8/1Q4u5b/HKbs7nbc6a6SP942xtWKzseaaLyWqjc4Wjh1Jd+ReumxZtMyF
	 HzwbC7nwUdngWjM9w817oQA0cNef2R1O1tsFRE0ViL7FQdUU+wJ8ry2j74C5JrGvqi
	 Cw3iOkbm5JqykxJGT93oGuIPLF4Cj3UUAF0BmK1inb5tIY7J7NK3ibpCefgYokWYe/
	 aA6HSUXU6eyCW4RuwYMXoIWhpY9RYKkaAzfPB2WtGWHSHLuNhG85Y0HH2uua0Wn1JA
	 QdlP3geoz5gfg==
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
Subject: [PATCH AUTOSEL 6.1 15/20] drm/amdgpu: handle amdgpu_cgs_create_device() errors in amd_powerplay_create()
Date: Thu,  3 Apr 2025 15:19:08 -0400
Message-Id: <20250403191913.2681831-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191913.2681831-1-sashal@kernel.org>
References: <20250403191913.2681831-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index eae4b4826f043..ab8ae74646649 100644
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


