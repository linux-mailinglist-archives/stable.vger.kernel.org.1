Return-Path: <stable+bounces-63988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5799941B98
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E141F23F72
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4421898F8;
	Tue, 30 Jul 2024 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aJD+WiB2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65290184549;
	Tue, 30 Jul 2024 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358608; cv=none; b=Uw79jPvGAnpVuQ0qBklkiL0D8HtpD3nbeTb5bBQqRJdNCbeaT76+0+7pd5GYOv+AIQVtsstaUtQLxE1zJJ+Jk/K9IWTtpRPsaRCVP7GwY2KM/7XdbWhquntDV5KmJUY7edHICFoNRdTNW8GErZm69PpcgJLM3hJtNcmx+steEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358608; c=relaxed/simple;
	bh=pL7ZAIs+TFJcVewFuOzADS6MncS9bacZVb52YYEqAlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbpBdhrdaNnYlKMP7Ksy8rQ4NPyodzdIlPFv96ujLkgUmcyHv20I1FxqwK/hxet0o1NK44MvyD5bdnLP4Dy9122YwD4EbLR6wRGcUaD1nUrjs04mV+9JOaz+FGY78NyT1NI18eYM5IpJJGz3Isa/UgZs4PG6Brtew0YG6gE2RIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aJD+WiB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1467C32782;
	Tue, 30 Jul 2024 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358608;
	bh=pL7ZAIs+TFJcVewFuOzADS6MncS9bacZVb52YYEqAlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJD+WiB2w6LHGt/DVJHrSRZYWAh0LPkKghpf+5wDZ3xpP2hMWqVHyCGRPNI6NCFfJ
	 wxeiI2o89enEpdmufydOAlZuhU2Z52YvJVr2vqBZgMC8VRax7vOvHjxv5+r25kpo0V
	 V+NEOhsrsbBoHDk08jqbEHXvTJe+1ug8jUZMcI3I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Michal Luczaj <mhal@rbox.co>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 406/440] af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
Date: Tue, 30 Jul 2024 17:50:39 +0200
Message-ID: <20240730151631.654731237@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 638f32604385fd23059985da8de918e9c18f0b98 ]

AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
with an `oob_skb` pointer. BPF redirecting does not account for that: when
an OOB packet is moved between sockets, `oob_skb` is left outdated. This
results in a single skb that may be accessed from two different sockets.

Take the easy way out: silently drop MSG_OOB data targeting any socket that
is in a sockmap or a sockhash. Note that such silent drop is akin to the
fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).

For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20240713200218.2140950-2-mhal@rbox.co
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
 net/unix/unix_bpf.c |  3 +++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3905cdcaa5184..db71f35b67b86 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2710,10 +2710,49 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
 static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
+	struct unix_sock *u = unix_sk(sk);
+	struct sk_buff *skb;
+	int err;
+
 	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED))
 		return -ENOTCONN;
 
-	return unix_read_skb(sk, recv_actor);
+	mutex_lock(&u->iolock);
+	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
+	mutex_unlock(&u->iolock);
+	if (!skb)
+		return err;
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	if (unlikely(skb == READ_ONCE(u->oob_skb))) {
+		bool drop = false;
+
+		unix_state_lock(sk);
+
+		if (sock_flag(sk, SOCK_DEAD)) {
+			unix_state_unlock(sk);
+			kfree_skb(skb);
+			return -ECONNRESET;
+		}
+
+		spin_lock(&sk->sk_receive_queue.lock);
+		if (likely(skb == u->oob_skb)) {
+			WRITE_ONCE(u->oob_skb, NULL);
+			drop = true;
+		}
+		spin_unlock(&sk->sk_receive_queue.lock);
+
+		unix_state_unlock(sk);
+
+		if (drop) {
+			WARN_ON_ONCE(skb_unref(skb));
+			kfree_skb(skb);
+			return -EAGAIN;
+		}
+	}
+#endif
+
+	return recv_actor(sk, skb);
 }
 
 static int unix_stream_read_generic(struct unix_stream_read_state *state,
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index bd84785bf8d6c..bca2d86ba97d8 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -54,6 +54,9 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	struct sk_psock *psock;
 	int copied;
 
+	if (flags & MSG_OOB)
+		return -EOPNOTSUPP;
+
 	if (!len)
 		return 0;
 
-- 
2.43.0




