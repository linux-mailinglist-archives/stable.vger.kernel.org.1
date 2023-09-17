Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07BF7A397C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjIQTuY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbjIQTt5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:49:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94FCC6
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:49:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDFAC433C9;
        Sun, 17 Sep 2023 19:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980191;
        bh=shRh3Cmz6dTdOewVY6H4IoI+xnIT/YgQ0jOOxru/oHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vc3W2g+Gh4ygVYMB/MhsEKkZCa+qcReMXeH9AZucSU9/W/y1JkjZ0pm3sc28cGzfw
         vpbXLVxUOYb8chxMB0qugsUM1FQUzzx6gfKgPVMOkivSX4mZkFP6XDitn+xxncMCWN
         U3XQ/dWY+dFQahHMAphAq3FbkFdzxGW5yEGRHtAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 119/285] net: use sk_forward_alloc_get() in sk_get_meminfo()
Date:   Sun, 17 Sep 2023 21:11:59 +0200
Message-ID: <20230917191055.786505128@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 4ae68aa07e9fe..3109eb0cd512e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3742,7 +3742,7 @@ void sk_get_meminfo(const struct sock *sk, u32 *mem)
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



