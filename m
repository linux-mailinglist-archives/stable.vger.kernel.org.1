Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A297BDE9F
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376356AbjJINVS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376364AbjJINVQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:21:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B2AC6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:21:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B1AC433C8;
        Mon,  9 Oct 2023 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857675;
        bh=CwGzTgzwAsEk+Of6VHsPs4DNgeII8kFbjhXLCFQJVdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KM0VlhIw9EikYS7k24m/MPy0VoXtwRZ2Zs9MmfbDMafiZh90eheMgDumrc7Uv5p9d
         iZki/diHJfQigauljsw9gZGBIne/6XcqxaMrlo3tIGHWgMaH6I/ljiTYflxcuIrWBh
         hsQ1gSfJn9Wx7bv5f/7rb2J5nMcEaBdYUpmiwrTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 103/162] bpf, sockmap: Do not inc copied_seq when PEEK flag set
Date:   Mon,  9 Oct 2023 15:01:24 +0200
Message-ID: <20231009130125.766650092@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit da9e915eaf5dadb1963b7738cdfa42ed55212445 ]

When data is peek'd off the receive queue we shouldn't considered it
copied from tcp_sock side. When we increment copied_seq this will confuse
tcp_data_ready() because copied_seq can be arbitrarily increased. From
application side it results in poll() operations not waking up when
expected.

Notice tcp stack without BPF recvmsg programs also does not increment
copied_seq.

We broke this when we moved copied_seq into recvmsg to only update when
actual copy was happening. But, it wasn't working correctly either before
because the tcp_data_ready() tried to use the copied_seq value to see
if data was read by user yet. See fixes tags.

Fixes: e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq")
Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20230926035300.135096-3-john.fastabend@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_bpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 5f93918c063c7..f53380fd89bcf 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -217,6 +217,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 				  int *addr_len)
 {
 	struct tcp_sock *tcp = tcp_sk(sk);
+	int peek = flags & MSG_PEEK;
 	u32 seq = tcp->copied_seq;
 	struct sk_psock *psock;
 	int copied = 0;
@@ -306,7 +307,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		copied = -EAGAIN;
 	}
 out:
-	WRITE_ONCE(tcp->copied_seq, seq);
+	if (!peek)
+		WRITE_ONCE(tcp->copied_seq, seq);
 	tcp_rcv_space_adjust(sk);
 	if (copied > 0)
 		__tcp_cleanup_rbuf(sk, copied);
-- 
2.40.1



