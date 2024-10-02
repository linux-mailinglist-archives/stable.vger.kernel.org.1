Return-Path: <stable+bounces-78768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC3498D4D9
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7164D28471D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E60A1D078D;
	Wed,  2 Oct 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X00d+fEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09161D0794;
	Wed,  2 Oct 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875474; cv=none; b=XBWIyRM3zxcrwNdSXm5myZ8XDTwAxQcY2sMI3IkAP0SaySg85fRnXFCAQWchKzNcDfNTgYLEMtKIo98VvUyzHFPLwHpY07f2EZkhkrlCCWzxoaIZZTqx1ENf38hEW3B/BajHGfDGe3cWEOWXhr1mgio2r4eUDB7XFyyq42f8IyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875474; c=relaxed/simple;
	bh=w8NuzBhNwe8FyJeXm+JUYXqpiBRCG1UQ98+TgzLPt/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mST9BQTtxuyk/YrQ+oTHxspf93eu6zUpza4/2tmu4thWPhcxRs/EhnAtTZneLVVT693Ric7cz51+i144amtrXuoN1jYuLrz0oviy/uPN8k+LUkIiCwCdXyzbdigFtoLkv/fszIRtzwY2D1OOOPzQUDjEsAf6M3Z2X7pxx+slC7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X00d+fEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D369FC4CEC5;
	Wed,  2 Oct 2024 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875474;
	bh=w8NuzBhNwe8FyJeXm+JUYXqpiBRCG1UQ98+TgzLPt/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X00d+fEa3pJ79NDtmaGOwoym/0tmT27kkZlgXhwzVqFm1xFx2Z462TfRGr0Sc9zKG
	 AOPcbWaOb9tPs7hPrrpAGQE6upHyOr/sghoEm1ygbBZ3ESguewJgEOwFtsZt3o8puh
	 Bey2USPmRtsYHKNaseUXghFFx6nFL9guNzfi48VM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 112/695] netkit: Assign missing bpf_net_context
Date: Wed,  2 Oct 2024 14:51:50 +0200
Message-ID: <20241002125826.943560475@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 157f29152b61ca41809dd7ead29f5733adeced19 ]

During the introduction of struct bpf_net_context handling for
XDP-redirect, the netkit driver has been missed, which also requires it
because NETKIT_REDIRECT invokes skb_do_redirect() which is accessing the
per-CPU variables. Otherwise we see the following crash:

	BUG: kernel NULL pointer dereference, address: 0000000000000038
	bpf_redirect()
	netkit_xmit()
	dev_hard_start_xmit()

Set the bpf_net_context before invoking netkit_xmit() program within the
netkit driver.

Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20240912155620.1334587-1-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netkit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 16789cd446e9e..3f4187102e773 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -65,6 +65,7 @@ static struct netkit *netkit_priv(const struct net_device *dev)
 
 static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct netkit *nk = netkit_priv(dev);
 	enum netkit_action ret = READ_ONCE(nk->policy);
 	netdev_tx_t ret_dev = NET_XMIT_SUCCESS;
@@ -72,6 +73,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct net_device *peer;
 	int len = skb->len;
 
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	rcu_read_lock();
 	peer = rcu_dereference(nk->peer);
 	if (unlikely(!peer || !(peer->flags & IFF_UP) ||
@@ -110,6 +112,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 		break;
 	}
 	rcu_read_unlock();
+	bpf_net_ctx_clear(bpf_net_ctx);
 	return ret_dev;
 }
 
-- 
2.43.0




