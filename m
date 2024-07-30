Return-Path: <stable+bounces-64104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096EB941C20
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8801C2276F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53A18454A;
	Tue, 30 Jul 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cfoTqOwb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87B1A6192;
	Tue, 30 Jul 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359003; cv=none; b=U2urEk/c1ZwG4qsKn+ILQuPPLStVMSAbuCgeh1m8gLH2KMxUTIo5J8y9Rz2n2fx3KyOiqx1OA8Lt7bI2Kd5ahY38iwmXTHXj4NRUmFo5jwxSmE0bgnpQI/q8EB0Sv18GcNE7pEnyntQUaNFHVxJKbHHvqVFSpb+c2yv2B1ormbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359003; c=relaxed/simple;
	bh=2punBQ4Kn7RxkYBt1KmDeZn8pyQZy4YpOOEwedJ9zGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/Nvsp+cnQnNsxqizSLp81HGt40nknLgm461xonaQij3ddRsbtKnxEBlBWOrPRY2MeHTqCaoExCuZwk+xjUcuuEjjarPQKKFdabeZSfbiKB07RLUw+yPOp/+b0eHvzThVGDj2JQJftBTQajkx2BNAP1pjUC3JEkj/nuXv7QLtlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cfoTqOwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C359C32782;
	Tue, 30 Jul 2024 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359002;
	bh=2punBQ4Kn7RxkYBt1KmDeZn8pyQZy4YpOOEwedJ9zGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfoTqOwbUVj3bDHjblsGRt39Xk3SdsYf9KODvGo6daMuOrt4u/Hs7OBb1YFuoioL/
	 9/F892n3HZCGZKBCIf9FzoRcnDaerlwLPjjax8ZHFDsrm16XysbmpjGoB6Acx0gJCc
	 GaE5hYqaVm+S4xA2X5+v+jDJyVHTXZTo5izVYuOU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 420/809] RDMA/mlx4: Fix truncated output warning in alias_GUID.c
Date: Tue, 30 Jul 2024 17:44:56 +0200
Message-ID: <20240730151741.284143454@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 5953e0647cec703ef436ead37fed48943507b433 ]

drivers/infiniband/hw/mlx4/alias_GUID.c: In function ‘mlx4_ib_init_alias_guid_service’:
drivers/infiniband/hw/mlx4/alias_GUID.c:878:74: error: ‘%d’ directive
output may be truncated writing between 1 and 11 bytes into a region of
size 5 [-Werror=format-truncation=]
  878 |                 snprintf(alias_wq_name, sizeof alias_wq_name, "alias_guid%d", i);
      |                                                                          ^~
drivers/infiniband/hw/mlx4/alias_GUID.c:878:63: note: directive argument in the range [-2147483641, 2147483646]
  878 |                 snprintf(alias_wq_name, sizeof alias_wq_name, "alias_guid%d", i);
      |                                                               ^~~~~~~~~~~~~~
drivers/infiniband/hw/mlx4/alias_GUID.c:878:17: note: ‘snprintf’ output
between 12 and 22 bytes into a destination of size 15
  878 |                 snprintf(alias_wq_name, sizeof alias_wq_name, "alias_guid%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Fixes: a0c64a17aba8 ("mlx4: Add alias_guid mechanism")
Link: https://lore.kernel.org/r/1951c9500109ca7e36dcd523f8a5f2d0d2a608d1.1718554641.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/alias_GUID.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 111fa88a3be44..9a439569ffcf3 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -829,7 +829,7 @@ void mlx4_ib_destroy_alias_guid_service(struct mlx4_ib_dev *dev)
 
 int mlx4_ib_init_alias_guid_service(struct mlx4_ib_dev *dev)
 {
-	char alias_wq_name[15];
+	char alias_wq_name[22];
 	int ret = 0;
 	int i, j;
 	union ib_gid gid;
-- 
2.43.0




