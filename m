Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95E7C4072
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 21:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjJJT5j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 15:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJJT5j (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 15:57:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BDF8E
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 12:57:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7d1816bccso8022067b3.1
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 12:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696967856; x=1697572656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IMuriLVtGmuu1GUG/MxY3S4UtzQcfybCSzyPxvpxkIU=;
        b=2mdtbfyZ6YoNdhmZxRmzcgKK44KwLs6jx1NYcLnk5w1f3AlXMgTEnA4NUIk1q78fVN
         /u6qYa+K7vCujR9Dzro973mvVq37rmeECHEDKFGbrb5bA7IWHnKZQcUN7eWyg/3PbjYh
         Ye1A9+BuiuWAkriumcLUxbFYqF2KnccPYLxUniSpvomyG3EpnY9mLS0VDDNECx4eMSPM
         UuP+nU6jYD0Q7z+6s2TYnViEDpuYcosdMh1qD/aAXjaLsSmf47Sfxxg9GWjtYlLabUoh
         hbVMlRLzLmgGkeeh0CpFt6Vbx+MqQHyGpyQRp7DRX5bUIDjDJ6lnlEvdj0vCe2abht8F
         aOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967856; x=1697572656;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMuriLVtGmuu1GUG/MxY3S4UtzQcfybCSzyPxvpxkIU=;
        b=Cew3/qPd+d4LABgn/GHjvdj4n4E4WyMs3s5AyOF9XkN4/jG6y7z8K5upKUeqWXkdw4
         FNktHfGZAfV1oE79wtNpLLSq9FNB8OjuJeLwM0xDoRS2b8pB69tOzcBKKNCsRLQa1ctO
         h+dD00lZkqQ5nwKPWH8NYhsv4/vYH1wDPl7r/6Ep8YyD169ylTpu8BQ4VvcOSdURPici
         BaGN+McHsFNr5QK8O8p+G2QNa4MACErG9wUGS3IGqM/MBkw+UgVd+HX89e+P70WzkSbN
         N4vgulzhquNrIbo9aagIHKD1jmvIfGhconrNR4zxIVHwMOy6t3/naWcJzoVCcauggF8C
         WOKA==
X-Gm-Message-State: AOJu0YzFpQRUU+Ai3Fqa4+yVEpz1IzvYuGaWm1n4iTj6n6HzdVRfzlhE
        K6CbeloL4J9CAHx3YGHCy+IG1lojvC7zHKjSk3BLVMChgwsJzIEPVVtA2T4KBPxahbygErhhkNK
        IHLBFjWBtE4XN6SEU1XmPtR9GDpmlLDoUrcWgduBCxPqZEKF+BPn1by1p5q8=
X-Google-Smtp-Source: AGHT+IGOc+XnkuO5bidtkcDh1LjZHtWBavpfMoZNZjc0TqJx6J3ZVly21ev4xwgZtajz6e6tBucyMlXW5w==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:ace5:0:b0:d81:8e4d:b681 with SMTP id
 x37-20020a25ace5000000b00d818e4db681mr294402ybd.12.1696967856370; Tue, 10 Oct
 2023 12:57:36 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:57:12 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231010195711.3211020-2-jrife@google.com>
Subject: [PATCH] net: prevent rewrite of msg_name in sock_sendmsg()
From:   Jordan Rife <jrife@google.com>
To:     stable@vger.kernel.org
Cc:     Jordan Rife <jrife@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Simon Horman <horms@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
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

commit 86a7e0b69bd5b812e48a20c66c2161744f3caa16 upstream.

This commit was already queued for backport to 5.4+ but did not cleanly
apply to 4.19 due to some merge conflicts. This patch fixes merge
conflicts for backport to 4.19.

Callers of sock_sendmsg(), and similarly kernel_sendmsg(), in kernel
space may observe their value of msg_name change in cases where BPF
sendmsg hooks rewrite the send address. This has been confirmed to break
NFS mounts running in UDP mode and has the potential to break other
systems.

This patch:

1) Creates a new function called __sock_sendmsg() with same logic as the
   old sock_sendmsg() function.
2) Replaces calls to sock_sendmsg() made by __sys_sendto() and
   __sys_sendmsg() with __sock_sendmsg() to avoid an unnecessary copy,
   as these system calls are already protected.
3) Modifies sock_sendmsg() so that it makes a copy of msg_name if
   present before passing it down the stack to insulate callers from
   changes to the send address.

Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
Cc: <stable@vger.kernel.org> # 4.19.x
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jordan Rife <jrife@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/socket.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index db9d908198f21..8c1a4e26c01fb 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -653,13 +653,30 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
 	return ret;
 }
 
-int sock_sendmsg(struct socket *sock, struct msghdr *msg)
+static int __sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
 	int err = security_socket_sendmsg(sock, msg,
 					  msg_data_left(msg));
 
 	return err ?: sock_sendmsg_nosec(sock, msg);
 }
+
+int sock_sendmsg(struct socket *sock, struct msghdr *msg)
+{
+	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;
+	struct sockaddr_storage address;
+	int ret;
+
+	if (msg->msg_name) {
+		memcpy(&address, msg->msg_name, msg->msg_namelen);
+		msg->msg_name = &address;
+	}
+
+	ret = __sock_sendmsg(sock, msg);
+	msg->msg_name = save_addr;
+
+	return ret;
+}
 EXPORT_SYMBOL(sock_sendmsg);
 
 /**
@@ -963,7 +980,7 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (sock->type == SOCK_SEQPACKET)
 		msg.msg_flags |= MSG_EOR;
 
-	res = sock_sendmsg(sock, &msg);
+	res = __sock_sendmsg(sock, &msg);
 	*from = msg.msg_iter;
 	return res;
 }
@@ -1896,7 +1913,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	if (sock->file->f_flags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
 	msg.msg_flags = flags;
-	err = sock_sendmsg(sock, &msg);
+	err = __sock_sendmsg(sock, &msg);
 
 out_put:
 	fput_light(sock->file, fput_needed);
@@ -2224,7 +2241,7 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
 		err = sock_sendmsg_nosec(sock, msg_sys);
 		goto out_freectl;
 	}
-	err = sock_sendmsg(sock, msg_sys);
+	err = __sock_sendmsg(sock, msg_sys);
 	/*
 	 * If this is sendmmsg() and sending to current destination address was
 	 * successful, remember it.
-- 
2.42.0.609.gbb76f46606-goog

