Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5076AECD
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjHAJmG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjHAJly (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3729359C1
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14D9F614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2094CC433C8;
        Tue,  1 Aug 2023 09:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882768;
        bh=hzeMK1A/AdPapE9grLO5RqiRntJA6bMvobKpKziMV6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0HMMSaEVpF9LzG0nPahWZe3nmEfcQR6hKUm299rUCqNzvcGd75BZ1uHdZi0fXKhW
         iw67UJbehA8rFiznuMWEe8RzOYOXpa8rCfGI9xQg6q/1R7HwSrHN+OU2svg8k8Am4V
         co0ycRjaHwPDHrTQvr9ooXY5OLTqXskrHovTtNQA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 224/228] mptcp: ensure subflow is unhashed before cleaning the backlog
Date:   Tue,  1 Aug 2023 11:21:22 +0200
Message-ID: <20230801091930.946662934@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit 3fffa15bfef48b0ad6424779c03e68ae8ace5acb upstream.

While tacking care of the mptcp-level listener I unintentionally
moved the subflow level unhash after the subflow listener backlog
cleanup.

That could cause some nasty race and makes the code harder to read.

Address the issue restoring the proper order of operations.

Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2945,9 +2945,9 @@ static void mptcp_check_listen_stop(stru
 		return;
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	tcp_set_state(ssk, TCP_CLOSE);
 	mptcp_subflow_queue_clean(sk, ssk);
 	inet_csk_listen_stop(ssk);
-	tcp_set_state(ssk, TCP_CLOSE);
 	release_sock(ssk);
 }
 


