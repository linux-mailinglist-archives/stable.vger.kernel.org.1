Return-Path: <stable+bounces-40848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242CC8AF94E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DB8283CDF
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEF3143C57;
	Tue, 23 Apr 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YxKF+sgU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821D14388D;
	Tue, 23 Apr 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908504; cv=none; b=NOILMsq3aQb7V25oJcFgEIClkpqJ0RjiUXSd5aoqE50EI0Fiv7xYMrXTS78uAlEfk9RSUyqzxYIUkg41+vXI2Yyo2rojDFiQ0wuyJHe3+wjqDFuYu/a9cLU/lyZYMmgBid7RJByZUEYM969+hcDnEUN/ALeqqah9iBIPVLuzFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908504; c=relaxed/simple;
	bh=JPxduFrp/QjGOjVyh8sREju9oE/QVAca3trAicn4eYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDA6ZZ9dy3rbFMky/x14Xq8VOTCKiWTtGkpGj8Ettnq69mO8gaM2FcuOnwty2r7kmohS8hjZdXvxZSD1J3Zf0Uv3+Dmw5jNUOjVJOBwOi+ZSrqMYAP6qa9rvQ4FFyQOaJWwss6RUK6Tus4iOaANCTb0PnQDVHi9N2CVFGJwJtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YxKF+sgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E52C32781;
	Tue, 23 Apr 2024 21:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908504;
	bh=JPxduFrp/QjGOjVyh8sREju9oE/QVAca3trAicn4eYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxKF+sgUN/oLk0lN5nRPAD0ug8kvN4I2SgTjSv7DhLbb3OcNuMX0HZ3ly8cItn3Zq
	 lkd7OS7JefAAevm8Z36vGe9+89oLntCXNNO7LjN8AcV+qOyCXaxsJG6kWoQwtL+x8t
	 SYaVGm9IQjowIu0w/jBZv85QS24FfnDV2IK+U5Yw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 057/158] RDMA/mlx5: Fix port number for counter query in multi-port configuration
Date: Tue, 23 Apr 2024 14:37:59 -0700
Message-ID: <20240423213857.789246472@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Guralnik <michaelgur@nvidia.com>

[ Upstream commit be121ffb384f53e966ee7299ffccc6eeb61bc73d ]

Set the correct port when querying PPCNT in multi-port configuration.
Distinguish between cases where switchdev mode was enabled to multi-port
configuration and don't overwrite the queried port to 1 in multi-port
case.

Fixes: 74b30b3ad5ce ("RDMA/mlx5: Set local port to one when accessing counters")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Link: https://lore.kernel.org/r/9bfcc8ade958b760a51408c3ad654a01b11f7d76.1712134988.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/mad.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 0c3c4e64812c5..3e43687a7f6f7 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -188,7 +188,8 @@ static int process_pma_cmd(struct mlx5_ib_dev *dev, u32 port_num,
 		mdev = dev->mdev;
 		mdev_port_num = 1;
 	}
-	if (MLX5_CAP_GEN(dev->mdev, num_ports) == 1) {
+	if (MLX5_CAP_GEN(dev->mdev, num_ports) == 1 &&
+	    !mlx5_core_mp_enabled(mdev)) {
 		/* set local port to one for Function-Per-Port HCA. */
 		mdev = dev->mdev;
 		mdev_port_num = 1;
-- 
2.43.0




