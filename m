Return-Path: <stable+bounces-239831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH0SNLdo5mnBvwEAu9opvQ
	(envelope-from <stable+bounces-239831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:56:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9F4324A7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A6BB372E7BB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CAB3375C5;
	Mon, 20 Apr 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TcjGll0W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC22BD11;
	Mon, 20 Apr 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701327; cv=none; b=EuEJUshYTkd/ZpxOWp5Z6aVwSQV02i9rG7/lCWHQYeT0z1YtEtMFKOkfloLRQeNzcpwKk2weTYccRGxMXsyDgz2RVAEyariZtGGky/waBRtMEzQxwxQ9rR9AnZi4SriEOGHNJW8Y6haQ4qlsqnuIkLGAdiu8/7lGwL7uOAdMMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701327; c=relaxed/simple;
	bh=R6q9EtXCgC13p5ehgCVF8a+Ins2/cyeDydn2hAX+dQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKZjTA/fUCeRuP9cWMglpG6obOmGWffaGnmKSzXJjlYAuaabOsuhWD8IqdWZTOCe8TrSINl1nnFHR5Df9kaZZWUTZOljDSBKj7FD9nSSGJyHE0tbYJ01c4Vsad6PBxz4puxw+cQTrT1u5M0gQqKO76JdberPfpJtGGF1fXpQits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TcjGll0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED6DC19425;
	Mon, 20 Apr 2026 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701327;
	bh=R6q9EtXCgC13p5ehgCVF8a+Ins2/cyeDydn2hAX+dQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcjGll0Wl21yzKkvaTy0NY4dt4lUxKcgViI8q4thioLy/SazdcShycrryg+dfyh6q
	 rFAft9rgFDyWSjDHAu5M2QtTPgNizdEKsJfVrUbk9Fv2ZrXPEtrwSNp7BXp6d1eYaA
	 iEL9tatamqpmT2JNWogYX2P+usRHKUm6qIjLNFrE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 070/162] netfilter: nfnetlink_log: initialize nfgenmsg in NLMSG_DONE terminator
Date: Mon, 20 Apr 2026 17:41:42 +0200
Message-ID: <20260420153929.572749204@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
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
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,asu.edu,strlen.de,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239831-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.560];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,strlen.de:email]
X-Rspamd-Queue-Id: 39F9F4324A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit 1f3083aec8836213da441270cdb1ab612dd82cf4 ]

When batching multiple NFLOG messages (inst->qlen > 1), __nfulnl_send()
appends an NLMSG_DONE terminator with sizeof(struct nfgenmsg) payload via
nlmsg_put(), but never initializes the nfgenmsg bytes. The nlmsg_put()
helper only zeroes alignment padding after the payload, not the payload
itself, so four bytes of stale kernel heap data are leaked to userspace
in the NLMSG_DONE message body.

Use nfnl_msg_put() to build the NLMSG_DONE terminator, which initializes
the nfgenmsg payload via nfnl_fill_hdr(), consistent with how
__build_packet_message() already constructs NFULNL_MSG_PACKET headers.

Fixes: 29c5d4afba51 ("[NETFILTER]: nfnetlink_log: fix sending of multipart messages")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index f96421ad14afb..3da32d2f68e09 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -361,10 +361,10 @@ static void
 __nfulnl_send(struct nfulnl_instance *inst)
 {
 	if (inst->qlen > 1) {
-		struct nlmsghdr *nlh = nlmsg_put(inst->skb, 0, 0,
-						 NLMSG_DONE,
-						 sizeof(struct nfgenmsg),
-						 0);
+		struct nlmsghdr *nlh = nfnl_msg_put(inst->skb, 0, 0,
+						    NLMSG_DONE, 0,
+						    AF_UNSPEC, NFNETLINK_V0,
+						    htons(inst->group_num));
 		if (WARN_ONCE(!nlh, "bad nlskb size: %u, tailroom %d\n",
 			      inst->skb->len, skb_tailroom(inst->skb))) {
 			kfree_skb(inst->skb);
-- 
2.53.0




