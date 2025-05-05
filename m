Return-Path: <stable+bounces-139967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3748AAA316
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC043B7834
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DE82EDB11;
	Mon,  5 May 2025 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVOvBsAt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF082EDB07;
	Mon,  5 May 2025 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483792; cv=none; b=PIDNgD7C4Pf1xXwgh1EzXWZS3OiG9SIG9cGMIsvevFcQEZ4GQ4AokFcCg/+JRLeW/XB+tXbKhIZUUxkbnh/vVQvce2Ryh8AXtiRmSSla494ROlGZGyKL/8+Wxtb+iTnH5o9KC7xJvHzYjnF1pQHi9ybCe/qIj0t13iy7Ee+Cdk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483792; c=relaxed/simple;
	bh=HBJx4tgknO3q8nVzeQsulOIFELLP0vgjGMS2diT3WdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYaz4LLjBtvt+1JnNxd0K6wpoufv8fQmN72ydjh+jbnFc3q6gMO68xCaCUttdS99DabLZVW4FYC4zD3kFafgbIfGIOX4qNX6x1nnI6Vo0wVEOM2S5f9vz0x2rT6qKuvgIVcgee+Nc26GniUzzXZ8kr0S4TtVDRmECnPpd3ia1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVOvBsAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC830C4CEEF;
	Mon,  5 May 2025 22:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483792;
	bh=HBJx4tgknO3q8nVzeQsulOIFELLP0vgjGMS2diT3WdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVOvBsAt+aAdgVxkzlP8RQD4kgq4ANBF6B9PneC80f6TQT1KC9CRZXG9v1Pz+m+vb
	 2w8yU/HiKBGZjs6ea5kCOeH00S2ftfXYNOagqh2yATvHkc0KG5ZpKlmRt2vzK0vGrF
	 SuLNONJtgvERuX5B/51TVC/z2ESJwmRuO4rcx5Ce5FO5aFwzc900LfQ5h/qQJ5DIbE
	 JJGiASrw4k0+KHLqltV6qr+ClYfHLiT8pXREd9JZ72w0IPaogx2Qkp/R2nF7LSz7Nr
	 6PL6IcgjLtZ7bb54b1I0hCWHtR6oUTDGB6lyRlK4aDLhACgbtqb3OXskUTP1Z7rAxt
	 YV6U8/Jedsfnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Sierra <alex.sierra@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Amber Lin <Amber.Lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 220/642] drm/amdkfd: clear F8_MODE for gfx950
Date: Mon,  5 May 2025 18:07:16 -0400
Message-Id: <20250505221419.2672473-220-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Alex Sierra <alex.sierra@amd.com>

[ Upstream commit 59228c6631f902fa826dc61321ab377ba8aadec5 ]

Default F8_MODE should be OCP format on gfx950.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index c734eb9b505f8..3264509408bc8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -98,8 +98,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
 		if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 3) ||
-		    KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4) ||
-		    KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 5, 0))
+		    KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4))
 			qpd->sh_mem_config |=
 				(1 << SH_MEM_CONFIG__F8_MODE__SHIFT);
 
-- 
2.39.5


