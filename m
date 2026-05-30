Return-Path: <stable+bounces-257419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK2RJR8aG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:10:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5FD60F0CB
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F8503060D56
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DBC3AEB5C;
	Sat, 30 May 2026 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yYns5O91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968543AB26B;
	Sat, 30 May 2026 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160932; cv=none; b=CSaskEJ0tFgaeuU4yXvX2W7MbZxlv03+bTS+hNb0N7wTXlFDmIj48IHwvyjO5C+XIkM3AYnv13CZL3hUwtcpqbhIDsiuddDbrwF8hPK/97DdOkl8YEPrvFi/hV/vCADuMlZFarw0pmJ+qxYA0/lYQPm0yS4ZvkhH34hNoJmUI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160932; c=relaxed/simple;
	bh=Dp42CdlRpuVBEFrz1YmggdOg+vFJb6C5/mb7fRgTXIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N81UM6oYoW3mrdmaqvhQ+QBQq3/yP87YmZOYHG0KL8ngiuSfGxmymFZzQN4X2IPKSIMTRpLucj+0UN/fougCvCTZf40tSVg1sxOBdHOSRPLjo3SopHMnwU6cJ9gkG/SSPMHrEw0IjZMI/Ixd2LcKl8DqeMICKwF1YWuLmkmGzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yYns5O91; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C111F00893;
	Sat, 30 May 2026 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160931;
	bh=iwZwngi1ouS8OBTM0gAFQTD1TsGO7+ICFjC4TS2rLaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yYns5O91NfBM1KOJ0BwTLwk1caIIs8uM+FVHRTDvhfS3NHmcFT0jVyxEjLYWcrrMP
	 zOZq6Iy2V6201rpHUHqA7bK3fxgRgrp6Yhv81etxNKPwX0oco9zrPUs8awimz2Qo7f
	 hbN7oFEOrmgixNleXkdaBZgG5vkqzfZGtoZ4D4DI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 477/969] netfilter: nft_fwd_netdev: check ttl/hl before forwarding
Date: Sat, 30 May 2026 18:00:01 +0200
Message-ID: <20260530160313.469308958@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257419-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6A5FD60F0CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 1dfd95bdf4d18d263aa8fad06bfb9f4d9c992b18 ]

Drop packets if their ttl/hl is too small for forwarding.

Fixes: d32de98ea70f ("netfilter: nft_fwd_netdev: allow to forward packets via neighbour layer")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_fwd_netdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 7c5876dc9ff2b..6f6b355134625 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -115,6 +115,11 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 			goto out;
 		}
 		iph = ip_hdr(skb);
+		if (iph->ttl <= 1) {
+			verdict = NF_DROP;
+			goto out;
+		}
+
 		ip_decrease_ttl(iph);
 		neigh_table = NEIGH_ARP_TABLE;
 		break;
@@ -131,6 +136,11 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 			goto out;
 		}
 		ip6h = ipv6_hdr(skb);
+		if (ip6h->hop_limit <= 1) {
+			verdict = NF_DROP;
+			goto out;
+		}
+
 		ip6h->hop_limit--;
 		neigh_table = NEIGH_ND_TABLE;
 		break;
-- 
2.53.0




