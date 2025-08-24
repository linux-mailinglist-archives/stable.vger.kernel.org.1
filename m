Return-Path: <stable+bounces-172679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9706B32CD6
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 03:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FED1B65BEA
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 01:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72CA188000;
	Sun, 24 Aug 2025 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzZBLqvP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55B51865EE
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755998340; cv=none; b=ZfFajR9XmYNe4/hQPYEO9u+qIQir2I5A7oL64Sn6BWvig+YWW0Wwxw7NIu6hDuZzwkvf51M95op1an9pl4NnP+F7kCV0mlX6fy9VcaZ56iykKjOWUQHyr1cONFDWRBm7wwqyao5kfQxAWocTNb5NztM5x6FQvHrPH7A8gEvGKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755998340; c=relaxed/simple;
	bh=S1tCl0CWPFIcfIClRaAaoaD2XHbAlw3HVAEEZIvndKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsTIRI4iSithIkCJVarDKyZjiEGbunYLHj3Qb2CNc0TKFPney6jywPsiDzMdCrgccGxzuspxuKiFcROP1LcFxoUUAYLcxn8RcO66E4wErGJpyvoEOkJ0NSPtMcx30ZT8zOPvSbZx66D81s2wWtF+ZWLb5498uZnNy8ZE9TLOceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzZBLqvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C07C113D0;
	Sun, 24 Aug 2025 01:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755998340;
	bh=S1tCl0CWPFIcfIClRaAaoaD2XHbAlw3HVAEEZIvndKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RzZBLqvPpMgkmIaNCkkD+KwDPkFJpp5BDUikoDxohZVKQeiVtTya/XKqZLknbkR++
	 RFNH9+IIe5Av5mAvU1RYAkMlYZDgKp0UCAoJNS1HNRDW308HtNp3P75mf7sltad1fL
	 aSyRNVlFLmSBUP2/6XAD8ulc66ChK9N+xSSTGTbDM1+3vKVfIDo2tcfrKiYvBB6Rsg
	 ngAnlBVmXNtL07VDe8tP8vjluhp/2sTsXQ6PHRGsL1oc1S8S4gkfaabTu15oJchiCw
	 7PBHAf6kg+FbDLigAkRHNr7mhmpYFhmyDAmGZrk4JPMoqq5rsm5/ButuKM2EWeDukA
	 tIjdpiwj52+VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Hung <alex.hung@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amd/display: Don't overclock DCE 6 by 15%
Date: Sat, 23 Aug 2025 21:18:57 -0400
Message-ID: <20250824011857.2574854-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082313-mobility-alive-f9e9@gregkh>
References: <2025082313-mobility-alive-f9e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit cb7b7ae53b557d168b4af5cd8549f3eff920bfb5 ]

The extra 15% clock was added as a workaround for a Polaris issue
which uses DCE 11, and should not have been used on DCE 6 which
is already hardcoded to the highest possible display clock.
Unfortunately, the extra 15% was mistakenly copied and kept
even on code paths which don't affect Polaris.

This commit fixes that and also adds a check to make sure
not to exceed the maximum DCE 6 display clock.

Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for Polaris")
Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
Fixes: 3ecb3b794e2c ("drm/amd/display: dc/clk_mgr: add support for SI parts (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 427980c1cbd22bb256b9385f5ce73c0937562408)
Cc: stable@vger.kernel.org
[ `MIN` => `min` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index 0267644717b2..0d6743c37102 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -123,11 +123,9 @@ static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dm_pp_power_level_change_request level_change_req;
-	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
-
-	/*TODO: W/A for dal3 linux, investigate why this works */
-	if (!clk_mgr_dce->dfs_bypass_active)
-		patched_disp_clk = patched_disp_clk * 115 / 100;
+	const int max_disp_clk =
+		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	int patched_disp_clk = min(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
 	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
 	/* get max clock state from PPLIB */
-- 
2.50.1


