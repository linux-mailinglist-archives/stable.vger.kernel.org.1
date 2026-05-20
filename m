Return-Path: <stable+bounces-252723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HbpEXMDDmoD5gUAu9opvQ
	(envelope-from <stable+bounces-252723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:54:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D7597615
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D47237427EB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1DC401486;
	Wed, 20 May 2026 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wq1UWy4x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D387400DF5;
	Wed, 20 May 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301421; cv=none; b=NstWeGBpS81W4xZbuxhbbaqNx1cgA1bcmQ3KH5bJhEUVcDfGrshPWdZ7niDee7IH98EebnZf6Hj/1IlqGP9wk4XXxZS5DiOfGQwpSk05Bi6IVVz2rOMULbWdT6HmbCqGp/FKncMIlKF7hQfwB+qGACvIlBVZ0Yeyere1B1a+cXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301421; c=relaxed/simple;
	bh=Fw+9TamXA0+M/teiq9q+J4A3TLKPBLdXeD85lMeCZ80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvpldx15Vi6k5Z4ykFAvZrwytuyR50cN24Xd2/bb6AD04D4v9GF1OCglbNuCXtAaJo2DtdqCngE+QLsBcQJoX6leKYsyknZ4PQ6KrNpsiGmXQIynuSpA/6A8NaYY8sftOzdIP6gkY8ygZw6mpLw/7lsdwMq08nuqYX2uR9XsZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wq1UWy4x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0A61F00893;
	Wed, 20 May 2026 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301420;
	bh=KkEYPxrKReaLzkQewRiFUrRsuEKQLHqkJHXrMblgHn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wq1UWy4xnQWM3W9UydCwcKe5oN53iJOP/5nCqFoAmeVWaOUWMurqe83a35peGZ1fF
	 79RVkWL0c4AtfLaHHwT+NHfFd9KozTzjZcoImhV1h/CBxbBXOA6NaUKuEO0pf2t7tj
	 xpMkNTxkzsayWm9NdRBteuqWeay8FJTOsdeL7W6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 548/666] netpoll: Extract carrier wait function
Date: Wed, 20 May 2026 18:22:39 +0200
Message-ID: <20260520162123.147526879@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252723-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: AD5D7597615
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 76d30b51e818064e02917ce6328fb2c8adce5c87 ]

Extract the carrier waiting logic into a dedicated helper function
netpoll_wait_carrier() to improve code readability and reduce
duplication in netpoll_setup().

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250618-netpoll_ip_ref-v1-1-c2ac00fe558f@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 3bc179bc7146 ("netpoll: fix IPv6 local-address corruption")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a38b239cd7db6..a9c38f75b00ec 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -706,6 +706,21 @@ static char *egress_dev(struct netpoll *np, char *buf)
 	return buf;
 }
 
+static void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev,
+				 unsigned int timeout)
+{
+	unsigned long atmost;
+
+	atmost = jiffies + timeout * HZ;
+	while (!netif_carrier_ok(ndev)) {
+		if (time_after(jiffies, atmost)) {
+			np_notice(np, "timeout waiting for carrier\n");
+			break;
+		}
+		msleep(1);
+	}
+}
+
 int netpoll_setup(struct netpoll *np)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -736,28 +751,17 @@ int netpoll_setup(struct netpoll *np)
 	}
 
 	if (!netif_running(ndev)) {
-		unsigned long atmost;
-
 		np_info(np, "device %s not up yet, forcing it\n",
 			egress_dev(np, buf));
 
 		err = dev_open(ndev, NULL);
-
 		if (err) {
 			np_err(np, "failed to open %s\n", ndev->name);
 			goto put;
 		}
 
 		rtnl_unlock();
-		atmost = jiffies + carrier_timeout * HZ;
-		while (!netif_carrier_ok(ndev)) {
-			if (time_after(jiffies, atmost)) {
-				np_notice(np, "timeout waiting for carrier\n");
-				break;
-			}
-			msleep(1);
-		}
-
+		netpoll_wait_carrier(np, ndev, carrier_timeout);
 		rtnl_lock();
 	}
 
-- 
2.53.0




