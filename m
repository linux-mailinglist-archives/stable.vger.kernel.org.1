Return-Path: <stable+bounces-24149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C71B8692E2
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B781C22552
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597C213B78A;
	Tue, 27 Feb 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdmwIViy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ED513B2A2;
	Tue, 27 Feb 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041168; cv=none; b=fSV+rEzfXI7mtNFklpFXydjRODHs1geSWH1RU1lhwI+uXwiKYp7Pydbn9iYMd/oQ3ExsTyudoLxR6HqTUFzMYU+qtOsT5MZyQrteffAE0qdF601i48tfdGp1inBg5HU1epHlAFFPsNNsOhcFIho0yhulHdjmukvQJOyxhtNu28g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041168; c=relaxed/simple;
	bh=t9dTvVJdBnUr1rTXJkdG/piiWvP9ETTRgc2faxbwwKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuXVTVSxBiQdsUTGgVhhaRIDU77cuiguS03LF0S0NP2z/09rhp9WCiLUwEgYBT2parKd5BeSlmzAhSeaysXVEJ1yUDh8xyUaZl7/9amZnOsPp+eWmzkHcglctEsNJFSXCrSNnDA+gP2D4tlIpauprfBDFAnT6E2nM9qkOstcO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdmwIViy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97971C433C7;
	Tue, 27 Feb 2024 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041168;
	bh=t9dTvVJdBnUr1rTXJkdG/piiWvP9ETTRgc2faxbwwKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdmwIViypeTY++pTZx32USZjHwlwEfMhdQYGsbpwdU5uPW4sdM7+eFIC4pW0aGV6e
	 spk8Wud5eJX/fVz8VPXvH9FSeoNdKUPj7P4rl3L8OqzdOW6G1rhj9Su+nAknFtepN5
	 /a1MgDq/lVtNhEvUmdgNzfP7XSiX7bR5HfU5Vb54=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.7 215/334] mptcp: fix lockless access in subflow ULP diag
Date: Tue, 27 Feb 2024 14:21:13 +0100
Message-ID: <20240227131637.716266321@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit b8adb69a7d29c2d33eb327bca66476fb6066516b upstream.

Since the introduction of the subflow ULP diag interface, the
dump callback accessed all the subflow data with lockless.

We need either to annotate all the read and write operation accordingly,
or acquire the subflow socket lock. Let's do latter, even if slower, to
avoid a diffstat havoc.

Fixes: 5147dfb50832 ("mptcp: allow dumping subflow context to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h  |    2 +-
 net/mptcp/diag.c   |    6 +++++-
 net/tls/tls_main.c |    2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2502,7 +2502,7 @@ struct tcp_ulp_ops {
 	/* cleanup ulp */
 	void (*release)(struct sock *sk);
 	/* diagnostic */
-	int (*get_info)(const struct sock *sk, struct sk_buff *skb);
+	int (*get_info)(struct sock *sk, struct sk_buff *skb);
 	size_t (*get_info_size)(const struct sock *sk);
 	/* clone ulp */
 	void (*clone)(const struct request_sock *req, struct sock *newsk,
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -13,17 +13,19 @@
 #include <uapi/linux/mptcp.h>
 #include "protocol.h"
 
-static int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
+static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *sf;
 	struct nlattr *start;
 	u32 flags = 0;
+	bool slow;
 	int err;
 
 	start = nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
 	if (!start)
 		return -EMSGSIZE;
 
+	slow = lock_sock_fast(sk);
 	rcu_read_lock();
 	sf = rcu_dereference(inet_csk(sk)->icsk_ulp_data);
 	if (!sf) {
@@ -69,11 +71,13 @@ static int subflow_get_info(const struct
 	}
 
 	rcu_read_unlock();
+	unlock_sock_fast(sk, slow);
 	nla_nest_end(skb, start);
 	return 0;
 
 nla_failure:
 	rcu_read_unlock();
+	unlock_sock_fast(sk, slow);
 	nla_nest_cancel(skb, start);
 	return err;
 }
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1003,7 +1003,7 @@ static u16 tls_user_config(struct tls_co
 	return 0;
 }
 
-static int tls_get_info(const struct sock *sk, struct sk_buff *skb)
+static int tls_get_info(struct sock *sk, struct sk_buff *skb)
 {
 	u16 version, cipher_type;
 	struct tls_context *ctx;



