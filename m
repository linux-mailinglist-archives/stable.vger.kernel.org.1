Return-Path: <stable+bounces-120667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFBAA507C2
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0807A1893BAA
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C006520C004;
	Wed,  5 Mar 2025 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bYMIxqsR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB814B075;
	Wed,  5 Mar 2025 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197624; cv=none; b=tkzHKQiw2I9hCio82NzFd8A9h4fyLdG7kPc6bLd6ByChOPkLxm5POLD4eWQ8qujyVq1Qf52Y3vAu20S3UKc8c4G2PsKp+JJeByQWB1nKmx1SzZUP7cqBjbFN33LAbbmLPeppDN6lKyZojZhi72z94nQKT8kUipxn4a2UeSQ3GcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197624; c=relaxed/simple;
	bh=/cnOVNyKoYWh2piN6jiXopl/q3jB7MOYomYFC2vSgqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEnRfjTJD8rYxfgzFSwXEuuIAeNm94ati0w1XvqzQm6UezjPj+YznFbmQG1O/VZBvOdxL2v8VxhsQDMD3ZxWn7ioScevk78Hw8kL03Z2azYrdSTKP97A2eFH7ZBe8ON+CnZbtfCT0YnBljh9exHrvSq1Zl6AaRoKHDq+3+GCjeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bYMIxqsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0168AC4CED1;
	Wed,  5 Mar 2025 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197624;
	bh=/cnOVNyKoYWh2piN6jiXopl/q3jB7MOYomYFC2vSgqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYMIxqsRXu87QgotkUXeI/9FUA3SZVnHAWepsYXT70avLe8zIcEPRIKPYJA2fAkO4
	 +JKEZpRQpS/WhT9zjGq+TsAzbGukpF+y/baJ1HFWh5lE30pQvnZ4g1gDtiNzqdctyB
	 RhlrnbAcdjci/c7HKNMBW8pI7s47uctQ8QeIJM08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Drory <shayd@nvidia.com>,
	kernel test robot <lkp@intel.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 044/142] net/mlx5: IRQ, Fix null string in debug print
Date: Wed,  5 Mar 2025 18:47:43 +0100
Message-ID: <20250305174502.108136785@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit 2f5a6014eb168a97b24153adccfa663d3b282767 ]

irq_pool_alloc() debug print can print a null string.
Fix it by providing a default string to print.

Fixes: 71e084e26414 ("net/mlx5: Allocating a pool of MSI-X vectors for SFs")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501141055.SwfIphN0-lkp@intel.com/
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Link: https://patch.msgid.link/20250225072608.526866-4-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 6bac8ad70ba60..a8d6fd18c0f55 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -617,7 +617,7 @@ irq_pool_alloc(struct mlx5_core_dev *dev, int start, int size, char *name,
 	pool->min_threshold = min_threshold * MLX5_EQ_REFS_PER_IRQ;
 	pool->max_threshold = max_threshold * MLX5_EQ_REFS_PER_IRQ;
 	mlx5_core_dbg(dev, "pool->name = %s, pool->size = %d, pool->start = %d",
-		      name, size, start);
+		      name ? name : "mlx5_pcif_pool", size, start);
 	return pool;
 }
 
-- 
2.39.5




