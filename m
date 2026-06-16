Return-Path: <stable+bounces-265847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P9XAMSyRMWqkmwUAu9opvQ
	(envelope-from <stable+bounces-265847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:08:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A08693D4F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:08:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=C6QWC+ZR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265847-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265847-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCC9C302F487
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260463D47CE;
	Tue, 16 Jun 2026 18:08:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3A3D45CB;
	Tue, 16 Jun 2026 18:08:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633321; cv=none; b=UPckpVePIdbZsNt8RGQDlcKUPzLNzuSVbQ79PWzKC9MSoJkusv5au+8k5RSuMeuxufPhtzWeoBb4eFuAiBCjNBcmNdCB6h9zX9rI2eYjdeqRzFk++WUMuRsllAFRl56U1hE6LGxzx1K8vP/gQNSPc7+VnT5dcnW/45Jgcez6KbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633321; c=relaxed/simple;
	bh=jHflKDAHQyCjxukLWp+zKw/M/jj3HEcbQSLblz4aQh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPJkpvPSHFZSedFSxXwUijK5hYoJJBSC0RMM8IwLQXk6y2oaPAfyqH0jjn96pJ8Mqm1bQlVD+kzP/ffxZgKuBWX8mWO2LLL4y7PfnJrkfFjWWlsmYnVM3fKM8zovemIGokZAAkuVSXxiZdDAWmeqoeuhjaVLeG2qYc8OgI3HlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C6QWC+ZR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A641F000E9;
	Tue, 16 Jun 2026 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633320;
	bh=QATsVKaI4msb7MH0zOrL200pseKubYtbJhZs/pvxXCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C6QWC+ZR5XxIC/BHyeYvBRIpz+PqpJBBvuFm9twgMKEUGYLpZWs1F2HvCMVVQPu8x
	 a+IuOAZAEk4p8Vr7y5XkG8UvDP1IbJH8TSCa9TGIgDdImYC3y0fgxt+J8XTwDuePWm
	 RD5J4PhD10IrgiQ4Vr0X+/ckfdonQiIvexEv1uLM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+690d3e3ffa7335ac10eb@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 013/411] netfilter: xt_cpu: prefer raw_smp_processor_id
Date: Tue, 16 Jun 2026 20:24:11 +0530
Message-ID: <20260616145101.068723805@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265847-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:syzbot+690d3e3ffa7335ac10eb@syzkaller.appspotmail.com,m:fw@strlen.de,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,690d3e3ffa7335ac10eb];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60A08693D4F

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit c376f07e16c02239ed44cabb97145d03f65b4d15 ]

With PREEMPT_RCU we get splat:

BUG: using smp_processor_id() in preemptible [..]
caller is cpu_mt+0x53/0xd0 net/netfilter/xt_cpu.c:37
CPU: 1 .. Comm: syz.3.1377 #0 PREEMPT(full)
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 cpu_mt+0x53/0xd0 net/netfilter/xt_cpu.c:37
 [..]

Just use raw version instead.
This is similar to 14d14a5d2957 ("netfilter: nft_meta: use raw_smp_processor_id()").

Fixes: 0ca743a55991 ("netfilter: nf_tables: add compatibility layer for x_tables")
Reported-by: syzbot+690d3e3ffa7335ac10eb@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_cpu.c b/net/netfilter/xt_cpu.c
index 3bdc302a0f9137..9cb259902a586b 100644
--- a/net/netfilter/xt_cpu.c
+++ b/net/netfilter/xt_cpu.c
@@ -34,7 +34,7 @@ static bool cpu_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct xt_cpu_info *info = par->matchinfo;
 
-	return (info->cpu == smp_processor_id()) ^ info->invert;
+	return (info->cpu == raw_smp_processor_id()) ^ info->invert;
 }
 
 static struct xt_match cpu_mt_reg __read_mostly = {
-- 
2.53.0




