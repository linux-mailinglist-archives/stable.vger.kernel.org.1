Return-Path: <stable+bounces-258457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEEMKbknG2qS/ggAu9opvQ
	(envelope-from <stable+bounces-258457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:08:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC39461112A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C9E83005312
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938093112C1;
	Sat, 30 May 2026 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EOdwB7uE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806483AE18D;
	Sat, 30 May 2026 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164414; cv=none; b=J2tFh+GwXWYU3ae7uLKMW6B1cm5fFSqIcLWymr89v8H9Y6MI2ELfIS8Y6adf8RHMbQ+aMC3CIWCjnKhTatZrninAdoDSTz6J+TYPrJ+ba7FhJ5AF2XWwKMNiIPe4SPFX0Rlc14EWlCOEi+MlQ5QEl/3OZFdgALkhBbrgLlfJaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164414; c=relaxed/simple;
	bh=Bt37Ndx0DbPL7pKXgi7WwvF/MQspstrH1bZV6jaZ/u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBJ33nTk81HX5eOPHqHDzVnL0eQsqAGW6U9wPQZgYEtJLlXGzJhlBpZ455+rkXGFwnogOo1MgCTHonQJemlufmnj8f60J1PD2EWlUR/HwHpXa1Da6oO8jDmSUOjCIRk8Nxrbz1nReM3uPIQsUgWNUSr5muO6BIkgdcP4OmllE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EOdwB7uE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D701F00893;
	Sat, 30 May 2026 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164413;
	bh=sfyYpHp+7b33fmh87q4MSIiNYmoQskbdoU6aX1YtWQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EOdwB7uE68yzaixOLiPZiihSbH7cPFgJCPvWQqtlG98aWl2ehDKF1mIe654JsZYoR
	 6tjOCk5Yx7eEFBSgTZFRrrsiZdhqGbfcQ7R6smryRvEK/kk1ykL+XC7Pskgwc5hvrz
	 Q3VdOqHjmo9OLl6fJXBn6kCu8WppFbI2z+CcF6q4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Brian Masney <bmasney@redhat.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 547/776] clk: xgene: Fix mapping leak in xgene_pllclk_init()
Date: Sat, 30 May 2026 18:04:21 +0200
Message-ID: <20260530160254.304898718@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258457-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BC39461112A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 857217cbcef87..7dd3aa955484a 100644
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




