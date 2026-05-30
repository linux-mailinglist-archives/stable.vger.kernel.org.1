Return-Path: <stable+bounces-257649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKa8LWwdG2qW/QgAu9opvQ
	(envelope-from <stable+bounces-257649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:25:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5807760F944
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2213130117B6
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540F530E829;
	Sat, 30 May 2026 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WpD0m2i8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316B8263F44;
	Sat, 30 May 2026 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161709; cv=none; b=tdXs4cBX48MWY4r81tvMEp0OsCFiPYBcOFwwqIEhzNVOftu7NZGMc4bqCrUR15Y9km+I9dN3oH6Jb/xyNNzQhWL4ol25n4l6vR5oMayay7ZZYmngc9Xmca/zjvzgu7QEacCoRTj6QM3m4g9u8oG+tv5yR925VAMTAbP6pclj9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161709; c=relaxed/simple;
	bh=YYQYGvEwNRMaCLRhOhHtYDCLC5EYd4N/tkK74SXHAlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCzIOVF72CXc6dKkst9JBgxLezuTjCZFq4bXnkKYqqIIirEndvrMZPpnSIsQJGqmikaNI5XhvHJ6BIPiJz8UQE3TABOhc6NDlpwICYsfH/7Lj+Og1mKsHjPqO3WslrJBMKEiueSnEOYy8yd2RPZxwmSQNNiQgeWUW9mGCBCRGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WpD0m2i8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBC51F00893;
	Sat, 30 May 2026 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161708;
	bh=YfaYi+yzadAgyYT8h7JbYhusBIfRSYvIRdBiPSkou5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WpD0m2i8iFpdYv6Sv46E23B6c479TOwwePQA93/QvZOs92fC8yvPx6iy+0j1uy7d8
	 Jwnvqn/dJk0aQbDUT3H4jyV8+dEoymMvvsa4truARqRc5paSlHPOeDRN9FEHI0eZRI
	 Jxo8TRzC5QwsZWwHS+KiQpI/6o4VPTHGJUFaS7a8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Val Packett <val@packett.cool>
Subject: [PATCH 6.1 664/969] clk: qcom: dispcc-sc7180: Add missing MDSS resets
Date: Sat, 30 May 2026 18:03:08 +0200
Message-ID: <20260530160318.816239759@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257649-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5807760F944
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[ Upstream commit b0bc6011c5499bdfddd0390262bfa13dce1eff74 ]

The MDSS resets have so far been left undescribed. Fix that.

Fixes: dd3d06622138 ("clk: qcom: Add display clock controller driver for SC7180")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Tested-by: Val Packett <val@packett.cool> # sc7180-ecs-liva-qc710
Link: https://lore.kernel.org/r/20260120-topic-7180_dispcc_bcr-v1-2-0b1b442156c3@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/dispcc-sc7180.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sc7180.c b/drivers/clk/qcom/dispcc-sc7180.c
index 5d2ae297e7413..040149f24d798 100644
--- a/drivers/clk/qcom/dispcc-sc7180.c
+++ b/drivers/clk/qcom/dispcc-sc7180.c
@@ -16,6 +16,7 @@
 #include "clk-regmap-divider.h"
 #include "common.h"
 #include "gdsc.h"
+#include "reset.h"
 
 enum {
 	P_BI_TCXO,
@@ -635,6 +636,11 @@ static struct gdsc mdss_gdsc = {
 	.flags = HW_CTRL,
 };
 
+static const struct qcom_reset_map disp_cc_sc7180_resets[] = {
+	[DISP_CC_MDSS_CORE_BCR] = { 0x2000 },
+	[DISP_CC_MDSS_RSCC_BCR] = { 0x4000 },
+};
+
 static struct gdsc *disp_cc_sc7180_gdscs[] = {
 	[MDSS_GDSC] = &mdss_gdsc,
 };
@@ -686,6 +692,8 @@ static const struct qcom_cc_desc disp_cc_sc7180_desc = {
 	.config = &disp_cc_sc7180_regmap_config,
 	.clks = disp_cc_sc7180_clocks,
 	.num_clks = ARRAY_SIZE(disp_cc_sc7180_clocks),
+	.resets = disp_cc_sc7180_resets,
+	.num_resets = ARRAY_SIZE(disp_cc_sc7180_resets),
 	.gdscs = disp_cc_sc7180_gdscs,
 	.num_gdscs = ARRAY_SIZE(disp_cc_sc7180_gdscs),
 };
-- 
2.53.0




