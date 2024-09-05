Return-Path: <stable+bounces-73356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D307996D480
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122581C231FC
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C588194A45;
	Thu,  5 Sep 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lDKgQUkB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6DC1957F8;
	Thu,  5 Sep 2024 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529966; cv=none; b=aYmBmr1pLjKHhbUm8++viCyxhaZTo5NgzSr6NT03L0A1WN65qPjEqF9jK+gLOAt4U1WMO2MpiUdLZSle9tRm3P6tn/vxtiSeHJKrLUIIyGMmbeI7sGiYUIX8pbBFSsTC41irME+ZGLiGOo6KTgIAfh3Z4BLhd0SErpjcSozKRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529966; c=relaxed/simple;
	bh=l4VB41bfxti8JtX89vzUEDC8tD9/+nzNhG49lNeXy7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktgfVIixCoA3SvLioFaECN1GEbGJx/Rh7Stbo9pPSlAODI7M6oH417uhS0rYgZRy+3CrYYYVPSSQT50gBnmBAMUxi5vU5HAjqVSsk22QmWxlUChYgh2wD70V4PMH50CZwIHUl5YGxZSxqMfflaBzEIdZ9Vp/lEWWKIXdnd8FV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lDKgQUkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059A5C4CEC3;
	Thu,  5 Sep 2024 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529965;
	bh=l4VB41bfxti8JtX89vzUEDC8tD9/+nzNhG49lNeXy7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDKgQUkBhHK4/CATnYeoMbY8Bkp7dEmTs9NG7G8gFGtpINVHrd4zLik2b2F51kAEs
	 0FclaJDjbmxSD/NgqnWejeGEKQM2464PZZOary94t8c+fKOBVrA7OhbsR74iArBL92
	 gWE9aoz1NXX1gIUgLUg8vSMzamFkB/k+Ppg2N16w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Alex Vesker <valex@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 013/132] net/mlx5: DR, Fix stack guard page was hit error in dr_rule
Date: Thu,  5 Sep 2024 11:40:00 +0200
Message-ID: <20240905093722.752673690@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093722.230767298@linuxfoundation.org>
References: <20240905093722.230767298@linuxfoundation.org>
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

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

[ Upstream commit 94a3ad6c081381fa9ee523781789802b4ed00faf ]

This patch reduces the size of hw_ste_arr_optimized array that is
allocated on stack from 640 bytes (5 match STEs + 5 action STES)
to 448 bytes (2 match STEs + 5 action STES).
This fixes the 'stack guard page was hit' issue, while still fitting
majority of the usecases (up to 2 match STEs).

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Alex Vesker <valex@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Link: https://patch.msgid.link/20240730061638.1831002-4-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
index 042ca03491243..d1db04baa1fa6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
@@ -7,7 +7,7 @@
 /* don't try to optimize STE allocation if the stack is too constaraining */
 #define DR_RULE_MAX_STES_OPTIMIZED 0
 #else
-#define DR_RULE_MAX_STES_OPTIMIZED 5
+#define DR_RULE_MAX_STES_OPTIMIZED 2
 #endif
 #define DR_RULE_MAX_STE_CHAIN_OPTIMIZED (DR_RULE_MAX_STES_OPTIMIZED + DR_ACTION_MAX_STES)
 
-- 
2.43.0




