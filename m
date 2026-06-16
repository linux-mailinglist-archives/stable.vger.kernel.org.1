Return-Path: <stable+bounces-266220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mzl5JtuYMWosnwUAu9opvQ
	(envelope-from <stable+bounces-266220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:41:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C5C69455E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:41:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=x6jfyNDc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266220-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266220-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D210B300862C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4D1478E5E;
	Tue, 16 Jun 2026 18:41:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870F13777E;
	Tue, 16 Jun 2026 18:41:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635284; cv=none; b=JX8qt/awAeUlbyXppJ93uBG4cBoZcpi5KHG0nYqaysL0o5uH6PCbY1iw6aQ8o354vOhJPe3FKu/vJfsClXcNutqdMQyR6E4L3FN0Qj/VU8nsJ1yxPLvmy0HFZ3d8vr83QIyfdORPbBayi1nraUO6m9vZBY+4wgUCA5TvsiibR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635284; c=relaxed/simple;
	bh=biB9EASDtzQAhVcCWrn3HvfBrIFt/2cn95Rv8SyjB9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOSdXlnzNe5LITH+EfVblbGylDr3kOCX07YGYPWJkw6vGvYJDlxwU5ymqs7mQT5xU43PTRPRdfRjNAdoy+Sngky7xLwbWnUv21BdIDyAQVXx76oUuaj+RdkF/NUD24J0gc8ovLUNxsGNeJdq3PapM4ch1DkW6qOvrEZeqd/1ceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x6jfyNDc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47271F000E9;
	Tue, 16 Jun 2026 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635283;
	bh=kfadv817FWJck+x/GnbhCHytaKIP74FoQ/SkMXiMMKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x6jfyNDc5kJauXGFFtEgSzTROdX/q0wxbmL5iqwU+yHsI9tONFcc8UFRWIaXmWJYV
	 orDQ9Q5pm4MrcY+uywpRLsxX6Ds23W/JFB7gDmLagGLP3EIiwvgtxBVIHqBlrDIef6
	 Kx9cHla6UkUeY7ewxFv69bIhKxAZUlwT3K5TwTro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+690d3e3ffa7335ac10eb@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 012/342] netfilter: xt_cpu: prefer raw_smp_processor_id
Date: Tue, 16 Jun 2026 20:25:08 +0530
Message-ID: <20260616145048.876404182@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-266220-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:syzbot+690d3e3ffa7335ac10eb@syzkaller.appspotmail.com,m:fw@strlen.de,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,strlen.de:email,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2C5C69455E

5.10-stable review patch.  If anyone has any objections, please let me know.

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




