Return-Path: <stable+bounces-264219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ff+GIs9yMWp5jgUAu9opvQ
	(envelope-from <stable+bounces-264219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:59:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E952691982
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:59:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VkvEd3JE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264219-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264219-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1505F30E61F2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E684E449EB0;
	Tue, 16 Jun 2026 15:46:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BB44CAF9;
	Tue, 16 Jun 2026 15:45:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624760; cv=none; b=EKW4hx1PVEJwFFupG18JYxzJSkfO7RS+D532wDYF3T7fbTW97nhyJNIy8+fWeaLB+r43mxXukACegK+q3AGvy5SaGle4S0MErXzUqcoyJua/1eaZsJUkBeBUeYgB0FiPBO9UP1gb44nQecSbL0VBwR7XAl2l/ECFprX8e94WHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624760; c=relaxed/simple;
	bh=EoW/Bewzn/zMdabab+ajMB1V+6h+ommMEdbD7Sp3OuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViQ5RxIYthF/LZJ5+95XcvVSmtSyzYUP8DvOLpa0CrH0lGYS3LyCRTE2FHf/uQOXCvWq1raJfFRm1QvE+xjE9jRvYyVR/A+I8JUeZ1sDqGvNf0gaictGksgNs1iTR5NxY7vGAN+RfvCPlVtlcw/nGU/D8XAxMQUo/aUy/Eo9rX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VkvEd3JE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992CA1F000E9;
	Tue, 16 Jun 2026 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624756;
	bh=mdL3b/VROFsYtJSvQPN78+SkgyZD0gB8BsA6JjYbLpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VkvEd3JERNdIN1qWO4i0ihfvOUSngStjMAjxomAIOOn+zyK1WaePK0Te4mXyggRnv
	 5VDW1QMMSxzBE1Avxrdz9QkBOvP2gQMxmNe6s/iuJ27Zs93UHSXbh5gvQmYEaHlo+y
	 wpg8MxErKTu7wvy2E9SaCOukYYVUYvYcRREx4nzg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 024/325] netfilter: conntrack_irc: fix possible out-of-bounds read
Date: Tue, 16 Jun 2026 20:27:00 +0530
Message-ID: <20260616145058.977152880@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264219-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:fw@strlen.de,m:fmancera@suse.de,m:pablo@netfilter.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,suse.de:email,sashiko.dev:url,vger.kernel.org:from_smtp,strlen.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E952691982

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 5703846bea3b69..0f50ea92ced9df 100644
--- a/net/netfilter/nf_conntrack_irc.c
+++ b/net/netfilter/nf_conntrack_irc.c
@@ -208,7 +208,7 @@ static int help(struct sk_buff *skb, unsigned int protoff,
 			if (parse_dcc(data, data_limit, &dcc_ip,
 				       &dcc_port, &addr_beg_p, &addr_end_p)) {
 				pr_debug("unable to parse dcc command\n");
-				continue;
+				goto out;
 			}
 
 			pr_debug("DCC bound ip/port: %pI4:%u\n",
@@ -222,7 +222,7 @@ static int help(struct sk_buff *skb, unsigned int protoff,
 				net_warn_ratelimited("Forged DCC command from %pI4: %pI4:%u\n",
 						     &tuple->src.u3.ip,
 						     &dcc_ip, dcc_port);
-				continue;
+				goto out;
 			}
 
 			exp = nf_ct_expect_alloc(ct);
-- 
2.53.0




