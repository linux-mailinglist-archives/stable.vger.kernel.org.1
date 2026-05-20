Return-Path: <stable+bounces-252589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADvlLwonDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:26:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFD59AD91
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA48B3309863
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454D37DE8A;
	Wed, 20 May 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="06WJMmSN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6E29B78D;
	Wed, 20 May 2026 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301071; cv=none; b=dOUW52vJanCka327m/sPan669QiqqaxzCvoPcKQD0SMpGJ3giJTigePWbANblyw9Cep+b4RhRDbIaOGKRYCPDa5SuWVjgCnz/6Hkafy2FHu42jefehzAEfwXu8+fORZjYdm1CLDCkMXZkWm9Z3oOiSAsEc4g+Uj4vaFhkPx2fSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301071; c=relaxed/simple;
	bh=SZ9bRH1SQB1bHj50+06CFESm0G6Vjok0beSIVcsnOs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQtbJ+l/AJ+8k3T44BRLP6t61+K+d9DN3c3GSfLf7WOh49XCSjt0MuqfZ9dg32XQE7ZMkM0BpQEo2PDxZus837USV/XZPXpHDZUUpWWlokZRMKq8CWGVMBrzhgDhqwfm+5Ppm4PC676UooiEAhKsj198IIUliG7/BSTu0DcLU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=06WJMmSN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8904C1F000E9;
	Wed, 20 May 2026 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301070;
	bh=ArCpwfTxiRUSMgr3YoSRzRjPYPMe8jT48x/LAKxXF+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=06WJMmSNuTwRO/LhZuxLuK2YVOCEqK8mwzLiRam6379zFNDtzAUIxizG7+Mpp7P+h
	 BXlZe8XhYSiFWy+igRH9R7l3KSeOhsuJObfWnGp5wcqnxASMVt/AuRWBL4JetrNQOq
	 9ezw/HSV26grX4oXTltewScDkOtbOj5QFAuERfWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 388/666] leds: lgm-sso: Remove duplicate assignments for priv->mmap
Date: Wed, 20 May 2026 18:19:59 +0200
Message-ID: <20260520162119.665203559@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252589-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 1CFFD59AD91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 7186d0330c3f3e86de577687a82f4ebd96dcb5ac ]

Remove duplicate assignment of priv->mmap in intel_sso_led_probe().

Fixes: fba8a6f2263b ("leds: lgm-sso: Fix clock handling")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://patch.msgid.link/20260226033048.3715915-1-nichen@iscas.ac.cn
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/blink/leds-lgm-sso.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/leds/blink/leds-lgm-sso.c b/drivers/leds/blink/leds-lgm-sso.c
index 7b04ea1462605..330cd46194659 100644
--- a/drivers/leds/blink/leds-lgm-sso.c
+++ b/drivers/leds/blink/leds-lgm-sso.c
@@ -806,8 +806,6 @@ static int intel_sso_led_probe(struct platform_device *pdev)
 
 	priv->fpid_clkrate = clk_get_rate(priv->clocks[1].clk);
 
-	priv->mmap = syscon_node_to_regmap(dev->of_node);
-
 	priv->mmap = syscon_node_to_regmap(dev->of_node);
 	if (IS_ERR(priv->mmap)) {
 		dev_err(dev, "Failed to map iomem!\n");
-- 
2.53.0




