Return-Path: <stable+bounces-48598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDD98FE9AE
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04051C23CA0
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9919B3C0;
	Thu,  6 Jun 2024 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DrYj4PDp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34D195FC4;
	Thu,  6 Jun 2024 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683054; cv=none; b=rVtrc06eP3u0Z5qu+TTX+FZG/Rwg/FsMKWiBSqpci58T2bYHQXPY4IBo3fxo6Wmj3F5pqjDhFyAy8aohGWwpDJL3TWZ2Uj/gljKqwmg+XTvRXx2uNyOPL6HNChELv9MV3RoBWj9UOx/TuPtd6fOrPsdiUyJufB2L82ft8GuC3d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683054; c=relaxed/simple;
	bh=Zpy2OH7VQD86m/l32Yq1KVZvnMuAY0JY6Ym6whEzLjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrDucVYVY+nHClqMyuhYZuEQKDllIZP9LdCnwHZt0LTdbJZsHHEsxq7o6Nvd1Km5eIlo3lmMHTJ6eUQcQAf6Wm9foJXGnTsbpTCAgWIilAYlcbGG/fwyD2P9Ggq4y9iXSb/YK0/TiLmAnFXkqq87I9k0CVvNlO3tVcP7Dc1yClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DrYj4PDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641F3C32781;
	Thu,  6 Jun 2024 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683054;
	bh=Zpy2OH7VQD86m/l32Yq1KVZvnMuAY0JY6Ym6whEzLjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrYj4PDpIVCHJZ4Y4BQBNwUBz+FaICTnIwguk8RbGR9ASV/1SagWMwPIH05R1LZdo
	 i13hgAnpcRz9IREkDMnOXkNAxWk5QGceRnvhKB+29PHKXUdJr3dHpUwIsYgY1mvuSI
	 kd+8IrGYxpgz+fnQEGVR2LGDdwx/4d0eXWc3vSEQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gal Pressman <gal@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 298/374] net/mlx5: Fix MTMP register capability offset in MCAM register
Date: Thu,  6 Jun 2024 16:04:37 +0200
Message-ID: <20240606131701.851564487@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <gal@nvidia.com>

[ Upstream commit 1b9f86c6d53245dab087f1b2c05727b5982142ff ]

The MTMP register (0x900a) capability offset is off-by-one, move it to
the right place.

Fixes: 1f507e80c700 ("net/mlx5: Expose NIC temperature via hardware monitoring kernel API")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mlx5/mlx5_ifc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index c940b329a475f..5e5a9c6774bde 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10267,9 +10267,9 @@ struct mlx5_ifc_mcam_access_reg_bits {
 	u8         mfrl[0x1];
 	u8         regs_39_to_32[0x8];
 
-	u8         regs_31_to_10[0x16];
+	u8         regs_31_to_11[0x15];
 	u8         mtmp[0x1];
-	u8         regs_8_to_0[0x9];
+	u8         regs_9_to_0[0xa];
 };
 
 struct mlx5_ifc_mcam_access_reg_bits1 {
-- 
2.43.0




