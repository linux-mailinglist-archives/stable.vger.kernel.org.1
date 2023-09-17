Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD57A3ABB
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbjIQUID (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbjIQUHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:07:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6DCF3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:07:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9689FC433C8;
        Sun, 17 Sep 2023 20:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981267;
        bh=Kb4hDg9erNmJlflywbwn7t6n8FXOmdmrPJXWqYn/Zlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oz1lC9IpmB0qpEYLzgBTqWJusmDysaQJRKZPpMOrLY8GcOrV9qzN6ZhGwharyYtzB
         VmqsnyEuDAHoPn9kE2AVFUsLCsSWDOx52N75VY36dpP6bIneI7q8vTi8dcbwfN0h4g
         E0aYxPruK22PRDwaSnzPIKiABkI0ystDVgTWyyfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 097/219] net: use sk_forward_alloc_get() in sk_get_meminfo()
Date:   Sun, 17 Sep 2023 21:13:44 +0200
Message-ID: <20230917191044.478849564@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 66d58f046c9d3a8f996b7138d02e965fd0617de0 ]

inet_sk_diag_fill() has been changed to use sk_forward_alloc_get(),
but sk_get_meminfo() was forgotten.

Fixes: 292e6077b040 ("net: introduce sk_forward_alloc_get()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index fa988063630db..6ff58fa5f41ed 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3715,7 +3715,7 @@ void sk_get_meminfo(const struct sock *sk, u32 *mem)
 	mem[SK_MEMINFO_RCVBUF] = READ_ONCE(sk->sk_rcvbuf);
 	mem[SK_MEMINFO_WMEM_ALLOC] = sk_wmem_alloc_get(sk);
 	mem[SK_MEMINFO_SNDBUF] = READ_ONCE(sk->sk_sndbuf);
-	mem[SK_MEMINFO_FWD_ALLOC] = sk->sk_forward_alloc;
+	mem[SK_MEMINFO_FWD_ALLOC] = sk_forward_alloc_get(sk);
 	mem[SK_MEMINFO_WMEM_QUEUED] = READ_ONCE(sk->sk_wmem_queued);
 	mem[SK_MEMINFO_OPTMEM] = atomic_read(&sk->sk_omem_alloc);
 	mem[SK_MEMINFO_BACKLOG] = READ_ONCE(sk->sk_backlog.len);
-- 
2.40.1



