Return-Path: <stable+bounces-250737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAEpAy33DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:02:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1493595283
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3118B3578795
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C423E120A;
	Wed, 20 May 2026 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q81D6U+1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916503DCD9A;
	Wed, 20 May 2026 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296185; cv=none; b=AH59W66ljqubdzKO472pSI1OjmuhFOtlVduVr7nbud2hCEog6RI1Ge+O2K5GgCseBYIR1kDTzb/ZG6ZNufuHvbssmvXMHYJlwa6RG60N6haF9J9r6WSnzx5v4vZtdgy9NJouW8uH3csdZ71LXkaq+pl+7ScecXk1RiK6MgHFHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296185; c=relaxed/simple;
	bh=A8hBEw/hly/tfqFMoozimsid65CecLMxtS753g+6QfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch1RFan0IY7KZUwcc7x2yNJj5wF9XuJDaw5hnHOW2Xnaca9N3xTOB9BxPKUyp5mD8n8Y6qzWRNiGAZ04iJawVaYZ5UQcLdw1DWwCWbiWKQ1aK9ghMavLTruPzsrv5XGd8yxIN9qF7xq+xgm6BXnm2iEYvUobsKTI+z5WdMvdSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q81D6U+1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74551F00893;
	Wed, 20 May 2026 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296184;
	bh=VgyiidcuqYFIIu3Phpccc/E3xWnP0YhbkSPt/Zmz3I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q81D6U+17aaRTJOPoYiYOSHGZWNq/6Ru7rB3wdgptIR8o2nK0v+K9WxV8JQNHVbdU
	 vEnrhgWG1w3WLJXs6qSveYTx+gfFF67nO7R67KLMWS9QFQCyfz0oVX4Ef4InOUNwiL
	 7ik93UzamEwJmnCipsoCSPTRESgiG5Vbf1X0hEkg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	White Lewis <liu224806@gmail.com>,
	Pengyu Luo <mitltlatltl@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0704/1146] clk: qcom: dispcc-sc8280xp: remove CLK_SET_RATE_PARENT from byte_div_clk_src dividers
Date: Wed, 20 May 2026 18:15:54 +0200
Message-ID: <20260520162204.121455128@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-250737-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: D1493595283
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: White Lewis <liu224806@gmail.com>

[ Upstream commit 0b151a6307205eb867250985a910a88787cbf12e ]

The four byte_div_clk_src dividers (disp{0,1}_cc_mdss_byte{0,1}_div_clk_src)
had CLK_SET_RATE_PARENT set. When the DSI driver calls clk_set_rate() on
byte_intf_clk, the rate-change propagates through the divider up to the
parent PLL (byte_clk_src), halving the byte clock rate.

A simiar issue had been also encountered on SM8750.
b8501febdc51 ("clk: qcom: dispcc-sm8750: Drop incorrect CLK_SET_RATE_PARENT on byte intf parent").

Likewise, remove CLK_SET_RATE_PARENT from all four byte divider clocks
so that clk_set_rate() on the divider adjusts only the divider ratio,
leaving the parent PLL untouched.

Fixes: 4a66e76fdb6d ("clk: qcom: Add SC8280XP display clock controller")
Signed-off-by: White Lewis <liu224806@gmail.com>
[pengyu: reword]
Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260303115550.9279-1-mitltlatltl@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/dispcc-sc8280xp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
index 5903a759d4af4..e91dfed0f37e9 100644
--- a/drivers/clk/qcom/dispcc-sc8280xp.c
+++ b/drivers/clk/qcom/dispcc-sc8280xp.c
@@ -1160,7 +1160,6 @@ static struct clk_regmap_div disp0_cc_mdss_byte0_div_clk_src = {
 			&disp0_cc_mdss_byte0_clk_src.clkr.hw,
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_regmap_div_ops,
 	},
 };
@@ -1175,7 +1174,6 @@ static struct clk_regmap_div disp1_cc_mdss_byte0_div_clk_src = {
 			&disp1_cc_mdss_byte0_clk_src.clkr.hw,
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_regmap_div_ops,
 	},
 };
@@ -1190,7 +1188,6 @@ static struct clk_regmap_div disp0_cc_mdss_byte1_div_clk_src = {
 			&disp0_cc_mdss_byte1_clk_src.clkr.hw,
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_regmap_div_ops,
 	},
 };
@@ -1205,7 +1202,6 @@ static struct clk_regmap_div disp1_cc_mdss_byte1_div_clk_src = {
 			&disp1_cc_mdss_byte1_clk_src.clkr.hw,
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_regmap_div_ops,
 	},
 };
-- 
2.53.0




