Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFB678AB7C
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjH1KbV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjH1Kay (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6659A1B3
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:30:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF45561E21
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09856C433CD;
        Mon, 28 Aug 2023 10:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218637;
        bh=wdm4rsetILlrx1/CacYiA23mHgJ87Ot6tt4aAN+CfDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GEiw+mqrhFatCo/Yth4Y+3Pl0FAUCBn8csB5GBcoytacN69VK9LWgCVZIuOnFpLNj
         VTebZXmVhL0Ja0aU/WZtEPgnsXbiB2Y1E74E9QHLBbXY9+PX/v1G4nJkZQfFBT0but
         dEW4JHg7G+Gw4OTZuhoFDe60/4IVaR4nlT6VCd+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 030/122] sock: annotate data-races around prot->memory_pressure
Date:   Mon, 28 Aug 2023 12:12:25 +0200
Message-ID: <20230828101157.427001473@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 76f33296d2e09f63118db78125c95ef56df438e9 ]

*prot->memory_pressure is read/writen locklessly, we need
to add proper annotations.

A recent commit added a new race, it is time to audit all accesses.

Fixes: 2d0c88e84e48 ("sock: Fix misuse of sk_under_memory_pressure()")
Fixes: 4d93df0abd50 ("[SCTP]: Rewrite of sctp buffer management code")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Link: https://lore.kernel.org/r/20230818015132.2699348-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h | 7 ++++---
 net/sctp/socket.c  | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 699408944952c..d1f936ed97556 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1320,6 +1320,7 @@ struct proto {
 	/*
 	 * Pressure flag: try to collapse.
 	 * Technical note: it is used by multiple contexts non atomically.
+	 * Make sure to use READ_ONCE()/WRITE_ONCE() for all reads/writes.
 	 * All the __sk_mem_schedule() is of this nature: accounting
 	 * is strict, actions are advisory and have some latency.
 	 */
@@ -1448,7 +1449,7 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 static inline bool sk_under_global_memory_pressure(const struct sock *sk)
 {
 	return sk->sk_prot->memory_pressure &&
-		!!*sk->sk_prot->memory_pressure;
+		!!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
 static inline bool sk_under_memory_pressure(const struct sock *sk)
@@ -1460,7 +1461,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
-	return !!*sk->sk_prot->memory_pressure;
+	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
 static inline long
@@ -1537,7 +1538,7 @@ proto_memory_pressure(struct proto *prot)
 {
 	if (!prot->memory_pressure)
 		return false;
-	return !!*prot->memory_pressure;
+	return !!READ_ONCE(*prot->memory_pressure);
 }
 
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c806d272107ac..83656fe03a0e6 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -98,7 +98,7 @@ struct percpu_counter sctp_sockets_allocated;
 
 static void sctp_enter_memory_pressure(struct sock *sk)
 {
-	sctp_memory_pressure = 1;
+	WRITE_ONCE(sctp_memory_pressure, 1);
 }
 
 
-- 
2.40.1



