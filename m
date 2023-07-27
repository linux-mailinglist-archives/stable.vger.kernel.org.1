Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF64E7655B3
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjG0OPw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjG0OPv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 10:15:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DD930CF
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 07:15:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-316feb137a7so1055679f8f.1
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690467347; x=1691072147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUTyC4acFyvgFGwLwOB3Um17AnP3SMbPa7d0UPDlcYY=;
        b=PWDHu+ZtqZH6Fam6cltbUrQF7q0zaaOWs1jJvGr5Odw6DJEFKNuFGbkBnOLaS2X6n/
         /Wzmv9j47kgOC3srSvbyAw1v5rzYHdCw0iOEOZLbHF+w8AVFj3s6kheAN5w9urcG60bS
         pwoXifRWAKR6AOrGz4yiEE4a/pM4Q/+OdvL62V5IlBT9+pkaDWz8QTFgGL0vkl73pYkG
         BKAUNAO6hRCczpNQHYpC/V8hNwtd2Q1dNIpPwyY78Ew4AglYJjIjPtKn825oqRWeOIUG
         CO4hAIriNxDrQMXCyWPjW0hoo9QZ+fpc8sFazCbws+V/N11n77bbjFJ2sxGEx6ak1KHk
         QBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467347; x=1691072147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUTyC4acFyvgFGwLwOB3Um17AnP3SMbPa7d0UPDlcYY=;
        b=M/RsWhm9BCtPkXQoNyPzJAUq9YIGoEsrBG7A0nt0PKZ/Nkjus4m7v29RWsEelQbXXl
         qRipbgXC9kD7cd//YphI+8nWECNfCX/vc8MD7b5VvudTvi4Gvko2zNbOTU3KKCkWkFf+
         a7F8S2U3U07JEXlGZRPS8ywJMKFGsg4q+ZGYiZCqyAHv+CXSjVCdtJ8SkKG6jNeKqzVy
         FOyUpVHbGfvIliiqJtgUZ7YcSWUk0xv0nkXcamzI+746nyXVWPP8eUcZbU/kx9KP2AOL
         VagUsSDq66O5npW99C7D9kKJuHXODrYXNySR3UDQrnecl62Rjk1EilNnpxsV4KDgA/V+
         iaUA==
X-Gm-Message-State: ABy/qLZVq7P/Z89WPnj3MYJMTSthr39bTfMqN7tWH71xjEyzd7rKeFyK
        mTe8NC7hfvnAFf0b/PTmptEECrIsSd4s2TA1cgSDxA==
X-Google-Smtp-Source: APBJJlH0/Xmo6P55SNMxQDufy7JV+SnpeOLwPYQewO3wu1mi3cf2482eqphtyLZ+haJwIV1XVQB2XA==
X-Received: by 2002:adf:dd52:0:b0:315:964b:89b9 with SMTP id u18-20020adfdd52000000b00315964b89b9mr1742208wrm.52.1690467347111;
        Thu, 27 Jul 2023 07:15:47 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm2145405wrq.115.2023.07.27.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:15:46 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     MPTCP Upstream <mptcp@lists.linux.dev>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y] mptcp: ensure subflow is unhashed before cleaning the backlog
Date:   Thu, 27 Jul 2023 16:14:57 +0200
Message-Id: <20230727141457.2522904-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023072102-finicky-everyday-cce4@gregkh>
References: <2023072102-finicky-everyday-cce4@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=iINWTQLqXuf9BqfqCJJtElqlaK4/W/YWj+/Sbg1H6lY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkwnvhJx1CYP72oqfBeDwO+vY9ia3y7nJhqt7cy
 XLaV39sO/OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMJ74QAKCRD2t4JPQmmg
 c5OkD/9maxrV3IGumIUvnnyPk4D2Yzq+IMbPtIDnmdSlWuR9b8T+T0BWfDwgrlt4q8SNUkoebGv
 ugzpskBC6+2Tio8SHZ6jlhw8DmjubT+D2SiP27wFi1strJiugbPCDD4jykHWsGFkNC0umcN0bjZ
 27Ji8uFgcptRtHJEgnrvZVplEKYqx0rE707PAPoE0erJ45VscV2DfnEYLZ0OzgfFRBUF2Zbt59U
 g25lIpD4G1rM+EBpYCrYCkGG8FwKMbsLHzOQSHghHdoo8K4lviBq19kENFJ8i19NmjFBeWUHbmr
 A8EJLESpQFN7EbZf/jiLBwEm9on/qpUGQRYmcTeCX1xMT/NIVZSbEL8HDAwP+hK2H0KrBoYVNFF
 KdNU5Nfil/ONPHc9O2ibK+6nrMh2vB7qxwpDf5CM1YW4iQ92XDGwqD4YT5W6OX/ATJlGXvqimpv
 6pw3CNI29Po7JKHqFmmSWOcVMrEn4zUoT9i4IAvvRq7tlsP9A1kblZ0Jbx6a3g1J1W7B0NEKJya
 AOugPNnNqrzyirVwGDnzrIfBq117ahrPFnir/0IvvFOHXUJtNiganQzd23GlSRLccZ/ojOasF4c
 UisF++S3JQpuJYbnNBGS/yvyGcKQ1Vo4UDhryVv9I30NeZUVWHKFQYb7hF4A4eCznjiAYetzeVi PmpPum9xEu0pOSw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---
Backport notes:
  - it was conflicting with a new feature not present in v6.1, see
    commit f8c9dfbd875b ("mptcp: add pm listener events"): the call to
    mptcp_event_pm_listener() has not been taken, only tcp_set_state()
    has been moved here.
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4ca61e80f4bb..a6a5c16f2a49 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2945,9 +2945,9 @@ static void mptcp_check_listen_stop(struct sock *sk)
 		return;
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	tcp_set_state(ssk, TCP_CLOSE);
 	mptcp_subflow_queue_clean(sk, ssk);
 	inet_csk_listen_stop(ssk);
-	tcp_set_state(ssk, TCP_CLOSE);
 	release_sock(ssk);
 }
 
-- 
2.40.1

