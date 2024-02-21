Return-Path: <stable+bounces-22575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7A285DCAF
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989FBB22721
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340E17A715;
	Wed, 21 Feb 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="biuPYR1H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9E762C1;
	Wed, 21 Feb 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523778; cv=none; b=kwkW/PoPqpFE+/oPjvn39GPstB1JARDWHeeVRTPqPKJZx1zKYDN1FhZcj4Z+b1nIslsBvF1GAliYQ6l0/X+bklA4OrVJMg5StR7JOnjZPrNZT/sf7Gtn2wLFhNGbW+mZdXFUgmSiEb7BPjmlo4qUdJl1DBMQHyF68F1HWyTED90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523778; c=relaxed/simple;
	bh=9RUDBIQ2lZ0jEicybmP5CqwO23NsdFySch5SINMhUeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jk19gtJl+BikvGWKHI5XsiWeqXvdZW4MCYIwPzM4SBJOATOZajrCqLlPu9pecTlBeYjhJAKF1Z5uomQ5RoOeQaRVcCd6eKOYmu2AQ5cquQUL298Zbf6z1cjR16JK9BNWvQvR58rOc6H7hbLn2jQNuW8YJy6T8YkeG6XeujsKgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=biuPYR1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748BBC433F1;
	Wed, 21 Feb 2024 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523777;
	bh=9RUDBIQ2lZ0jEicybmP5CqwO23NsdFySch5SINMhUeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biuPYR1HRVKqqNocXy4HMtpm1Ngrsq3sZd6gZ+ISD3j9zBtS6WbKKxaSz5MeCl8gd
	 W5wFvNZr4uakYhl1OjKU5fjeFGCJbqFlmA4FgTgMEqTBz0IpTHIllg3qyRi68XMidK
	 9RDS1HHcfB/bnFWCV87f3Ju/qAZRbmUm40tVdX6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 054/379] net/mlx5: DR, Use the right GVMI number for drop action
Date: Wed, 21 Feb 2024 14:03:53 +0100
Message-ID: <20240221125956.514840071@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

[ Upstream commit 5665954293f13642f9c052ead83c1e9d8cff186f ]

When FW provides ICM addresses for drop RX/TX, the provided capability
is 64 bits that contain its GVMI as well as the ICM address itself.
In case of TX DROP this GVMI is different from the GVMI that the
domain is operating on.

This patch fixes the action to use these GVMI IDs, as provided by FW.

Fixes: 9db810ed2d37 ("net/mlx5: DR, Expose steering action functionality")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index df1363a34a42..9721fe58eb7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -667,6 +667,7 @@ int mlx5dr_actions_build_ste_arr(struct mlx5dr_matcher *matcher,
 		switch (action_type) {
 		case DR_ACTION_TYP_DROP:
 			attr.final_icm_addr = nic_dmn->drop_icm_addr;
+			attr.hit_gvmi = nic_dmn->drop_icm_addr >> 48;
 			break;
 		case DR_ACTION_TYP_FT:
 			dest_action = action;
-- 
2.43.0




