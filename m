Return-Path: <stable+bounces-258447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DrHHZwnG2qS/ggAu9opvQ
	(envelope-from <stable+bounces-258447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:08:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCA76110DC
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97A2630118E9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3A23BFE4D;
	Sat, 30 May 2026 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c+CRI0CK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425533AFCE3;
	Sat, 30 May 2026 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164381; cv=none; b=HXlQ3+BLzgdQ7S9e5sPOMh3biwVtG/ms+cy/xdWjNa178aYi9GPffh749yxcCS0f+h2G3vjHt8QJ66aOrr8Nx9EClK/07jSl42xuLDYV6p8fuFIX8o04F5agB1lW6lGt8rNd7ZjPIy11MedoDuENr/MWFWJK52jaW515tS6kZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164381; c=relaxed/simple;
	bh=gDODUjN4/SohszmZG4mZfgYx+EHxtbCdvsrwygI+lsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMYchNu7eE6WE1U2UcTcFalvKHmiSUxQjtlw8y6TA2GWeiW5DOiFee5ub2EnbN//LtqA3+qevnyGVdUerluiu/MXbDodNv00kH/959X5MJByY7W2BiAdxsQ+SnvQZX8iZpGRUaXxL1kP3mMR+YXzxvs/BSN5OfQH3BMq/KYRqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c+CRI0CK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1FA1F00893;
	Sat, 30 May 2026 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164380;
	bh=ueFqDP5Tch56DH6suXeaOZU2nAPiVpyAOxt1aPaIONg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+CRI0CKilFVFGHpuqO66VzuVrlvNp0PtZE8Ko1nff6DwdmOgHzv/NSSGQrXXYYh9
	 QqY0CCehF/tGHS9ORi3ABpOcXigMqDVgaUWjBwk3VsIUa65BYAgts5FjIscBiQcEiy
	 IH6jHVlLi8ZvtGMjdwMYTOaQGtNfmTaLXlaCCvfg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Val Packett <val@packett.cool>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 538/776] clk: qcom: gcc-sc8180x: Add missing GDSCs
Date: Sat, 30 May 2026 18:04:12 +0200
Message-ID: <20260530160254.094967128@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258447-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7BCA76110DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Val Packett <val@packett.cool>

[ Upstream commit 3565741eb985a8a7cc6656eb33496195468cb99e ]

There are 5 more GDSCs that we were ignoring and not putting to sleep,
which are listed in downstream DTS. Add them.

Fixes: 4433594bbe5d ("clk: qcom: gcc: Add global clock controller driver for SC8180x")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Val Packett <val@packett.cool>
Link: https://lore.kernel.org/r/20260312112321.370983-3-val@packett.cool
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sc8180x.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
index ba004281f2944..00e2e22a14175 100644
--- a/drivers/clk/qcom/gcc-sc8180x.c
+++ b/drivers/clk/qcom/gcc-sc8180x.c
@@ -4200,6 +4200,51 @@ static struct gdsc usb30_mp_gdsc = {
 	.flags = POLL_CFG_GDSCR,
 };
 
+static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
+	.gdscr = 0x7d050,
+	.pd = {
+		.name = "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc = {
+	.gdscr = 0x7d058,
+	.pd = {
+		.name = "hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct gdsc hlos1_vote_mmnoc_mmu_tbu_sf_gdsc = {
+	.gdscr = 0x7d054,
+	.pd = {
+		.name = "hlos1_vote_mmnoc_mmu_tbu_sf_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct gdsc hlos1_vote_turing_mmu_tbu0_gdsc = {
+	.gdscr = 0x7d05c,
+	.pd = {
+		.name = "hlos1_vote_turing_mmu_tbu0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct gdsc hlos1_vote_turing_mmu_tbu1_gdsc = {
+	.gdscr = 0x7d060,
+	.pd = {
+		.name = "hlos1_vote_turing_mmu_tbu1_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
 static struct clk_regmap *gcc_sc8180x_clocks[] = {
 	[GCC_AGGRE_NOC_PCIE_TBU_CLK] = &gcc_aggre_noc_pcie_tbu_clk.clkr,
 	[GCC_AGGRE_UFS_CARD_AXI_CLK] = &gcc_aggre_ufs_card_axi_clk.clkr,
@@ -4500,6 +4545,11 @@ static struct gdsc *gcc_sc8180x_gdscs[] = {
 	[USB30_MP_GDSC] = &usb30_mp_gdsc,
 	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
 	[USB30_SEC_GDSC] = &usb30_sec_gdsc,
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = &hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc,
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = &hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc,
+	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = &hlos1_vote_mmnoc_mmu_tbu_sf_gdsc,
+	[HLOS1_VOTE_TURING_MMU_TBU0_GDSC] = &hlos1_vote_turing_mmu_tbu0_gdsc,
+	[HLOS1_VOTE_TURING_MMU_TBU1_GDSC] = &hlos1_vote_turing_mmu_tbu1_gdsc,
 };
 
 static const struct regmap_config gcc_sc8180x_regmap_config = {
-- 
2.53.0




