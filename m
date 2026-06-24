Return-Path: <stable+bounces-268144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y8ZLLgK5O2p6bwgAu9opvQ
	(envelope-from <stable+bounces-268144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 13:01:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 132A36BD886
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 13:01:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=f3yWLuUB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268144-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268144-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF89A303FF3A
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC682E764D;
	Wed, 24 Jun 2026 11:01:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ABA1FC7C5
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 11:01:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782298866; cv=none; b=IDT2Q4ZsRmLBUypigOv9sbOQHb8iSMArtjqS8ZB4j+MiiApzuF2fLP27MeamviGXuWqHTMweomMntljdCJSPobQUbw/jsE67/eGVADRcc/18QnDfcpOV+ulYZshY2ZAO+gBMKXi2VZF1S5wXB8+TkWfEtccXbrIKtGqbkmsjtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782298866; c=relaxed/simple;
	bh=Bg/C650zMhhzCeh8uDt6OlrHOje50P0/4D6oNiD3c+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPq7Ekbg5VYruZfTJNHF80StJCd/WTftRLtOhEEXkbNTax4ZmY7fcAY7ce2x4TcUy/ylQKuR5/HKA6mhL2hY3WJUC3NqZoUvGZ1bD/N8ltz+EiVvvP55tJCpRZiYEet6SzqcegoKf2X7YuLd3SCtxbaj1qHFnsbV+e1BUURXvbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3yWLuUB; arc=none smtp.client-ip=209.85.208.174
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3967738c801so7193401fa.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782298863; x=1782903663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pxuVeaMBnszMeRz8ajoDN+MAccCemdt9YS/JX9ZEN0=;
        b=f3yWLuUBgY0PTcUmu9w6/rRbK+mvr4YY3qFzeHPqT9gOoUZiX0m7TE6mZUyMqJ78eL
         QbsETAYUcMLs8bdD1WQrGo223rNZm5FI0Cvg/YnZusZ8hNCrOwR3QFuc0y5GSk7qImdQ
         CBkOzGYHSvIZQi0ZTLdulBLrDSRnbzO1foYoja6SwT5KE75fXGzjTXUyqw+th1U7E06W
         Moj2BZhAugG6VNL1emjdLkydzCuAcT3AznnxfydKt2T6ngLcLtbg5e6VMEpwfluZe6Gt
         8tYvDKEYSaaRnC4zKqdIQVS/buk0Z9Kt8NkP6y84ib/LEsrhYBeTRM0Szxllo7Ecubgm
         1xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782298863; x=1782903663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pxuVeaMBnszMeRz8ajoDN+MAccCemdt9YS/JX9ZEN0=;
        b=hjbU6mp9U1uTVwqZm0M1Djtk6yP4xpldqnpm90HumhuJjDkHmbbdIcASA50StbKdm7
         P2RhP+ssGd7y6MjXPfnOBulGQyrDFpds/b62lxg/9PpWG1KDy72de1WSvd/yzaWCm1hj
         5Xcx+zBT9GCrwB4fxRkffvFXbTQyKpcwVxGRXkvEcD29fWJWyGrrIhiraSDppSXj9EMl
         irnob7XhdYNgv+mxvSIRHPaKeqLKsiSJmoA6zfqb9KvcLZjLD+jdWYuqD0rVZ38iGNld
         4a/vb1c96Ra7qeTjfwfXMImkRC0ih6y+re3L+9E2HqwFp0XxeBglrsBwQ+OuZ9GKNICm
         Aydw==
X-Gm-Message-State: AOJu0YxzLpGpIgjVaOpEVgUHr6BnSj8BjqyR38qUAwm5CuwXWoa66jm/
	PajFymJUXQrRecZuDt31X1X0IfKRLrXNX0q9BWbrmcNr81pvUCdheYQrr2jDz2NkMqw=
X-Gm-Gg: AfdE7clMK0BeuAZKZJL0u9SFiorPeKKG+Gmq4ag9YYhcVjI7WBTPv2OdIwTdl21BMl2
	Uj7MkEd5ki8CCQ71ypsBrgFdyutW8I3NkIr4eNrAD7IWXfEKYTVclLdHnVIwNI3Xn75HEcUYQ3R
	s4sY6/hPPtRvlQ8EEz5Wcsvoxjt2lTQ5koC02tnz/TZSiX4raSpxIEp0GyIStNHe+Y/g/GRemdR
	Dxglz9oISEJPHd7PvIp2u4vi24mU4qJycXQI304ap5fubxb8E2GSyPXuxGO6uKHZPCiLKgFniuB
	stN78vu0ygQwhdYuY56zEGWc7BzIyI3+XPf9vIfuRn0m+iukYPpdYItQPuIRi+OpESXO4cxAxcK
	STESKS0zoxhCsey7jlomK6kc9C5KYHxQhxrQjcMaT+wksGx+Hm7G/Q+WTp1etDQfrxJdTmAreJF
	a2GAJ3g9NPPArJhfxz1cwWqjgu23Fy/C6/hafixIM=
X-Received: by 2002:a05:6512:2c0c:b0:5aa:6d0f:d74e with SMTP id 2adb3069b0e04-5ae9d56fe99mr792437e87.3.1782298862200;
        Wed, 24 Jun 2026 04:01:02 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad695509dfsm1630422e87.18.2026.06.24.04.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:01:00 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	netfilter-devel@vger.kernel,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH 5.10] netfilter: nf_log: validate MAC header was set before dumping it
