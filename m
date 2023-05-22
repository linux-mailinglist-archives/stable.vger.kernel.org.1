Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D470C782
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjEVTaW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjEVTaV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEF19C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B46628F9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E34CC433D2;
        Mon, 22 May 2023 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783819;
        bh=m4T4wpyQCQgdJqiEPvFCSaUMvmA4Ris8Ph6gOl5wHjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0b+PYlWyXSsfRGbdG/z9rIyVkLbhBcMNP5AkqwlQb32HAmUk2MwiOXQx0pp/8RBA
         6LPFAVdmnlzRCe03K2r2ifPQ697cjSqZFWxg1jEdGaXtfgDO2FYpVNVPlz1DYE9O4j
         hLF6L0waFc84+C7MQOykfmQeqCg1fZMzsK8ytM+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhuang Shengen <zhuangshengen@huawei.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 172/292] vsock: avoid to close connected socket after the timeout
Date:   Mon, 22 May 2023 20:08:49 +0100
Message-Id: <20230522190410.263166510@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Zhuang Shengen <zhuangshengen@huawei.com>

[ Upstream commit 6d4486efe9c69626cab423456169e250a5cd3af5 ]

When client and server establish a connection through vsock,
the client send a request to the server to initiate the connection,
then start a timer to wait for the server's response. When the server's
RESPONSE message arrives, the timer also times out and exits. The
server's RESPONSE message is processed first, and the connection is
established. However, the client's timer also times out, the original
processing logic of the client is to directly set the state of this vsock
to CLOSE and return ETIMEDOUT. It will not notify the server when the port
is released, causing the server port remain.
when client's vsock_connect timeout，it should check sk state is
ESTABLISHED or not. if sk state is ESTABLISHED, it means the connection
is established, the client should not set the sk state to CLOSE

Note: I encountered this issue on kernel-4.18, which can be fixed by
this patch. Then I checked the latest code in the community
and found similar issue.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Zhuang Shengen <zhuangshengen@huawei.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/af_vsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 884eca7f6743a..8360c790a8a01 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1427,7 +1427,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 			vsock_transport_cancel_pkt(vsk);
 			vsock_remove_connected(vsk);
 			goto out_wait;
-		} else if (timeout == 0) {
+		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
 			err = -ETIMEDOUT;
 			sk->sk_state = TCP_CLOSE;
 			sock->state = SS_UNCONNECTED;
-- 
2.39.2



