Return-Path: <stable+bounces-119493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA80A43E97
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E13170A23
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784931E7C0A;
	Tue, 25 Feb 2025 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lIFZERQp"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A6262D03
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484625; cv=none; b=SbUFDAIc034lsP9mW+f45bUf8pP8fVnErbirE8qBg5JYOauiWXdat+PrAD2gDDBsBtNQuHe10YB1RZSlJAK9VtbbYuYeLH01iWbJbtTZG9mczouXo/J3eRDC3xX7PplPXh4vhNGAgekNUetILuE4BNPBu4kCBt3JBaHEz9Rw8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484625; c=relaxed/simple;
	bh=IEQ6uGPDvtf1Uqs79Cda6UYPVcr523SjM4RrddmLdoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JiCRmp0alOZi9eV+fZkOEuugcl+1BSiYK9PftzIgbS0oCF9pLUFL01GUHbSGqipLmXq3Uotsf8oGbIaZpx5fhmZ43HF97lhszSkBepG2LxaWuDSo5MXjIJYjH4im6UCxQqY+fITFPEd5sBd+hmW+BjtS+63vj9FDcIJgzV9fYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lIFZERQp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wRY6f+CK/nRdK+FEU7dDQAV9bNOog/6KnnQXl5mgWNw=; b=lIFZERQpyRKS+dZa8solkdXdmG
	9cqBKQD9GKF+TcjpA5HRzPceP3DntNnxircAKv0A23IfgsS1lJUJQdBq4G7xNwAmBGRV4nCA0TMMP
	pl5t5FJ7vWPkqbwFQPEZV0NtrFpkf/fsEbJUYQdZ/i+f+RhDlSwGtQ7RBSIe91yhUhfvIddlrHHeN
	W3iD+LgFGkmbppTgTyZgqu/ae5HOp7BCibmemtz29Niv5j5Ulb4oQfmwXZnmMqXWZJZcZGtK624s4
	thwXT/+prk8JNgBplacL7WUiANSSkM8xhBFOqtRBUvb+PCDwMJOV8rRyAW2WebY+0eHgtovw5OBIX
	hpKodR2g==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tmtYT-000Ms0-Ih; Tue, 25 Feb 2025 12:56:59 +0100
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Date: Tue, 25 Feb 2025 12:56:28 +0100
Subject: [PATCH 6.6 v2 2/2] tun: Assign missing bpf_net_context.
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v2-2-bc31173653b4@igalia.com>
References: <20250225-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v2-0-bc31173653b4@igalia.com>
In-Reply-To: <20250225-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v2-0-bc31173653b4@igalia.com>
To: stable@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: revest@google.com, kernel-dev@igalia.com, 
 syzbot+0b5c75599f1d872bea6f@syzkaller.appspotmail.com, 
 syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com, 
 syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com, 
 Jakub Kicinski <kuba@kernel.org>
X-Mailer: b4 0.14.2

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit fecef4cd42c689a200bdd39e6fffa71475904bc1 ]

During the introduction of struct bpf_net_context handling for
XDP-redirect, the tun driver has been missed.
Jakub also pointed out that there is another call chain to
do_xdp_generic() originating from netif_receive_skb() and drivers may
use it outside from the NAPI context.

Set the bpf_net_context before invoking BPF XDP program within the TUN
driver. Set the bpf_net_context also in do_xdp_generic() if a xdp
program is available.

Reported-by: syzbot+0b5c75599f1d872bea6f@syzkaller.appspotmail.com
Reported-by: syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com
Reported-by: syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com
Fixes: 401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20240704144815.j8xQda5r@linutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[rcn: Backport the patch to address minor differences in the context lines.
These differences are introduced by upstream commits
4d2bb0bfe874 ("xdp: rely on skb pointer reference in do_xdp_generic and
netif_receive_generic_xdp") and 7cd1107f48e2a ("bpf, xdp: constify some
bpf_prog * function arguments"), which change the parameters in
do_xdp_generic() and in calls to netif_receive_generic_xdp(),
kfree_skb_reason() and generic_xdp_tx(). These changes aren't
significant to the purpose of the patch.]
Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
---
 drivers/net/tun.c | 7 +++++++
 net/core/dev.c    | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c1fdf8804d60b6776b7fb78c41ac041b6aeb5a88..f28f57abe59dc1afca310de8f7a0a69107ec33db 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1668,6 +1668,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     int len, int *skb_xdp)
 {
 	struct page_frag *alloc_frag = &current->task_frag;
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	char *buf;
@@ -1707,6 +1708,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 	local_bh_disable();
 	rcu_read_lock();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
 		struct xdp_buff xdp;
@@ -1735,12 +1737,14 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		pad = xdp.data - xdp.data_hard_start;
 		len = xdp.data_end - xdp.data;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
 
 	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
 
 out:
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
 	return NULL;
@@ -2577,6 +2581,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 
 	if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
 	    ctl && ctl->type == TUN_MSG_PTR) {
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 		struct tun_page tpage;
 		int n = ctl->num;
 		int flush = 0, queued = 0;
@@ -2585,6 +2590,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 
 		local_bh_disable();
 		rcu_read_lock();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 		for (i = 0; i < n; i++) {
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
@@ -2599,6 +2605,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		if (tfile->napi_enabled && queued > 0)
 			napi_schedule(&tfile->napi);
 
+		bpf_net_ctx_clear(bpf_net_ctx);
 		rcu_read_unlock();
 		local_bh_enable();
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 24460c630d3cdfa2490d15969b7ab62b6ce42003..a6a63f5b6b8364d2d24553180d4e2138b13614b9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5051,11 +5051,14 @@ static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
 int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+
 	if (xdp_prog) {
 		struct xdp_buff xdp;
 		u32 act;
 		int err;
 
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		act = netif_receive_generic_xdp(skb, &xdp, xdp_prog);
 		if (act != XDP_PASS) {
 			switch (act) {
@@ -5069,11 +5072,13 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
 				generic_xdp_tx(skb, xdp_prog);
 				break;
 			}
+			bpf_net_ctx_clear(bpf_net_ctx);
 			return XDP_DROP;
 		}
 	}
 	return XDP_PASS;
 out_redir:
+	bpf_net_ctx_clear(bpf_net_ctx);
 	kfree_skb_reason(skb, SKB_DROP_REASON_XDP);
 	return XDP_DROP;
 }

-- 
2.48.1


