Return-Path: <stable+bounces-141292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE5CAAB67E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396F54C28E9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF4E2D6431;
	Tue,  6 May 2025 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An6mkgLO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5792D6449;
	Mon,  5 May 2025 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485702; cv=none; b=muQSXI79m5ZOm5EkVMZOzXmfSYd+DVILZomT4OczBow693/LECuTwyjfGx5ZIfvmWFNUarcrJEVoifQBxMCY408upmIGZ2TEwcMZIimu/V8YMgwCgMOmsIew24sf/6dmZdtGkMP9Jbuj0HLoDY5980jeO7MJOpqHlS0nFLc5cmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485702; c=relaxed/simple;
	bh=r4fgLAAVznNRNX+Ukr/B1QOru5Iw0iU6f8ToF0OtkFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cETjKa1P6rqcFK7p09OyTt4b+JNafwbXXmwBumQjIFqMzg4dl9oNqM35voh2/1gI48PTiOx/1aMVbLP15KFfCiHU543pDtq5Xi6j1dgY/WSDqFsXKE2ZCI+WxOu13FbavdEVMpYXVUVGq7D93LylN89QtOoOJNy4dSAl2cuti+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An6mkgLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009B6C4CEED;
	Mon,  5 May 2025 22:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485701;
	bh=r4fgLAAVznNRNX+Ukr/B1QOru5Iw0iU6f8ToF0OtkFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=An6mkgLOpfOXnvmTSu6c058drQew3R7QVXZ9mBTuqmg/20vHz4R55mN5X6vnuQshd
	 WLDUZG2N7Pd0IAUgksHroYOPrVgSfLy9wM9p+ppUAUlFJwmTSAR4jaHApIyKGWXJgX
	 cGOoglwEc3lrKyXFLxq84fK7aA+SzIt6t2zWT1xxscN4RIPgjf6EAe+gmWbrdLGKwP
	 zhZs9GZpHbNc3tjuWDyGp3wc5R049Dyhrvx0u39og2lqlgmMNrjTp9GGHczdBrmrKe
	 BW3/qLbwgZJeu6KLieQkDdFTR1OMC8mbVz0HwOp5QBFnE1qb7KOIrLiIqHY0NWUqnq
	 cIxVWJMQ+R/yQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 432/486] ice: init flow director before RDMA
Date: Mon,  5 May 2025 18:38:28 -0400
Message-Id: <20250505223922.2682012-432-sashal@kernel.org>
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

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

[ Upstream commit d67627e7b53203ca150e54723abbed81a0716286 ]

Flow director needs only one MSI-X. Load it before RDMA to save MSI-X
for it.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ca707dfcb286e..63d2105fce933 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5175,11 +5175,12 @@ int ice_load(struct ice_pf *pf)
 
 	ice_napi_add(vsi);
 
+	ice_init_features(pf);
+
 	err = ice_init_rdma(pf);
 	if (err)
 		goto err_init_rdma;
 
-	ice_init_features(pf);
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5187,6 +5188,7 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 err_tc_indir_block_register:
 	ice_unregister_netdev(vsi);
@@ -5210,8 +5212,8 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
-	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 	ice_unregister_netdev(vsi);
 	ice_devlink_destroy_pf_port(pf);
-- 
2.39.5


