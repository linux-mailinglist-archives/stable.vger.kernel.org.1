Return-Path: <stable+bounces-140737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA75AAAEFE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D815A1BA525A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED962F2C64;
	Mon,  5 May 2025 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvTsmBIP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0092E5DEC;
	Mon,  5 May 2025 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486120; cv=none; b=USELNMhnaN6s8Gfj8khKPpUgkgYvVgSrZLJ1Em6sMW71/afPFMG6GNvsBftJ2/I518PLsDjD0yvcR/yDY16Y96c0d/F7Y+sI/iovBNPwMvlwt+uyZ/6RappSXIDnquu2ClwMCCv1AGEa0nH5v4q3ga1IAy7lRwJjNXoqwNTIEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486120; c=relaxed/simple;
	bh=NhetDVpHwaNtQW9Pf4j1Qjez9peTYB0dwDkouFiyJuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Io4mJRdAWc3nveQj82t88NfSu3LVTvVpj+NKkT4rwET1PVyEm/TlQDyN+rsndHckFJZXIQrcuDyYZR45ue7SQOOwKMmaBxrvG9omymt/0vEG61ikgahOtY9rCYIOB0wULD2BBV2QDV4czmw9n26PUK5qzTodm45tWWkMZdYE+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvTsmBIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A005C4CEE4;
	Mon,  5 May 2025 23:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486118;
	bh=NhetDVpHwaNtQW9Pf4j1Qjez9peTYB0dwDkouFiyJuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvTsmBIPx4fuFqf2ar8PpLMhw+IYtRpbr+xdIArIcu0bu2jc1YXKI07jJ0ne391vn
	 bOF36nqOXpskVuiNuMyAaskyzjeaoNXOQTtgHzem+TIXGzfcu6uNakBWwyF5r3rDYv
	 O4uUot6iLrViL5vKk/by1VmKXdUe8/5iv3sJZBL+7s1W5TY8RyXl180v17faCt/iUC
	 Zv64JcxrmXp1Q7TG8YT8EAOAIFyGAMpAJLKU+qrYmRFMO07ryvgWbGYlYKLxukCkeZ
	 VztKtZub8eWHeySS+OwPPTgKuiN+zznlZy9Z1yIp8nLFzuodpXORWPyH7OwovEcWhx
	 7hSM40PUHXzzQ==
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
Subject: [PATCH AUTOSEL 6.6 161/294] vdpa/mlx5: Fix mlx5_vdpa_get_config() endianness on big-endian machines
Date: Mon,  5 May 2025 18:54:21 -0400
Message-Id: <20250505225634.2688578-161-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index b56aae3f7be37..9b8b70ffde5a0 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3420,6 +3420,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
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


