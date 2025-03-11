Return-Path: <stable+bounces-123947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F2A5C830
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C6E18864EE
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4EB25DCFA;
	Tue, 11 Mar 2025 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwyS8Krn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5051A5BA4;
	Tue, 11 Mar 2025 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707421; cv=none; b=jniCn0uxJFnfhSrlrYvXY0OOWYARkry4Ab76TgMvQVb0rmzu+gmwaUek45TYPmnwkkXDJyeqW7gg9pJyUZNS5cAQjanCfutZTtCSFgFM4DKVWK3ynB1BMY+idDFhrGzLiPBUDrxqyn+cCmWErswfaR5rXBWw57re1THAWBZrQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707421; c=relaxed/simple;
	bh=An6jCjVFwbSklmTV6uxvTu8Oy8Poe/Kz7olRlfwXWdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AppX7wypeDBfeX35K7nWZMpsrH8juIl7FCJD5I/8CrLQzzf/X5sewzmrNXm2G3SQv4ici/oU0acfdm1Vfc31kE0lbvOyjZlaC6EVFXrqCY98bMMrcQmGbnWFTxqPOz9BT/6/QgONYej0ZuTHYhXOIf1rWqLSGilQ468dgoP2A7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwyS8Krn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D722FC4CEE9;
	Tue, 11 Mar 2025 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741707421;
	bh=An6jCjVFwbSklmTV6uxvTu8Oy8Poe/Kz7olRlfwXWdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwyS8Krn0R0iz2eMy+evg/gBietATI26fPNcEkOtckXFG+8wE3sJ7koxfXd/ljMbd
	 5+ns2dvQCJ2jh9yzhnN9IUjaUIFK4paRIeXAkFiscHuUvKwUyR6hzUXR9p/rc3lyUn
	 sFryXZ/brdORUq0MWD/Vz5A8gfZWMQAc5JQbZv7M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrisious Haddad <phaddad@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 352/462] RDMA/mlx5: Fix bind QP error cleanup flow
Date: Tue, 11 Mar 2025 16:00:18 +0100
Message-ID: <20250311145812.263827034@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit e1a0bdbdfdf08428f0ede5ae49c7f4139ac73ef5 ]

When there is a failure during bind QP, the cleanup flow destroys the
counter regardless if it is the one that created it or not, which is
problematic since if it isn't the one that created it, that counter could
still be in use.

Fix that by destroying the counter only if it was created during this call.

Fixes: 45842fc627c7 ("IB/mlx5: Support statistic q counter configuration")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Link: https://patch.msgid.link/25dfefddb0ebefa668c32e06a94d84e3216257cf.1740033937.git.leon@kernel.org
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/counters.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 70c8fd67ee2f6..f6bae1f7545b5 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -337,6 +337,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 				   struct ib_qp *qp)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
+	bool new = false;
 	int err;
 
 	if (!counter->id) {
@@ -351,6 +352,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 			return err;
 		counter->id =
 			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
+		new = true;
 	}
 
 	err = mlx5_ib_qp_set_counter(qp, counter);
@@ -360,8 +362,10 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 	return 0;
 
 fail_set_counter:
-	mlx5_ib_counter_dealloc(counter);
-	counter->id = 0;
+	if (new) {
+		mlx5_ib_counter_dealloc(counter);
+		counter->id = 0;
+	}
 
 	return err;
 }
-- 
2.39.5




