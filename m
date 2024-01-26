Return-Path: <stable+bounces-15987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B834D83E63A
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A72A1F22CFB
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D8456775;
	Fri, 26 Jan 2024 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zD/BruQJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D856473
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310485; cv=none; b=NCoAWXiXikMUiztaEFHqVdus5Shzj6AN5+mr2dlSV2iNw1zCrpHis6N8h1fuqevSBJeCc70b+7IH15iXG3PgwYA2TrH2doE8a3TvUlFkBt0J9zkyaSbCyQimeP99fOVts1ApU8xD7VYZjgTCQWz5Jt54VRcRwj4Ux7d4gHpfiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310485; c=relaxed/simple;
	bh=ao0vhEE0woaD/Rv5XMSj+Q0vhibiUsBvZ0IdUHZYBHo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dCs6F5IdaAt2jNNDP2VatuhkYIYEkkYwq456PKFUBsoVj/XIDgpISqF05L5EXuM0R7tv6xBWBBUlqBy3Xjjy1WpaSHd51oHg6q9xy+0L5guxK5NHZhGBDZxVPSX9lE6+rB+SyOUi9X1xGOIWtS1q+nGrEXS8uc3viDRgM5ZqGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zD/BruQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B801BC433A6;
	Fri, 26 Jan 2024 23:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310484;
	bh=ao0vhEE0woaD/Rv5XMSj+Q0vhibiUsBvZ0IdUHZYBHo=;
	h=Subject:To:Cc:From:Date:From;
	b=zD/BruQJod2vvrMIm2ufdTucPRhZp0h+IDIvKplglfSXB95juGobGSeWnI3LrY6SD
	 aiBNfRuiPr0SoXqy5vKT4pDKkKEPKKfuxB+7+Jx9bJg5JTjx3bCU2Tam6Ptx2nHbaB
	 mCo0rPXW2z32xLvWIqadtn4fQb3dnDXDXfrT/D/o=
Subject: FAILED: patch "[PATCH] dlm: use kernel_connect() and kernel_bind()" failed to apply to 6.1-stable tree
To: jrife@google.com,teigland@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:08:03 -0800
Message-ID: <2024012603-demeanor-raider-e2cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e9cdebbe23f1aa9a1caea169862f479ab3fa2773
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012603-demeanor-raider-e2cf@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


