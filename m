Return-Path: <stable+bounces-48596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F88FE9AC
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D485288B3E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EAB198A19;
	Thu,  6 Jun 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cE5J7BAJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9213B198A16;
	Thu,  6 Jun 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683053; cv=none; b=DhI8u3gaHLKgvIiDQ2XBky48YzqyHskcFnFXhvh0TIS9s2VDAbggzPJLJpEUVxu/Gf1GnFHiDT8Ljm8wKuI1uFA5BDMteQZGmQ4Qk+OO7xWb5d63NazogwQPfsXYyAmkUqnOOK7tHkLPvS6LsCY7jOFvUhs6g8Pc72kNdCN6+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683053; c=relaxed/simple;
	bh=PaqVYdCi6PYxcip1gQiGoSVuRnhP1krP94sxBScjzSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rk2YpwPIRwxeb5vp/u4NfB8Fd+/2Lin6M/uHtQl6WdbCOBvVd4lSN5o0cCnubjkbKsQsoulKboAvWJNasyfYhodm4Y2U3QdD2WSkjyCGXlMwWFd5eOMVoesaZzpBwlPPcT9XsYWDyN9nDCPHumdN8v9IExM3Y6rV2JCfhwxbm64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cE5J7BAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF84C4AF19;
	Thu,  6 Jun 2024 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683053;
	bh=PaqVYdCi6PYxcip1gQiGoSVuRnhP1krP94sxBScjzSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cE5J7BAJJ+NTK6vCnQ5vIvhyluOf0yhOcT+T3AfG8htuPy3weHi5vhngnBLS2vHUE
	 MU3jFHHwgwRF/oaVWRoZzUb8X6EX02E2zsnRJz0856bsRB5PxGSNY5VDFF8vb0Z8Ka
	 OvmpUiIZPfeiswKliSe5x2gOKVRdiv+ew3heIeLE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maher Sanalla <msanalla@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 296/374] net/mlx5: Lag, do bond only if slaves agree on roce state
Date: Thu,  6 Jun 2024 16:04:35 +0200
Message-ID: <20240606131701.789374276@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maher Sanalla <msanalla@nvidia.com>

[ Upstream commit 51ef9305b8f40946d65c40368ffb4c14636d369a ]

Currently, the driver does not enforce that lag bond slaves must have
matching roce capabilities. Yet, in mlx5_do_bond(), the driver attempts
to enable roce on all vports of the bond slaves, causing the following
syndrome when one slave has no roce fw support:

mlx5_cmd_out_err:809:(pid 25427): MODIFY_NIC_VPORT_CONTEXT(0×755) op_mod(0×0)
failed, status bad parameter(0×3), syndrome (0xc1f678), err(-22)

Thus, create HW lag only if bond's slaves agree on roce state,
either all slaves have roce support resulting in a roce lag bond,
or none do, resulting in a raw eth bond.

Fixes: 7907f23adc18 ("net/mlx5: Implement RoCE LAG feature")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 37598d116f3b8..58a452d20daf7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -720,6 +720,7 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 	struct mlx5_core_dev *dev;
 	u8 mode;
 #endif
+	bool roce_support;
 	int i;
 
 	for (i = 0; i < ldev->ports; i++)
@@ -746,6 +747,11 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 		if (mlx5_sriov_is_enabled(ldev->pf[i].dev))
 			return false;
 #endif
+	roce_support = mlx5_get_roce_state(ldev->pf[MLX5_LAG_P1].dev);
+	for (i = 1; i < ldev->ports; i++)
+		if (mlx5_get_roce_state(ldev->pf[i].dev) != roce_support)
+			return false;
+
 	return true;
 }
 
@@ -913,8 +919,10 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 		} else if (roce_lag) {
 			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
-			for (i = 1; i < ldev->ports; i++)
-				mlx5_nic_vport_enable_roce(ldev->pf[i].dev);
+			for (i = 1; i < ldev->ports; i++) {
+				if (mlx5_get_roce_state(ldev->pf[i].dev))
+					mlx5_nic_vport_enable_roce(ldev->pf[i].dev);
+			}
 		} else if (shared_fdb) {
 			int i;
 
-- 
2.43.0




