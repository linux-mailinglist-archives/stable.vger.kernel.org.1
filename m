Return-Path: <stable+bounces-257627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H9RBBkeG2qu/QgAu9opvQ
	(envelope-from <stable+bounces-257627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:27:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 858B860FB69
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED4003024C96
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9D93242D7;
	Sat, 30 May 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jf+W5EJs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61B14A62B;
	Sat, 30 May 2026 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161635; cv=none; b=oqaiD70Gf5neseIABDdCGZADc1gTlCBLFQ2885Uu7j0I9JrcxfVv567IgaPxVBbrmXuZK84Q9Y777DrsqBctMbSFP762pu/TARavLRACf4vXJHbNQ4pudyDL5kKfXBHBdK/EDDmQP/fqO8VhCUXhTcqUN4V1GMX4+USSd9kD6Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161635; c=relaxed/simple;
	bh=FCLOMC9qohpfb4OYXqYlQCZwYy7oaZtGP55leM6XA5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0n/cOCOYyUIoiy3wzNHfEhuCO1/lrPM0OcF6sqqFdIaN57DdHjKDdpao7r8OmoqyjPv7rxWGqexe0U+M+7AvAsTRxwaCAp4tlM2Z/pZgF/W/m7GWQtLDJKSFEO7EPEMw2SV8vr4GmKQYTKjZRwuDWD5uyaiY5IkUulgezF7aC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jf+W5EJs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7911F00893;
	Sat, 30 May 2026 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161634;
	bh=/EQPLPyh5Zb0dJJLb0dvRoixsAE69D7nBBeudLp9WdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jf+W5EJsjzGj6yUqVHnkp0dge9EAjRvE8+kW2HFJhpGAERcB/xnQU3wfkIOoKzmmZ
	 nVd/5DPnszKHn+jqfRhXDeVtISktWlu3I1NIp/4sNACss3HGETv5PFwEzJcowOHHFr
	 pGHdk7DlyYHw7HQRGOJ7Vwms8tWrh85FRYUwJPvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 682/969] net/sched: taprio: continue with other TXQs if one dequeue() failed
Date: Sat, 30 May 2026 18:03:26 +0200
Message-ID: <20260530160319.337625560@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257627-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,linutronix.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 858B860FB69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 1638bbbe4ececa615b273497d347d59ad71060a2 ]

This changes the handling of an unlikely condition to not stop dequeuing
if taprio failed to dequeue the peeked skb in taprio_dequeue().

I've no idea when this can happen, but the only side effect seems to be
that the atomic_sub_return() call right above will have consumed some
budget. This isn't a big deal, since either that made us remain without
any budget (and therefore, we'd exit on the next peeked skb anyway), or
we could send some packets from other TXQs.

I'm making this change because in a future patch I'll be refactoring the
dequeue procedure to simplify it, and this corner case will have to go
away.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 105425b1969c ("net/sched: taprio: fix use-after-free in advance_sched() on schedule switch")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_taprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 62219f23f76ab..aad95b084ae36 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -626,7 +626,7 @@ static struct sk_buff *taprio_dequeue(struct Qdisc *sch)
 
 		skb = child->ops->dequeue(child);
 		if (unlikely(!skb))
-			goto done;
+			continue;
 
 skb_found:
 		qdisc_bstats_update(sch, skb);
-- 
2.53.0




