Return-Path: <stable+bounces-219384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED+cD+GfnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:08:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 930B3193000
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 156EE31B6BA8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7D12D7810;
	Wed, 25 Feb 2026 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XNqAXX+A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250D2D4805;
	Wed, 25 Feb 2026 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002680; cv=none; b=lG4lDD7plCjgVmCGnSmlc3oVSSLSg3+M9RPbpOzGbpKws1Hz3xya+3u0OWpGM/fTcXTOBAhzIv/8TUc7w7g6UppEHybqNzkdApKRdHmwP2iPtBA8axTWU7N5YyjuMjnDRlUGFcqE1lsRVPU3DNuCz37+8MUlK3UOUKuI4/pwBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002680; c=relaxed/simple;
	bh=SZYui6kSxZhDs3JICCVCRCOOwEuyaFA/2CfCyZ5MxqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aqmf7jqBbtq46/4poqVQxmiEhGRzmxk3mMsunaB0Q+1nzIBFm5LyZXpeLK2UzUtu5pflI6iV4Fh3sIIFaPQf3aaZcR6CKrdQ7o0AF9efVOgwAcewtyM0Gvkr6ta00KAQVUBhnVSssYbaoktieNX5L4LHGW/dLNM9lTHHoBIP9YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XNqAXX+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6F3C116D0;
	Wed, 25 Feb 2026 06:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002680;
	bh=SZYui6kSxZhDs3JICCVCRCOOwEuyaFA/2CfCyZ5MxqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNqAXX+A/qQ+PS+4fWzRkUtro6m5ZLBvl5chi2iPCfzn+uJUEUsaOno31qAMBuTM2
	 KbJgyvos6+1mmgVNI8/J+JiHJxZePpjJuyo5qyNLTJ5uupbWMKRuNJ2ZTOVL8b6qmw
	 Q+95LvyKdXVPWLztRNd5gSe9uSAuD07tKQ58Fs4M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 425/641] clk: qcom: regmap-divider: convert from divider_ro_round_rate() to divider_ro_determine_rate()
Date: Tue, 24 Feb 2026 17:22:31 -0800
Message-ID: <20260225012358.846261282@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219384-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: 930B3193000
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit 349f02c0f5d4ee147c582b89cadd553bd534028a ]

The divider_ro_round_rate() function is now deprecated, so let's migrate
to divider_ro_determine_rate() instead so that this deprecated API can
be removed.

Note that when the main function itself was migrated to use
determine_rate, this was mistakenly converted to:

    req->rate = divider_round_rate(...)

This is invalid in the case when an error occurs since it can set the
rate to a negative value.

Fixes: b6f90511c165 ("clk: qcom: regmap-divider: convert from round_rate() to determine_rate()")
Signed-off-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260108-clk-divider-round-rate-v1-15-535a3ed73bf3@redhat.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/clk-regmap-divider.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-regmap-divider.c b/drivers/clk/qcom/clk-regmap-divider.c
index 4f5395f0ab6d0..af9c01dd78537 100644
--- a/drivers/clk/qcom/clk-regmap-divider.c
+++ b/drivers/clk/qcom/clk-regmap-divider.c
@@ -26,12 +26,8 @@ static int div_ro_determine_rate(struct clk_hw *hw,
 	val >>= divider->shift;
 	val &= BIT(divider->width) - 1;
 
-	req->rate = divider_ro_round_rate(hw, req->rate,
-					  &req->best_parent_rate, NULL,
-					  divider->width,
-					  CLK_DIVIDER_ROUND_CLOSEST, val);
-
-	return 0;
+	return divider_ro_determine_rate(hw, req, NULL, divider->width,
+					 CLK_DIVIDER_ROUND_CLOSEST, val);
 }
 
 static int div_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
-- 
2.51.0




