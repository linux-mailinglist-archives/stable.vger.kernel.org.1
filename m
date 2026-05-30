Return-Path: <stable+bounces-257600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHhHJpccG2qQ/QgAu9opvQ
	(envelope-from <stable+bounces-257600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:21:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A0160F7A0
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 577CD3024E25
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF553242D7;
	Sat, 30 May 2026 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qg5d5iq8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB81C5799;
	Sat, 30 May 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161543; cv=none; b=TQVm6m6RxhTUXMFJ3azlLgHeAywzrDGdpcu2YS2BqhuRAAWB6HVCf4HJE85qIbTGvAZ7rEAWte7NoSIOElQGOgomvbramxy2Wyt+m/o32nYET2RBYBmTmZgsNZRe1FiHj9y7hgd8wkmcl+ZEYhnIDQQk3hCBvy6kZMuuKJ/42s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161543; c=relaxed/simple;
	bh=WFCravKNqdQbXM6Y/WjeT8bASb8a+tVlT5QemSs3ZJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOyAsRCqkL2+3HZf+9rTMp7q1yJ14nMWfkRFmJfLXpiOYC/mWXf4GwO5hNbuYW1q48pCO9t6kOaAvv4D1EJFW1zdvqY2hvTwVZmngbeh4N5wouUTZ2JLO30pwoo3EEfKRMcy98oO7ADwVNJ0RyZgx9RJLblZP3w6HmmlIvlbBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qg5d5iq8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549421F00893;
	Sat, 30 May 2026 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161542;
	bh=j8jf9RdU7HbD0t4g4FEo2rgETtOIL+SzqCbO+RiECwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qg5d5iq8RQ/DLb5TPRqVFNpBMLzirnRIYTrwxKWbcT6ecCnC4X8PrYy8i558edJPm
	 y7qhZAs5awkdsDOZ0hyOk4aeLpEWq29NDLBxVQF4KWqoRvaLfZdtiOBonZaX4vWZgB
	 /OmA00rRuoHIMc350hNhg7+y/uvfwmk6Ei2f720o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Val Packett <val@packett.cool>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 654/969] clk: qcom: gcc-sc8180x: Use retention for USB power domains
Date: Sat, 30 May 2026 18:02:58 +0200
Message-ID: <20260530160318.530477573@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257600-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 37A0160F7A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Val Packett <val@packett.cool>

[ Upstream commit 25bc96f26cd6c19dde13a0b9859183e531d6fbfc ]

The USB subsystem does not expect to lose its state on suspend:

    xhci-hcd xhci-hcd.0.auto: xHC error in resume, USBSTS 0x401, Reinit
    usb usb1: root hub lost power or was reset

(The reinitialization usually succeeds, but it does slow down resume.)

To maintain state during suspend, the relevant GDSCs need to stay in
retention mode, like they do on other similar SoCs. Change the mode to
PWRSTS_RET_ON to fix.

Fixes: 4433594bbe5d ("clk: qcom: gcc: Add global clock controller driver for SC8180x")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Val Packett <val@packett.cool>
Link: https://lore.kernel.org/r/20260312112321.370983-4-val@packett.cool
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sc8180x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
index 00e2e22a14175..e0992f280692b 100644
--- a/drivers/clk/qcom/gcc-sc8180x.c
+++ b/drivers/clk/qcom/gcc-sc8180x.c
@@ -4106,7 +4106,7 @@ static struct gdsc usb30_sec_gdsc = {
 	.pd = {
 		.name = "usb30_sec_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR,
 };
 
@@ -4124,7 +4124,7 @@ static struct gdsc usb30_prim_gdsc = {
 	.pd = {
 		.name = "usb30_prim_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR,
 };
 
@@ -4196,7 +4196,7 @@ static struct gdsc usb30_mp_gdsc = {
 	.pd = {
 		.name = "usb30_mp_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR,
 };
 
-- 
2.53.0




