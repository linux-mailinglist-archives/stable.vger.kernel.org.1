Return-Path: <stable+bounces-214255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI9BEA1og2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:38:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB48FE9083
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72B14302AA06
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E93228853E;
	Wed,  4 Feb 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tVA7WEXe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D71C5D57;
	Wed,  4 Feb 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219081; cv=none; b=NIAl9yPcGxBqBHoqM6sXPEoDX9bGm0GANFYUjex1IQExqLcXQCp8+aybCa/JRvDwDltOQzwquJ9LjC6/3E7jMT+819Y/d6+UUJ22s/A0Kzf+NllobBEeQqeNBhBFLt0k1s/aX6OZu3yDJvQZoO/dmNWdTcnvvFiIylcL8bAXheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219081; c=relaxed/simple;
	bh=arIyi38bDZGvvuTyFCRJcdG7W8VwBw34S6KWPrQSKzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMn+MMmBuiI1A+5EeSKCrnep1UvKKliNHbJzj0iyUI7DWyhsNeRDupAPWr2prUxbjF8p+KbekGORewRknkPYzhuKKcJE+MkpqsmjcNXedz1mOx7weZl3uxLPecu1g7b8uaKm1xFO17RbeG54QM3IPurFjxckYKAZesdrfyGaae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tVA7WEXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7262FC4CEF7;
	Wed,  4 Feb 2026 15:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219080;
	bh=arIyi38bDZGvvuTyFCRJcdG7W8VwBw34S6KWPrQSKzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVA7WEXeLkdNQxnOJPYrV9ideNtx9TswVG5BaqyKrA7bQ8Ngds/ECqRU+wb/NJAKK
	 rnvcKUMwHlsxwleV9OEa4F/xx89VU1LGv0zvNQ5RDLUawwrJuz+yXT3dANlpcJNN10
	 gVJ8CAq+fzTC4A2jsXLaN8v+ajIARyiGJilHJpxE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Kaiser <martin@kaiser.cx>,
	Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 028/122] net: bridge: fix static key check
Date: Wed,  4 Feb 2026 15:40:10 +0100
Message-ID: <20260204143852.875393920@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214255-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,blackwall.org:email,kaiser.cx:email]
X-Rspamd-Queue-Id: CB48FE9083
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index e355a15bf5ab1..1405f1061a549 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -274,7 +274,7 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
 	int ret;
 
 	net = dev_net(skb->dev);
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	if (!static_key_false(&nf_hooks_needed[NFPROTO_BRIDGE][NF_BR_PRE_ROUTING]))
 		goto frame_finish;
 #endif
-- 
2.51.0




