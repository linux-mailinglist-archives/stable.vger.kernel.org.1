Return-Path: <stable+bounces-136108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBD2A991F5
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AA2445499
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80922BD5AC;
	Wed, 23 Apr 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zqa3HDB8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75457C9F;
	Wed, 23 Apr 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421679; cv=none; b=dwH11gQxU+xANn4yVRsee8FaLAAETL1MhsPtSeqZh5LCBVm1seJn7ZqJxERFEJUa3yCcSMJ8UXQie/VAdddF8Ou6YUPD75DB9PiR5fO96mMY8JiL3FMUKCkGR7r7WzzagMsbbR7gC3VCeAD+xupb0ia3+uuoBQKkmcrClkX2hzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421679; c=relaxed/simple;
	bh=FJyfqF81T6FmGn5xSl2kjR5LHeJTAOfiEpSLjRe+LnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8ferVlF07ZIb7yfAYQ4+jTFkLl1BJiDo4XVzshhJd7Hr4GK8sA/qmE6aNtSfqgVW5ngDQXmcXRoRc0Z47pkaeIzct8bNssB4pqKulRoGdABO2hL8D5qBLl1yCoGRFj0bCDkGS2TcYaW3waUkgvJyasCA45PiVv1miqzOcy8Joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zqa3HDB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63162C4CEE3;
	Wed, 23 Apr 2025 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421676;
	bh=FJyfqF81T6FmGn5xSl2kjR5LHeJTAOfiEpSLjRe+LnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zqa3HDB8N6+NMkxwsjfeQ9qtLt52Eo0VwjKAzZvxaJL3aMBeYM7+BW+1Yoi82WqS9
	 vIv32fsWW/amEHOlaHXQkfhH3wigqpiR72zQTNsdUJHVC9bFTsckUy0cxq+PXLULGc
	 kxD2Hw7XqxCoWB1qzbljxxdgjrgiVloyQY9NG2eo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taniya Das <quic_tdas@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.6 207/393] clk: qcom: gdsc: Set retain_ff before moving to HW CTRL
Date: Wed, 23 Apr 2025 16:41:43 +0200
Message-ID: <20250423142651.935704146@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taniya Das <quic_tdas@quicinc.com>

commit 25708f73ff171bb4171950c9f4be5aa8504b8459 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/gdsc.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -292,6 +292,9 @@ static int gdsc_enable(struct generic_pm
 	 */
 	udelay(1);
 
+	if (sc->flags & RETAIN_FF_ENABLE)
+		gdsc_retain_ff_on(sc);
+
 	/* Turn on HW trigger mode if supported */
 	if (sc->flags & HW_CTRL) {
 		ret = gdsc_hwctrl(sc, true);
@@ -308,9 +311,6 @@ static int gdsc_enable(struct generic_pm
 		udelay(1);
 	}
 
-	if (sc->flags & RETAIN_FF_ENABLE)
-		gdsc_retain_ff_on(sc);
-
 	return 0;
 }
 
@@ -420,13 +420,6 @@ static int gdsc_init(struct gdsc *sc)
 				goto err_disable_supply;
 		}
 
-		/* Turn on HW trigger mode if supported */
-		if (sc->flags & HW_CTRL) {
-			ret = gdsc_hwctrl(sc, true);
-			if (ret < 0)
-				goto err_disable_supply;
-		}
-
 		/*
 		 * Make sure the retain bit is set if the GDSC is already on,
 		 * otherwise we end up turning off the GDSC and destroying all
@@ -434,6 +427,14 @@ static int gdsc_init(struct gdsc *sc)
 		 */
 		if (sc->flags & RETAIN_FF_ENABLE)
 			gdsc_retain_ff_on(sc);
+
+		/* Turn on HW trigger mode if supported */
+		if (sc->flags & HW_CTRL) {
+			ret = gdsc_hwctrl(sc, true);
+			if (ret < 0)
+				goto err_disable_supply;
+		}
+
 	} else if (sc->flags & ALWAYS_ON) {
 		/* If ALWAYS_ON GDSCs are not ON, turn them ON */
 		gdsc_enable(&sc->pd);



