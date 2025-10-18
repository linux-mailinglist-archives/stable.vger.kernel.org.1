Return-Path: <stable+bounces-187807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67B8BEC66A
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 05:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703DD6E1A69
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5517A27602C;
	Sat, 18 Oct 2025 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQHXLttX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D13595C
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760757510; cv=none; b=XJsxk6EB6dS8SC1WnOZC9CXvd/Y69/wZTEA/cDMDiNgTmTSAk5rv6wYsmuvzU1TWRLp3l8qfV2DLYBluNKWsYcCR0hJC5vWym3HTxfSHnz9pIpv2sWw67WG7kdJOQwXdfN4RaBVbJWJVRhUVjkgQn/uGUd7NcYy4LjzcO7Rv31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760757510; c=relaxed/simple;
	bh=DrRRyBNDb6QCVDghnVBjdNhgGKhGYnD+4IzNMl4YFbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YocT34gvnLDMO3LE3tgoiN9p/F9XMeOl3JhuRTcuVFbtigwWJRJm6L/4YgVDQxBPwRNK2CTlMA9PmkjN42xghARLHZN9PLQBy61TK8xim98u/M2A+FUSFBIC+N49TDnQM5SKJJqlKxZAOI31i0fuL905jBbvKcb4gHR85QAE+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQHXLttX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB620C4CEE7;
	Sat, 18 Oct 2025 03:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760757509;
	bh=DrRRyBNDb6QCVDghnVBjdNhgGKhGYnD+4IzNMl4YFbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQHXLttXGUiJnSZyPxzsj+TP7cK2H1BiW6u1YTRGieREBylUGRaItAr7Z9brJdg27
	 JL3YrW4xj597SRHX3aX5176i/sboWSz/6GkmxIkj/ZQRfcXMaL4wvxkurCCclrBHwo
	 6HRlmJ9F7pmyFzZuv2lygQphcOq+miFTd4Yq3TGR/fuu9RSi19nrtn1b+/H4D8Oh2K
	 mzbHuMKwyTqNDEMziRocn6yVipQsgX1ToW6qNm3A+iHQx5v3HXXvt5H4cEz7sFSibA
	 ILFpgibeG/0yAwC8eKyPRT/Ri3p1kyANfhF3GRsmq6BMT+q8Ccltf8yZJd1hWl8BX3
	 MA2UOuLLhzKzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/rcar-du: dsi: Fix 1/2/3 lane support
Date: Fri, 17 Oct 2025 23:18:25 -0400
Message-ID: <20251018031825.247562-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101659-grinning-hertz-186a@gregkh>
References: <2025101659-grinning-hertz-186a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

[ Upstream commit d83f1d19c898ac1b54ae64d1c950f5beff801982 ]

Remove fixed PPI lane count setup. The R-Car DSI host is capable
of operating in 1..4 DSI lane mode. Remove the hard-coded 4-lane
configuration from PPI register settings and instead configure
the PPI lane count according to lane count information already
obtained by this driver instance.

Configure TXSETR register to match PPI lane count. The R-Car V4H
Reference Manual R19UH0186EJ0121 Rev.1.21 section 67.2.2.3 Tx Set
Register (TXSETR), field LANECNT description indicates that the
TXSETR register LANECNT bitfield lane count must be configured
such, that it matches lane count configuration in PPISETR register
DLEN bitfield. Make sure the LANECNT and DLEN bitfields are
configured to match.

Fixes: 155358310f01 ("drm: rcar-du: Add R-Car DSI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20250813210840.97621-1-marek.vasut+renesas@mailbox.org
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
[ adjusted file paths to remove renesas/ subdirectory ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c      | 5 ++++-
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h | 8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
index 9ec9c43971dfb..3f1148636f061 100644
--- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
@@ -385,7 +385,10 @@ static int rcar_mipi_dsi_startup(struct rcar_mipi_dsi *dsi,
 	udelay(10);
 	rcar_mipi_dsi_clr(dsi, CLOCKSET1, CLOCKSET1_UPDATEPLL);
 
-	ppisetr = PPISETR_DLEN_3 | PPISETR_CLEN;
+	rcar_mipi_dsi_clr(dsi, TXSETR, TXSETR_LANECNT_MASK);
+	rcar_mipi_dsi_set(dsi, TXSETR, dsi->lanes - 1);
+
+	ppisetr = ((BIT(dsi->lanes) - 1) & PPISETR_DLEN_MASK) | PPISETR_CLEN;
 	rcar_mipi_dsi_write(dsi, PPISETR, ppisetr);
 
 	rcar_mipi_dsi_set(dsi, PHYSETUP, PHYSETUP_SHUTDOWNZ);
diff --git a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h
index 1f1eb46c721fe..a04e9c6614dc9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h
@@ -12,6 +12,9 @@
 #define LINKSR_LPBUSY			(1 << 1)
 #define LINKSR_HSBUSY			(1 << 0)
 
+#define TXSETR				0x100
+#define TXSETR_LANECNT_MASK		(0x3 << 0)
+
 /*
  * Video Mode Register
  */
@@ -80,10 +83,7 @@
  * PHY-Protocol Interface (PPI) Registers
  */
 #define PPISETR				0x700
-#define PPISETR_DLEN_0			(0x1 << 0)
-#define PPISETR_DLEN_1			(0x3 << 0)
-#define PPISETR_DLEN_2			(0x7 << 0)
-#define PPISETR_DLEN_3			(0xf << 0)
+#define PPISETR_DLEN_MASK		(0xf << 0)
 #define PPISETR_CLEN			(1 << 8)
 
 #define PPICLCR				0x710
-- 
2.51.0


