Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D070C85E
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbjEVTiZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjEVTiI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EEAE4D
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BA3262965
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C79C433D2;
        Mon, 22 May 2023 19:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784252;
        bh=bpNz9U5KwDqt6mylltlHsYFDuW8G6eZ94IPs7OcLcbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYJ7qJfbKk6+8x/UmfHOgqfVAYBXF3wdLwOfzAgq5ktP69kX2K7zj+41X++KaYgRh
         H7DMhBTHxnDt8cBw0DshDiOBZhkeVeRzRqrSdalsjnF5+7oMFp3SBfZeDU2wojaztn
         jP3zqDAPtetqnE1RJdLMXgtoQiePaiLCYDrXIK0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 020/364] net: annotate sk->sk_err write from do_recvmmsg()
Date:   Mon, 22 May 2023 20:05:25 +0100
Message-Id: <20230522190413.334627371@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e05a5f510f26607616fecdd4ac136310c8bea56b ]

do_recvmmsg() can write to sk->sk_err from multiple threads.

As said before, many other points reading or writing sk_err
need annotations.

Fixes: 34b88a68f26a ("net: Fix use after free in the recvmmsg exit path")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 9c92c0e6c4da8..263fab8e49010 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2909,7 +2909,7 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 		 * error to return on the next call or if the
 		 * app asks about it using getsockopt(SO_ERROR).
 		 */
-		sock->sk->sk_err = -err;
+		WRITE_ONCE(sock->sk->sk_err, -err);
 	}
 out_put:
 	fput_light(sock->file, fput_needed);
-- 
2.39.2



