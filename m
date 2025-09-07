Return-Path: <stable+bounces-178046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F976B47BEE
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AAC189E239
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8F3263F36;
	Sun,  7 Sep 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkEThAFs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0715278E
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757257715; cv=none; b=HEWGs8iCN0MsKnwabiSqO25rUSPSW3qPjhg0m3CKVnvQnImR9xhpoSevtVmVro77s5oWpXMuQLZhu6+hkDmf7xh4s5iKzTE10q0wHkOshxAlwucP6JcbsK4b1Nc1Lz8yDL2D/QmlIoPWWrmwU+5+PcxzyWXe5c6Srii9ssmkktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757257715; c=relaxed/simple;
	bh=t8iJjYJxfCGrr5eWr3chvNjaW9C8YhbD2SQjFNwV/kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiTaUYDubQcYzvRA7oiFDYQhE3DTCjR2WFe4r1HJEDRYz86aN1myD1hnvdjqJ9euMx28cf84lnFvCPaKk2PjLRlvYRclAi+p2LedfcwFzy2XLZ5Pm6kWNaQeIXFSu/hhroGv/Nof9/qf2L6vkB89CEhmI76u8P+mG2dNU28JtRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkEThAFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63F9C4CEF0;
	Sun,  7 Sep 2025 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757257715;
	bh=t8iJjYJxfCGrr5eWr3chvNjaW9C8YhbD2SQjFNwV/kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkEThAFsG41U5N7/LHJ1Er83e6F8e//A18uqrdGdIVhoBBZ8AyVIEIER81Wgn5HQq
	 3zMfDlF/v38myeATdYF9/P027hGzpjtjz6qhETFdAVwsOVYyWwfgFGyXyb3DhEMmv3
	 k88g6wQZgSQAgvm3xNSt0Z4MenPb9Z4OhxQEn2wzf2hUlEIEQ3bg/v/66+nFFuEaKs
	 Iul6BKtGEPrc80930ZSjjc1e567S5HR62ydqDL2QQt/CZVJH5ETWxi07CByVS4A9np
	 VHkBVOFh3ScpOSmorZr+bNgft9yy3oJeMP4nOQsfXvFmel7k9wdXz+l7lSrEY6T1RR
	 tRfzIe8Cp+I7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Taniya Das <quic_tdas@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] clk: qcom: gdsc: Set retain_ff before moving to HW CTRL
Date: Sun,  7 Sep 2025 11:08:33 -0400
Message-ID: <20250907150833.640151-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041713-sterility-resample-9288@gregkh>
References: <2025041713-sterility-resample-9288@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Taniya Das <quic_tdas@quicinc.com>

[ Upstream commit 25708f73ff171bb4171950c9f4be5aa8504b8459 ]

Enable the retain_ff_enable bit of GDSCR only if the GDSC is already ON.
Once the GDSCR moves to HW control, SW no longer can determine the state
of the GDSCR and setting the retain_ff bit could destroy all the register
contents we intended to save.
Therefore, move the retain_ff configuration before switching the GDSC to
HW trigger mode.

Cc: stable@vger.kernel.org
Fixes: 173722995cdb ("clk: qcom: gdsc: Add support to enable retention of GSDCR")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Reviewed-by: Imran Shaik <quic_imrashai@quicinc.com>
Tested-by: Imran Shaik <quic_imrashai@quicinc.com> # on QCS8300
Link: https://lore.kernel.org/r/20250214-gdsc_fixes-v1-1-73e56d68a80f@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
[ Changed error path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gdsc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index cf23cfd7e4674..da3797241f319 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -273,6 +273,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	 */
 	udelay(1);
 
+	if (sc->flags & RETAIN_FF_ENABLE)
+		gdsc_retain_ff_on(sc);
+
 	/* Turn on HW trigger mode if supported */
 	if (sc->flags & HW_CTRL) {
 		ret = gdsc_hwctrl(sc, true);
@@ -289,9 +292,6 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 		udelay(1);
 	}
 
-	if (sc->flags & RETAIN_FF_ENABLE)
-		gdsc_retain_ff_on(sc);
-
 	return 0;
 }
 
@@ -392,13 +392,6 @@ static int gdsc_init(struct gdsc *sc)
 				return ret;
 		}
 
-		/* Turn on HW trigger mode if supported */
-		if (sc->flags & HW_CTRL) {
-			ret = gdsc_hwctrl(sc, true);
-			if (ret < 0)
-				return ret;
-		}
-
 		/*
 		 * Make sure the retain bit is set if the GDSC is already on,
 		 * otherwise we end up turning off the GDSC and destroying all
@@ -406,6 +399,14 @@ static int gdsc_init(struct gdsc *sc)
 		 */
 		if (sc->flags & RETAIN_FF_ENABLE)
 			gdsc_retain_ff_on(sc);
+
+		/* Turn on HW trigger mode if supported */
+		if (sc->flags & HW_CTRL) {
+			ret = gdsc_hwctrl(sc, true);
+			if (ret < 0)
+				return ret;
+		}
+
 	} else if (sc->flags & ALWAYS_ON) {
 		/* If ALWAYS_ON GDSCs are not ON, turn them ON */
 		gdsc_enable(&sc->pd);
-- 
2.51.0


