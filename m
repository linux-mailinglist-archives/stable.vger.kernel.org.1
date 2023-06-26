Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE1173EC4D
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 22:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjFZU7l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZU7k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 16:59:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2963012A
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 13:59:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fa7cd95dacso46540035e9.3
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687813177; x=1690405177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKBuL0o49Zdsxh1tx7cIjFFXogUch8m75MPWRlC/xp0=;
        b=REGOn3bfUWvmFtYTcLWuNHu3tMsMMdbykPif2q5QQbbK43XQfZVNmqpylFgqQ+09UR
         V9URMl4NX4eKh6VF/ib0NXVdQS2fez18OEHJ0eAmcomEnQWQ+ugz1QsWKnpDmsfsmSTA
         mJo3d7UKNkrfyQAYkpVdfISi5yTbZYokWUrYbCBNxyQX1JFso3xFa6KhcArSRzHXCmk7
         yeScAGOPHbUzvflrB385ZkdBu/VquKUO4Qq1vQvPIpCPg48JMkYd6NTPqWjaQ7nOMASd
         yLFMgN/vabbom6vVpOfeKmvFXBRUtTZmB8gQQHpqBgvSq2XDP+/U9j1UvGUGgvJH0JjB
         Wehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687813177; x=1690405177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKBuL0o49Zdsxh1tx7cIjFFXogUch8m75MPWRlC/xp0=;
        b=PEmowqktnttC1T7qkFUwDnZc/0XJtYJx7p+OBYEEXa0r/4EPR9V1ODix2PzI/7OvT3
         tH45KcC2yrE8fy1cmSjyecKJp2Iuf9evFfSSocdfsZxXb7b84WmSYYTMXL0KkqmI+aNi
         qNS856+QvsQJXDkjr0MMAdnxllgUMf3Kg8iK9wpQAECHN3jnGR0gjVbWwb41bZCx5Tjh
         JZdJlG/0MDJXw/BEgWP3wqcWQsKy/OzV97r6sxYrCA1IfpzPW2XMJnlmwKcio37AllJX
         Ggdcyp2x3EItBkn2w7kAx7ZU0otiYbm/MNOuzz+f0Yc3v4hvwiVjuIHcz2kv2fpzofXe
         Av1A==
X-Gm-Message-State: AC+VfDwMBmBXJGDSWJ94Tt+FrLaBftkZ6+zBMZZflKlo513b42M3xJcG
        Ki7tH/cUJGBOLl4jsK1NicxrJOySuvb5gzVPdSKYXw==
X-Google-Smtp-Source: ACHHUZ40AMydsdjeF5oucXWm2K7f3MWNLSKXFPg9JO0lG5MMC8NXGyLZx/ByCHuK3q/8UzfmG8e1pw==
X-Received: by 2002:a5d:6711:0:b0:30f:c298:601d with SMTP id o17-20020a5d6711000000b0030fc298601dmr24514095wru.5.1687813177258;
        Mon, 26 Jun 2023 13:59:37 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b0030647449730sm8444962wrv.74.2023.06.26.13.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:59:37 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] mptcp: ensure listener is unhashed before updating the sk status
