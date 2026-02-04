Return-Path: <stable+bounces-213689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLQ2G69hg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:11:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A398DE8146
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E2A31A34BF
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723354218B3;
	Wed,  4 Feb 2026 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vT8Kh6dM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CAD4218B0;
	Wed,  4 Feb 2026 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217176; cv=none; b=OYi7N3NDED7GmLXWYj4ap8uKKA/DZHIizeSXk/c2oBNfmOseNR5ajlyNMgdbt1qHZEo+WMybRF3vDztMKWo7wNOcLB+DprPvwe7nScqpol2iE2xJdf5/uD8cz9HDDwmN87RJqopYytIHlOaMVDZd86TFLuGWCUy62hkVfhw7o3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217176; c=relaxed/simple;
	bh=5IlF6mU2FeDH4x/icbZ9JLO6Sm8oXsrvNHkO5PX4OIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVxSm2QCG0dlv59C/Y/46Tcs2Vtoe4FanQSd8X1bp26hoiJGaNbHMYHPzRw9S4KHTNHFVdV4xg4HA8+eQkK4epeKv+PFelJYNOqFcPgageBCxy2t/cSh65oj5z8QQjtoYAcxR6fCDhFjtFbnkVXDCWlT+z6JLSXF5NiSGJSngHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vT8Kh6dM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8D6C4CEF7;
	Wed,  4 Feb 2026 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217175;
	bh=5IlF6mU2FeDH4x/icbZ9JLO6Sm8oXsrvNHkO5PX4OIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vT8Kh6dMT2IRrgF6yVZoCn1CF4Zj33h5Ono1BUtDHGVZhuI8r9Zi+29Ncq9IZVGEE
	 a8QoEpWhZNLKyAtO1ob0M967Cq49ZTv3v/4kab7AYbq/gAZnbFwZvfA0sUX7qQzxaU
	 JkX+Sk1hs0CM0JqjG8HwR6sEbJa6XcgkTpmc03ko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Kaiser <martin@kaiser.cx>,
	Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 147/206] net: bridge: fix static key check
Date: Wed,  4 Feb 2026 15:39:38 +0100
Message-ID: <20260204143903.499540088@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213689-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,blackwall.org:email,kaiser.cx:email]
X-Rspamd-Queue-Id: A398DE8146
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kaiser <martin@kaiser.cx>

[ Upstream commit cc0cf10fdaeadf5542d64a55b5b4120d3df90b7d ]

Fix the check if netfilter's static keys are available. netfilter defines
and exports static keys if CONFIG_JUMP_LABEL is enabled. (HAVE_JUMP_LABEL
is never defined.)

Fixes: 971502d77faa ("bridge: netfilter: unroll NF_HOOK helper in bridge input path")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20260127101925.1754425-1-martin@kaiser.cx
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index f3d49343f7dbe..14423132a3df5 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -225,7 +225,7 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
 	int ret;
 
 	net = dev_net(skb->dev);
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	if (!static_key_false(&nf_hooks_needed[NFPROTO_BRIDGE][NF_BR_PRE_ROUTING]))
 		goto frame_finish;
 #endif
-- 
2.51.0




