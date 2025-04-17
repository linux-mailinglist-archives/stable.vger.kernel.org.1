Return-Path: <stable+bounces-133113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E9BA91E0C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA2C7B05CD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA155150980;
	Thu, 17 Apr 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2MHnzeK6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E1145B24
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896457; cv=none; b=QcfGf++G8MgwezBKqwb6sCiY9PAyQknjgBp/uct8VeJxikwAsM75YqyDR5f2dwWSCLoooWKI55uo5a84DoakQJnD0qdqy0QAvZ2KtmJ3jAZnE+6Ul5L1WaYLAE326DYFBDFK+e3VPk47LueGjIXXGNZtqol97FWQ4GUkqrCzvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896457; c=relaxed/simple;
	bh=ivvNdC8v7tT8T6gaM0J/rupCxZYq7E1ta3Tj13eS+Wk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ceCRuqIsinjF7TI3LmQND9SHM4xVjfvSsZaS19n4tS9wn4s7O4m6XKbherPD+prw6qckTpIXDWc8xbE3pR3XEgCLQbCLQG8UWoPsO3Cdnd2xb2Db/W68XD/OCY1LhfgJ0zXr10lG/LfXsub+MUg01FBY8AHDxtLzilG6iKxc7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2MHnzeK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E368AC4CEEB;
	Thu, 17 Apr 2025 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744896457;
	bh=ivvNdC8v7tT8T6gaM0J/rupCxZYq7E1ta3Tj13eS+Wk=;
	h=Subject:To:Cc:From:Date:From;
	b=2MHnzeK6nPuT8voUNnACCwaVOm0NXtVzc2BKvRo14NS0fljANu3QPCN7fLoIZVl5R
	 vrIMlYrPW6CZdNAL59JGYcRPO/FqGjTI8RZs8S0dOBShP4eBXwUIVxt/U15oK7kk2H
	 ZJ5lNdhy+GNQLE8zktr8zE/ow4s9J3Vf0OFE6/U4=
Subject: FAILED: patch "[PATCH] clk: qcom: gdsc: Set retain_ff before moving to HW CTRL" failed to apply to 5.15-stable tree
To: quic_tdas@quicinc.com,andersson@kernel.org,quic_imrashai@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:22:12 +0200
Message-ID: <2025041712-antibody-octane-7c74@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 25708f73ff171bb4171950c9f4be5aa8504b8459
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041712-antibody-octane-7c74@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 25708f73ff171bb4171950c9f4be5aa8504b8459 Mon Sep 17 00:00:00 2001
From: Taniya Das <quic_tdas@quicinc.com>
Date: Fri, 14 Feb 2025 09:56:59 +0530
Subject: [PATCH] clk: qcom: gdsc: Set retain_ff before moving to HW CTRL

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

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 7687661491f1..f3f95f4d9313 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -292,6 +292,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	 */
 	udelay(1);
 
+	if (sc->flags & RETAIN_FF_ENABLE)
+		gdsc_retain_ff_on(sc);
+
 	/* Turn on HW trigger mode if supported */
 	if (sc->flags & HW_CTRL) {
 		ret = gdsc_hwctrl(sc, true);
@@ -308,9 +311,6 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 		udelay(1);
 	}
 
-	if (sc->flags & RETAIN_FF_ENABLE)
-		gdsc_retain_ff_on(sc);
-
 	return 0;
 }
 
@@ -457,13 +457,6 @@ static int gdsc_init(struct gdsc *sc)
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
@@ -471,6 +464,14 @@ static int gdsc_init(struct gdsc *sc)
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


