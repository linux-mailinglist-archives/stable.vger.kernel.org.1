Return-Path: <stable+bounces-220614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPtKDodAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:22:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4011C6E8F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 145CA3442D2C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8A43E5585;
	Sat, 28 Feb 2026 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgFCyxPA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2973E557D;
	Sat, 28 Feb 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300497; cv=none; b=dJUmI4oTQ1ol1LPjt6D7eMqVEuhm5wX6/H2DvHTuQx4iuFanizfazOhvTzXgOUW+SecMvlNBtu6m6oAOTbULmY4EVu4lRmb2TYqI2jQ62hT8ueXqTwBqpyYrGtnJkbc6thTZCplATF4NUEF1CQCYUPOK3+Pry6wXAL/LUePb3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300497; c=relaxed/simple;
	bh=FbUwHqWJZ1clU++cKGaAtloRHsD74SCvaxpYluc92Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3KwSWSL7uwo0Ta+RmUC9qpTyGVe3Vd5hxBI4D4SSeRqo5IrM/YerMmRtoW7uyEiefgNrJ4E8wZzBtqFmrypA8UER8j/i2aoAfOSRiLaIllMQUSJZz3u6J3HsJujC2lE/8I+QeCcXWTfkaCwcmqdyOh5mtRzoS/WBDhQ+DlX5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgFCyxPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E9DC19425;
	Sat, 28 Feb 2026 17:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300497;
	bh=FbUwHqWJZ1clU++cKGaAtloRHsD74SCvaxpYluc92Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgFCyxPAVziZYRjns7YfVJ8Gz40rhoEm7iobZwnPMop0kzUfF1kTngVo8VryjvkhA
	 yn9x3nToH3z32qGqx/i+iF4O0rDWn+iZHVi9wlybOSGf7hbYjoKizMloUuad86K+wT
	 Jh1hVAhviy5ZnSQauz5h0etnbsfTqKNyxBJPUVjC0jv83U/AfIUvkcYWRCbbBu7vsh
	 eF5QVMjDmW75Y/WcSRbiAE1OS5v24gTy/h4jvjRQ2bwSrw+1Vnez1vhCs3IOWHjyc5
	 VJiZxCkNrSigsq0iYZ8yLeWwy3ICzxWAhz40OTROQcxBoDUAo+mOtMSLVjMqVULD3t
	 lRxKAxsZ5Uozw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 535/844] phy: qcom: edp: Make the number of clocks flexible
Date: Sat, 28 Feb 2026 12:27:28 -0500
Message-ID: <20260228173244.1509663-536-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220614-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url,linaro.org:email]
X-Rspamd-Queue-Id: 8E4011C6E8F
X-Rspamd-Action: no action

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 7d51b709262c5aa31d2b9cd31444112c1b2dae03 ]

On X Elite, the DP PHY needs another clock called ref, while all other
platforms do not.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, even though this change breaks the ABI, it is
needed in order to make the driver disables this clock along with the
other ones, for a proper bring-down of the entire PHY.

So in order to handle these clocks on different platforms, make the driver
get all the clocks regardless of how many there are provided.

Cc: stable@vger.kernel.org # v6.10
Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://patch.msgid.link/20251224-phy-qcom-edp-add-missing-refclk-v5-2-3f45d349b5ac@oss.qualcomm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index f1b51018683d5..06a08c9ea0f70 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -103,7 +103,9 @@ struct qcom_edp {
 
 	struct phy_configure_opts_dp dp_opts;
 
-	struct clk_bulk_data clks[2];
+	struct clk_bulk_data *clks;
+	int num_clks;
+
 	struct regulator_bulk_data supplies[2];
 
 	bool is_edp;
@@ -218,7 +220,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(edp->clks), edp->clks);
+	ret = clk_bulk_prepare_enable(edp->num_clks, edp->clks);
 	if (ret)
 		goto out_disable_supplies;
 
@@ -885,7 +887,7 @@ static int qcom_edp_phy_exit(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(edp->clks), edp->clks);
+	clk_bulk_disable_unprepare(edp->num_clks, edp->clks);
 	regulator_bulk_disable(ARRAY_SIZE(edp->supplies), edp->supplies);
 
 	return 0;
@@ -1092,11 +1094,9 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(edp->pll))
 		return PTR_ERR(edp->pll);
 
-	edp->clks[0].id = "aux";
-	edp->clks[1].id = "cfg_ahb";
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(edp->clks), edp->clks);
-	if (ret)
-		return ret;
+	edp->num_clks = devm_clk_bulk_get_all(dev, &edp->clks);
+	if (edp->num_clks < 0)
+		return dev_err_probe(dev, edp->num_clks, "failed to get clocks\n");
 
 	edp->supplies[0].supply = "vdda-phy";
 	edp->supplies[1].supply = "vdda-pll";
-- 
2.51.0


