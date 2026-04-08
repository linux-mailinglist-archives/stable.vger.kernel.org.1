Return-Path: <stable+bounces-234887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGJLGpaj1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:51:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DA03C1C19
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAF7D30B70C9
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7E33D9022;
	Wed,  8 Apr 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="avg4SxUF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1A2641FC;
	Wed,  8 Apr 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674020; cv=none; b=KxAOCJ13fyqm/rkL3JlyrjDsSevUEKrq07pBFjxUP3uqXpLBwSue+Exx3o6TViwwJ5kfxkj+fVHiSeb2zwFw+WPNR5AvQZffpMR3as0fKtVaRAyvGKpScgJ6wUCetxolQNH/zYA7Hh9WbuLj2mAJnBpvJie1HUZlW1/PA48BBR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674020; c=relaxed/simple;
	bh=KV85lPvQuesDA76/kzrrzYFLVv7aULxauAo7iJcQmNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RY4LYHJ1jYmvtcCT8NFe4eN05y59MWbSN6YHlzqjvqYgZ6zM6KVvAq3NuIapCbZUJMeZYRF+FMcVsD3jF6mIUeS+iRNQpLWZupsLpQfCGQxCdszXO5HBpHZKo07t30U8qJeIl37gTY4fmCfhwsed9MN41s8PUUIZFzI+wgFgcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=avg4SxUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A147EC19421;
	Wed,  8 Apr 2026 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674020;
	bh=KV85lPvQuesDA76/kzrrzYFLVv7aULxauAo7iJcQmNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avg4SxUF0sK68LqjE7S4N/FBFafGQKZCXTPvSwqL+kLjdvuXf1YOVPfpT1S2YdKZo
	 qvjNcbUHhLyNE6k8KS4q0/Dx0vCfci5bf9wCNBr/ZQwPdJnQUQkI6Ox7sR7TJhoqkw
	 Gd2RolZj8v0aegft/YY5JH2W5uWLBPaiYfdd88+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	Yuan Tan <tanyuan98@outlook.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 171/242] bridge: br_nd_send: validate ND option lengths
Date: Wed,  8 Apr 2026 20:03:31 +0200
Message-ID: <20260408175933.487987293@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,outlook.com,nvidia.com,blackwall.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-234887-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,blackwall.org:email,msgid.link:url,outlook.com:email]
X-Rspamd-Queue-Id: D3DA03C1C19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Yang <n05ec@lzu.edu.cn>

commit 850837965af15707fd3142c1cf3c5bfaf022299b upstream.

br_nd_send() walks ND options according to option-provided lengths.
A malformed option can make the parser advance beyond the computed
option span or use a too-short source LLADDR option payload.

Validate option lengths against the remaining NS option area before
advancing, and only read source LLADDR when the option is large enough
for an Ethernet address.

Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Cc: stable@vger.kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20260326034441.2037420-3-n05ec@lzu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_arp_nd_proxy.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -285,12 +285,14 @@ static void br_nd_send(struct net_bridge
 	ns_olen = request->len - (skb_network_offset(request) +
 				  sizeof(struct ipv6hdr)) - sizeof(*ns);
 	for (i = 0; i < ns_olen - 1; i += (ns->opt[i + 1] << 3)) {
-		if (!ns->opt[i + 1]) {
+		if (!ns->opt[i + 1] || i + (ns->opt[i + 1] << 3) > ns_olen) {
 			kfree_skb(reply);
 			return;
 		}
 		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
-			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
+			if ((ns->opt[i + 1] << 3) >=
+			    sizeof(struct nd_opt_hdr) + ETH_ALEN)
+				daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
 			break;
 		}
 	}



