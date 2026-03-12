Return-Path: <stable+bounces-225097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMUuO5sgs2mpSQAAu9opvQ
	(envelope-from <stable+bounces-225097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:22:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49545278E9B
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D997300C5A2
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C33369215;
	Thu, 12 Mar 2026 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M45kXNda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF02ECE9B;
	Thu, 12 Mar 2026 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346943; cv=none; b=aeHFY7A34NU/tra+zBM0aqU5lc64+JbEMl1LMM9cKG6MKRk1KCGG0Ne1xLM6cxBV+DNO404GRQOw9LFUdrhZl735cqAraozSpJC5NZOxsrVrfiGvU7MHeQcLacd+ev+trn21Ea9uMAC36Cy88JOQu1EM3b84Jv5lnncA2jyvwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346943; c=relaxed/simple;
	bh=gifU353o9J35v/g1Q4nXFtEwKKx027Bx+obysLiul0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VypqhSmdALzh1q+667jQcZvB5o2OvJC9LPvOFnH3y1BNGqmqTih03C3VmTCZkaZiSwOlAMATb+aV4S5ehWvRLHJQguPeOZnj/0nBYZJseUR9THG21vrenRulLg8XPgcuGGdtfO8Y53Y4anhwhWV3tkgvApvKBb03eIWaCdve0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M45kXNda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED702C4CEF7;
	Thu, 12 Mar 2026 20:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346943;
	bh=gifU353o9J35v/g1Q4nXFtEwKKx027Bx+obysLiul0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M45kXNda9CRokvzKCKoZ4LNAg7kjHjGDzCScFoPwnuS8k9d+osC2Z5mAbnH4uXdkQ
	 iq1fBhxpMhzI7C2dxepzN2Ozi99x3W15VSGgAWk2A5hY4Go8o0ndvz9QlstRXvn2ak
	 nQX8CUn0o00lKgL84rGJQ5+7syvsJDZObc76nA1c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongliang Wang <wanghongliang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 165/265] net: stmmac: dwmac-loongson: Set clk_csr_i to 100-150MHz
Date: Thu, 12 Mar 2026 21:09:12 +0100
Message-ID: <20260312201024.236580943@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-225097-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,loongson.cn:email]
X-Rspamd-Queue-Id: 49545278E9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit e1aa5ef892fb4fa9014a25e87b64b97347919d37 upstream.

Current clk_csr_i setting of Loongson STMMAC (including LS7A1000/2000
and LS2K1000/2000/3000) are copy & paste from other drivers. In fact,
Loongson STMMAC use 125MHz clocks and need 62 freq division to within
2.5MHz, meeting most PHY MDC requirement. So fix by setting clk_csr_i
to 100-150MHz, otherwise some PHYs may link fail.

Cc: stable@vger.kernel.org
Fixes: 30bba69d7db40e7 ("stmmac: pci: Add dwmac support for Loongson")
Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://patch.msgid.link/20260203062901.2158236-1-chenhuacai@loongson.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -86,7 +86,7 @@ static void loongson_default_data(struct
 	/* Get bus_id, this can be overwritten later */
 	plat->bus_id = pci_dev_id(pdev);
 
-	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
+	plat->clk_csr = 1;	/* clk_csr_i = 100-150MHz & MDC = clk_csr_i/62 */
 	plat->has_gmac = 1;
 	plat->force_sf_dma_mode = 1;
 



