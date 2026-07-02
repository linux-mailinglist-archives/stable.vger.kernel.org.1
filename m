Return-Path: <stable+bounces-270782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id slwPFHSVRmqXZAsAu9opvQ
	(envelope-from <stable+bounces-270782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:44:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA1E6FA792
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:44:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=saQjCj1k;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270782-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270782-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 340693298570
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74243546E1;
	Thu,  2 Jul 2026 16:30:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC6534D91F;
	Thu,  2 Jul 2026 16:30:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009837; cv=none; b=JZlKk3FnoUdqSiQEMRu/S4Tt5SjaLxOpLLUzP2y63vic5SGWZC4m7RkmtGM9NrPradTo2mWyCJJFhwsm6a/C1GfDic0OgfZTMR5UwKuVQQV1Jw7TlhYeR1or93wosfD6IleXn9CdJRTIXwMBatgVnrPfo1wJGTyhWmMAVju4ECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009837; c=relaxed/simple;
	bh=oM1CRDQk5cuyw4KmvkzR2p2WFUcE9fMgEVR9Iq/ocVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6g/c4mPbGtV8CjxGZ8efX35ni9f42BhOfrdZKMamtt/nD7cjKC+B12/AK74w2VeasbtH7SR6yPmz/yG/6Zaj3e682QrbWs76//9s4CXTKOVvEBgmNfuARxqeTUTd7rkDIqZgoeKtAMt5Al0NwOOUefwrG+a4cKbZSOknZNUYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=saQjCj1k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FC91F000E9;
	Thu,  2 Jul 2026 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009836;
	bh=0QyboJ3Yt19yA8rAJEX3ysuqYAEVNIXFUqGDTXYr5oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=saQjCj1kdpXYR3suX7Ks3tIaPZKZYgWe38f1wXxQAihaSdIvxPv7U9Y0nH9yB3myk
	 +ezMIpgwKhhi1Vg6Jf5DUuuyuYEGhcrSoMt9tMrdFkDcWFOPALh48vra2hSFhksfXo
	 X0+Uf449R+orNA6q4aPSPArszWwTKR4Pu+ntstOM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wentao Guan <guanwentao@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 003/129] net/sched: act_pedit: rate limit datapath messages
Date: Thu,  2 Jul 2026 18:18:42 +0200
Message-ID: <20260702155112.235010288@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270782-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jhs@mojatatu.com,m:simon.horman@corigine.com,m:pctammela@mojatatu.com,m:davem@davemloft.net,m:guanwentao@uniontech.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mojatatu.com:email,uniontech.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,davemloft.net:email,corigine.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBA1E6FA792

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit e3c9673e2f6e1b3aa4bb87c570336e10f364c28a ]

Unbounded info messages in the pedit datapath can flood the printk
ring buffer quite easily depending on the action created.
As these messages are informational, usually printing some, not all,
is enough to bring attention to the real issue.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit e3c9673e2f6e1b3aa4bb87c570336e10f364c28a)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_pedit.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 2bdc44efee779a..7ba460fda1f4e9 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -429,8 +429,8 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			u8 *d, _d;
 
 			if (!offset_valid(skb, hoffset + tkey->at)) {
-				pr_info("tc action pedit 'at' offset %d out of bounds\n",
-					hoffset + tkey->at);
+				pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",
+						    hoffset + tkey->at);
 				goto bad;
 			}
 			d = skb_header_pointer(skb, hoffset + tkey->at,
@@ -440,14 +440,13 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 
 			offset += (*d & tkey->offmask) >> tkey->shift;
 			if (offset % 4) {
-				pr_info("tc action pedit offset must be on 32 bit boundaries\n");
+				pr_info_ratelimited("tc action pedit offset must be on 32 bit boundaries\n");
 				goto bad;
 			}
 		}
 
 		if (!offset_valid(skb, hoffset + offset)) {
-			pr_info("tc action pedit offset %d out of bounds\n",
-				hoffset + offset);
+			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
 			goto bad;
 		}
 
@@ -464,8 +463,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			val = (*ptr + tkey->val) & ~tkey->mask;
 			break;
 		default:
-			pr_info("tc action pedit bad command (%d)\n",
-				cmd);
+			pr_info_ratelimited("tc action pedit bad command (%d)\n", cmd);
 			goto bad;
 		}
 
-- 
2.53.0




