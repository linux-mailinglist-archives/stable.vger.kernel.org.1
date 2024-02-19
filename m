Return-Path: <stable+bounces-20573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9C485A858
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AFFAB260C6
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5413C697;
	Mon, 19 Feb 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rN4ohlcQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F83A1DE
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359060; cv=none; b=Uyn1Ue1/HNKW3R5C6oFsaP9hxSngtS8jkgSZwHXJzYgjLD8cyzYTnfFFjLLgarThPsUe1xqrF7lAIFgQirihpAcN4oFI2BzTuHHKTt3MAwoO6brsup5Hed+J4aiMi6B0kkdnNuCj79enYcESP+CxnY265NOTCytqBKhGAOv5KlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359060; c=relaxed/simple;
	bh=nh/navufMien7FziRSvK/N5+eI7uUEBodbvc/kNznss=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o+kNokfgz2+Qwcmup2EdSgm/UMEMugcfb22by7eaYR5BghLI96G3+8CvbyqyfxCCSAazjkds/zYeKXLPU6G0WvFay/bM+vRuq9QJ8UMmMuvCKwiKs8CSpLx6D9svPp4lA4cBltkbODKOU2h1F+mRvZ3dnxUP20Jmk6L2UMw4bKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rN4ohlcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735C1C433F1;
	Mon, 19 Feb 2024 16:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359059;
	bh=nh/navufMien7FziRSvK/N5+eI7uUEBodbvc/kNznss=;
	h=Subject:To:Cc:From:Date:From;
	b=rN4ohlcQ5fWiMwAH38iQ6AqtkPsRgs4L1tZWUfJScsr6/tr0vKwjaumm6Nb1n2ucK
	 9VhM8h28ZDpsRVXUsWxzPNmMsHGsdSky7rXKVmljowlugT+nJVW0lnPpiGnUpJXxmk
	 x3MV5oLl0b/USTURMvRnl95x3dj4DBwAdAZoQ6uU=
Subject: FAILED: patch "[PATCH] lsm: fix default return value of the socket_getpeersec_*()" failed to apply to 6.1-stable tree
To: omosnace@redhat.com,paul@paul-moore.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:10:57 +0100
Message-ID: <2024021956-lumpiness-massive-2dd8@gregkh>
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
git cherry-pick -x 5a287d3d2b9de2b3e747132c615599907ba5c3c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021956-lumpiness-massive-2dd8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5a287d3d2b9d ("lsm: fix default return value of the socket_getpeersec_*() hooks")
b10b9c342f75 ("lsm: make security_socket_getpeersec_stream() sockptr_t safe")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a287d3d2b9de2b3e747132c615599907ba5c3c1 Mon Sep 17 00:00:00 2001
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 26 Jan 2024 19:45:31 +0100
Subject: [PATCH] lsm: fix default return value of the socket_getpeersec_*()
 hooks

For these hooks the true "neutral" value is -EOPNOTSUPP, which is
currently what is returned when no LSM provides this hook and what LSMs
return when there is no security context set on the socket. Correct the
value in <linux/lsm_hooks.h> and adjust the dispatch functions in
security/security.c to avoid issues when the BPF LSM is enabled.

Cc: stable@vger.kernel.org
Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
[PM: subject line tweak]
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 185924c56378..76458b6d53da 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -315,9 +315,9 @@ LSM_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, int optname)
 LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
 LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
 LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
-LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
+LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket *sock,
 	 sockptr_t optval, sockptr_t optlen, unsigned int len)
-LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
+LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket *sock,
 	 struct sk_buff *skb, u32 *secid)
 LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
 LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
diff --git a/security/security.c b/security/security.c
index 6196ccaba433..3aaad75c9ce8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4624,8 +4624,20 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 				      sockptr_t optlen, unsigned int len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-			     optval, optlen, len);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list) {
+		rc = hp->hook.socket_getpeersec_stream(sock, optval, optlen,
+						       len);
+		if (rc != LSM_RET_DEFAULT(socket_getpeersec_stream))
+			return rc;
+	}
+	return LSM_RET_DEFAULT(socket_getpeersec_stream);
 }
 
 /**
@@ -4645,8 +4657,19 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 int security_socket_getpeersec_dgram(struct socket *sock,
 				     struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+			     list) {
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+		if (rc != LSM_RET_DEFAULT(socket_getpeersec_dgram))
+			return rc;
+	}
+	return LSM_RET_DEFAULT(socket_getpeersec_dgram);
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 


