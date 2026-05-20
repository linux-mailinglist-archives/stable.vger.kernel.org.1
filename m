Return-Path: <stable+bounces-250754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBxFMobsDWo04wUAu9opvQ
	(envelope-from <stable+bounces-250754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:16:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 721485933B9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5330030E7741
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDAE3E832A;
	Wed, 20 May 2026 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jX/1TiTU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E03A383C;
	Wed, 20 May 2026 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296230; cv=none; b=B1BG4GYtuDVL31oNrCjD3PQ0ijgjJsWAp5XxqI0Vj94JtdxbmUdrYe1lqoSuTn0M1yfU8K+nRFfJUAE3cAS33cFsgJpr0bodWTF0bDe5PvsEzZ5VgvoSTBOCiSodkvpNs2Jp997ClQHsLs6NieFgMymOMmcLw+CtPabX2bHFl6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296230; c=relaxed/simple;
	bh=TlwqqH6AJUAxVJO8VGQ3cy4auHV2CSzCXrq7GtpWwRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vp8G62P0UYdPGKNWL68aTdKqjRvZYfJ/HxzloeqZNrQzHVzz33/spBLSDuyK/P0JFD1MmcVQ6Ai9rP2S+nnRgrQn91V1EmTOcrfPhD48KjVqXmbGzih4IMt56tNJAP9by49L+aL3RRxuF2YJea5Bg29GjXB9KIrjoZGceB/YIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jX/1TiTU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713871F000E9;
	Wed, 20 May 2026 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296228;
	bh=wBJyoXf/vTR/cKp1hJygI2pjRs9izbDzgr/9s4sxQn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jX/1TiTUUOyFilr2xzkM9dVU810UnSqDKfdeQ7hJFLL0yo8mJj84DSUrkQaNrV+rC
	 C3SrrexG2eoI2ImuxBt+/b5QpsFIRZksEj02wPyqEqDIYeqC/Hmmwi2QS8aM3UYXKh
	 SE9rBjbL7niPG/nXU4a1/4DBjuvd526wQe67ofeg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Val Packett <val@packett.cool>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0719/1146] clk: qcom: dispcc-sm8250: Enable parents for pixel clocks
Date: Wed, 20 May 2026 18:16:09 +0200
Message-ID: <20260520162204.476628077@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250754-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,packett.cool:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 721485933B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Val Packett <val@packett.cool>

[ Upstream commit acf7a91d0b0e9e3ef374944021de62062125b7e4 ]

Add CLK_OPS_PARENT_ENABLE to MDSS pixel clock sources to ensure parent
clocks are enabled during clock operations, preventing potential
stability issues during display configuration.

Fixes: 80a18f4a8567 ("clk: qcom: Add display clock controller driver for SM8150 and SM8250")
Signed-off-by: Val Packett <val@packett.cool>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260312112321.370983-9-val@packett.cool
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/dispcc-sm8250.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index cdfdb2cfb02b2..e59cdadd56479 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -578,7 +578,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
 		.name = "disp_cc_mdss_pclk0_clk_src",
 		.parent_data = disp_cc_parent_data_6,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_6),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_pixel_ops,
 	},
 };
@@ -592,7 +592,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src = {
 		.name = "disp_cc_mdss_pclk1_clk_src",
 		.parent_data = disp_cc_parent_data_6,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_6),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_pixel_ops,
 	},
 };
-- 
2.53.0




