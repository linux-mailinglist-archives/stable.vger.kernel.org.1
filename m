Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E149E77AC15
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjHMV3G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjHMV3G (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:29:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF9310D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F334C62AA9
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1373EC433C8;
        Sun, 13 Aug 2023 21:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962147;
        bh=qKYm8v32+PTgWYZZ5UYo0Dq0ImsKO9tQNgpzOlXIdJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YuKRfNqkTYgx0tHX/FkbT14i74H/KX9vZ6PjvO4/BgiCdyOngSlVUMFm9PAixCejT
         HJjBAFollizlsEbncHeqnOH8WFUxH1d14seRsJTt5E3cCcLLfcB+eCKxesL/0qwAas
         rfiOeOJCWYk5/Fb/jfKZfWiTkjuodCnaN0XlcBEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xu Kuohai <xukuohai@huawei.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 6.4 123/206] bpf, sockmap: Fix bug that strp_done cannot be called
Date:   Sun, 13 Aug 2023 23:18:13 +0200
Message-ID: <20230813211728.556852855@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
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

From: Xu Kuohai <xukuohai@huawei.com>

commit 809e4dc71a0f2b8d2836035d98603694fff11d5d upstream.

strp_done is only called when psock->progs.stream_parser is not NULL,
but stream_parser was set to NULL by sk_psock_stop_strp(), called
by sk_psock_drop() earlier. So, strp_done can never be called.

Introduce SK_PSOCK_RX_ENABLED to mark whether there is strp on psock.
Change the condition for calling strp_done from judging whether
stream_parser is set to judging whether this flag is set. This flag is
only set once when strp_init() succeeds, and will never be cleared later.

Fixes: c0d95d3380ee ("bpf, sockmap: Re-evaluate proto ops when psock is removed from sockmap")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20230804073740.194770-3-xukuohai@huaweicloud.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skmsg.h |    1 +
 net/core/skmsg.c      |   10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -62,6 +62,7 @@ struct sk_psock_progs {
 
 enum sk_psock_state_bits {
 	SK_PSOCK_TX_ENABLED,
+	SK_PSOCK_RX_STRP_ENABLED,
 };
 
 struct sk_psock_link {
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1120,13 +1120,19 @@ static void sk_psock_strp_data_ready(str
 
 int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 {
+	int ret;
+
 	static const struct strp_callbacks cb = {
 		.rcv_msg	= sk_psock_strp_read,
 		.read_sock_done	= sk_psock_strp_read_done,
 		.parse_msg	= sk_psock_strp_parse,
 	};
 
-	return strp_init(&psock->strp, sk, &cb);
+	ret = strp_init(&psock->strp, sk, &cb);
+	if (!ret)
+		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
+
+	return ret;
 }
 
 void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
@@ -1154,7 +1160,7 @@ void sk_psock_stop_strp(struct sock *sk,
 static void sk_psock_done_strp(struct sk_psock *psock)
 {
 	/* Parser has been stopped */
-	if (psock->progs.stream_parser)
+	if (sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED))
 		strp_done(&psock->strp);
 }
 #else


