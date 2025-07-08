Return-Path: <stable+bounces-160635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DAAFD10C
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FD37AF317
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD5D1D5AC0;
	Tue,  8 Jul 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sJkpDlJ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E4881E;
	Tue,  8 Jul 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992241; cv=none; b=kzPZYfpk9rxhn4l2mNVJwGRBQtK74sF1rAXKOu18SHxNOQs56o0BIW8/kfOQF81PNkfNXXQBHg0GvpubFGxbKa48ZwqYApzd91CumlvVqnd/GIN+5LQ2jkP++NMuKdFCtspPpfuGJzn/1RheevaiEby/bZuXvJYjD+anAR4ku4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992241; c=relaxed/simple;
	bh=Gzx8qDR9RxfGZsHOAOxnB/BuTIv0SXw2MaeRkMKNrpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ghy72Fazqs0sxBWmrUzRcIaZi7DCdsfQXj58Cl/d/qQRdCbOThFJRNugZUF9yjxNGHt5yAUZ4JgsPY16Iqr1nvZlr5QEO4Y47lVHBatIUFCMY6JonO0eMBtSxaOzAU7QlFfw+GqoAz+qtn7T1zh12e/F1v1VR3b78UlxrrK6iQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sJkpDlJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B50C4CEED;
	Tue,  8 Jul 2025 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992240;
	bh=Gzx8qDR9RxfGZsHOAOxnB/BuTIv0SXw2MaeRkMKNrpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJkpDlJ8VVFBYstix1HFmtLGGVorQuB60vcKyZYfQ3CR1Vif+pUj15UtkkPTg3rHv
	 0GUlsLlmPv3tFmBBkJkMpUUlR8Qie+cWkAawC2JXZxUUyu4hlQUvuXV8tDiNb2zkHL
	 68OXPrhcYMQWm/8R3/ryk9nuemS6oi7JPmAuv3no=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrisious Haddad <phaddad@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 026/132] RDMA/mlx5: Fix HW counters query for non-representor devices
Date: Tue,  8 Jul 2025 18:22:17 +0200
Message-ID: <20250708162231.480493205@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
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

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit 3cc1dbfddf88dc5ecce0a75185061403b1f7352d ]

To get the device HW counters, a non-representor switchdev device
should use the mlx5_ib_query_q_counters() function and query all of
the available counters. While a representor device in switchdev mode
should use the mlx5_ib_query_q_counters_vport() function and query only
the Q_Counters without the PPCNT counters and congestion control counters,
since they aren't relevant for a representor device.

Currently a non-representor switchdev device skips querying the PPCNT
counters and congestion control counters, leaving them unupdated.
Fix that by properly querying those counters for non-representor devices.

Fixes: d22467a71ebe ("RDMA/mlx5: Expand switchdev Q-counters to expose representor statistics")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Link: https://patch.msgid.link/56bf8af4ca8c58e3fb9f7e47b1dca2009eeeed81.1750064969.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index b049bba215790..f4aa72166cf35 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -387,7 +387,7 @@ static int do_get_hw_stats(struct ib_device *ibdev,
 		return ret;
 
 	/* We don't expose device counters over Vports */
-	if (is_mdev_switchdev_mode(dev->mdev) && port_num != 0)
+	if (is_mdev_switchdev_mode(dev->mdev) && dev->is_rep && port_num != 0)
 		goto done;
 
 	if (MLX5_CAP_PCAM_FEATURE(dev->mdev, rx_icrc_encapsulated_counter)) {
-- 
2.39.5




