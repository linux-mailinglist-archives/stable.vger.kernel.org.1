Return-Path: <stable+bounces-178206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79877B47DAD
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE423A8045
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170DC277C94;
	Sun,  7 Sep 2025 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zh1Pjb6u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9D29C326;
	Sun,  7 Sep 2025 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276101; cv=none; b=N6Iu3UmMpm+n1Ope7pFOJKWAwUcMI3/aSr0h1vG3rFB2lLDwRrSJGr8R6IWZKtLiEwt0aaOCrW6BRNRLrUrmCSUNE9z6oUzDkYKhl6tIWTTLZC1EgLcGJ1zSS9L7s7/PO7ylXzGfEIVLbBq/BwoNXALq1tlGQK2kiIYGH3CouRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276101; c=relaxed/simple;
	bh=3Lk2gZol8HgqjWI6rSVqCVhutwnEjwB9EWVSgSsk7yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeBEM+omczPMYMKexCFepdolUehUt08+LmbKEJY1zWtO4NtHIViiQLL5Cl+LepXhT99x+pG8Jk32/+ojjIC6fPrSj38YfOfimHZKfPhSNzL+IS1CU7QwjToC+g3icU0NGFWEgWAAOJFRDv4zuTEJJHTAXLENaFppHCwOKeSySRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zh1Pjb6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DD8C4CEF8;
	Sun,  7 Sep 2025 20:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276101;
	bh=3Lk2gZol8HgqjWI6rSVqCVhutwnEjwB9EWVSgSsk7yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zh1Pjb6uNVOPSrt6/8hiNjFEojylC2SiLLd/jgTYkJoQgr2fvsgDbR2HInkQLga+q
	 oGe+rN3cacQimFCmYr7I5P7itNI3fNTeaFCl5QBe5iGSblb5dnKABcFzxumsBfZPR7
	 e88WGX9EFJKhZgCjxkdrAb17orRNlK4x73cwyysM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taniya Das <quic_tdas@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 62/64] clk: qcom: gdsc: Set retain_ff before moving to HW CTRL
Date: Sun,  7 Sep 2025 21:58:44 +0200
Message-ID: <20250907195605.128430960@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195603.394640159@linuxfoundation.org>
References: <20250907195603.394640159@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/gdsc.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -273,6 +273,9 @@ static int gdsc_enable(struct generic_pm
 	 */
 	udelay(1);
 
+	if (sc->flags & RETAIN_FF_ENABLE)
+		gdsc_retain_ff_on(sc);
+
 	/* Turn on HW trigger mode if supported */
 	if (sc->flags & HW_CTRL) {
 		ret = gdsc_hwctrl(sc, true);
@@ -289,9 +292,6 @@ static int gdsc_enable(struct generic_pm
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



