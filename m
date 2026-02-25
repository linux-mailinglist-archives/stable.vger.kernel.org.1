Return-Path: <stable+bounces-219346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGlWIESinmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:18:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E46201932FA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C65F531924B3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6740030CD94;
	Wed, 25 Feb 2026 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O0BDIxra"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC37304BB4;
	Wed, 25 Feb 2026 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002655; cv=none; b=ZAsqHLMJbjXi49eugwoSAsTrIBK+0LrLgd7jBNr80CQdVI9onqulowi4+YHeTzoKkz3VgvINjHL+ZaF3eGcLGg5UlZksbjZqcCgtp3Vn1tVyqQlq2tEyN3w1u5BqsJlRwhI/ld10nBuFsjObmIPz+bzPcy/P0X9Jxth6FYRxxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002655; c=relaxed/simple;
	bh=N5IOQGxSJ6kRwgswntdafO0yP7Lu7nhOUotfYOJaSQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+PJMd0BPhsBdetE7WU2CpukeIVyzIQc5cyrwlZGzlyrrdtPS4ipeOSKoliLsT60lpTLB/Ah5oSPyrjkKWo32wlKzpPHUQk9+zMEqGgAE1QEoi6S5oOuOwNzqQOUQpBfqJXh3smjeqMf9RoBT84q9raL9ABYIx1ZT4hxQEmCd0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O0BDIxra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CFCC116D0;
	Wed, 25 Feb 2026 06:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002655;
	bh=N5IOQGxSJ6kRwgswntdafO0yP7Lu7nhOUotfYOJaSQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0BDIxra928MDpT35dZqzsCB0fBua9leYMzYNr7SMNM5Z7uciHOxrFLWT+GMBfHoa
	 ckUDyMKIchM+4k6flO/ARxh5+1HybgzVtgg1A1+raAxL6ChsRFrSAZQzUekA8cP/rm
	 iWfXLKfqtzpMfhkInpCf3g4nkZKsMtn0iH9k/0nc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <mani@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 431/641] clk: actions: owl-divider: convert from divider_round_rate() to divider_determine_rate()
Date: Tue, 24 Feb 2026 17:22:37 -0800
Message-ID: <20260225012358.985455892@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219346-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,linuxfoundation.org:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E46201932FA
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit 3ff3360440fa8cc7ef5a4da628d3b770b46a4f73 ]

The divider_round_rate() function is now deprecated, so let's migrate
to divider_determine_rate() instead so that this deprecated API can be
removed. Additionally, owl_divider_helper_round_rate() is no longer used,
so let's drop that from the header file as well.

Note that when the main function itself was migrated to use
determine_rate, this was mistakenly converted to:

    req->rate = divider_round_rate(...)

This is invalid in the case when an error occurs since it can set the
rate to a negative value.

Fixes: 1b04e12a8bcc ("clk: actions: owl-divider: convert from round_rate() to determine_rate()")
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/actions/owl-divider.c | 17 ++---------------
 drivers/clk/actions/owl-divider.h |  5 -----
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/actions/owl-divider.c b/drivers/clk/actions/owl-divider.c
index 118f1393c6780..316ace80e87e3 100644
--- a/drivers/clk/actions/owl-divider.c
+++ b/drivers/clk/actions/owl-divider.c
@@ -13,26 +13,13 @@
 
 #include "owl-divider.h"
 
-long owl_divider_helper_round_rate(struct owl_clk_common *common,
-				const struct owl_divider_hw *div_hw,
-				unsigned long rate,
-				unsigned long *parent_rate)
-{
-	return divider_round_rate(&common->hw, rate, parent_rate,
-				  div_hw->table, div_hw->width,
-				  div_hw->div_flags);
-}
-
 static int owl_divider_determine_rate(struct clk_hw *hw,
 				      struct clk_rate_request *req)
 {
 	struct owl_divider *div = hw_to_owl_divider(hw);
 
-	req->rate = owl_divider_helper_round_rate(&div->common, &div->div_hw,
-						  req->rate,
-						  &req->best_parent_rate);
-
-	return 0;
+	return divider_determine_rate(hw, req, div->div_hw.table,
+				      div->div_hw.width, div->div_hw.div_flags);
 }
 
 unsigned long owl_divider_helper_recalc_rate(struct owl_clk_common *common,
diff --git a/drivers/clk/actions/owl-divider.h b/drivers/clk/actions/owl-divider.h
index 083be6d80954d..2ba957740c381 100644
--- a/drivers/clk/actions/owl-divider.h
+++ b/drivers/clk/actions/owl-divider.h
@@ -56,11 +56,6 @@ static inline struct owl_divider *hw_to_owl_divider(const struct clk_hw *hw)
 	return container_of(common, struct owl_divider, common);
 }
 
-long owl_divider_helper_round_rate(struct owl_clk_common *common,
-				const struct owl_divider_hw *div_hw,
-				unsigned long rate,
-				unsigned long *parent_rate);
-
 unsigned long owl_divider_helper_recalc_rate(struct owl_clk_common *common,
 					 const struct owl_divider_hw *div_hw,
 					 unsigned long parent_rate);
-- 
2.51.0




