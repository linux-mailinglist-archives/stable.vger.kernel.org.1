Return-Path: <stable+bounces-244289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI1uLqyX+mk6QAMAu9opvQ
	(envelope-from <stable+bounces-244289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:21:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FF64D538A
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04FBF301B719
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 01:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2310B212566;
	Wed,  6 May 2026 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wIyDM7JF"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033A257845
	for <stable@vger.kernel.org>; Wed,  6 May 2026 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778030492; cv=none; b=TKDmhauxE/93tBER0qB1pRpupO3zjUpCxe05KedouDj0PDl8DDstjcdxs8kltA1bIfw6x1s3x37DDDmc1cTjeDHNDlRKo/sdwcH0Pw+98n9qsTHxVP2B1mPJb+CBWwKUIF2iKvHmwRbhwSdKi1sdpKG75ehRWhXucauAA9Hpjmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778030492; c=relaxed/simple;
	bh=c1cfG2aonJabf7BhONhUIVthQSLWxd1RrCCj4VTVJZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3q7VebvGNf81GsC/QAzfdP8rY19HaE9W+hJ8aZtPSRQFXB6RPz0ODWSnIJPxOYbpe7RIprQK71NQq+RCpqkwQ7Mdpg2vJbl797FkKMXkWWzy/Yy6K/yZQzxC46edWnbZEUEKTl4HFe761+lUzAjKmQB5M0H5LQllAsBYZbmJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wIyDM7JF; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778030489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FgZWqNO7/35Ij6XHqQM9K7W4BfzuKmWmp4dIAVq7Pa8=;
	b=wIyDM7JFsnvz2RV+OhuGmzk1ap5miiuPe7jIDAZj+f9gANZ0JGGtg2E2p5Sg53pr5+gJ9y
	KZZ18t83tpP24lITtNTvs4bB8+vIZVrrt2uKwdl1U/uedNBYoKMETSeonZR8lgW6T6r0md
	BHvN+GVYdOnUK8DlOY/JYum+AOXAsHU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] net: Fix icmp host relookup triggering ip_rt_bug
Date: Wed,  6 May 2026 09:21:15 +0800
Message-ID: <20260506012115.286204-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: F3FF64D538A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244289-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qemu.org:url,msgid.link:url,huawei.com:email,linux.dev:email,linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Dong Chenchen <dongchenchen2@huawei.com>

[ Upstream commit c44daa7e3c73229f7ac74985acb8c7fb909c4e0a ]

arp link failure may trigger ip_rt_bug while xfrm enabled, call trace is:

WARNING: CPU: 0 PID: 0 at net/ipv4/route.c:1241 ip_rt_bug+0x14/0x20
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00077-g2e1b3cc9d7f7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:ip_rt_bug+0x14/0x20
Call Trace:
 <IRQ>
 ip_send_skb+0x14/0x40
 __icmp_send+0x42d/0x6a0
 ipv4_link_failure+0xe2/0x1d0
 arp_error_report+0x3c/0x50
 neigh_invalidate+0x8d/0x100
 neigh_timer_handler+0x2e1/0x330
 call_timer_fn+0x21/0x120
 __run_timer_base.part.0+0x1c9/0x270
 run_timer_softirq+0x4c/0x80
 handle_softirqs+0xac/0x280
 irq_exit_rcu+0x62/0x80
 sysvec_apic_timer_interrupt+0x77/0x90

The script below reproduces this scenario:
ip xfrm policy add src 0.0.0.0/0 dst 0.0.0.0/0 \
	dir out priority 0 ptype main flag localok icmp
ip l a veth1 type veth
ip a a 192.168.141.111/24 dev veth0
ip l s veth0 up
ping 192.168.141.155 -c 1

icmp_route_lookup() create input routes for locally generated packets
while xfrm relookup ICMP traffic.Then it will set input route
(dst->out = ip_rt_bug) to skb for DESTUNREACH.

For ICMP err triggered by locally generated packets, dst->dev of output
route is loopback. Generally, xfrm relookup verification is not required
on loopback interfaces (net.ipv4.conf.lo.disable_xfrm = 1).

Skip icmp relookup for locally generated packets to fix it.

Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241127040850.1513135-1-dongchenchen2@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
failed backport
https://lore.kernel.org/stable/20250207161555-b1a8749027831a1a@stable.kernel.org/T/#m0c880c1f04f7211aea9b7f6b4de0b64aa1726417
---
 net/ipv4/icmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index b8607763d113..b7bc922be8f2 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -512,6 +512,9 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	if (!IS_ERR(rt)) {
 		if (rt != rt2)
 			return rt;
+		if (inet_addr_type_dev_table(net, route_lookup_dev,
+					     fl4->daddr) == RTN_LOCAL)
+			return rt;
 	} else if (PTR_ERR(rt) == -EPERM) {
 		rt = NULL;
 	} else
-- 
2.43.0


