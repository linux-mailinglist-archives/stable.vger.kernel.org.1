Return-Path: <stable+bounces-178044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7798B47BE6
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 16:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34F1189BFBE
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256C326F29F;
	Sun,  7 Sep 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6PsCiQx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85811A0BD0
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757257038; cv=none; b=Yg1/19bHF0c9IFTNam5axElR5tLI2/BeRMoQvEcnhY9/t8ClaVr2veyFNGHCw2fINEmxR6uvYwI3REUPiadCwL24BIOTX6HTvZiMSQSBCWcFxDHWU84tQH0VcGFtOSPZAejZLul9zsIwHJArw3mORCfB1dkO0COIUeSTU82bZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757257038; c=relaxed/simple;
	bh=t8iJjYJxfCGrr5eWr3chvNjaW9C8YhbD2SQjFNwV/kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXp9hkJLHI7xwU2ndu5zgCdZTknh2mbc0myQEQBo7/oF0NunTmtKhH6ivKC8AMCRWHb7XfJjWt2uWkefrSz4xR8zaQijxDhAChyxpuQXGbHpDHyALRJlj9JEVpgzMr35UMFpc8dOL6yqeLv5YqAj5YIUhQU3K39ruI0cN4ilPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6PsCiQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57C3C4CEF0;
	Sun,  7 Sep 2025 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757257038;
	bh=t8iJjYJxfCGrr5eWr3chvNjaW9C8YhbD2SQjFNwV/kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6PsCiQxlEdlYST6ahAIFn/ia2izMP/asdXPlkdSf0RnK00TPFwrP++R3//kvISh/
	 cdoxkCyflQFlL53PXmHFHSV97HBwy5wY/VxdCQ5onvWWMRD7A7HmSl/Z052d/OCsul
	 ojfk+j0dSbdsYncFR5QDcBgNGfOseaWeVK6bo9xAxbzDOmllH6gHWO9tQD0nLi2I+M
	 oZIzCJy86g/pjIixiPzk796B6076gwFDKJ+M8qNTXZssKAH+uOFeb9ZV8r3bRjNZeJ
	 qLU+X7ahDu50AvtfSJVBkq1WILd8ZxABFsAC2osH+njKgC3wJI7OFwGhq2sRJlIre1
	 t0WGSOnyk6Icg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Taniya Das <quic_tdas@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] clk: qcom: gdsc: Set retain_ff before moving to HW CTRL
Date: Sun,  7 Sep 2025 10:57:15 -0400
Message-ID: <20250907145715.636498-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041712-antibody-octane-7c74@gregkh>
References: <2025041712-antibody-octane-7c74@gregkh>
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


