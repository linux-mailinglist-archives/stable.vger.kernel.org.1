Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DC37831DA
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjHUUHY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjHUUHY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7804BE3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 163BA649A4
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E50C433C8;
        Mon, 21 Aug 2023 20:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648441;
        bh=QF3DELslLF2bvZP+XIcw45e4YuYmOEZLSjnL3WPncQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pWjDqsbXhQNxrASUBFxHlYJgveH2MTSD43ABnnj3uEuJfg8ck4KodswNvFvDr0g8B
         8flzINwGQZcsFM6MHsilzvDT/z9rxe0v04pu6OO7Ophh9uaOUKJRgxLGkpjwiLZ5/w
         oYp1pBnMRscsqbCsAZzAcZlsskQ0k2dx1r2r52ww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abel Wu <wuyun.abel@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 176/234] sock: Fix misuse of sk_under_memory_pressure()
Date:   Mon, 21 Aug 2023 21:42:19 +0200
Message-ID: <20230821194136.631558457@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Abel Wu <wuyun.abel@bytedance.com>

[ Upstream commit 2d0c88e84e483982067a82073f6125490ddf3614 ]

The status of global socket memory pressure is updated when:

  a) __sk_mem_raise_allocated():

	enter: sk_memory_allocated(sk) >  sysctl_mem[1]
	leave: sk_memory_allocated(sk) <= sysctl_mem[0]

  b) __sk_mem_reduce_allocated():

	leave: sk_under_memory_pressure(sk) &&
		sk_memory_allocated(sk) < sysctl_mem[0]

So the conditions of leaving global pressure are inconstant, which
may lead to the situation that one pressured net-memcg prevents the
global pressure from being cleared when there is indeed no global
pressure, thus the global constrains are still in effect unexpectedly
on the other sockets.

This patch fixes this by ignoring the net-memcg's pressure when
deciding whether should leave global memory pressure.

Fixes: e1aab161e013 ("socket: initial cgroup code.")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Link: https://lore.kernel.org/r/20230816091226.1542-1-wuyun.abel@bytedance.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h | 6 ++++++
 net/core/sock.c    | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index ad468fe71413a..415f3840a26aa 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1421,6 +1421,12 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 	return sk->sk_prot->memory_pressure != NULL;
 }
 
+static inline bool sk_under_global_memory_pressure(const struct sock *sk)
+{
+	return sk->sk_prot->memory_pressure &&
+		!!*sk->sk_prot->memory_pressure;
+}
+
 static inline bool sk_under_memory_pressure(const struct sock *sk)
 {
 	if (!sk->sk_prot->memory_pressure)
diff --git a/net/core/sock.c b/net/core/sock.c
index 1f31a97100d4f..8451a95266bf0 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3107,7 +3107,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
 
-	if (sk_under_memory_pressure(sk) &&
+	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
 }
-- 
2.40.1



