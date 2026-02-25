Return-Path: <stable+bounces-218576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LrNHbhTnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E1118F9BC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84D85315E3EE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC590256C84;
	Wed, 25 Feb 2026 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZiLIKWg9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D61FE45D;
	Wed, 25 Feb 2026 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983418; cv=none; b=f3pEZui5QKub9d6KlcZwsgYsPk3WqtK7CXGGXLukZ8KSjNWFE4w7dlhpfVpYuwta4XhfOfrDenZJJQmkLQ3FzsG/n6gX0r57+bbgAygJkGLl9NkuJX0+aWaLG+haulVIqmkgokeA0RuLBHTNyDgIjEoHVkRNYopG3BCbWZSnpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983418; c=relaxed/simple;
	bh=wVQIg2ryYfiYbmJi9EXjrgkrXJZjjJUsS+YOd3zt2mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViH7tdV6+AXsjEZ/LLPfGCgTtNLIYfMnHCHuJORnvR0gKmAm4pd3xt0VqdppuFe+YHYrr/n9ADA8h/E5rYxf3icKF2Q0KzSktqKtQsC1H4f11GkfExF8TngaZGsAakqWLoxa7s2MtGxdnzWkjf5MrGBZa1JXlQnVf91DHtkug5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZiLIKWg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A04C116D0;
	Wed, 25 Feb 2026 01:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983418;
	bh=wVQIg2ryYfiYbmJi9EXjrgkrXJZjjJUsS+YOd3zt2mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiLIKWg9YAibTnUAwoVq9MChVqmwR58fU61qAc8GfB/HS+8DsXDYx7NMiaq2g+TOP
	 FKnY8eCyBHJKt2fGmuSKwOu0f2aZKsmUID3VF5YJOywO7N2ZGsXaU5oz11x6fXxDLY
	 30feUYQsU04tZETXUkFT8sPAu5NprdZun40B94B4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <mani@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 539/781] clk: actions: owl-composite: convert from owl_divider_helper_round_rate() to divider_determine_rate()
Date: Tue, 24 Feb 2026 17:20:48 -0800
Message-ID: <20260225012413.017786629@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218576-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 18E1118F9BC
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit d0b7c5bf6c5520c35fecff34da83d390405d3eaf ]

owl_divider_helper_round_rate() is just a wrapper for
divider_round_rate(), which is deprecated. Let's migrate to
divider_determine_rate() instead so that this deprecated API can be
removed.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Stable-dep-of: 3ff3360440fa ("clk: actions: owl-divider: convert from divider_round_rate() to divider_determine_rate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/actions/owl-composite.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/actions/owl-composite.c b/drivers/clk/actions/owl-composite.c
index 00b74f8bc4375..9540444307d6c 100644
--- a/drivers/clk/actions/owl-composite.c
+++ b/drivers/clk/actions/owl-composite.c
@@ -57,15 +57,10 @@ static int owl_comp_div_determine_rate(struct clk_hw *hw,
 				       struct clk_rate_request *req)
 {
 	struct owl_composite *comp = hw_to_owl_comp(hw);
-	long rate;
-
-	rate = owl_divider_helper_round_rate(&comp->common, &comp->rate.div_hw,
-					     req->rate, &req->best_parent_rate);
-	if (rate < 0)
-		return rate;
+	struct owl_divider_hw *div = &comp->rate.div_hw;
 
-	req->rate = rate;
-	return 0;
+	return divider_determine_rate(&comp->common.hw, req, div->table,
+				      div->width, div->div_flags);
 }
 
 static unsigned long owl_comp_div_recalc_rate(struct clk_hw *hw,
-- 
2.51.0




