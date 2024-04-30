Return-Path: <stable+bounces-42228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9318B7200
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90A91F235BA
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC9A12C530;
	Tue, 30 Apr 2024 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cEU3vY1R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E412C801;
	Tue, 30 Apr 2024 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474981; cv=none; b=m5qav1gXECQLv7NhA87ExjCARnbR6ZMmXDRtVygtY/x+uQQQnQo+Riy+QV5YFgFnh01x4/SaLQ2yIPw/rkCEXlZ8NvltHr20qv/7QocW3/X417xTPLpgCMgkNUSi6u2KSc5SrApCvhiHFGLuyyXEPIrxfP3PbOJ5tG6ssw6T8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474981; c=relaxed/simple;
	bh=GZ45Rssixe6/htk9FPrGhTBkpDjTcYsgKxSr1C6M8FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXgX2I3XaJn7rvhtBkxpmAvwe0qc2sY46YF9VAthYT7UrKlJ0rkrSoLUW/hJBNotJMDyJw6kAdLFM1poAIcXcO5TtP4a8hxv+3TCYK71Qb2CRzSeBtUxMEKbW/JLaK81XJWSJgfu+AD+b0+UgfOKpJscaCNmudtI4kBNZ2hB06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cEU3vY1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089D3C2BBFC;
	Tue, 30 Apr 2024 11:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474981;
	bh=GZ45Rssixe6/htk9FPrGhTBkpDjTcYsgKxSr1C6M8FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEU3vY1R8k4L7VsORDEUIF6lE5eNWKvsxTEGjat0tfJ8k/aNaEobq5Md4EO5PhhZx
	 YV/T/rdYz7rdg2Sb4C2ad6lYkqPGO17Jr+Fo8+tJoMn5ZCegsLsyZM50fK76Odsg6v
	 eppioEn6lKkMzimBfdHDNtZOSxs47xbBsHlMeEVo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 096/138] mlxsw: spectrum_acl_tcam: Rate limit error message
Date: Tue, 30 Apr 2024 12:39:41 +0200
Message-ID: <20240430103052.241409133@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 5bcf925587e9b5d36420d572a0b4d131c90fb306 ]

In the rare cases when the device resources are exhausted it is likely
that the rehash delayed work will fail. An error message will be printed
whenever this happens which can be overwhelming considering the fact
that the work is per-region and that there can be hundreds of regions.

Fix by rate limiting the error message.

Fixes: e5e7962ee5c2 ("mlxsw: spectrum_acl: Implement region migration according to hints")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/c510763b2ebd25e7990d80183feff91cde593145.1713797103.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index a60d511f00eaa..cdad4772b60a0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -1480,7 +1480,7 @@ mlxsw_sp_acl_tcam_vregion_rehash(struct mlxsw_sp *mlxsw_sp,
 	err = mlxsw_sp_acl_tcam_vregion_migrate(mlxsw_sp, vregion,
 						ctx, credits);
 	if (err) {
-		dev_err(mlxsw_sp->bus_info->dev, "Failed to migrate vregion\n");
+		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Failed to migrate vregion\n");
 		return;
 	}
 
-- 
2.43.0




