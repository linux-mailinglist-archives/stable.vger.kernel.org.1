Return-Path: <stable+bounces-17163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E55F841014
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335941F23D3A
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480E15EAAE;
	Mon, 29 Jan 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1C/0OKO/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416815A490;
	Mon, 29 Jan 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548557; cv=none; b=DwYUjoW0c2Ie78a/ku61inpPkBSusu4jS8JOhSgHwFD6wMRQ0H7bO+aZKDrOvrS6Y4FD6r3vkjXgoOL9pzkMChWzx0maNe6z581RAIWCIPsbt4W0Rg8hvIo95X4jrFBpxVEtqgRU1g70B2wzdCq0ZwJksiftqXwjwlq5f+IUMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548557; c=relaxed/simple;
	bh=O4cso+Bsc18niQiKycDIWI13NXSdrpUVhqqKTpDtwaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjGwAwgTIxd1HqTrTq0+tBKHjvYfKZaMGytBXmzKqVWTNXIHaUqcax49SgQbUDKrjIZJOpo710c1JoaS6+RxZNcTodz3Mrj4vfs7HQ8gwgSuUEHQe3Tmaou7Efp6AOHbyVPO0uOOZJNFqS/2D2PxW8nFRNAidw9RPu9NSW4rKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1C/0OKO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C80CC433F1;
	Mon, 29 Jan 2024 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548557;
	bh=O4cso+Bsc18niQiKycDIWI13NXSdrpUVhqqKTpDtwaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1C/0OKO/mDt2ET3ebm/bJTP8tV5bIGwxSL+XhiwCGne+8XLqWniWvUdR41b8Bzez8
	 eA0lKHdQ2rOLtUmr1BofhJ48raaXVwrbjHvINByClwAspLxi1hF1woRN0qQ59oIyJp
	 23SW1m/rAWI86L4v5Sb5PS4BsVFtw6F8t4TGnPTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 203/331] net/mlx5e: fix a potential double-free in fs_any_create_groups
Date: Mon, 29 Jan 2024 09:04:27 -0800
Message-ID: <20240129170020.818667805@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit aef855df7e1bbd5aa4484851561211500b22707e ]

When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
fs_any_create_groups() will free ft->g. However, its caller
fs_any_create_table() will free ft->g again through calling
mlx5e_destroy_flow_table(), which will lead to a double-free.
Fix this by setting ft->g to NULL in fs_any_create_groups().

Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
index e1283531e0b8..671adbad0a40 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
@@ -436,6 +436,7 @@ static int fs_any_create_groups(struct mlx5e_flow_table *ft)
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if  (!in || !ft->g) {
 		kfree(ft->g);
+		ft->g = NULL;
 		kvfree(in);
 		return -ENOMEM;
 	}
-- 
2.43.0




