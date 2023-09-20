Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A4F7A7F85
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjITM1h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjITM1g (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:27:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FB6D9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:27:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D55C433C9;
        Wed, 20 Sep 2023 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212850;
        bh=qm/TCz6oqe7SBGBfYK6BaoGqtwS8C+piqs3kmGpWyNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiP3E9vdRqk2sj6UgOS+V0VPUqmiM0zaYvynOrUvf85Ve9ZDcI2z+ppgv0yOqZqEb
         SReoh0UvIzvtMmrMdlUdFy+0elfnS/U3v/DOKcUG7tuwbDJARd7jHWPTkafJDr5CG1
         4OvpFqENK8P91ZwAZ/qoBGU05P2vABp54O9A23bs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jordan Rife <jrife@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 043/367] net: Avoid address overwrite in kernel_connect
Date:   Wed, 20 Sep 2023 13:27:00 +0200
Message-ID: <20230920112859.613113722@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jordan Rife <jrife@google.com>

commit 0bdf399342c5acbd817c9098b6c7ed21f1974312 upstream.

BPF programs that run on connect can rewrite the connect address. For
the connect system call this isn't a problem, because a copy of the address
is made when it is moved into kernel space. However, kernel_connect
simply passes through the address it is given, so the caller may observe
its address value unexpectedly change.

A practical example where this is problematic is where NFS is combined
with a system such as Cilium which implements BPF-based load balancing.
A common pattern in software-defined storage systems is to have an NFS
mount that connects to a persistent virtual IP which in turn maps to an
ephemeral server IP. This is usually done to achieve high availability:
if your server goes down you can quickly spin up a replacement and remap
the virtual IP to that endpoint. With BPF-based load balancing, mounts
will forget the virtual IP address when the address rewrite occurs
because a pointer to the only copy of that address is passed down the
stack. Server failover then breaks, because clients have forgotten the
virtual IP address. Reconnects fail and mounts remain broken. This patch
was tested by setting up a scenario like this and ensuring that NFS
reconnects worked after applying the patch.

Signed-off-by: Jordan Rife <jrife@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/socket.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/socket.c
+++ b/net/socket.c
@@ -3637,7 +3637,11 @@ EXPORT_SYMBOL(kernel_accept);
 int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags)
 {
-	return sock->ops->connect(sock, addr, addrlen, flags);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return sock->ops->connect(sock, (struct sockaddr *)&address, addrlen, flags);
 }
 EXPORT_SYMBOL(kernel_connect);
 


