Return-Path: <stable+bounces-251759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOqRJkkeDmro6AUAu9opvQ
	(envelope-from <stable+bounces-251759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:49:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D68259A28E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9260B3503C43
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7E93D75D3;
	Wed, 20 May 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="obfAyL38"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619D317160;
	Wed, 20 May 2026 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298818; cv=none; b=tf6hNkC5dB45Zn2KnXv1q8Yx8IL+aGZJfpRrqkFzGSVWBx443wP03MFB8ry1cwlzbyRnbEiZ+haJG5HNyXcsa0PvCrSy64gUKJwnAY3k032KFk/O+Z+kqfVW0L0J9/viCHxzOYBgCpj1vRRgpqhiuGYM1BLf3Hf0VvEtJJ5rjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298818; c=relaxed/simple;
	bh=uW0fdFQZqLqeaJQkeDjqZmd2ZZEo0fjsd2TwO3/milk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDuMPlh2pj3T46v5CNvLlVZxBLn/wzuflATDFoAknjV79SkGgX2VyyALsd/q1mUhjTzMocHbp1penDDsSEpCmZRtkGFboaB9Ek0g+tmpDcgxsecHp/xhyR35bQPOj0YsDkIkOikgpFcfU919D60TdyJNoHQ6JiU7WKD3HnEwnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=obfAyL38; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF0E1F000E9;
	Wed, 20 May 2026 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298817;
	bh=b94a3BKplmpsr7cLMfqbDXT06WTGoB1QGxBOB7XiaFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=obfAyL38GlSv9nWFzVNds2wg0lrE79lsyNFRNWG0MI6J+94GdD48poNDsaQY2KCjr
	 5OgjdtQjY8EY+djD1iDMNr5Nkx4fyS+XQTVGQRvOazs+8WcE7Xv73rYLBOcdFmNmKG
	 af9gJSS2RmM3shcUHlhtfcODVO55hU3TD4qKVX+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 555/957] clk: qcom: dispcc-glymur: Fix DSI byte clock rate setting
Date: Wed, 20 May 2026 18:17:18 +0200
Message-ID: <20260520162146.568484312@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251759-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1D68259A28E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[ Upstream commit 98ea9eda030587601db56425efcd32263d853591 ]

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

Fixes: b4d15211c408 ("clk: qcom: dispcc-glymur: Add support for Display Clock Controller")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260304-topic-dsi_byte_fixup-v1-1-b79b29f83176@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/dispcc-glymur.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-glymur.c b/drivers/clk/qcom/dispcc-glymur.c
index f352165bf56fc..bef74f58405ba 100644
--- a/drivers/clk/qcom/dispcc-glymur.c
+++ b/drivers/clk/qcom/dispcc-glymur.c
@@ -747,7 +747,6 @@ static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
 			&disp_cc_mdss_byte0_clk_src.clkr.hw,
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_regmap_div_ops,
 	},
 };
@@ -762,7 +761,6 @@ static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
 			&disp_cc_mdss_byte1_clk_src.clkr.hw,
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_regmap_div_ops,
 	},
 };
-- 
2.53.0




