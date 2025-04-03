Return-Path: <stable+bounces-128085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18672A7AF10
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EEC3B416A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B60122D4D6;
	Thu,  3 Apr 2025 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB1VzOz7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABDB22D4CD;
	Thu,  3 Apr 2025 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707933; cv=none; b=l1YdXhz8/wgRjNt+8H47Pc++lg4a2iXJSFbe1Km7R77eib8IzJ4Fpi2emq5Yq2urHSZtE5iCJVm9H22gcosjyP06T5uThbOz1PVK6toz7cmAX3XK3tebgtwBQdw0/feYNs41yKVEm847pbuNirnk/vtYKg7MYNq6E3vK7htO8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707933; c=relaxed/simple;
	bh=3yOn4USbalgOi1HsP2QZNo5mp0EAqTwWyd2mr1Sb1bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ej1lTFoXMZHsp90T1bK8u2+KDXRA0oZ9+N6Pbkv96vZfBSL71CkRf8+uhaNvXoIx6E1662EVrzm8+TcdtJs+5OZ6k+vecFl0gIKakOpaYIJRsTtYpSdXR1JkZSMjH7Fbsx2tYm0Ohg9Xwvf7ZYuEd5H12iynnoHUL3TAYPa3Et8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OB1VzOz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA0BC4CEE3;
	Thu,  3 Apr 2025 19:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707932;
	bh=3yOn4USbalgOi1HsP2QZNo5mp0EAqTwWyd2mr1Sb1bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OB1VzOz7+80oT96S3JrxJC480F1DKGoL4kS/1/o+3djfenvhJtg6cq5I4IyHmc6Jq
	 rqOWnRTwo0jpB3VcK4M35+dTLLBZy47hPpHwdagXUz0z4q8baSZBsVgLhVPyJS+wM6
	 F05Qs3zS7gl45JQ5MFBEv6AkzJA4bnqS+HUUOJpVNa5Qtf6UdIjFbyzJLNGsNo99lj
	 93D4SXq/GtLAw7LM75KGAt9Rwa6R52LTOqCYb90eiZcOLVWDpPHXluU4f3QqmOZAer
	 Srbp3BSREWqVVGFWk+Yjjs3scno9hqOEerpLWb9xQ5Kj5NFiFYB7PbyIuRQJyOFWoR
	 /90tPmDog7m4g==
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
Subject: [PATCH AUTOSEL 6.6 14/23] drm/amdkfd: debugfs hang_hws skip GPU with MES
Date: Thu,  3 Apr 2025 15:18:07 -0400
Message-Id: <20250403191816.2681439-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191816.2681439-1-sashal@kernel.org>
References: <20250403191816.2681439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index 9d0b0bf70ad1e..2786d47961e07 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1388,6 +1388,11 @@ int kfd_debugfs_hang_hws(struct kfd_node *dev)
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


