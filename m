Return-Path: <stable+bounces-127980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C997CA7ADE1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF84E3A215F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4788294A26;
	Thu,  3 Apr 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K486Le4Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A6261E5A;
	Thu,  3 Apr 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707668; cv=none; b=P17emTXzfevC1yfFRp3dxD9ieyRyGP48BM1qUkVzboqXjSxH9/UR+aAKtpnyzu/P8bcAuJABwUbwFDZczc2FO3+WjUimb957KwSCfF7xnSSGMlkhPTW8g51qV8IOuMu0AjfJH/ljEwkjtkDbA0wXmj650EIdy+4KfwvH3oc8R6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707668; c=relaxed/simple;
	bh=c4UmLzJirykiDj9tqkoEAjFK8HkN7gf+2yTFLOTMjG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=egk4ivd158ZfPrS8qeZf/U0AlPcEArntb1hqMLzDIHL1o3ScDhgMDX1Z4SB/vm8IPjy0mrbUiPDQ0cVctELF0aZG6AyYHJRfdhQLd0KunYbk0wV33QUg0VAeYhrLDbphhS6ncJnriYUpVHiilzwWzWh7AOI82wpaHmFSxAJrLSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K486Le4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF21CC4CEEC;
	Thu,  3 Apr 2025 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707668;
	bh=c4UmLzJirykiDj9tqkoEAjFK8HkN7gf+2yTFLOTMjG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K486Le4YmddXUsygrPAsvHJGJjjUvTZUzBSeM01FjI+FHH00J4jzNjZUkaECL+FWj
	 82KbH7/oMPFtmtwKRdBMTXSRrxGgIbs1Nzmg6U/Z9Hk2UZiGuxZU/YY8jKZpZm5hS+
	 UkdG5UmfUCGQgF5Kvv5k9pIf0UQsEyJPY7QN1+3qudZYlinsr6MhhxLefXgMbgHRBL
	 Zhb2eIh9iXdP/xiIRvX+Q1OD+DJDAF2VBMzHzEANsphnoqpuWxV8+1nLKyDmcFLZwS
	 yxDMXJY/2P0ULt6/My4GKV21jzcG5n7EPEfHm+3Tu71fPpKy3pDhkHdFYWmpf5j48q
	 S1QbN1LUkXipg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Kent Russell <kent.russell@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 25/44] drm/amdkfd: debugfs hang_hws skip GPU with MES
Date: Thu,  3 Apr 2025 15:12:54 -0400
Message-Id: <20250403191313.2679091-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit fe9d0061c413f8fb8c529b18b592b04170850ded ]

debugfs hang_hws is used by GPU reset test with HWS, for MES this crash
the kernel with NULL pointer access because dqm->packet_mgr is not setup
for MES path.

Skip GPU with MES for now, MES hang_hws debugfs interface will be
supported later.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index a29374c864056..6cefd338f23de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1593,6 +1593,11 @@ int kfd_debugfs_hang_hws(struct kfd_node *dev)
 		return -EINVAL;
 	}
 
+	if (dev->kfd->shared_resources.enable_mes) {
+		dev_err(dev->adev->dev, "Inducing MES hang is not supported\n");
+		return -EINVAL;
+	}
+
 	return dqm_debugfs_hang_hws(dev->dqm);
 }
 
-- 
2.39.5


