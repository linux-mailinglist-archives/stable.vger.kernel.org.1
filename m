Return-Path: <stable+bounces-251710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJrkBn4ADmp+5QUAu9opvQ
	(envelope-from <stable+bounces-251710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:42:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E5597065
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BA7B3038D47
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F83AE6E6;
	Wed, 20 May 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JL07drsg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A315E8B;
	Wed, 20 May 2026 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298691; cv=none; b=sTfLvF4XGkT8Pgl8NBe50wwOPwFAIOXfGJMEXRiPJk2W6yjsg1Z0y7W4Zc1j7TMQ9f5rdI3EmzgOmVby+brS31W0NmoFqveiQNL24bR6JwO7QLjFXXpvPWuVjuH11e/1D74QO17kUl82lNAmF0R+dTxwSZqatpNEYtv84jR+e4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298691; c=relaxed/simple;
	bh=4AjdCIT6Kpf06OY89UASPI3Hb50l7ft1Jf3ReR1HvXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzQXDzkI2m846X0+s0z79haoJochNiqZhLmo3oLhhAL1u9utJW/w9/agxCLczeYay2KNJCAfSl7VykgJseOEqjmpsvYGGizeIzhwQsq1GshFuIknGwm5vVsZVBcXVlLomwBSllvSDacs/NnQo/N0JGkwYdDJ3sIGSxGX7WcRUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JL07drsg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0DA1F000E9;
	Wed, 20 May 2026 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298690;
	bh=/S2x8Vr8k/J5RC9M1KvyovMpOqOn6bZSARe2NBZm8z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JL07drsgjd8mfZlVXZ1s95lJJ3j8RckJYwwTbA7PrebdeGDBZEVQEovVx7DKFPjR+
	 8QjPXxwdqvqOXbXUiKErtsjfNWLlfUpCaS/V/4dzEMyXB8pgBHBvm7lrZNlYpzIzWw
	 sLziNh+uO7M75D4qYUyLNo58UPX48ZAr2jw91qdE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 507/957] pinctrl: abx500: Fix type of argument variable
Date: Wed, 20 May 2026 18:16:30 +0200
Message-ID: <20260520162145.528705643@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-251710-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2D7E5597065
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu-Chun Lin <eleanor15x@gmail.com>

[ Upstream commit 34006f77890d050e6d80cbee365b5d703c1140b4 ]

The argument variable is assigned the return value of
pinconf_to_config_argument(), which returns a u32. Change its type from
enum pin_config_param to unsigned int to correctly store the configuration
argument.

Fixes: 03b054e9696c ("pinctrl: Pass all configs to driver on pin_config_set()")
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/nomadik/pinctrl-abx500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index fc7ebeda8440e..858fbaebcf8e5 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -852,7 +852,7 @@ static int abx500_pin_config_set(struct pinctrl_dev *pctldev,
 	int ret = -EINVAL;
 	int i;
 	enum pin_config_param param;
-	enum pin_config_param argument;
+	unsigned int argument;
 
 	for (i = 0; i < num_configs; i++) {
 		param = pinconf_to_config_param(configs[i]);
-- 
2.53.0




