Return-Path: <stable+bounces-140441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 958FFAAA8BF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994CC46789C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051673537CB;
	Mon,  5 May 2025 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKPSVwrq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B03537C3;
	Mon,  5 May 2025 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484858; cv=none; b=LGuvwuR+NgRJ4CWQMXjflTb3z/gBy3UBX+jLVBNqFQH6W0FyW/oQefbMS9zHDuT3nD0dlcQ7BjDF/e1vlwS8ml8gaKWOB6VMOpW1TuHgr6XNBJdcsKW91voeM/E4emDeKLznd8Pxwo+Iu4MG7BB7OlVjvUGtZZIydRE8Q4DFWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484858; c=relaxed/simple;
	bh=4o1SaIJfbgsIyH2KkZE6s8ppy/CEyUkg5lfmus5W7iE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uo7Bacr6/HZeHajf/m5sU3aWgshf9tbp20+pUxG/TYlLVpOMRBTlFUlkFfUJHHha7qOQLpz9ODDOX3Z6DNlgp/LH++rlK8U2ZAlDyTIhFvuM3zrZqD41qyfSEQ4LervXEgBsqLuaLinhitWo+qH+AVqeC1Q4aWDfqGcCqXFEAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKPSVwrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F03C4CEE4;
	Mon,  5 May 2025 22:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484858;
	bh=4o1SaIJfbgsIyH2KkZE6s8ppy/CEyUkg5lfmus5W7iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKPSVwrqCQYTKz8umWmMnv9ti/f+w+wPxS0W/kxn77l9GnN9H8CVLW03VZXh1y57i
	 N93l8frgHliZ5xUPgY6oiBIOPFJP0FPQhzbdR14SIx3NFChNHfri2xLfLUDaZc1hsL
	 ZxAY7CyO4jCuUHUdvR2OH2rc0tANumXBoCMviCkw9MosrVeAIWP3M6Rucydi6h/2rr
	 l5KxDq5lvcIgk52h27cTEmN5ftKwa2EMFioiOhTZQwEJPM5tKlvcR4jYbCTAH35dI0
	 NSLsB5uBO0ZXQb9aaTAXELveA45jve1WFYWXO6L9JGjMCU0rVYfURRteY3XcycKmPZ
	 f7X3SjrhzeG1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Kim <jonathan.kim@amd.com>,
	Lancelot Six <lancelot.six@amd.com>,
	Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 050/486] drm/amdkfd: set precise mem ops caps to disabled for gfx 11 and 12
Date: Mon,  5 May 2025 18:32:06 -0400
Message-Id: <20250505223922.2682012-50-sashal@kernel.org>
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

From: Jonathan Kim <jonathan.kim@amd.com>

[ Upstream commit f82d27dcff939d3cbecbc60e1b71e2518c37e81d ]

Clause instructions with precise memory enabled currently hang the
shader so set capabilities flag to disabled since it's unsafe to use
for debugging.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Tested-by: Lancelot Six <lancelot.six@amd.com>
Reviewed-by: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3871591c9aec9..bcb5cdc4a9d81 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2002,10 +2002,6 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
 
-		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0))
-			dev->node_props.capability |=
-				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
-
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0))
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;
-- 
2.39.5


