Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191F17B7629
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 03:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjJDBNQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 21:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJDBNQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 21:13:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2BDAF
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 18:13:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c647150c254so364627276.1
        for <stable@vger.kernel.org>; Tue, 03 Oct 2023 18:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696381992; x=1696986792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vov+OjwAGZgpW+sJbWfht9dksDbSHqK3KW37zgfpqdI=;
        b=WWnAHNfWc61NZZUuM2qMIj1LOV9En41kETs79JalCifw5ES4mSlOFtdfousDR/R50l
         rdPzf2ug7a4dTy6xdr+V0TjBM3+XCC9fcRobgX7C0R0VhJQryqrk+LVXNhT5Titx5aMm
         9YBrYBEj8sEmOs+LE8yyhx/oWz5+D3wTXA4C+F4Z/5jn6rvFR4khCdsJekmsPtnXgNo1
         uVnzCYaV0m7XbpsXEeLCZHkNwUfRL6/D8d6QOrFNlda03Uq59bBF2/3h/HH9lNrcHRFS
         wAGKgGpsiUHZBTUUnfzmU0i5z0e8X5kxQScbItQHjdHDEx+vOQKXLN16XJn3z9l/QiW2
         MU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696381992; x=1696986792;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vov+OjwAGZgpW+sJbWfht9dksDbSHqK3KW37zgfpqdI=;
        b=Egbsh+su3UV7rCbO9OMOLu2Q3yOfN0CS38GfwV+5qBhXra2fCihhyLEoDYf1396+BI
         lAP41aIt9Az0VdNdSYeDqjFFZYOUy0iqPqC/5bT+HgWEnRG9yz3m1hitOHddYr6dr9pc
         lRboRD7IHQXOsJfAa2pfdURQXudXbv4sfoIIqEj7fmNc/i0/mB9+z3BExCteMAzffZgs
         hPtlazo3EJoZgxTJuHPgm7MHEVrVYycsfvzF2Uyqf7JNBrBw/21u5H6rgyhj0Km93sO5
         nCYbPlAgo6FL5smMbStPSJSvaIRsSA96mu10vuApyDVorrkBN7DQkexL4Jc/JobUuhnR
         LEkg==
X-Gm-Message-State: AOJu0Yy60MfNhzCDrBs4MDzIFQlu8PxnL/T75OLmVtLI6G0J47g3Jo2g
        IlE90/PXbnhfkXdOm762n6V5ti9uzQ==
X-Google-Smtp-Source: AGHT+IEXj6lXfUBrlzRw212Zm1JTFqKAIg+J3EbwcNfRJyryRiFJxPoFIWxFKK7aZfNWYvwatpny5enPqg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:14c1:0:b0:d81:5c03:df99 with SMTP id
 184-20020a2514c1000000b00d815c03df99mr16753ybu.3.1696381992379; Tue, 03 Oct
 2023 18:13:12 -0700 (PDT)
Date:   Tue,  3 Oct 2023 20:13:03 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231004011303.979995-1-jrife@google.com>
Subject: [PATCH] smb: use kernel_connect() and kernel_bind()
From:   Jordan Rife <jrife@google.com>
To:     sfrench@samba.org, pc@manguebit.com, lsahlber@redhat.com,
        sprasad@microsoft.com, tom@talpey.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     Jordan Rife <jrife@google.com>, stable@vger.kernel.org
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

Recent changes to kernel_connect() and kernel_bind() ensure that
callers are insulated from changes to the address parameter made by BPF
SOCK_ADDR hooks. This patch wraps direct calls to ops->connect() and
ops->bind() with kernel_connect() and kernel_bind() to ensure that SMB
mounts do not see their mount address overwritten in such cases.

Link: https://lore.kernel.org/netdev/9944248dba1bce861375fcce9de663934d933ba9.camel@redhat.com/
Cc: <stable@vger.kernel.org> # 6.x.y
Signed-off-by: Jordan Rife <jrife@google.com>
---
 fs/smb/client/connect.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 3902e90dca6b0..ce11165446cfb 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2895,9 +2895,9 @@ bind_socket(struct TCP_Server_Info *server)
 	if (server->srcaddr.ss_family != AF_UNSPEC) {
 		/* Bind to the specified local IP address */
 		struct socket *socket = server->ssocket;
-		rc = socket->ops->bind(socket,
-				       (struct sockaddr *) &server->srcaddr,
-				       sizeof(server->srcaddr));
+		rc = kernel_bind(socket,
+				 (struct sockaddr *) &server->srcaddr,
+				 sizeof(server->srcaddr));
 		if (rc < 0) {
 			struct sockaddr_in *saddr4;
 			struct sockaddr_in6 *saddr6;
@@ -3046,8 +3046,8 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		 socket->sk->sk_sndbuf,
 		 socket->sk->sk_rcvbuf, socket->sk->sk_rcvtimeo);
 
-	rc = socket->ops->connect(socket, saddr, slen,
-				  server->noblockcnt ? O_NONBLOCK : 0);
+	rc = kernel_connect(socket, saddr, slen,
+			    server->noblockcnt ? O_NONBLOCK : 0);
 	/*
 	 * When mounting SMB root file systems, we do not want to block in
 	 * connect. Otherwise bail out and then let cifs_reconnect() perform
-- 
2.42.0.582.g8ccd20d70d-goog

