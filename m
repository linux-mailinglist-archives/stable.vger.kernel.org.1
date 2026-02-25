Return-Path: <stable+bounces-218579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMp4G71Tnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD44918F9DA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C15653090EC7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2D25EF9C;
	Wed, 25 Feb 2026 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SctYjXBx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E9D254B03;
	Wed, 25 Feb 2026 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983422; cv=none; b=NivibQt2rJHu5dAo+Eb/Q1KUymEhug0bmrrqwhYv9MYEH8+cpunK+VulKiDUdxR4xE14w3CjrbHx5Mxhgf2edqOlCOXNpAPx8Oiiqxnc2UPokUAj1cVv33zv6xkerN9BBJnkqP0x2C6esrLjEHpGGHlP34Cnwy4AsWBtPxE85fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983422; c=relaxed/simple;
	bh=fF7LYvZtwrOJ00/H4DSbl2L/aRPQiOJdCShFaAes/1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlyFwbJXPj7lDXT8GOOo4xOiC0r0IARdz13szhvrOoKOoQ+j4zCbfl5cstnmrcQ9JU+VP2dE7VYAdPQVyNa4aL9CLZaQwMm3xPXN21L99myL/Xdxp42e0dIwZfebC+vR+LaFxY7wWAhlxz6x0eXAIFW7lEI7rByNYN0tL1iMouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SctYjXBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9662EC116D0;
	Wed, 25 Feb 2026 01:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983421;
	bh=fF7LYvZtwrOJ00/H4DSbl2L/aRPQiOJdCShFaAes/1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SctYjXBx5+xIZAw5+TFcSuOYF+Fz+hbo2YTNgNPmRvp3pHx9M0E6dYSaK1g6QmUim
	 0orOFTgdl4p43thyKiTIh2kQl3tZpEyxcIPcP/6YuR5af68kTMT1GneBoHgcr7di49
	 y+JEE9FV5chRwWCdvF4woN3WsKje9Jp3++/rRgA8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 542/781] clk: hisilicon: clkdivider-hi6220: convert from divider_round_rate() to divider_determine_rate()
Date: Tue, 24 Feb 2026 17:20:51 -0800
Message-ID: <20260225012413.089682552@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218579-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD44918F9DA
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit e3a5249c140a1ded55937ba04247d530a85f0edc ]

The divider_round_rate() function is now deprecated, so let's migrate
to divider_determine_rate() instead so that this deprecated API can be
removed.

Note that when the main function itself was migrated to use
determine_rate, this was mistakenly converted to:

    req->rate = divider_round_rate(...)

This is invalid in the case when an error occurs since it can set the
rate to a negative value.

Fixes: 619a6210f398 ("clk: hisilicon: clkdivider-hi6220: convert from round_rate() to determine_rate()")
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/hisilicon/clkdivider-hi6220.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/hisilicon/clkdivider-hi6220.c b/drivers/clk/hisilicon/clkdivider-hi6220.c
index 6bae18a84cb6c..fd7ceb92d6515 100644
--- a/drivers/clk/hisilicon/clkdivider-hi6220.c
+++ b/drivers/clk/hisilicon/clkdivider-hi6220.c
@@ -60,10 +60,8 @@ static int hi6220_clkdiv_determine_rate(struct clk_hw *hw,
 {
 	struct hi6220_clk_divider *dclk = to_hi6220_clk_divider(hw);
 
-	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate, dclk->table,
-				       dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
-
-	return 0;
+	return divider_determine_rate(hw, req, dclk->table, dclk->width,
+				      CLK_DIVIDER_ROUND_CLOSEST);
 }
 
 static int hi6220_clkdiv_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.51.0




