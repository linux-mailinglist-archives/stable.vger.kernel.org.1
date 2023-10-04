Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A00F7B98C0
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 01:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjJDXkE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 19:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjJDXkD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 19:40:03 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA15AC9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 16:39:59 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6c65c78d7bbso515427a34.3
        for <stable@vger.kernel.org>; Wed, 04 Oct 2023 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696462799; x=1697067599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AmDqm4rQtpNyDmMaNDTRTb/F7GEAJTZGgDpU+ccwZEQ=;
        b=RHg4HTjO5w4Gl/H8wwDwzUXwAmpkSvYnjPMKBIDTvgMxmbGjXUGVnd65DWevq5KzTf
         ivV9ym1u1d+vWeBmnO+xj0S2ydp37OosUU++7NLR3fld/YKec/mAd/scf0rKGLv9sWCw
         St4MfIO0nff1uSSoZL/i7jKFH60d7QHnKFVt4h8tdaCys/INOR1TJmZ1GxZ9moXVegFT
         KYKE49MVUyDcYAtnNXtgS4v9RHtOMLaLOF4VFNkijPcGYhDjFODuHBwpKmjSEYgBqvns
         N6cCwvQ8zqEjFahEI8KbqRsWG1VTfXDlWNh1LvbN4BKQHH2yRX4vtdOsrhrSY2VyGlAL
         MKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696462799; x=1697067599;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmDqm4rQtpNyDmMaNDTRTb/F7GEAJTZGgDpU+ccwZEQ=;
        b=Y3YdGlIpjOG/SiKx34X0YDDQHrhExGqApli4qq9/AbSniJ9T/Ejo52H5Vr8BAIvxnA
         lS0ooEnKsCK6YgD/K+2tXO2Obbcv5cgKaQvU95ZYksjW+GxUqwyNXHrS31ZmX5xPQ6Gq
         vA602+xhrKkHW+QfOKXQ7fSQmX8afHE8/EczizoPvMzsR17xNHJ8SM8IEVwrsK4DYLnE
         Th24o5UgpF25+yxVgb4FuQi6JK474UtJtBxfeD3RTpUgjQSpmouZyDgR16DyLMTN2dpv
         XMSSwZInd26JxQRGRMDy7S7iwMRQvq74WbVLlOaEqxNeUgWSgRKOgDEw8J5OTfK7Q3gF
         titw==
X-Gm-Message-State: AOJu0Yy5XM+4QKlVFmI0q3y4nk1/ECFKN8p8wrmYULTx3LPCA0FjIVGr
        xA7hSIJpCKlwXrciQc+IbIsVMIbPWQ==
X-Google-Smtp-Source: AGHT+IH2IvELyaJYyWZbLcyvTFHh6ueK+8/Jiphpfq9ynf5I9ByGcCwPPVxbitIMTbduVDPsRXRRHt/GUQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a9d:7ace:0:b0:6c6:42ca:ed46 with SMTP id
 m14-20020a9d7ace000000b006c642caed46mr983846otn.0.1696462799212; Wed, 04 Oct
 2023 16:39:59 -0700 (PDT)
Date:   Wed,  4 Oct 2023 18:38:27 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231004233827.1274148-1-jrife@google.com>
Subject: [PATCH] ceph: use kernel_connect()
From:   Jordan Rife <jrife@google.com>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org,
        Jordan Rife <jrife@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Direct calls to ops->connect() can overwrite the address parameter when
used in conjunction with BPF SOCK_ADDR hooks. Recent changes to
kernel_connect() ensure that callers are insulated from such side
effects. This patch wraps the direct call to ops->connect() with
kernel_connect() to prevent unexpected changes to the address passed to
ceph_tcp_connect().

This change was originally part of a larger patch targeting the net tree
addressing all instances of unprotected calls to ops->connect()
throughout the kernel, but this change was split up into several patches
targeting various trees.

Link: https://lore.kernel.org/netdev/20230821100007.559638-1-jrife@google.com/
Link: https://lore.kernel.org/netdev/9944248dba1bce861375fcce9de663934d933ba9.camel@redhat.com/
Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Cc: stable@vger.kernel.org
Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/ceph/messenger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 10a41cd9c5235..3c8b78d9c4d1c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -459,8 +459,8 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	set_sock_callbacks(sock, con);
 
 	con_sock_state_connecting(con);
-	ret = sock->ops->connect(sock, (struct sockaddr *)&ss, sizeof(ss),
-				 O_NONBLOCK);
+	ret = kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss),
+			     O_NONBLOCK);
 	if (ret == -EINPROGRESS) {
 		dout("connect %s EINPROGRESS sk_state = %u\n",
 		     ceph_pr_addr(&con->peer_addr),
-- 
2.42.0.582.g8ccd20d70d-goog

