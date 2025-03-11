Return-Path: <stable+bounces-123284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03113A5C4AA
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 281BE7AB8F8
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9E25D908;
	Tue, 11 Mar 2025 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F53Z3jpn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916E25EF8F;
	Tue, 11 Mar 2025 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705507; cv=none; b=BEbT/FA2ZuJh5acH9cOUYEB8YN75EqOG8JR5rE44JguOXwMfOpPLbgdZJOv5jj3u2Y6L+pnu+y8L1h8T5AMd7h6H8s98rJmi4KqGVIvzI4eB2vwKWEXHbBuVezSAK+z5BpiBlm1lIg2FvVg5nrmBUrI+tidDZ10PPs3UbumEfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705507; c=relaxed/simple;
	bh=NbjsQLE+7CcxlC/DqG1L9Cm6KTP+JKKmx3iT/SRBcgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvT/MYVbXnEY/kqcDg3VgWMofuAV2STSurxqocEwV1KeH2ZpmIU8hOGP97Uf/GOoRr2tVlprgwdLGHUucKnvsMoJ73tR1vx4MPk6y0VBpZbPQv6GK+Yc2CHhVgu206HOm0ENEVaWLYxh5qnR/NrQtkaeZvd0TqO9kgbpI6KDbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F53Z3jpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B06C4CEE9;
	Tue, 11 Mar 2025 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741705506;
	bh=NbjsQLE+7CcxlC/DqG1L9Cm6KTP+JKKmx3iT/SRBcgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F53Z3jpn8BCSbPsZf6lV8iDdXX8lGCa8MgM7/s6SmwZ7u69NR7Nmm4l535yDExr7e
	 zmiu6CAadUHSG92l4ZQjqASVM/VyQRfG2Vyl1XZ06UFucijsO2CAcu4xhcT2F2WvmV
	 MUXujLQ0AIGpL2qvyBtz6w/5++9hRVxs2H8Ii580=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leon Romanovsky <leonro@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 042/328] RDMA/mlx4: Avoid false error about access to uninitialized gids array
Date: Tue, 11 Mar 2025 15:56:52 +0100
Message-ID: <20250311145716.565324427@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 1f53d88cbb0dcc7df235bf6611ae632b254fccd8 ]

Smatch generates the following false error report:
drivers/infiniband/hw/mlx4/main.c:393 mlx4_ib_del_gid() error: uninitialized symbol 'gids'.

Traditionally, we are not changing kernel code and asking people to fix
the tools. However in this case, the fix can be done by simply rearranging
the code to be more clear.

Fixes: e26be1bfef81 ("IB/mlx4: Implement ib_device callbacks")
Link: https://patch.msgid.link/6a3a1577463da16962463fcf62883a87506e9b62.1733233426.git.leonro@nvidia.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index baa129a6c9127..20335542a81ae 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -384,10 +384,10 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
 	}
 	spin_unlock_bh(&iboe->lock);
 
-	if (!ret && hw_update) {
+	if (gids)
 		ret = mlx4_ib_update_gids(gids, ibdev, attr->port_num);
-		kfree(gids);
-	}
+
+	kfree(gids);
 	return ret;
 }
 
-- 
2.39.5




