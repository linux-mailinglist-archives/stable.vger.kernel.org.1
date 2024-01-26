Return-Path: <stable+bounces-15988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 746E783E63B
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70B61C21AC7
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6594456B70;
	Fri, 26 Jan 2024 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+IrIeVq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2817A55E57
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310486; cv=none; b=nzZ5ywrnmYEya28r0otweWVejYRXtQgjmMPWksWeeDYhV7JU8EPoLpnLH+LgMkCgmEI9ND1kB8TW97EB8KBGAAoOuuQHXzsFwsFJxRUtLLgly7B3TEPaA0iOMBBjPSsJjJnVU7Y0CxJng5mBM7w/XpLd711Y6yCzp4x58ZWcu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310486; c=relaxed/simple;
	bh=FC+At/ypuutjDvZq7hy6i9jmQW+1YBR5SO+ZQEOwHNE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C79S1fRTazxpy72En3SMR9f3EQ7OfO3+gx6CGXLES559sVUa0/08y3hS5ORRBt4nXFXrUoxijske5FeRnnFhRUruV7OsYtFTUzrMTk7Z5lK8GMdnaeGz7/Ad30QG9N1R0z+TjJXpr6V9zaRGiyBPXaULwPunTnktO6HP8CfjRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+IrIeVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5286C433F1;
	Fri, 26 Jan 2024 23:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310485;
	bh=FC+At/ypuutjDvZq7hy6i9jmQW+1YBR5SO+ZQEOwHNE=;
	h=Subject:To:Cc:From:Date:From;
	b=M+IrIeVqRRUk1eGLQF6I1WhWOvLqlnnkBTfxCRPbgj+7DJYYJptF+oT0M6RmYLEkV
	 /cO0vkwuUDHIG04WferLWu0o5ayOPf4T2tdmuxo0L6QXEgtUEetX7DYbmrueBvQfqA
	 UuUFHVOneb4jFOUEatQk+jNAWkPTV/A2yQRjZC8o=
Subject: FAILED: patch "[PATCH] dlm: use kernel_connect() and kernel_bind()" failed to apply to 5.15-stable tree
To: jrife@google.com,teigland@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:08:04 -0800
Message-ID: <2024012604-antiviral-unhidden-5f9b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e9cdebbe23f1aa9a1caea169862f479ab3fa2773
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012604-antiviral-unhidden-5f9b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
dbb751ffab0b ("fs: dlm: parallelize lowcomms socket handling")
c852a6d70698 ("fs: dlm: use saved sk_error_report()")
e9dd5fd849f1 ("fs: dlm: use sock2con without checking null")
6f0b0b5d7ae7 ("fs: dlm: remove dlm_node_addrs lookup list")
c51c9cd8addc ("fs: dlm: don't put dlm_local_addrs on heap")
c3d88dfd1583 ("fs: dlm: cleanup listen sock handling")
4f567acb0b86 ("fs: dlm: remove socket shutdown handling")
1037c2a94ab5 ("fs: dlm: use listen sock as dlm running indicator")
194a3fb488f2 ("fs: dlm: relax sending to allow receiving")
f0f4bb431bd5 ("fs: dlm: retry accept() until -EAGAIN or error returns")
08ae0547e75e ("fs: dlm: fix sock release if listen fails")
dfc020f334f8 ("fs: dlm: fix grammar in lowcomms output")
3af2326ca0a1 ("fs: dlm: memory cache for writequeue_entry")
6c547f264077 ("fs: dlm: memory cache for midcomms hotpath")
be3b0400edbf ("fs: dlm: remove wq_alloc mutex")
92c446053814 ("fs: dlm: replace use of socket sk_callback_lock with sock_lock")
4c3d90570bcc ("fs: dlm: don't call kernel_getpeername() in error_report()")
b87b1883efe3 ("fs: dlm: remove double list_first_entry call")
9af5b8f0ead7 ("fs: dlm: add debugfs rawmsg send functionality")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e9cdebbe23f1aa9a1caea169862f479ab3fa2773 Mon Sep 17 00:00:00 2001
From: Jordan Rife <jrife@google.com>
Date: Mon, 6 Nov 2023 15:24:38 -0600
Subject: [PATCH] dlm: use kernel_connect() and kernel_bind()

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
Signed-off-by: David Teigland <teigland@redhat.com>

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 67f8dd8a05ef..6296c62c10fa 100644
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