Date: Wed, 24 Jun 2026 14:01:15 +0000
Message-ID: <20260624140117.19799-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	DATE_IN_FUTURE(4.00)[2];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268144-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,netfilter.org,strlen.de,davemloft.net,ms2.inr.ac.ru,linux-ipv6.org,kernel.org,trash.net,vger.kernel,vger.kernel.org,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:alexevgmart@gmail.com,m:pablo@netfilter.org,m:kadlec@netfilter.org,m:fw@strlen.de,m:davem@davemloft.net,m:kuznet@ms2.inr.ac.ru,m:yoshfuji@linux-ipv6.org,m:kuba@kernel.org,m:kaber@trash.net,m:netfilter-devel@vger.kernel,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,netfilter.org:email,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 132A36BD886

From: Xiang Mei <xmei5@asu.edu>

commit a84b6fedbc97078788be78dbdd7517d143ad1a77 upstream

The fallback path of dump_mac_header() guards the MAC header access
only with "skb->mac_header != skb->network_header", without checking
skb_mac_header_was_set(). When the MAC header is unset, mac_header is
0xffff, so the test passes and skb_mac_header(skb) returns
skb->head + 0xffff, ~64 KiB past the buffer; the loop then reads
dev->hard_header_len bytes out of bounds into the kernel log.

This is reachable via the netdev logger: nf_log_unknown_packet() calls
dump_mac_header() unconditionally, and an skb sent through AF_PACKET
with PACKET_QDISC_BYPASS reaches the egress hook with mac_header still
unset (__dev_queue_xmit(), which would reset it, is bypassed).

Add the skb_mac_header_was_set() check the ARPHRD_ETHER path already
uses, and replace the open-coded MAC header length test with
skb_mac_header_len(). Only skbs with an unset MAC header are affected;
valid ones are dumped as before.

 BUG: KASAN: slab-out-of-bounds in dump_mac_header (net/netfilter/nf_log_syslog.c:831)
 Read of size 1 at addr ffff88800ea49d3f by task exploit/148
 Call Trace:
  kasan_report (mm/kasan/report.c:595)
  dump_mac_header (net/netfilter/nf_log_syslog.c:831)
  nf_log_netdev_packet (net/netfilter/nf_log_syslog.c:938 net/netfilter/nf_log_syslog.c:963)
  nf_log_packet (net/netfilter/nf_log.c:260)
  nft_log_eval (net/netfilter/nft_log.c:60)
  nft_do_chain (net/netfilter/nf_tables_core.c:285)
  nft_do_chain_netdev (net/netfilter/nft_chain_filter.c:307)
  nf_hook_slow (net/netfilter/core.c:619)
  nf_hook_direct_egress (net/packet/af_packet.c:257)
  packet_xmit (net/packet/af_packet.c:280)
  packet_sendmsg (net/packet/af_packet.c:3114)
  __sys_sendto (net/socket.c:2265)

Fixes: 7eb9282cd0ef ("netfilter: ipt_LOG/ip6t_LOG: add option to print decoded MAC header")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-52942
 net/ipv4/netfilter/nf_log_ipv4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/netfilter/nf_log_ipv4.c b/net/ipv4/netfilter/nf_log_ipv4.c
index d07583fac8f8..d6164e8e2c73 100644
--- a/net/ipv4/netfilter/nf_log_ipv4.c
+++ b/net/ipv4/netfilter/nf_log_ipv4.c
@@ -296,8 +296,8 @@ static void dump_ipv4_mac_header(struct nf_log_buf *m,
 
 fallback:
 	nf_log_buf_add(m, "MAC=");
-	if (dev->hard_header_len &&
-	    skb->mac_header != skb->network_header) {
+	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
+	    skb_mac_header_len(skb) != 0) {
 		const unsigned char *p = skb_mac_header(skb);
 		unsigned int i;
 
-- 
2.43.0


