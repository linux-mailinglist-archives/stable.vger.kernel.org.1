Return-Path: <stable+bounces-168854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A023DB236F7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF9A7ABF1B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175A9260583;
	Tue, 12 Aug 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGNiPyJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A023182D;
	Tue, 12 Aug 2025 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025554; cv=none; b=TP2TIVvU9/auFYGhNzwJ2GtHpOHCgAXb0KgZtAqPdqgwhpPZVcWik+AFjsQAmOjSRI5TKiv+x2UhGCpYg44DVD3ymYiMlLjY1l76p/AOXE2jdl3jATUyjz6KjLBsRPoarQhze5rIz0PzEmZ860oFimX7hWye4Sp0n7+Rnis88LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025554; c=relaxed/simple;
	bh=EyMSHGsQJkStmjcgKhJ+wdwkBVXQTq+QuJLtDd1etY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLM1kwQLmzoFdQroIoi/GuiYFXac0ncoGmPaE8S2VgIabW+tbk/JqlpESMr1NzTuTSl2TQ4C2mE+H/TUSiB83J2z28pYyjOkhcw3pm+WzVa18dsCmmcan57um0VTa/QDfRxGv4vp9txnYV1wG4I6E5NxWjXsqKcl8XCYUgMbqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGNiPyJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A63C4CEF0;
	Tue, 12 Aug 2025 19:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025554;
	bh=EyMSHGsQJkStmjcgKhJ+wdwkBVXQTq+QuJLtDd1etY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGNiPyJlOFi3PF8EDV+vengGCIpSzdlM+9QZiT+PDN4bYMCz5F3T+eY7xcIPJ7b68
	 96wlgr+pwgXSGkEjDSPQFxzUOA2PEeeY7Oj2uHeefyUDhDVTBqST4uc6X2V0JVpYzt
	 E0jIqJBECCph++8y4UqyDkaBKjbM2DGiXYhzY/Fo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sumit Gupta <sumitg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 074/480] soc/tegra: cbb: Clear ERR_FORCE register with ERR_STATUS
Date: Tue, 12 Aug 2025 19:44:42 +0200
Message-ID: <20250812174400.489775089@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sumit Gupta <sumitg@nvidia.com>

[ Upstream commit a0647bca8966db04b79af72851ebd04224a4da40 ]

When error is injected with the ERR_FORCE register, then this register
is not auto cleared on clearing the ERR_STATUS register. This causes
repeated interrupts on error injection. To fix, set the ERR_FORCE to
zero along with clearing the ERR_STATUS register after handling error.

Fixes: fc2f151d2314 ("soc/tegra: cbb: Add driver for Tegra234 CBB 2.0")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/cbb/tegra234-cbb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index c74629af9bb5..1da31ead2b5e 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -185,6 +185,8 @@ static void tegra234_cbb_error_clear(struct tegra_cbb *cbb)
 {
 	struct tegra234_cbb *priv = to_tegra234_cbb(cbb);
 
+	writel(0, priv->mon + FABRIC_MN_MASTER_ERR_FORCE_0);
+
 	writel(0x3f, priv->mon + FABRIC_MN_MASTER_ERR_STATUS_0);
 	dsb(sy);
 }
-- 
2.39.5




