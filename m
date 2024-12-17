Return-Path: <stable+bounces-104772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14A39F5301
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80BE1885723
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6C11F75BC;
	Tue, 17 Dec 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h5Q5xqrR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8D1F4735;
	Tue, 17 Dec 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456052; cv=none; b=hs7oWjTFEQCp+8X7/d6mu08T2geYc3ykCP68RjFXjd99uA0HzebTF0z9IqlFv1Kd96xlZM8KxaMzBfogbSP25RTKU5DJMQUgApWcRzqEcFDuZ14zDfAGPLWTAIBKLe/RY4/Qwv+bQLUb82wPLknggO/r7QBjegQBCGIXXZVh4Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456052; c=relaxed/simple;
	bh=nPBLcMzwlPoDF++2IdX8/WzIPRYDLLuzTyfxlwZqpEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUz2oT4jTM8vmQ13x3ZV3izGgWZ2aUQKtYQVUEaCoApM/ROorldkylitNeXwHHGJThAZvPAgbCK4Jm3vU6uBp1iFVj9glyvD3MwxtIkzgGjBwU/VCVNrYOe6a3Ymg3Gf0v+vMqL0DtNW9StkEk4gOWSKvTuYlVyGWhfUI3yIc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h5Q5xqrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9B6C4CED3;
	Tue, 17 Dec 2024 17:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456051;
	bh=nPBLcMzwlPoDF++2IdX8/WzIPRYDLLuzTyfxlwZqpEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5Q5xqrRsEB/5m3raTYbybONOqtRfi6rcnI3BicO8umAJbKmz8Xd++W+JvoUrNoTF
	 dfFy4EQPzLzb3qSB2LbPsi7eYn6WGNTlm0PV7iHkvfLbsrNh4QbjYHNnIL/WK3harR
	 ZM+vf85EIwQbRAUFOPhRubR6yVNjnJ4tCncp2Sjs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 045/109] net/mlx5: DR, prevent potential error pointer dereference
Date: Tue, 17 Dec 2024 18:07:29 +0100
Message-ID: <20241217170535.257007684@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170533.329523616@linuxfoundation.org>
References: <20241217170533.329523616@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 11776cff0b563c8b8a4fa76cab620bfb633a8cb8 ]

The dr_domain_add_vport_cap() function generally returns NULL on error
but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
and if it's and -ENOMEM then the error pointer is propogated back and
eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().

Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/07477254-e179-43e2-b1b3-3b9db4674195@stanley.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
index 3d74109f8230..49f22cad92bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
@@ -297,7 +297,9 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
 	if (ret) {
 		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
 		kvfree(vport_caps);
-		return ERR_PTR(ret);
+		if (ret == -EBUSY)
+			return ERR_PTR(-EBUSY);
+		return NULL;
 	}
 
 	return vport_caps;
-- 
2.39.5




