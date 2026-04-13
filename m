Return-Path: <stable+bounces-237043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJHECBgg3WndaAkAu9opvQ
	(envelope-from <stable+bounces-237043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:55:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8E23F0416
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F2CF308E0E1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0585330E857;
	Mon, 13 Apr 2026 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ubnsMSvq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3A30C361;
	Mon, 13 Apr 2026 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098442; cv=none; b=CpCPCy9iyUawB2YR9xlNweVJKdDCj+5bqoMw5RTZKFyq50LO1vsixrGNksyHx+etlxpwTKfNzjpuMXHdc1CyoYXBOj7eX1HaZk5C9txQ4sh1Fd0o4oPDfByDQvMKqkMGIWdGwE1OnCE8Xa/ar4/W5LS1a7jpT971Dj9Mgu8LvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098442; c=relaxed/simple;
	bh=ixil2JnuMNJN5l8aE9uMAyA85yu6rVuOG+0Ad8BXWmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKX3YWpKTORW2GIQKIn5LASK6d+JUJQdxcKTESrwvAtqtHh+Kye3sZj78eC2AD3oL8LTh4zs44NnepqzjQClqByqYPuweWqKohkDyyONrxWkWK3uRM5F++bDVCxeKLKzw2bdWljyNN1X2DZLUG+eN2UK9ugopfdIbZpqWyznSBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ubnsMSvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542F7C2BCAF;
	Mon, 13 Apr 2026 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098442;
	bh=ixil2JnuMNJN5l8aE9uMAyA85yu6rVuOG+0Ad8BXWmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubnsMSvq0ZqzUeHDy0WHigCTfFB0WhH7hQTAF72Cr64xk17TwhInUpRA0cJYQXeKm
	 7XjXZqubier8rL+1yWsZb9on9yUCrDpjDhXOFrAec7L5F1IjyxmJPtgv3jJs8zABl0
	 pYlhxehR/PoLvESukG24lJlcV6T5x/iRQBPo2aeI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tuan Do <tuan@calif.io>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH 5.15 526/570] netfilter: nft_ct: fix use-after-free in timeout object destroy
Date: Mon, 13 Apr 2026 18:00:57 +0200
Message-ID: <20260413155850.153569376@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237043-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,strlen.de:email,calif.io:email]
X-Rspamd-Queue-Id: 1A8E23F0416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tuan Do <tuan@calif.io>

commit f8dca15a1b190787bbd03285304b569631160eda upstream.

nft_ct_timeout_obj_destroy() frees the timeout object with kfree()
immediately after nf_ct_untimeout(), without waiting for an RCU grace
period. Concurrent packet processing on other CPUs may still hold
RCU-protected references to the timeout object obtained via
rcu_dereference() in nf_ct_timeout_data().

Add an rcu_head to struct nf_ct_timeout and use kfree_rcu() to defer
freeing until after an RCU grace period, matching the approach already
used in nfnetlink_cttimeout.c.

KASAN report:
 BUG: KASAN: slab-use-after-free in nf_conntrack_tcp_packet+0x1381/0x29d0
 Read of size 4 at addr ffff8881035fe19c by task exploit/80

 Call Trace:
  nf_conntrack_tcp_packet+0x1381/0x29d0
  nf_conntrack_in+0x612/0x8b0
  nf_hook_slow+0x70/0x100
  __ip_local_out+0x1b2/0x210
  tcp_sendmsg_locked+0x722/0x1580
  __sys_sendto+0x2d8/0x320

 Allocated by task 75:
  nft_ct_timeout_obj_init+0xf6/0x290
  nft_obj_init+0x107/0x1b0
  nf_tables_newobj+0x680/0x9c0
  nfnetlink_rcv_batch+0xc29/0xe00

 Freed by task 26:
  nft_obj_destroy+0x3f/0xa0
  nf_tables_trans_destroy_work+0x51c/0x5c0
  process_one_work+0x2c4/0x5a0

Fixes: 7e0b2b57f01d ("netfilter: nft_ct: add ct timeout support")
Cc: stable@vger.kernel.org
Signed-off-by: Tuan Do <tuan@calif.io>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_conntrack_timeout.h |    1 +
 net/netfilter/nft_ct.c                       |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/include/net/netfilter/nf_conntrack_timeout.h
+++ b/include/net/netfilter/nf_conntrack_timeout.h
@@ -14,6 +14,7 @@
 struct nf_ct_timeout {
 	__u16			l3num;
 	const struct nf_conntrack_l4proto *l4proto;
+	struct rcu_head		rcu;
 	char			data[];
 };
 
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -935,7 +935,7 @@ static void nft_ct_timeout_obj_destroy(c
 	nf_queue_nf_hook_drop(ctx->net);
 	nf_ct_untimeout(ctx->net, timeout);
 	nf_ct_netns_put(ctx->net, ctx->family);
-	kfree(priv->timeout);
+	kfree_rcu(priv->timeout, rcu);
 }
 
 static int nft_ct_timeout_obj_dump(struct sk_buff *skb,



