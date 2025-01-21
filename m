Return-Path: <stable+bounces-109991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6F0A184CC
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93921623E7
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C831F75AC;
	Tue, 21 Jan 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFtk6cIS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A91F3FFE;
	Tue, 21 Jan 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737483026; cv=none; b=nNU5n5l8wiP7K6XWc8XmvMpl3yPHh0N7uU+v+N9h9aToQrpkS6f0HVvlmuvvrsKYsYK/Aj+oudK48HsY1jTM5/kUvLPfMtrwqJIx5wloHpk/H1VKaRxC2goghImuAEM3M7XAdp+acKFWchXclS8jyi90HklLTfJ2Jrt0y2GgIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737483026; c=relaxed/simple;
	bh=a4KwR2jjRnNoUxrSP0+jUIZcisgPHe6iXLiW7RS3Bcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8Xy7+186/B7592moAozhMs97UDrVDgBvPVaW7ATqRm3HP3ksVPK2yWLZ1yFb7LGGZXTFcY3bup+L2S1p4KczdNruXkHY5jo7tyqGBg3hD8sLf+w/5d2Wn6lk1/XsqNWRlkTbT1L7iNXqD60oKLaUOPg5fypXMeH39U+DqJ/oOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SFtk6cIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A140AC4CEDF;
	Tue, 21 Jan 2025 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737483026;
	bh=a4KwR2jjRnNoUxrSP0+jUIZcisgPHe6iXLiW7RS3Bcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFtk6cISaWy9vu05ipJWpvIyXxQsfi5QRUGwkewEwnXOtAytSWcw73V7B/zgczUs+
	 I5JFBfgEmUyoO3BZfTwyC999uXTH9mMEc9XEdGX+dZ3q/2C630rkV9kSGLzqkE4kZk
	 PU8zn4UXA34JILajQj/rL9ieKCoCZ3Zup+5BuEUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrisious Haddad <phaddad@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 090/127] net/mlx5: Fix RDMA TX steering prio
Date: Tue, 21 Jan 2025 18:52:42 +0100
Message-ID: <20250121174533.118456093@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174529.674452028@linuxfoundation.org>
References: <20250121174529.674452028@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit c08d3e62b2e73e14da318a1d20b52d0486a28ee0 ]

User added steering rules at RDMA_TX were being added to the first prio,
which is the counters prio.
Fix that so that they are correctly added to the BYPASS_PRIO instead.

Fixes: 24670b1a3166 ("net/mlx5: Add support for RDMA TX steering")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 9632abb83f04c..8ff2b81960de7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2366,6 +2366,7 @@ struct mlx5_flow_namespace *mlx5_get_flow_namespace(struct mlx5_core_dev *dev,
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_TX:
 		root_ns = steering->rdma_tx_root_ns;
+		prio = RDMA_TX_BYPASS_PRIO;
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_RX_COUNTERS:
 		root_ns = steering->rdma_rx_root_ns;
-- 
2.39.5




