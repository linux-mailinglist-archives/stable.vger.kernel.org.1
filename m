Return-Path: <stable+bounces-252593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLK+EBQnDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-252593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:26:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B205C59ADAF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D16A332AC7C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AAF37DE8A;
	Wed, 20 May 2026 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1giTaLdm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22BB29B78D;
	Wed, 20 May 2026 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301081; cv=none; b=fd7YSqK9NgH0TAB7fQKtm06hB+36az3gaa+E4rXhWAAuQ9E6TDr9IRrOa96nlCAcM2ZaDl6U8YqQqWYrtsPs48EvwLO7ZSleIATjhJkMcWm7VXVbeiiKBa6mjy9qkjyXtVnm3kbJjymRmV7t18mBnp/5db+RabObRdZAJ9jRUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301081; c=relaxed/simple;
	bh=tlJUM7LmXo0VTDFNxFFLQKOLBIFQyTH3tzjwOPx6lOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5ssktp4tZ0p2d5nazw+L2ivFO7XYpHoNg0kuNOdnHmXd18fOy9DMPxTSQ069QwezGDT2vUilB/z+amLIwPjtVTw6d/SviZlKJbRTNoh/3sQVa3rrnZft/0ngm74VhVTQMM41UO539TaurDPb9VKEUcEmMNMQ5bpWCC8oHxOvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1giTaLdm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143071F000E9;
	Wed, 20 May 2026 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301080;
	bh=JyD6uUDakjcPaDsqOu1UYpvrR4Fzk27qrc/usD1V5Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1giTaLdmgHnDFCLBok//Fit/Xr/QEoLw783nMJGgiE9RZgx/LJBG3A2osCNZMvoBZ
	 WIz9tJHIdMn7+zQu11UNaEjhs4JlWqnfBV3R3/PG1GM8G1v9wd2sTMUo2r9MlYrbMC
	 TNnpPIMuagWsAEeKGymXPCQlGase3eOxe3tVaRWk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Brian Masney <bmasney@redhat.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 418/666] clk: xgene: Fix mapping leak in xgene_pllclk_init()
Date: Wed, 20 May 2026 18:20:29 +0200
Message-ID: <20260520162120.326870570@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252593-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,glider.be:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B205C59ADAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit f520a492e07bc6718e26cfb7543ab4cadd8bb0e2 ]

If xgene_register_clk_pll() fails, the mapped register block is never
unmapped.

Fixes: 308964caeebc45eb ("clk: Add APM X-Gene SoC clock driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-xgene.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
index 0c3d0cee98c83..a542b78d9c731 100644
--- a/drivers/clk/clk-xgene.c
+++ b/drivers/clk/clk-xgene.c
@@ -187,6 +187,8 @@ static void xgene_pllclk_init(struct device_node *np, enum xgene_pll_type pll_ty
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 		clk_register_clkdev(clk, clk_name, NULL);
 		pr_debug("Add %s clock PLL\n", clk_name);
+	} else {
+		iounmap(reg);
 	}
 }
 
-- 
2.53.0




