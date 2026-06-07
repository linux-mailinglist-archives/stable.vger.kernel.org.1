Return-Path: <stable+bounces-261001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LuLrBOlDJWqHFQIAu9opvQ
	(envelope-from <stable+bounces-261001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD764F64C
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Gb65lqAT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261001-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261001-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA09D3047BF5
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271E42F8E8E;
	Sun,  7 Jun 2026 10:08:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046782E1EFC;
	Sun,  7 Jun 2026 10:08:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826924; cv=none; b=cgiA4Ia4h/DEJxiTPWfbxPjSBOD5mrD149rlwrmuxo3oCwVgyTsj2wiyDKZ3hEwohS25khSoLDzvBvujbQggYj/eMC8R/t0pYIomt3U/4l1XxZTEEqctIWNrFTwEheObcibUFOjKcFwBn9eNgqblcti5jDTFr8MX4S+JRTEeAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826924; c=relaxed/simple;
	bh=mrulElXfk0E68t5NqnefzJzMsQ4evp6pIvq3xrNGWHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8UC4MMEhon7bI//DkIIQ2QdGuQHDXMe1EQ/+KFHF+xV6WMFdQLU2X2NW65g16w1hFOvmnD9XZN4jKPogrRjIwrDwzuQbmTqznVTpbkhCKpU/0C6U1rYdVi59d/2L63IGmcFGLPToPqpjqyZ8hoFivzpQQ15IA2X/y9kyu2WyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gb65lqAT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4571F00893;
	Sun,  7 Jun 2026 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826923;
	bh=+K1vlW+de/8c45x3YMfq9n0YymkYsCO8z8ctI66MSeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gb65lqATkKO7qE2lmHGlNXZbwo8OdoTsI5qGyouP8GiY10+h/T3l57WzkD03HQGnK
	 dIwrNSKj1cCjZ75b1fFl1njuRgahFn7jK4cgh922L8yeDp14eIMLEnqzQy5K3MwPJf
	 RNex6cI0c+F28f8Nm0yOhc7C/j6BBC0H2oB/fweY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Maximets <i.maximets@ovn.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 023/315] net: netlink: fix sending unassigned nsid after assigned one
Date: Sun,  7 Jun 2026 11:56:50 +0200
Message-ID: <20260607095728.342130603@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261001-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:i.maximets@ovn.org,m:nicolas.dichtel@6wind.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,6wind.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,ovn.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65DD764F64C

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 70f8592ee90585272018a725054b6eb2ab7e99ca ]

If the current skb is not shared, it is re-used directly for all the
sockets subscribed to the notification.  If we have remote all-nsid
socket receiving a message first, then the 'nsid_is_set' will be
set to 'true'.  If the nsid is NOT_ASSIGNED for the next socket in
the list, the 'nsid_is_set' will remain 'true' and the negative value
is be delivered to the user space.  All subsequent nsid values will be
delivered as well, since there is no code path that sets the flag
back to 'false'.

Fix that by always dropping the flag to 'false' first.

Fixes: 7212462fa6fd ("netlink: don't send unknown nsid")
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Link: https://patch.msgid.link/20260520172317.175168-2-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/af_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2b46c0cd752a31..0e6dfd01d9b419 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1484,6 +1484,7 @@ static void do_one_broadcast(struct sock *sk,
 		p->skb2 = NULL;
 		goto out;
 	}
+	NETLINK_CB(p->skb2).nsid_is_set = false;
 	NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
 	if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
 		NETLINK_CB(p->skb2).nsid_is_set = true;
-- 
2.53.0




