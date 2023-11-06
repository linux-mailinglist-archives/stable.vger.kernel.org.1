Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23337E2EE8
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 22:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjKFVYo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 16:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFVYn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 16:24:43 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456C1B3
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 13:24:41 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b3715f3b41so67110197b3.2
        for <stable@vger.kernel.org>; Mon, 06 Nov 2023 13:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699305880; x=1699910680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RdEIUnfrd16mPMex7MqqZYwlL2xFlg4/43Dphzmx9M8=;
        b=2LKE4Z/Ebv1HPEE+ODb9YZmRdPttCDNUUIrKOSkpg/zezCp9n/MrPbD/PZRv7P1ptw
         rtnq3mum2KTu7S/oS1xIELrXefb6TbtQ/ZR+ZRDf5oqkAVHOiUFr81N3S36nhDR8/+zf
         6NbTrD3s07D5GZbZlrvNRR9/Dnk9oL3yvRWOwBGZdfWzj8itwywEubHdIuFqDNq4Byfl
         lUxJQGp29WHTobLwFLZoNl7FuZcAMiekbeZaLiPGf6ueKTHrvZKrSH8Gv201Sc31R4mM
         GAR8EdgxZUXJkOztHfHthzEBWwEab4sQZHSssIaT97B9gsSk5M+H0V2H8TY53zUi4C5f
         vLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699305880; x=1699910680;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdEIUnfrd16mPMex7MqqZYwlL2xFlg4/43Dphzmx9M8=;
        b=PHkp9/3PpyOkSwL26Dz0/bIej80aeH3aScJJWWnAaXMJcHKe9Vgk7gRUiylVpWX75C
         3CjksooHtQien0LDOle6Ufs80oYCAO4LZOu5H6XGsdnq2goxuuRy9Upox2wxlqxqIErI
         Y0VcIrxU6S7cQiPhKMEiYb69py2iDf63cN9QTpxa2S1MxEnamz9GMP2xIetntGYJFuw1
         OkLPXIXinpige7Ke0LWgmHWh3+hGBdklGAYHbwOuwtSLufY1OG3l3NRAZ8iEA+PPD1aC
         PIs06Tf/t4ngDaPYx2E4HDNKNo4Ru+VifcXwRUUdYJ2a4hRgVRgLB6s5BSLANouXH32t
         bTjQ==
X-Gm-Message-State: AOJu0YwUUHdFw1XA1mJeT5skx2vokwRNHthrfrEY9RyAsUgwMmOtH3u2
        x8ZnB1MBjCq8BizYAjwfUGNP6HkIBw==
X-Google-Smtp-Source: AGHT+IHAFKt4u4FlY2yLPoT34HEnwSfhJPmytVKYXvvDochEsMQmonstUOFiNOSSTQqVCJ8ycRoLPM1nAQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:109:0:b0:da0:c6d7:8231 with SMTP id
 9-20020a250109000000b00da0c6d78231mr577424ybb.0.1699305880527; Mon, 06 Nov
 2023 13:24:40 -0800 (PST)
Date:   Mon,  6 Nov 2023 15:24:38 -0600
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106212438.663455-1-jrife@google.com>
Subject: [PATCH] dlm: use kernel_connect() and kernel_bind()
From:   Jordan Rife <jrife@google.com>
To:     gfs2@lists.linux.dev
Cc:     aahringo@redhat.com, teigland@redhat.com,
        Jordan Rife <jrife@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Recent changes to kernel_connect() and kernel_bind() ensure that
callers are insulated from changes to the address parameter made by BPF
SOCK_ADDR hooks. This patch wraps direct calls to ops->connect() and
ops->bind() with kernel_connect() and kernel_bind() to protect callers
in such cases.

Link: https://lore.kernel.org/netdev/9944248dba1bce861375fcce9de663934d933ba9.camel@redhat.com/
Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
Cc: stable@vger.kernel.org
Signed-off-by: Jordan Rife <jrife@google.com>
---
 fs/dlm/lowcomms.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 67f8dd8a05ef2..6296c62c10fa9 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1817,8 +1817,8 @@ static int dlm_tcp_bind(struct socket *sock)
 	memcpy(&src_addr, &dlm_local_addr[0], sizeof(src_addr));
 	make_sockaddr(&src_addr, 0, &addr_len);
 
-	result = sock->ops->bind(sock, (struct sockaddr *)&src_addr,
-				 addr_len);
+	result = kernel_bind(sock, (struct sockaddr *)&src_addr,
+			     addr_len);
 	if (result < 0) {
 		/* This *may* not indicate a critical error */
 		log_print("could not bind for connect: %d", result);
@@ -1830,7 +1830,7 @@ static int dlm_tcp_bind(struct socket *sock)
 static int dlm_tcp_connect(struct connection *con, struct socket *sock,
 			   struct sockaddr *addr, int addr_len)
 {
-	return sock->ops->connect(sock, addr, addr_len, O_NONBLOCK);
+	return kernel_connect(sock, addr, addr_len, O_NONBLOCK);
 }
 
 static int dlm_tcp_listen_validate(void)
@@ -1862,8 +1862,8 @@ static int dlm_tcp_listen_bind(struct socket *sock)
 
 	/* Bind to our port */
 	make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
-	return sock->ops->bind(sock, (struct sockaddr *)&dlm_local_addr[0],
-			       addr_len);
+	return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
+			   addr_len);
 }
 
 static const struct dlm_proto_ops dlm_tcp_ops = {
@@ -1888,12 +1888,12 @@ static int dlm_sctp_connect(struct connection *con, struct socket *sock,
 	int ret;
 
 	/*
-	 * Make sock->ops->connect() function return in specified time,
+	 * Make kernel_connect() function return in specified time,
 	 * since O_NONBLOCK argument in connect() function does not work here,
 	 * then, we should restore the default value of this attribute.
 	 */
 	sock_set_sndtimeo(sock->sk, 5);
-	ret = sock->ops->connect(sock, addr, addr_len, 0);
+	ret = kernel_connect(sock, addr, addr_len, 0);
 	sock_set_sndtimeo(sock->sk, 0);
 	return ret;
 }
-- 
2.42.0.869.gea05f2083d-goog

