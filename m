Return-Path: <stable+bounces-265947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jw4dIDKTMWqynAUAu9opvQ
	(envelope-from <stable+bounces-265947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:17:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 718EF693FE2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:17:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=yFJynD+L;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265947-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265947-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CB6A3001FB6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7531946AEFC;
	Tue, 16 Jun 2026 18:17:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646B3D75CE;
	Tue, 16 Jun 2026 18:17:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633835; cv=none; b=d47s9ADAlE+bFF2kBGZpYyXoswTD+bqgXVgai6MKpJ1PwzZN3/TFlOYkK1oggQBD5/7tJZ7oAByWTP/03wNDL6xYZzXa1Aw6NhQBsGpsCKmPPKJtJb8XYe8xTEtb6w34Tp8e0tKGAb1NAcbfU+qz4AmUX2lNNbatekcXxsbRm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633835; c=relaxed/simple;
	bh=eQJwlRLUHc5gsu1R8I5Ra+2+/BiwS73OGjPRxBwpytY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2t/Dl0ECiULZ6yCRA8juh2jQHmNCgdyi+zjt+DYkeO27GGBZrcheArzF9CwoYaCZ4S5yRxaIcSInYkdSUxw/XqXuqzoWccd48eNLvfkr40ow5Ri0cjF/sZ8dFqn4OA2Pn6iIRlaQb/7KrXQrjCChoK8Bb+RyMVaPUYVlen2YSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yFJynD+L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3392B1F000E9;
	Tue, 16 Jun 2026 18:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633834;
	bh=qIXMPefimXkFoH6QaY1zhsdwvxIuve4ZNiMqdo+Qt1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yFJynD+L4qP+dfVJC/cjLRy1d8AKBuOH6BIy4WQCtpuJRC0T3Kk79qXoCPmaH2jJ4
	 g9oMyRlpG49zGUgY7WQdQwcqx5Ei3m/a/gIG2yK7FZOnfyPK61xq6xtRpdIrc9WTU6
	 wb8jp9L6VdXPYdD4PL9aYTHo0Xc4uWkdV2xSH+Tg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 153/411] netfilter: conntrack_irc: fix possible out-of-bounds read
Date: Tue, 16 Jun 2026 20:26:31 +0530
Message-ID: <20260616145108.574509386@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265947-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:fw@strlen.de,m:fmancera@suse.de,m:pablo@netfilter.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,netfilter.org:email,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,strlen.de:email,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 718EF693FE2

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 66eba0ffce3b7e11449946b4cbbef8ea36112f56 ]

When parsing fails after we've matched the command string we
should bail out instead of trying to match a different command.

This helper should be deprecated, given prevalence of TLS I doubt it has
any relevance in 2026.

Fixes: 869f37d8e48f ("[NETFILTER]: nf_conntrack/nf_nat: add IRC helper port")
Closes: https://sashiko.dev/#/patchset/20260525182924.28456-1-fw%40strlen.de
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_irc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_irc.c b/net/netfilter/nf_conntrack_irc.c
index 159e1e4441a433..7a0c645a11c390 100644
--- a/net/netfilter/nf_conntrack_irc.c
+++ b/net/netfilter/nf_conntrack_irc.c
@@ -202,7 +202,7 @@ static int help(struct sk_buff *skb, unsigned int protoff,
 			if (parse_dcc(data, data_limit, &dcc_ip,
 				       &dcc_port, &addr_beg_p, &addr_end_p)) {
 				pr_debug("unable to parse dcc command\n");
-				continue;
+				goto out;
 			}
 
 			pr_debug("DCC bound ip/port: %pI4:%u\n",
@@ -216,7 +216,7 @@ static int help(struct sk_buff *skb, unsigned int protoff,
 				net_warn_ratelimited("Forged DCC command from %pI4: %pI4:%u\n",
 						     &tuple->src.u3.ip,
 						     &dcc_ip, dcc_port);
-				continue;
+				goto out;
 			}
 
 			exp = nf_ct_expect_alloc(ct);
-- 
2.53.0




