Return-Path: <stable+bounces-250739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ48Is0TDmot6AUAu9opvQ
	(envelope-from <stable+bounces-250739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:04:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29690599161
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D693803A38
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B503E1D01;
	Wed, 20 May 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yuy+GcQ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FB3DA7D9;
	Wed, 20 May 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296190; cv=none; b=Pd5W4wjJzDIu7Q/GUMkRCtYyBLrpja2HP3vaZ9AzfKVUAnFBO6suThIDSB+RoFZPfTBe1z+6Li3LpU/x0CPHArVifgtIdXqaMr4XjC7/qRfjzqfqBMUUkCaI2hty7UIGz4krcDFEe//b4aL9QFKXdqfqBcgyfcLuzgEYsQqidJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296190; c=relaxed/simple;
	bh=AY5WUhy5RIk26ZaGxgo1fQ/nHJo/BNaa+kIyzwM72kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfT8gudaxj5hhYBgd3tkLTdDKcgGNig/aBtmm1pFhAVQaQMIarBfHqSWFhD5SRchaynHMkjAHrPQMmiFiRE9mO2ig1Zj6sdY/Bdhhv3wBpIhvPBW6wOWQP1q/BO5fHp9u0hbYep23hfc50mfTWBEA4abfImSsVyOJHk7s5juxrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yuy+GcQ6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE05B1F000E9;
	Wed, 20 May 2026 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296189;
	bh=Ljcm49n3PQhCYQs+YBarhIIuYup/e11YzgqllQNRDwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yuy+GcQ6SJvReN0za7auKsEm3jIVvUHZFzdPtUEnwHjB+O4IQ6ZWhCYDqu5GjrQdI
	 ONXwO+kyRAwVh8ESlQiKGc7sB/SOiPFJPYWs4zqSrFDRbnDEW97WBOHCA63RSjnTsF
	 jF7RKypby2wkr0e8q7g7HAuvTkqLxo2MJAu2C/YA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0706/1146] clk: qcom: dispcc-kaanapali: Fix DSI byte clock rate setting
Date: Wed, 20 May 2026 18:15:56 +0200
Message-ID: <20260520162204.167514442@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250739-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 29690599161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[ Upstream commit e892f4e3f3d558ce5d7595dca7cce2bd170a19fa ]

The clock tree for byte_clk_src is as follows:

   ┌──────byte0_clk_src─────┐
   │                        │
byte0_clk            byte0_div_clk_src
                            │
                     byte0_intf_clk

If both of its direct children have CLK_SET_RATE_PARENT with different
requests, byte0_clk_src (and its parent) will be reconfigured. In this
case, byte0_intf should strictly follow the rate of byte0_clk (with
some adjustments based on PHY mode).

Remove CLK_SET_RATE_PARENT from byte0_div_clk_src to avoid this issue.

Fixes: 6c6750b7061c ("clk: qcom: dispcc: Add support for display clock controller Kaanapali")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260304-topic-dsi_byte_fixup-v1-2-b79b29f83176@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/dispcc-kaanapali.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-kaanapali.c b/drivers/clk/qcom/dispcc-kaanapali.c
index baae2ec1f72aa..c1578cd07041b 100644
--- a/drivers/clk/qcom/dispcc-kaanapali.c
+++ b/drivers/clk/qcom/dispcc-kaanapali.c
@@ -800,7 +800,6 @@ static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
 			&disp_cc_mdss_byte0_clk_src.clkr.hw,
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_regmap_div_ops,
 	},
 };
@@ -815,7 +814,6 @@ static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
 			&disp_cc_mdss_byte1_clk_src.clkr.hw,
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_regmap_div_ops,
 	},
 };
-- 
2.53.0




