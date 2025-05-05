Return-Path: <stable+bounces-141146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A3AAB617
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637757A1731
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DEC329D2D;
	Tue,  6 May 2025 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFX23x09"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD32BF3D0;
	Mon,  5 May 2025 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485307; cv=none; b=UzAVkzwbRvxZAH5Fg3f8RhKkq13t3oT7GXlhHNcJlASoY21JeI1t59Ky4z9/Z6aml0vrOLClpyNFfoVgwwkv4cyA/JGw4A8dU3n3KOfBiPaOGc4ZSRNBWFz/GSK0EMw9oJJbs3KzcxFeI7MUelDr9KJrfEWFNV3fYkOAjMp5FPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485307; c=relaxed/simple;
	bh=ThMI58tx3Plf6LbcYctJfyvp+twd840+OZ1wM5jYdTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyg5tKXb5oSXn7GRhz90r26frtFgpap94doLVIFCm82+SuWC99YGR23eQ8dxxoM+m1tjm4DhvysuAm8TrNaKC1h1E5uv772rVl6KmadrbKz/I6E2PgU5YrEXODiwi6zbOOy1tM/vSJ95kMJwZV7U5uzqcp6AqLjcNkb2RM5NVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFX23x09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CE6C4CEE4;
	Mon,  5 May 2025 22:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485306;
	bh=ThMI58tx3Plf6LbcYctJfyvp+twd840+OZ1wM5jYdTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pFX23x094F0y/6vHaVmD8vcn27+0pa2DWbJse0sy88mrIE/8OQytJyQKLNM2NzI7I
	 yZNzbsnck58aUuIpGF1GwUxJOl2Yr8gdEfNUA0GmupdMZhHyEF11TFUB3A/iEX+mKj
	 mpiWSfqitarvHX0dcrj902BGpx2rtPh+C7tbDAZrtLjMXGubG2BtEUTNWxjXkvjaf7
	 E5RWs1OYw+y30zdcCgvCYePE5Ncvxgf5LfZ+vPI4iaYiJYO6w2XjvIjG++TONIFLJW
	 D9hokaDkFYFHVd5z46mG8C1fYn2gl/9cUEwc4ZmetOYey7968MP2y4HJmyK4dhWdG1
	 FzJRfJcBfZH/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	eperezma@redhat.com,
	cratiu@nvidia.com,
	tariqt@nvidia.com,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 259/486] vdpa/mlx5: Fix mlx5_vdpa_get_config() endianness on big-endian machines
Date: Mon,  5 May 2025 18:35:35 -0400
Message-Id: <20250505223922.2682012-259-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

[ Upstream commit 439252e167ac45a5d46f573aac1da7d8f3e051ad ]

mlx5_vdpa_dev_add() doesn’t initialize mvdev->actual_features. It’s
initialized later by mlx5_vdpa_set_driver_features(). However,
mlx5_vdpa_get_config() depends on the VIRTIO_F_VERSION_1 flag in
actual_features, to return data with correct endianness. When it’s called
before mlx5_vdpa_set_driver_features(), the data are incorrectly returned
as big-endian on big-endian machines, while QEMU then interprets them as
little-endian.

The fix is to initialize this VIRTIO_F_VERSION_1 as early as possible,
especially considering that mlx5_vdpa_dev_add() insists on this flag to
always be set anyway.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Message-Id: <20250204173127.166673-1-kshk@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 5f581e71e2010..76aedac37a788 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3884,6 +3884,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	ndev->mvdev.max_vqs = max_vqs;
 	mvdev = &ndev->mvdev;
 	mvdev->mdev = mdev;
+	/* cpu_to_mlx5vdpa16() below depends on this flag */
+	mvdev->actual_features =
+			(device_features & BIT_ULL(VIRTIO_F_VERSION_1));
 
 	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
 	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
-- 
2.39.5


