Return-Path: <stable+bounces-49321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF508FECC8
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1871F26335
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302961B29C4;
	Thu,  6 Jun 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nKHCovL5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3474198A3B;
	Thu,  6 Jun 2024 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683409; cv=none; b=HEz1wadIjxROZ0Thjk7VS5GMGZwrbfyZmbRt/OYFI+q5kgcn1e7/vUmQX91l8K4f6m29ZlxYz2QSF8aiDy8MObkkDiRkVlEF7NgYNEuD5WuYzGx3UOyljyPDckgqnLL9F6HfjwG64/T5jb8LiFhkWZ4PcWgstZsGl0/Ixni7aR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683409; c=relaxed/simple;
	bh=xyHfswpSiQ9mB0jsrTrsPexwb4fBWPlQ468fhrnYuys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ah7pECdPxWlqr6UKj+3JdKv8/1dKax3TiVG9ENHZlPPzIf/vbBh0nAguov6kr9p0AfsfgwQeyHj2jtYLtiblhAJPQT6jlzRlqKXlQ0BuDLO9qyYI7stkJ4vv84vKQQAOTR8j8DyKo5wyGJ6nZoVrVDrXzEQkUTZKGBVG7Edz2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nKHCovL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FC7C2BD10;
	Thu,  6 Jun 2024 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683408;
	bh=xyHfswpSiQ9mB0jsrTrsPexwb4fBWPlQ468fhrnYuys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nKHCovL5PIvDw/fz0jpvOTfiR2eBNsaLFdPKee99+txyGBpPZ9JfNorl59IvdSDnx
	 bst1jVeIyy/VeqMoBQyVbI0NLbAuJf/IlJxz+ifkujPIrWBfzXWxC05Cu0vbVtpQa0
	 w8tqsLhLBdNRjMCuHlniXvCApWItthSjS94+bx/I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 352/744] clk: renesas: r8a779a0: Fix CANFD parent clock
Date: Thu,  6 Jun 2024 16:00:24 +0200
Message-ID: <20240606131743.766390250@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 3b23118bdbd898dc2f4de8f549d598d492c42ba8 ]

According to Figure 52A.1 ("RS-CANFD Module Block Diagram (in classical
CAN mode)") in the R-Car V3U Series User’s Manual Rev. 0.5, the parent
clock for the CANFD peripheral module clock is the S3D2 clock.

Fixes: 9b621b6adff53346 ("clk: renesas: r8a779a0: Add CANFD module clock")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/aef9300f44c9141b1465343f91c5cc7303249b6e.1713279523.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r8a779a0-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a779a0-cpg-mssr.c b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
index 4c2872f45387f..ff3f85e906fe1 100644
--- a/drivers/clk/renesas/r8a779a0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
@@ -139,7 +139,7 @@ static const struct mssr_mod_clk r8a779a0_mod_clks[] __initconst = {
 	DEF_MOD("avb3",		214,	R8A779A0_CLK_S3D2),
 	DEF_MOD("avb4",		215,	R8A779A0_CLK_S3D2),
 	DEF_MOD("avb5",		216,	R8A779A0_CLK_S3D2),
-	DEF_MOD("canfd0",	328,	R8A779A0_CLK_CANFD),
+	DEF_MOD("canfd0",	328,	R8A779A0_CLK_S3D2),
 	DEF_MOD("csi40",	331,	R8A779A0_CLK_CSI0),
 	DEF_MOD("csi41",	400,	R8A779A0_CLK_CSI0),
 	DEF_MOD("csi42",	401,	R8A779A0_CLK_CSI0),
-- 
2.43.0




