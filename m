Return-Path: <stable+bounces-79076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670198D674
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D48285314
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CF81D0BAD;
	Wed,  2 Oct 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KrR6v2Nw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666D1D0BA8;
	Wed,  2 Oct 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876369; cv=none; b=QXZYxwckWNXhs20YQ6zi6XLR6VrOm5fVV/ZVpvQnTvvWq7CUpWj5TN9nCz49aDV73ltlOigMZZrC/57eB6ANh7pIP2eJ9bpUEM9mSa0jo7pLFpgLIN94j5SIQCnL+a9egDsWxojYr2txtnKg0fEA3MlxUgccYKPWRqS/qXwjej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876369; c=relaxed/simple;
	bh=aLXwvYSe8NnbkMM1vhxKBSLoQI7FElnAN2I8MWu3X7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuzsaOIN4o/0I2OzLewfeOgK//lUn1bkjI0oUh4KwzqOHPJd8E/bQ9xdZuUFPtKddcMlIeC9EnIyzK6gjMRTMQBiqMuVOPF5Ww5xw87ui+bI/CD65dyAfrjEq1Y0n2a6UOC4CbgPQuleNX9PgG+94A5/DQWidapFTDINHxnmDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KrR6v2Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C596C4CECD;
	Wed,  2 Oct 2024 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876368;
	bh=aLXwvYSe8NnbkMM1vhxKBSLoQI7FElnAN2I8MWu3X7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrR6v2Nw/JORKq00FTm280NnSxl1o66pBjO0eK504dJ9pJhpXunrYtiWzAVOXh0Zy
	 q6DyLTjtur5/7uuzg0vWxcguqerx21DMXLR/bBUE6UoX6q0N+U9gS3m6KnsP5RNfxW
	 nM25WatUlPpk2keY1dKo+/yoHlsitUUFD7kFLT9E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 419/695] RDMA/mlx5: Obtain upper net device only when needed
Date: Wed,  2 Oct 2024 14:56:57 +0200
Message-ID: <20241002125839.180163199@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Bloch <mbloch@nvidia.com>

[ Upstream commit 3ed7f9e239938a0cfaf3689e2f545229ecabec06 ]

Report the upper device's state as the RDMA port state only in RoCE LAG or
switchdev LAG.

Fixes: 27f9e0ccb6da ("net/mlx5: Lag, Add single RDMA device in multiport mode")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Link: https://patch.msgid.link/20240909173025.30422-3-michaelgur@nvidia.com
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6048b9ad13bb4..5926fd07a6021 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -550,7 +550,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	if (!ndev)
 		goto out;
 
-	if (dev->lag_active) {
+	if (mlx5_lag_is_roce(mdev) || mlx5_lag_is_sriov(mdev)) {
 		rcu_read_lock();
 		upper = netdev_master_upper_dev_get_rcu(ndev);
 		if (upper) {
-- 
2.43.0




