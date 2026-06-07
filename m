Return-Path: <stable+bounces-260970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bbiyCndDJWpTFQIAu9opvQ
	(envelope-from <stable+bounces-260970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:09:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 688F064F5DA
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:09:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=GIvNLVF4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260970-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260970-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 611323034DD0
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F62234994;
	Sun,  7 Jun 2026 10:07:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B178C9C;
	Sun,  7 Jun 2026 10:06:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826820; cv=none; b=oqhO6n0tyfx/jEaEhhTuSW/KJXj4bT4egqwY33orBhTy1G0w53C6G8VsBlMsuluupmyQ62u74WvyNOHG9ExiMvXcIDmclh9TCORbie8sH8xGf6iXQXKIB1RLLi5d4xZpsxjr+ZzsmHvxFZSgutmo0ZRIJQ65Pu9KanBJgjiCbxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826820; c=relaxed/simple;
	bh=9Py7EQOfkwb9v50wL5CdrjP2XMYmmnJmfYxp8UdmvPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9qm7refq01osbEftSkdDjoVADoUFGxclKS+Fq9QpRhUCXa4JnD4KEFwh4GMAJZjtipjH8zyvlZqfwnsobeliV2vTVaor1FrqaUz788TLWFV0/ZzlJj8TT60ZbcLdptLFaPVCGhXOM6AO74vnRLb+6cGX+0ppNEaW0ybK7F/UHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GIvNLVF4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F5F1F00893;
	Sun,  7 Jun 2026 10:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826819;
	bh=h/cBhtStUNQgj5+7WTr7TxQF+2JlHz0DrQO9Bb9O/2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GIvNLVF454nPte+nYxx2uPnV8vCzYvn40dxvyeU8k0lbh2g8K49lhnhHvG2E2gfZj
	 wbfv8Ywxe7owkEKlTSiz6UjEVUXCVDxPAKcua1sIK25MoCnAKWtOZe9/AimnQZRVFW
	 ZiJ5ZW2ps+QGtvagBKO95MbWS8iUxLF2pS6sXRHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jian Zhou <eilaimemedsnaimel@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 031/332] ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
Date: Sun,  7 Jun 2026 11:56:40 +0200
Message-ID: <20260607095729.233931935@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,linux.dev,kernel.org];
	TAGGED_FROM(0.00)[bounces-260970-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:eilaimemedsnaimel@gmail.com,m:edumazet@google.com,m:xiyou.wangcong@gmail.com,m:kerneljasonxing@gmail.com,m:jiayuan.chen@linux.dev,m:kuba@kernel.org,m:sashal@kernel.org,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 688F064F5DA

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 87a1e0fe7776da7ab411be332b4be58ac8840d10 ]

ipv4_sysctl_exit_net() is currently freeing net->ipv4.sysctl_local_reserved_ports
too soon.

Only after unregister_net_sysctl_table() we can be sure no threads can possibly
use the sysctls, including /proc/sys/net/ipv4/ip_local_reserved_ports.

Fixes: 122ff243f5f1 ("ipv4: make ip_local_reserved_ports per netns")
Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260521122147.3584624-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 5654cc9c8a0b9e..e47df4d706a9cd 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1698,10 +1698,10 @@ static __net_exit void ipv4_sysctl_exit_net(struct net *net)
 {
 	const struct ctl_table *table;
 
-	kfree(net->ipv4.sysctl_local_reserved_ports);
 	table = net->ipv4.ipv4_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.ipv4_hdr);
 	kfree(table);
+	kfree(net->ipv4.sysctl_local_reserved_ports);
 }
 
 static __net_initdata struct pernet_operations ipv4_sysctl_ops = {
-- 
2.53.0




