Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA4F7BDFFF
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377190AbjJINge (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377220AbjJINgb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:36:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D900F2
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:36:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92E6C433CA;
        Mon,  9 Oct 2023 13:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858586;
        bh=1rzaYniJioSM6u5RB8kFWaFicwKFfmMFV/+ddYpVTms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K154YeEmvFbCaHAtr/L6zjpPwTneJ/QQlXsh4I1KsdFHLoFPDLA2yfc72lWBcAocg
         mfW0pLTFpQ78hqYV4D1NNMkEhml/v1u2RiQpXdAIYpNM8qthiLgGZucg4I0pBIs36N
         1knPhq24I0WYvHx1bXo6qfVeYit93ptRiIL86pzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 037/226] selftests: tls: swap the TX and RX sockets in some tests
Date:   Mon,  9 Oct 2023 14:59:58 +0200
Message-ID: <20231009130127.760590456@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit c326ca98446e0ae4fee43a40acf79412b74cfedb ]

tls.sendmsg_large and tls.sendmsg_multiple are trying to send through
the self->cfd socket (only configured with TLS_RX) and to receive through
the self->fd socket (only configured with TLS_TX), so they're not using
kTLS at all. Swap the sockets.

Fixes: 7f657d5bf507 ("selftests: tls: add selftests for TLS sockets")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/tls.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 44984741bd41d..44a25a9f1f722 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -384,11 +384,11 @@ TEST_F(tls, sendmsg_large)
 
 		msg.msg_iov = &vec;
 		msg.msg_iovlen = 1;
-		EXPECT_EQ(sendmsg(self->cfd, &msg, 0), send_len);
+		EXPECT_EQ(sendmsg(self->fd, &msg, 0), send_len);
 	}
 
 	while (recvs++ < sends) {
-		EXPECT_NE(recv(self->fd, mem, send_len, 0), -1);
+		EXPECT_NE(recv(self->cfd, mem, send_len, 0), -1);
 	}
 
 	free(mem);
@@ -417,9 +417,9 @@ TEST_F(tls, sendmsg_multiple)
 	msg.msg_iov = vec;
 	msg.msg_iovlen = iov_len;
 
-	EXPECT_EQ(sendmsg(self->cfd, &msg, 0), total_len);
+	EXPECT_EQ(sendmsg(self->fd, &msg, 0), total_len);
 	buf = malloc(total_len);
-	EXPECT_NE(recv(self->fd, buf, total_len, 0), -1);
+	EXPECT_NE(recv(self->cfd, buf, total_len, 0), -1);
 	for (i = 0; i < iov_len; i++) {
 		EXPECT_EQ(memcmp(test_strs[i], buf + len_cmp,
 				 strlen(test_strs[i])),
-- 
2.40.1



