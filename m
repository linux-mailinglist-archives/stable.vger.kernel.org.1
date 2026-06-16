Return-Path: <stable+bounces-264351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id frgGKfl1MWqdjwUAu9opvQ
	(envelope-from <stable+bounces-264351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:12:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED5691CF7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:12:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=asE3I1Dy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264351-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264351-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BFE030EB5C5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF2944D6B2;
	Tue, 16 Jun 2026 15:57:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FA844DB95;
	Tue, 16 Jun 2026 15:57:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625429; cv=none; b=dOPGQJOvChoERUqw9xPK9SAx98Ne6r3SBs0ELFXkjKVXfHJ+Io4lATIAwx5rNHymtUMDXTn4B/CFWdSNT/z5AOlNRVOHWy4BS+i02P74H9zT7GAQ4/s7NcRwqxUlFXlNGAttfuvcUHdT2jnIbjw644BSzlkLD+IM7Q5GbHknT0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625429; c=relaxed/simple;
	bh=pgBiB8hfYOxaZuq3HdqPD9ODJqasZo9hpjPDAE7c5Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4pgZniNyHFHCmGHJ7gN4Wv977UoQaT/BwaIy/6iU9z/5KEc1EoBNomqf8hsZ+m+CE2U5+U9QPQkmCII6GHbTFbIvTvbjgWXhGMmZ2hWbKh8phU3WqXwYL0I9GkS1nQzdbz7IEbTnrb6FhxVc+MXGrqCUom3TeVMYyWQxU2nQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=asE3I1Dy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B2A1F000E9;
	Tue, 16 Jun 2026 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625428;
	bh=hXdjKc8qtYnEDc5MfSaAE4qhqjmciGuzUn4IM/g/4lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=asE3I1DyW8YZTGE/yH71W5658D3pf+bT9/5e0qw8Rq6I/x6uxDJIqAVXmRMxXPTHE
	 XThjnYLEHdVorGlY7h1p3JavPL47hYcE75awlP/veQcZElg/3T951LuYP2Ey+2ZTk+
	 SZtdvwKBNhnVjOGMfZ55lOZY4DHqtp+M2Gc5ugFQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 140/325] clk: samsung: gs101: Fix missing USI7_USI DIV clock in peric0_clk_regs
Date: Tue, 16 Jun 2026 20:28:56 +0530
Message-ID: <20260616145104.705369664@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linaro.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-264351-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:visitorckw@gmail.com,m:peter.griffin@linaro.org,m:tudor.ambarus@linaro.org,m:krzk@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,linaro.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CED5691CF7

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 78ee734b36284d82454e87a92094fdb926985b47 ]

In the peric0_clk_regs array, the divider register offset for USI6 was
accidentally listed twice, while the divider for USI7 was omitted.

Missing this DIV register causes the USI7 clock divider setting to be
lost and reset to its hardware default value during a suspend/resume
cycle.

Replace the duplicated USI6 DIV entry with the correct USI7 DIV
register.

Fixes: 893f133a040b ("clk: samsung: gs101: add support for cmu_peric0")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://patch.msgid.link/20260505171457.1960837-1-visitorckw@gmail.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-gs101.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 70b26db9b95ad0..cd2bf64e08c529 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -3602,7 +3602,7 @@ static const unsigned long peric0_clk_regs[] __initconst = {
 	CLK_CON_DIV_DIV_CLK_PERIC0_USI4_USI,
 	CLK_CON_DIV_DIV_CLK_PERIC0_USI5_USI,
 	CLK_CON_DIV_DIV_CLK_PERIC0_USI6_USI,
-	CLK_CON_DIV_DIV_CLK_PERIC0_USI6_USI,
+	CLK_CON_DIV_DIV_CLK_PERIC0_USI7_USI,
 	CLK_CON_DIV_DIV_CLK_PERIC0_USI8_USI,
 	CLK_CON_BUF_CLKBUF_PERIC0_IP,
 	CLK_CON_GAT_CLK_BLK_PERIC0_UID_PERIC0_CMU_PERIC0_IPCLKPORT_PCLK,
-- 
2.53.0




