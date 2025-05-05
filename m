Return-Path: <stable+bounces-140078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E362FAAA4CD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B4A188B5C9
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8B2304F52;
	Mon,  5 May 2025 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdIBhEZX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F214304F49;
	Mon,  5 May 2025 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484061; cv=none; b=Hli1I1opMOc4D9pVUE21OakLQsqK5726d2itpIgGvSw8+zYVR5k871kLULuv0U8nvkTOzZKe8ZLxctYaBA2RotzU5RSL4acPh6xeDuNPafIGkn/ga2ETi4GizxrSJxY1+6SaMHpIdH3ypV9LM3eNIQxBj1BaE8QQC6jBY0kmN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484061; c=relaxed/simple;
	bh=i5y9xk12CZLq4R5fPksIHIbwKTgyzbpskjBKUj8Qk4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJ6JKxwD9fh9ZQWC0t1hiZK1c9q3t65ZZMvXpfKUqFOUqtkwrVMjFMO0fkqY0bzWclG6QX9Fx+vUt84wRGhUhBLzwT3O088+LLfUzHMy9z/FubRW6fT2jH7Jc4loLc8WTKHyIj5BCWACmZnUWxEB8z7Gr9OW0jqsCH3h05loYwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdIBhEZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA2CC4CEED;
	Mon,  5 May 2025 22:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484061;
	bh=i5y9xk12CZLq4R5fPksIHIbwKTgyzbpskjBKUj8Qk4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdIBhEZXVotYkNpwMjddl4BNPHKq4vKJ94Jdfk2lE6Id7PF2fmT+R3nvfPIVSX/Nw
	 0DqHzbsmCnQoHax1xgJKsBDqHlu0aOEDYFiZH05usNIMb7tz6Zpy65bWgaSsVjhaiJ
	 ajHKN6YGoV5QqI6c16bZMsYfbGrdVXIlE87gEUc5IpnU2kiat3dGv8SlSpdcIIDIlW
	 4oTRwwYuNsT6FGFOpIMToUZ9bflCGRiQ81Nob8Tc7vSGH09lw/R0/Ntm7Y6gmUGZPS
	 ZnKRFryK1YF1Mp7JvSRAhvpgRbew948W8dLchmHEX9J0X/OkVZG2FKG43lyX1dkbl1
	 auLPbdpH1kQqg==
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
Subject: [PATCH AUTOSEL 6.14 331/642] vdpa/mlx5: Fix mlx5_vdpa_get_config() endianness on big-endian machines
Date: Mon,  5 May 2025 18:09:07 -0400
Message-Id: <20250505221419.2672473-331-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 36099047560df..cccc49a08a1ab 100644
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


