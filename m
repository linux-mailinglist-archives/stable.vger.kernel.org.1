Return-Path: <stable+bounces-218733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJXQNOZUnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D26A18FE36
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9F56310969A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBC1265CBE;
	Wed, 25 Feb 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xDUdansd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB424A05D;
	Wed, 25 Feb 2026 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983599; cv=none; b=Qh/26R2Js+94WSPvjwycDCiAfhA5/1Tr2zsXTXXcezyN0JscaluK7BSsTZ+TqA71PGcHxyuqeWVObedf8rPA3cuvzDTSNXhQI+6gCRnR3d8nFUnz44dWMkiyv5yLN/G4V13yQijju/4ev6zAfwq/NIQ3XcXGEPjz7Eogpu1hb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983599; c=relaxed/simple;
	bh=3bVqC6/Yvy472xeg7DedlVacl8sM2ofssoZMi75U/qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+Dm/qrJ+Zwcm/ribPRvbL4l8SjEmlAUovMozGSPOzewhBmPoOYy9J5+g0vMslRCZO0ljgIO+jVNDwF27Gmquv2WFfA9baDwnMI4lsyLbynwWwJyuQ3ozWlvlVC+msY/C2zdtw7b+rW2JshBaI7DpRKxd1HPkFgagQ+mENHwloM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xDUdansd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF51EC116D0;
	Wed, 25 Feb 2026 01:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983598;
	bh=3bVqC6/Yvy472xeg7DedlVacl8sM2ofssoZMi75U/qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xDUdansdkP+UCtOvx3ChYFpaiPPpIzjbt8aIzN46/qioH1IIFLja1D6d9IAwkwbcH
	 dywsVoFNoDFo9ri4bSJn00FXN48T5OiQUU52RHwdY42HQnmZrzILnS25z5teBPvJmW
	 m0Wfs4t8SEenv9TmD9sbhoFBJmlzWWM8RQNmd6z0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 671/781] net: psp: select CONFIG_SKB_EXTENSIONS
Date: Tue, 24 Feb 2026 17:23:00 -0800
Message-ID: <20260225012416.241563764@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218733-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,arndb.de,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: 4D26A18FE36
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 6e980df452169f82674f2e650079c1fe0aee343d ]

psp now uses skb extensions, failing to build when that is disabled:

In file included from include/net/psp.h:7,
                 from net/psp/psp_sock.c:9:
include/net/psp/functions.h: In function '__psp_skb_coalesce_diff':
include/net/psp/functions.h:60:13: error: implicit declaration of function 'skb_ext_find'; did you mean 'skb_ext_copy'? [-Wimplicit-function-declaration]
   60 |         a = skb_ext_find(one, SKB_EXT_PSP);
      |             ^~~~~~~~~~~~
      |             skb_ext_copy
include/net/psp/functions.h:60:31: error: 'SKB_EXT_PSP' undeclared (first use in this function)
   60 |         a = skb_ext_find(one, SKB_EXT_PSP);
      |                               ^~~~~~~~~~~
include/net/psp/functions.h:60:31: note: each undeclared identifier is reported only once for each function it appears in
include/net/psp/functions.h: In function '__psp_sk_rx_policy_check':
include/net/psp/functions.h:94:53: error: 'SKB_EXT_PSP' undeclared (first use in this function)
   94 |         struct psp_skb_ext *pse = skb_ext_find(skb, SKB_EXT_PSP);
      |                                                     ^~~~~~~~~~~
net/psp/psp_sock.c: In function 'psp_sock_recv_queue_check':
net/psp/psp_sock.c:164:41: error: 'SKB_EXT_PSP' undeclared (first use in this function)
  164 |                 pse = skb_ext_find(skb, SKB_EXT_PSP);
      |                                         ^~~~~~~~~~~

Select the Kconfig symbol as we do from its other users.

Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
Link: https://patch.msgid.link/20260216105500.2382181-1-arnd@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/psp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/psp/Kconfig b/net/psp/Kconfig
index 371e8771f3bd3..84d6b0f254606 100644
--- a/net/psp/Kconfig
+++ b/net/psp/Kconfig
@@ -6,6 +6,7 @@ config INET_PSP
 	bool "PSP Security Protocol support"
 	depends on INET
 	select SKB_DECRYPTED
+	select SKB_EXTENSIONS
 	select SOCK_VALIDATE_XMIT
 	help
 	Enable kernel support for the PSP Security Protocol (PSP).
-- 
2.51.0