Date:   Mon, 26 Jun 2023 22:59:18 +0200
Message-Id: <20230626205918.1651862-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062330-scrawny-capture-257c@gregkh>
References: <2023062330-scrawny-capture-257c@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3520; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=dVYThFo7Jv24VqPYlxEu4Cw0mfuN+r0x6vLNVORZ59Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkmfwmnYZsXIAHN18TFz6PLV3tNTZ4cs5A7uQRB
 UnLWByBsj2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJn8JgAKCRD2t4JPQmmg
 c20AEACMUZ6Nx8A7npsH8eDHhBCxZ4UfX4JBUipgfHtsfMKa772cCWukMwYO87IAZtQiUO5vZGS
 3ibxecY+5LyZCZzW+TDdRjHH+t3TqDNpCG1sqsfVUhuU2jihf+Ppt4zbfnTLchwlvlAlkbAv6Xi
 MvIvoEqPSZJIXRa7RutgOONMQuIfQnWQnF0BkzCXMnQdhYfi9T+MIK2DGYhUtMFBNXjnMECLn6M
 eeQYJZPOptwlaRfsRz2p1WrJGH33pcMoq4B2iQ+kiTEmGdkcCv2Iisd4/546NarB2nBP885gpvX
 Ei1RVFxNrcLBVJc3f1vECNQ0DzfN9vlri4GUOgUKxRD8BGqpAn1kmHxlH/LaiULiPsxlIEAIbz8
 Ac/UcmgM6RSOMo3XsEA9VyrMkw4Op4TUGHYlQ8ASYDWp4kccT4sdV2/PSvaEyI5mmk50IYQBlaN
 vFN4RDg3hL67BvGKt3J4SdLrdGum9BKNkAx/0JSASI3NH5SkET4AalOqx36NUR2vJxUrIS3sU+v
 WLLdMR8wLPXmNR6BKvWSlnqAkfp8fmU4iaJOjZ7A6puQtwQfKm84TyeStnvKKmyrfw+38locEwS
 6ohcPqggEP3BcfleX0SRWGti0bwOrk8lLBShmRH+gXObulpgMESKSX3vedCTRO7WW4xhOi/KyZR rHEIDld9OSVS/Bg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit 57fc0f1ceaa4016354cf6f88533e20b56190e41a upstream.

The MPTCP protocol access the listener subflow in a lockless
manner in a couple of places (poll, diag). That works only if
the msk itself leaves the listener status only after that the
subflow itself has been closed/disconnected. Otherwise we risk
deadlock in diag, as reported by Christoph.

Address the issue ensuring that the first subflow (the listener
one) is always disconnected before updating the msk socket status.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/407
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Conflicting with c558246ee73e ("mptcp: add statistics for mptcp socket
in use"): I took the new modifications without the ones modifying the
'inuse' counters.
It was on top of 786eda7a0c19 ("Linux 6.1.36-rc1")
---
 net/mptcp/pm_netlink.c |  1 +
 net/mptcp/protocol.c   | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 01d34ee4525e..9127a7fd5269 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1039,6 +1039,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 		return err;
 	}
 
+	inet_sk_state_store(newsk, TCP_LISTEN);
 	err = kernel_listen(ssock, backlog);
 	if (err) {
 		pr_warn("kernel_listen error, err=%d", err);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a2c6ce40e426..4ca61e80f4bb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2400,12 +2400,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		kfree_rcu(subflow, rcu);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
-		if (ssk->sk_state == TCP_LISTEN) {
-			tcp_set_state(ssk, TCP_CLOSE);
-			mptcp_subflow_queue_clean(sk, ssk);
-			inet_csk_listen_stop(ssk);
-		}
-
 		__tcp_close(ssk, 0);
 
 		/* close acquired an extra ref */
@@ -2939,6 +2933,24 @@ static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
 	return EPOLLIN | EPOLLRDNORM;
 }
 
+static void mptcp_check_listen_stop(struct sock *sk)
+{
+	struct sock *ssk;
+
+	if (inet_sk_state_load(sk) != TCP_LISTEN)
+		return;
+
+	ssk = mptcp_sk(sk)->first;
+	if (WARN_ON_ONCE(!ssk || inet_sk_state_load(ssk) != TCP_LISTEN))
+		return;
+
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	mptcp_subflow_queue_clean(sk, ssk);
+	inet_csk_listen_stop(ssk);
+	tcp_set_state(ssk, TCP_CLOSE);
+	release_sock(ssk);
+}
+
 bool __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2949,6 +2961,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
+		mptcp_check_listen_stop(sk);
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
 	}
@@ -3062,6 +3075,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (msk->fastopening)
 		return -EBUSY;
 
+	mptcp_check_listen_stop(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_timer(sk);
-- 
2.40.1

