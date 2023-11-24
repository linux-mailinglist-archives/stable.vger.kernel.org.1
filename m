Return-Path: <stable+bounces-2220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B5F7F8345
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F721F21017
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F53418E;
	Fri, 24 Nov 2023 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g6UlmsKK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1F381A2;
	Fri, 24 Nov 2023 19:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4291C433C8;
	Fri, 24 Nov 2023 19:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853348;
	bh=Sa7VLkfoAuGK6AnhkiRcyg+Et919EXYCXZsI1vPzU1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6UlmsKK6EUC2DrLB9vtJzZHC2XXZaEXa8DhIdqZ9jmyGJPiNpV6LQDqUzFN+F7wp
	 uXfbZrsTRzZTDyd+qzm3QsTMvJ3ui+PZGtsCT6QhQrJ7nOym5ac+K3HRJAKxumX34W
	 8pn88RgYYQvhwcdbITiW9/quRkWXZkKzg5v5oZKU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roi Dayan <roid@nvidia.com>,
	Maor Dickman <maord@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 128/297] net/mlx5e: Remove incorrect addition of action fwd flag
Date: Fri, 24 Nov 2023 17:52:50 +0000
Message-ID: <20231124172004.779923691@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roi Dayan <roid@nvidia.com>

[ Upstream commit 475fb86ac941f75da127c19d8e8b282d33de9784 ]

A user is expected to explicit request a fwd or drop action.
It is not correct to implicit add a fwd action for the user,
when modify header action flag exists.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Maor Dickman <maord@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Stable-dep-of: 0c101a23ca7e ("net/mlx5e: Fix pedit endianness")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index d123d9b4adf5e..d13ffba138934 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3639,9 +3639,6 @@ static int parse_tc_nic_actions(struct mlx5e_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
-	if (attr->action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR)
-		attr->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-
 	if (!actions_match_supported(priv, flow_action, parse_attr, flow, extack))
 		return -EOPNOTSUPP;
 
-- 
2.42.0




