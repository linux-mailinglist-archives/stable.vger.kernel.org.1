Return-Path: <stable+bounces-261108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uz22Ay1GJWrCFgIAu9opvQ
	(envelope-from <stable+bounces-261108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:21:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA4C64F913
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:21:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=i9zkvZ85;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261108-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261108-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E23DD304ED55
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B4730C157;
	Sun,  7 Jun 2026 10:14:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F81E98EF;
	Sun,  7 Jun 2026 10:14:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827288; cv=none; b=CkfqEEBwLm0ZrUAQ4Fo3L5h9Y7yGYu6wpWvjDIlAKlf8CZ78EZ72zrQcNMR7AMmD9bSSvq7hZne2NO9YQ3IBcXVI9KZnSr7t4IqHKrrC/4k6hal23j6prKYDjxBOfiTMln9D9MIhQDF8koD8qWSO/RJeOS5jWrdDL3Z/TRJu5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827288; c=relaxed/simple;
	bh=1KNDS1vG+xvpbauPv0T92mGmnrc6wA+BX3Xn4i55Vao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edjbFLbrkYs2sN+rMH0VFAxbNxx68Ctlf2WclTqACAMHegRMhB9gvOJ2xtCukhZjutZ52gDV/Ntcea5BEh8NYklsqtIuEHKeyR4P81UENQMNMpuUmRNdMvPwVoIr4NDx+75CslqiF+/925WPgfbACJP7++p4RAAGsy7jg6OUdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i9zkvZ85; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC7E1F00893;
	Sun,  7 Jun 2026 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827287;
	bh=GwGyjztPGSyBhevnzdrtn8JXgh9cmybtOlhPpvcRIbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i9zkvZ85Byw16Q8DqWpVfiUBkZ2mdylRe/sMn5XccpTR7q21fn/uTFt7aXPJwadQZ
	 15wyHPB6JA385B2AHXxYCF68mYqDOyUTrMzTrvf7e/x8FzxWkd+BRCXapOk4oueqN6
	 5Ismm7QyI4paeHLLVjbc4Nnnyacq11E/iU551OHQ=
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
Subject: [PATCH 6.12 042/307] ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
Date: Sun,  7 Jun 2026 11:57:19 +0200
Message-ID: <20260607095729.246158769@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,linux.dev,kernel.org];
	TAGGED_FROM(0.00)[bounces-261108-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EA4C64F913

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 8d411cce0aedc1..35a6e7d8f52f7e 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1630,10 +1630,10 @@ static __net_exit void ipv4_sysctl_exit_net(struct net *net)
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




