Return-Path: <stable+bounces-265016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id voAxKoKDMWpMlQUAu9opvQ
	(envelope-from <stable+bounces-265016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:10:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE9B692CED
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:10:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=jyxwDExH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265016-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265016-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1A63301CF7D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B033AD9B;
	Tue, 16 Jun 2026 16:57:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEB466B4B;
	Tue, 16 Jun 2026 16:57:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629054; cv=none; b=R4PLNBL8zc36UVN9hMAFfi/CegtnuU4L2bP54Rh5KIWU6s2c6APwR+oZerVyLLOtrBQBX3s/ykvNPLKoTXOX2hvMLhdpNK2bLL4YwNBuVGwimg61hDfT3pMPyIflZQJnf71gvVWnpnIP9paOs9opS/P21kGPnBEHAH75KhRnWbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629054; c=relaxed/simple;
	bh=pdxEX5zP8XEinWwpZgmK2C1qb8IRrphbPb8qGB8WeG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UU8yyKhhN+68U5UgCSt20XD/lYAf/eJIkjWxExLS6c69G8cx40XA6JxQWFSegOlbUdtrlt/7uD0+83lQXt9sCicJeuH8NHUqJkG4zGcqxWaO8YY1swt/zF0HnrbC9OFrBwxL0vn4CwWDWXFMY/1l4hBGc289p3JESP9zwXBpjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jyxwDExH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EA01F000E9;
	Tue, 16 Jun 2026 16:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629053;
	bh=Pd7JnGUar0/c3YHZXw+VgCtoe0Q4AZLFEb1sAwRNMB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jyxwDExHSJuosQOWJqdzgIDgtfKBtobRGrNZdPtLj8NkTgKVBcfonKRjFKd0XuBYg
	 2APq1DwMrTTSJWzrnbsqLwpuBFWfVd0iencCw5GFagUMVdnmCMXOcDM05Jg8ki6XHK
	 DTJOxQd7okI0jE4GDnXBmlw+HTYPbbVmk992I1g8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leo Lin <leo@depthfirst.com>,
	David Ahern <dahern@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 211/452] ipv6: mcast: Fix use-after-free when processing MLD queries
Date: Tue, 16 Jun 2026 20:27:18 +0530
Message-ID: <20260616145128.884895411@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-265016-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:leo@depthfirst.com,m:dahern@nvidia.com,m:idosch@nvidia.com,m:edumazet@google.com,m:jiayuan.chen@linux.dev,m:kuba@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp,depthfirst.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBE9B692CED

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

commit 791c91dc7a9dfb2457d5e29b8216a6484b9c4b40 upstream.

When processing an MLD query, a pointer to the multicast group address
is retrieved when initially parsing the packet. This pointer is later
dereferenced without being reloaded despite the fact that the skb header
might have been reallocated following the pskb_may_pull() calls, leading
to a use-after-free [1].

Fix by copying the multicast group address when the packet is initially
parsed.

[1]
BUG: KASAN: slab-use-after-free in __mld_query_work (net/ipv6/mcast.c:1512)
Read of size 8 at addr ffff8881154b8e90 by task kworker/4:1/118

Workqueue: mld mld_query_work
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_address_description.constprop.0 (mm/kasan/report.c:378)
print_report (mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
__mld_query_work (net/ipv6/mcast.c:1512)
mld_query_work (net/ipv6/mcast.c:1563)
process_one_work (kernel/workqueue.c:3314)
worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
</TASK>

[...]

Freed by task 118:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
kasan_save_free_info (mm/kasan/generic.c:584)
__kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
pskb_expand_head (net/core/skbuff.c:2335)
__pskb_pull_tail (net/core/skbuff.c:2878 (discriminator 4))
__mld_query_work (net/ipv6/mcast.c:1495 (discriminator 1))
mld_query_work (net/ipv6/mcast.c:1563)
process_one_work (kernel/workqueue.c:3314)
worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

Fixes: 97300b5fdfe2 ("[MCAST] IPv6: Check packet size when process Multicast")
Reported-by: Leo Lin <leo@depthfirst.com>
Reviewed-by: David Ahern <dahern@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260603101811.612594-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/mcast.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1392,9 +1392,9 @@ out:
 static void __mld_query_work(struct sk_buff *skb)
 {
 	struct mld2_query *mlh2 = NULL;
-	const struct in6_addr *group;
 	unsigned long max_delay;
 	struct inet6_dev *idev;
+	struct in6_addr group;
 	struct ifmcaddr6 *ma;
 	struct mld_msg *mld;
 	int group_type;
@@ -1426,8 +1426,8 @@ static void __mld_query_work(struct sk_b
 		goto kfree_skb;
 
 	mld = (struct mld_msg *)icmp6_hdr(skb);
-	group = &mld->mld_mca;
-	group_type = ipv6_addr_type(group);
+	group = mld->mld_mca;
+	group_type = ipv6_addr_type(&group);
 
 	if (group_type != IPV6_ADDR_ANY &&
 	    !(group_type&IPV6_ADDR_MULTICAST))
@@ -1477,7 +1477,7 @@ static void __mld_query_work(struct sk_b
 		}
 	} else {
 		for_each_mc_mclock(idev, ma) {
-			if (!ipv6_addr_equal(group, &ma->mca_addr))
+			if (!ipv6_addr_equal(&group, &ma->mca_addr))
 				continue;
 			if (ma->mca_flags & MAF_TIMER_RUNNING) {
 				/* gsquery <- gsquery && mark */



