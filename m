Return-Path: <stable+bounces-220586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEQzNHw/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:18:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBE21C6CE7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8189630F027C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBCB3DFC61;
	Sat, 28 Feb 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6UMvXBx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27FB3DEAAE;
	Sat, 28 Feb 2026 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300469; cv=none; b=As+oryx8sU5ugSgXZGrGsA12GpsydfoZ96n92g7M/cEpA6aVRpuYjOgWuEsKaMSrX3szXiU25eftAWO9cJE0v/YxrvzIvI+12a1bq+/Nnnv4znffyH5+xr0DXScR6gFFCkLl6No0RrbdYFpWqYmLDLBF0a1bxYa7EpY4k++kO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300469; c=relaxed/simple;
	bh=p9/AMJMKGGl78rdr2Pf3AjZ6BpFq4chl9Uva3fCCGl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPKx0BgI7MwnGeQLvaYVQSbaq3fgORAI4rt6tpnt36BqnWuP+vE6KAsht3SZcdXVj68k2+pS3WIjLhQMjeNh2P9LBGaQN4gQ7DSxGVzPqZ/eH3a4/yzLQnjt3tMCCADN/KOqbDcWDBXAaBMjO+z05dAXb3MWxQqM8un+1YCSkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6UMvXBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB5AC19424;
	Sat, 28 Feb 2026 17:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300468;
	bh=p9/AMJMKGGl78rdr2Pf3AjZ6BpFq4chl9Uva3fCCGl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6UMvXBxHGKO42c0iWhX4B+NY5Ci7lDCxxScd+OavqvhBrlzKm1+DyXd8bneqlieY
	 SPAozLm67GvjRyRJu1nmZcY4OX+Gr4MNYW8AEqxy3l/TtbElTwFHhHOGCkoD/cYuFl
	 rC192z2vHly7/aNoTsdiqUYaVzCgsMRLSGebweGSzR+E4p0yVgYzU+ILn0xksnUZkn
	 fGb32OgXUf8wTRP+IKHO54dwb+Bx1v/Fqax7Gc08M8Jl981tEI6cX/ydUUKBR3ogKE
	 q/rgyOV1wvcv9TciI1oRknlJ4JDgFRbvnfbwcTQPiFx8YSwjXSaDHLR4TKwnjomIYE
	 tvisWOzGBRomQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chris Brandt <chris.brandt@renesas.com>,
	stable@kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 507/844] clk: renesas: rzg2l: Select correct div round macro
Date: Sat, 28 Feb 2026 12:27:00 -0500
Message-ID: <20260228173244.1509663-508-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220586-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email,glider.be:email]
X-Rspamd-Queue-Id: 2BBE21C6CE7
X-Rspamd-Action: no action

From: Chris Brandt <chris.brandt@renesas.com>

[ Upstream commit f9451374dcfdfe669ee55b58ee6c11e8638980e4 ]

Variable foutvco_rate is an unsigned long, not an unsigned long long.

Cc: stable@kernel.org
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/CAMuHMdVf7dSeqAhtyxDCFuCheQRzwS-8996Rr2Ntui21uiBgdA@mail.gmail.com
Fixes: dabf72b85f29 ("clk: renesas: rzg2l: Fix FOUTPOSTDIV clk")
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251114194529.3304361-1-chris.brandt@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/rzg2l-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index de58a960a922b..f670c6408ea15 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -572,8 +572,8 @@ rzg2l_cpg_get_foutpostdiv_rate(struct rzg2l_pll5_param *params,
 	foutvco_rate = div_u64(mul_u32_u32(EXTAL_FREQ_IN_MEGA_HZ * MEGA,
 					   (params->pl5_intin << 24) + params->pl5_fracin),
 			       params->pl5_refdiv) >> 24;
-	foutpostdiv_rate = DIV_ROUND_CLOSEST_ULL(foutvco_rate,
-						 params->pl5_postdiv1 * params->pl5_postdiv2);
+	foutpostdiv_rate = DIV_ROUND_CLOSEST(foutvco_rate,
+					     params->pl5_postdiv1 * params->pl5_postdiv2);
 
 	return foutpostdiv_rate;
 }
-- 
2.51.0


