Return-Path: <stable+bounces-236934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEuaD6gb3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 071603EF5FF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C54130157BA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B287B30E0FD;
	Mon, 13 Apr 2026 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xhN+Q8Fg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541730DD3C;
	Mon, 13 Apr 2026 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098166; cv=none; b=ODRso9+DkiAtAl/ENMxw25f0/oEbhM01erOrCWv6sySYkPgF7x+qteFpwohANcXC43ZzlfEea7xcOaeaCqd95Z7WqrHjwj+UqvWD1QHp/WRKyQy6VKi/4vMa79nzxyksoXpZXyScOxhuqH5eOca93i1CV9YI3uprjs/VhM5mUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098166; c=relaxed/simple;
	bh=qnetcA/ruukqn8RIQuMorhigRjNzwqz0R0mdDzwOvxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qytPIxkpS3vMG0BFD+ndGDyxmPNSvooiTYIIUCQoQ2Pl7RPF4ziro9YFbKRDrZ7VHA2kNhEJ2aafSfcPUV+VhaN5RzXCiGi5BqEzGMPJgWSAj1ucUJEf2mUAQhiCHlA/XKlru+GtkYmQzzuninPCK2dfrzKYmJQY8zthq0Dk4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xhN+Q8Fg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEE8C2BCAF;
	Mon, 13 Apr 2026 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098166;
	bh=qnetcA/ruukqn8RIQuMorhigRjNzwqz0R0mdDzwOvxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xhN+Q8FgRZNnyA8I5w07QE2LC2WzGZjc3T39dUTcl9MtxzWXH/VtQcm1cm9LyA5zc
	 R8w16x/fDH9Jie8NTrGxeDD5fd8ywl1B+au/p970IQ9z5HybGJcAmpehEijzXWrc8i
	 8MHRHw2hBM2tqU0Xdfg3qSynMkWCO1HvmBakVCpk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiming Qian <yimingqian591@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 420/570] netfilter: nfnetlink_log: account for netlink header size
Date: Mon, 13 Apr 2026 17:59:11 +0200
Message-ID: <20260413155846.206266347@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,strlen.de,netfilter.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-236934-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,strlen.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 071603EF5FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 6d52a4a0520a6696bdde51caa11f2d6821cd0c01 ]

This is a followup to an old bug fix: NLMSG_DONE needs to account
for the netlink header size, not just the attribute size.

This can result in a WARN splat + drop of the netlink message,
but other than this there are no ill effects.

Fixes: 9dfa1dfe4d5e ("netfilter: nf_log: account for size of NLMSG_DONE attribute")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 6484d08223dbc..37d10c3d19b60 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -715,7 +715,7 @@ nfulnl_log_packet(struct net *net,
 		+ nla_total_size(plen)			/* prefix */
 		+ nla_total_size(sizeof(struct nfulnl_msg_packet_hw))
 		+ nla_total_size(sizeof(struct nfulnl_msg_packet_timestamp))
-		+ nla_total_size(sizeof(struct nfgenmsg));	/* NLMSG_DONE */
+		+ nlmsg_total_size(sizeof(struct nfgenmsg));	/* NLMSG_DONE */
 
 	if (in && skb_mac_header_was_set(skb)) {
 		size += nla_total_size(skb->dev->hard_header_len)
-- 
2.53.0




