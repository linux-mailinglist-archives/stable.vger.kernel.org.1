Return-Path: <stable+bounces-79329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA4598D7B0
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485EC282CDA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A81D04AD;
	Wed,  2 Oct 2024 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F/r0FfQd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679021BDA95;
	Wed,  2 Oct 2024 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877124; cv=none; b=fb2RyjW1KsexBRqHu9xCPWE3CnTerKF+hyUvTjJoIjYtv4e5DoutIrcZBVKXWuUbIf12DY7V4IMPBE1i1/CleWUrQY4/FZrGmCW1EnTD+cZVAnsnJj+7WTwjsH/YaUpbyuBBg+4UnHQPcer+VoxxFwTNnppHugF7tnOjXovkZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877124; c=relaxed/simple;
	bh=PrVCCFSmmEJz8+b9Ql/hVtK+54ipl1ob0CYJKz1/Sq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PX9ERmWV2W8pn9QjRnYM0AeGKG4HD7u1T0tQ9wVFeaCbUft68ehH4ORfjcBPy0bjDs4g8wniZbpBIR+3m9jXSowUaeQK/ntgxS/Kueh1DfV3u5pZpiLFCywensRgxuLxGlZyR8pJsG0d8cmTsZJ8RdorC49ElKjjzypjgkb73o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F/r0FfQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DF4C4CEC5;
	Wed,  2 Oct 2024 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877124;
	bh=PrVCCFSmmEJz8+b9Ql/hVtK+54ipl1ob0CYJKz1/Sq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/r0FfQdWLvs/M3Nwj0B4AH4qeTOEtjJ4TwE3FvfU1LfewSk7RLbwJQEVLve3KbFx
	 x3Aefsvg98KF+2NFiMU94AP15w15zevxtw3jOObICSai7l9hHtv/zE6YSMIhX6KDbc
	 D756QRZtB9520V74FNqJBJLKhJJBOW4rFIbZWGvw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Moore <paul@paul-moore.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 673/695] lsm: infrastructure management of the sock security
Date: Wed,  2 Oct 2024 15:01:11 +0200
Message-ID: <20241002125849.377793120@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Casey Schaufler <casey@schaufler-ca.com>

[ Upstream commit 2aff9d20d50ac45dd13a013ef5231f4fb8912356 ]

Move management of the sock->sk_security blob out
of the individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
[PM: subject tweak]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: 63dff3e48871 ("lsm: add the inode_free_security_rcu() LSM implementation hook")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/lsm_hooks.h         |    1 
 security/apparmor/include/net.h   |    3 -
 security/apparmor/lsm.c           |   17 --------
 security/apparmor/net.c           |    2 
 security/security.c               |   36 ++++++++++++++++-
 security/selinux/hooks.c          |   80 +++++++++++++++++---------------------
 security/selinux/include/objsec.h |    5 ++
 security/selinux/netlabel.c       |   23 +++++-----
 security/smack/smack.h            |    5 ++
 security/smack/smack_lsm.c        |   70 +++++++++++++++------------------
 security/smack/smack_netfilter.c  |    4 -
 11 files changed, 133 insertions(+), 113 deletions(-)

--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -73,6 +73,7 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_sock;
 	int	lbs_superblock;
 	int	lbs_ipc;
 	int	lbs_msg_msg;
--- a/security/apparmor/include/net.h
+++ b/security/apparmor/include/net.h
@@ -51,10 +51,9 @@ struct aa_sk_ctx {
 	struct aa_label *peer;
 };
 
-#define SK_CTX(X) ((X)->sk_security)
 static inline struct aa_sk_ctx *aa_sock(const struct sock *sk)
 {
-	return sk->sk_security;
+	return sk->sk_security + apparmor_blob_sizes.lbs_sock;
 }
 
 #define DEFINE_AUDIT_NET(NAME, OP, SK, F, T, P)				  \
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1058,27 +1058,12 @@ static int apparmor_userns_create(const
 	return error;
 }
 
-static int apparmor_sk_alloc_security(struct sock *sk, int family, gfp_t flags)
-{
-	struct aa_sk_ctx *ctx;
-
-	ctx = kzalloc(sizeof(*ctx), flags);
-	if (!ctx)
-		return -ENOMEM;
-
-	sk->sk_security = ctx;
-
-	return 0;
-}
-
 static void apparmor_sk_free_security(struct sock *sk)
 {
 	struct aa_sk_ctx *ctx = aa_sock(sk);
 
-	sk->sk_security = NULL;
 	aa_put_label(ctx->label);
 	aa_put_label(ctx->peer);
-	kfree(ctx);
 }
 
 /**
@@ -1433,6 +1418,7 @@ struct lsm_blob_sizes apparmor_blob_size
 	.lbs_cred = sizeof(struct aa_label *),
 	.lbs_file = sizeof(struct aa_file_ctx),
 	.lbs_task = sizeof(struct aa_task_ctx),
+	.lbs_sock = sizeof(struct aa_sk_ctx),
 };
 
 static const struct lsm_id apparmor_lsmid = {
@@ -1478,7 +1464,6 @@ static struct security_hook_list apparmo
 	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
 	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
 
-	LSM_HOOK_INIT(sk_alloc_security, apparmor_sk_alloc_security),
 	LSM_HOOK_INIT(sk_free_security, apparmor_sk_free_security),
 	LSM_HOOK_INIT(sk_clone_security, apparmor_sk_clone_security),
 
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -151,7 +151,7 @@ static int aa_label_sk_perm(const struct
 			    const char *op, u32 request,
 			    struct sock *sk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 	int error = 0;
 
 	AA_BUG(!label);
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/msg.h>
 #include <linux/overflow.h>
 #include <net/flow.h>
+#include <net/sock.h>
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
@@ -227,6 +228,7 @@ static void __init lsm_set_blob_sizes(st
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 	lsm_set_blob_size(&needed->lbs_xattr_count,
@@ -401,6 +403,7 @@ static void __init ordered_lsm_init(void
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
+	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
@@ -4674,6 +4677,28 @@ int security_socket_getpeersec_dgram(str
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
 /**
+ * lsm_sock_alloc - allocate a composite sock blob
+ * @sock: the sock that needs a blob
+ * @priority: allocation mode
+ *
+ * Allocate the sock blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_sock_alloc(struct sock *sock, gfp_t priority)
+{
+	if (blob_sizes.lbs_sock == 0) {
+		sock->sk_security = NULL;
+		return 0;
+	}
+
+	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
+	if (sock->sk_security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
  * security_sk_alloc() - Allocate and initialize a sock's LSM blob
  * @sk: sock
  * @family: protocol family
@@ -4686,7 +4711,14 @@ EXPORT_SYMBOL(security_socket_getpeersec
  */
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
-	return call_int_hook(sk_alloc_security, sk, family, priority);
+	int rc = lsm_sock_alloc(sk, priority);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(sk_alloc_security, sk, family, priority);
+	if (unlikely(rc))
+		security_sk_free(sk);
+	return rc;
 }
 
 /**
@@ -4698,6 +4730,8 @@ int security_sk_alloc(struct sock *sk, i
 void security_sk_free(struct sock *sk)
 {
 	call_void_hook(sk_free_security, sk);
+	kfree(sk->sk_security);
+	sk->sk_security = NULL;
 }
 
 /**
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4594,7 +4594,7 @@ static int socket_sockcreate_sid(const s
 
 static int sock_has_perm(struct sock *sk, u32 perms)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 
@@ -4662,7 +4662,7 @@ static int selinux_socket_post_create(st
 	isec->initialized = LABEL_INITIALIZED;
 
 	if (sock->sk) {
-		sksec = sock->sk->sk_security;
+		sksec = selinux_sock(sock->sk);
 		sksec->sclass = sclass;
 		sksec->sid = sid;
 		/* Allows detection of the first association on this socket */
@@ -4678,8 +4678,8 @@ static int selinux_socket_post_create(st
 static int selinux_socket_socketpair(struct socket *socka,
 				     struct socket *sockb)
 {
-	struct sk_security_struct *sksec_a = socka->sk->sk_security;
-	struct sk_security_struct *sksec_b = sockb->sk->sk_security;
+	struct sk_security_struct *sksec_a = selinux_sock(socka->sk);
+	struct sk_security_struct *sksec_b = selinux_sock(sockb->sk);
 
 	sksec_a->peer_sid = sksec_b->sid;
 	sksec_b->peer_sid = sksec_a->sid;
@@ -4694,7 +4694,7 @@ static int selinux_socket_socketpair(str
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
 
@@ -4834,7 +4834,7 @@ static int selinux_socket_connect_helper
 					 struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 
 	err = sock_has_perm(sk, SOCKET__CONNECT);
@@ -5012,9 +5012,9 @@ static int selinux_socket_unix_stream_co
 					      struct sock *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *sksec_sock = sock->sk_security;
-	struct sk_security_struct *sksec_other = other->sk_security;
-	struct sk_security_struct *sksec_new = newsk->sk_security;
+	struct sk_security_struct *sksec_sock = selinux_sock(sock);
+	struct sk_security_struct *sksec_other = selinux_sock(other);
+	struct sk_security_struct *sksec_new = selinux_sock(newsk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	int err;
@@ -5043,8 +5043,8 @@ static int selinux_socket_unix_stream_co
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
-	struct sk_security_struct *ssec = sock->sk->sk_security;
-	struct sk_security_struct *osec = other->sk->sk_security;
+	struct sk_security_struct *ssec = selinux_sock(sock->sk);
+	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 
@@ -5081,7 +5081,7 @@ static int selinux_sock_rcv_skb_compat(s
 				       u16 family)
 {
 	int err = 0;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
@@ -5110,7 +5110,7 @@ static int selinux_sock_rcv_skb_compat(s
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int err, peerlbl_active, secmark_active;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
@@ -5178,7 +5178,7 @@ static int selinux_socket_getpeersec_str
 	int err = 0;
 	char *scontext = NULL;
 	u32 scontext_len;
-	struct sk_security_struct *sksec = sock->sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sock->sk);
 	u32 peer_sid = SECSID_NULL;
 
 	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
@@ -5238,34 +5238,27 @@ static int selinux_socket_getpeersec_dgr
 
 static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
-	struct sk_security_struct *sksec;
-
-	sksec = kzalloc(sizeof(*sksec), priority);
-	if (!sksec)
-		return -ENOMEM;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	sksec->peer_sid = SECINITSID_UNLABELED;
 	sksec->sid = SECINITSID_UNLABELED;
 	sksec->sclass = SECCLASS_SOCKET;
 	selinux_netlbl_sk_security_reset(sksec);
-	sk->sk_security = sksec;
 
 	return 0;
 }
 
 static void selinux_sk_free_security(struct sock *sk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
-	sk->sk_security = NULL;
 	selinux_netlbl_sk_security_free(sksec);
-	kfree(sksec);
 }
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = sksec->sid;
 	newsksec->peer_sid = sksec->peer_sid;
@@ -5279,7 +5272,7 @@ static void selinux_sk_getsecid(const st
 	if (!sk)
 		*secid = SECINITSID_ANY_SOCKET;
 	else {
-		const struct sk_security_struct *sksec = sk->sk_security;
+		const struct sk_security_struct *sksec = selinux_sock(sk);
 
 		*secid = sksec->sid;
 	}
@@ -5289,7 +5282,7 @@ static void selinux_sock_graft(struct so
 {
 	struct inode_security_struct *isec =
 		inode_security_novalidate(SOCK_INODE(parent));
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
 	    sk->sk_family == PF_UNIX)
@@ -5306,7 +5299,7 @@ static int selinux_sctp_process_new_asso
 {
 	struct sock *sk = asoc->base.sk;
 	u16 family = sk->sk_family;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	int err;
@@ -5361,7 +5354,7 @@ static int selinux_sctp_process_new_asso
 static int selinux_sctp_assoc_request(struct sctp_association *asoc,
 				      struct sk_buff *skb)
 {
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
 	u32 conn_sid;
 	int err;
 
@@ -5394,7 +5387,7 @@ static int selinux_sctp_assoc_request(st
 static int selinux_sctp_assoc_established(struct sctp_association *asoc,
 					  struct sk_buff *skb)
 {
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
@@ -5493,8 +5486,8 @@ static int selinux_sctp_bind_connect(str
 static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
 				  struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	/* If policy does not support SECCLASS_SCTP_SOCKET then call
 	 * the non-sctp clone version.
@@ -5510,8 +5503,8 @@ static void selinux_sctp_sk_clone(struct
 
 static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 {
-	struct sk_security_struct *ssksec = ssk->sk_security;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *ssksec = selinux_sock(ssk);
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	ssksec->sclass = sksec->sclass;
 	ssksec->sid = sksec->sid;
@@ -5526,7 +5519,7 @@ static int selinux_mptcp_add_subflow(str
 static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 	u16 family = req->rsk_ops->family;
 	u32 connsid;
@@ -5547,7 +5540,7 @@ static int selinux_inet_conn_request(con
 static void selinux_inet_csk_clone(struct sock *newsk,
 				   const struct request_sock *req)
 {
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = req->secid;
 	newsksec->peer_sid = req->peer_secid;
@@ -5564,7 +5557,7 @@ static void selinux_inet_csk_clone(struc
 static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 {
 	u16 family = sk->sk_family;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* handle mapped IPv4 packets arriving via IPv6 sockets */
 	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
@@ -5639,7 +5632,7 @@ static int selinux_tun_dev_attach_queue(
 static int selinux_tun_dev_attach(struct sock *sk, void *security)
 {
 	struct tun_security_struct *tunsec = security;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* we don't currently perform any NetLabel based labeling here and it
 	 * isn't clear that we would want to do so anyway; while we could apply
@@ -5762,7 +5755,7 @@ static unsigned int selinux_ip_output(vo
 			return NF_ACCEPT;
 
 		/* standard practice, label using the parent socket */
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		sid = sksec->sid;
 	} else
 		sid = SECINITSID_KERNEL;
@@ -5785,7 +5778,7 @@ static unsigned int selinux_ip_postroute
 	sk = skb_to_full_sk(skb);
 	if (sk == NULL)
 		return NF_ACCEPT;
-	sksec = sk->sk_security;
+	sksec = selinux_sock(sk);
 
 	ad_net_init_from_iif(&ad, &net, state->out->ifindex, state->pf);
 	if (selinux_parse_skb(skb, &ad, NULL, 0, &proto))
@@ -5874,7 +5867,7 @@ static unsigned int selinux_ip_postroute
 		u32 skb_sid;
 		struct sk_security_struct *sksec;
 
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
 			return NF_DROP;
 		/* At this point, if the returned skb peerlbl is SECSID_NULL
@@ -5903,7 +5896,7 @@ static unsigned int selinux_ip_postroute
 	} else {
 		/* Locally generated packet, fetch the security label from the
 		 * associated socket. */
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 		peer_sid = sksec->sid;
 		secmark_perm = PACKET__SEND;
 	}
@@ -5946,7 +5939,7 @@ static int selinux_netlink_send(struct s
 	unsigned int data_len = skb->len;
 	unsigned char *data = skb->data;
 	struct nlmsghdr *nlh;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 sclass = sksec->sclass;
 	u32 perm;
 
@@ -7004,6 +6997,7 @@ struct lsm_blob_sizes selinux_blob_sizes
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
+	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 };
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -195,4 +195,9 @@ selinux_superblock(const struct super_bl
 	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
 }
 
+static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
+{
+	return sock->sk_security + selinux_blob_sizes.lbs_sock;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -17,6 +17,7 @@
 #include <linux/gfp.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/lsm_hooks.h>
 #include <net/sock.h>
 #include <net/netlabel.h>
 #include <net/ip.h>
@@ -68,7 +69,7 @@ static int selinux_netlbl_sidlookup_cach
 static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (sksec->nlbl_secattr != NULL)
@@ -100,7 +101,7 @@ static struct netlbl_lsm_secattr *selinu
 							const struct sock *sk,
 							u32 sid)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr = sksec->nlbl_secattr;
 
 	if (secattr == NULL)
@@ -240,7 +241,7 @@ int selinux_netlbl_skbuff_setsid(struct
 	 * being labeled by it's parent socket, if it is just exit */
 	sk = skb_to_full_sk(skb);
 	if (sk != NULL) {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 
 		if (sksec->nlbl_state != NLBL_REQSKB)
 			return 0;
@@ -277,7 +278,7 @@ int selinux_netlbl_sctp_assoc_request(st
 {
 	int rc;
 	struct netlbl_lsm_secattr secattr;
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
 	struct sockaddr_in addr4;
 	struct sockaddr_in6 addr6;
 
@@ -356,7 +357,7 @@ inet_conn_request_return:
  */
 void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (family == PF_INET)
 		sksec->nlbl_state = NLBL_LABELED;
@@ -374,8 +375,8 @@ void selinux_netlbl_inet_csk_clone(struc
  */
 void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->nlbl_state = sksec->nlbl_state;
 }
@@ -393,7 +394,7 @@ void selinux_netlbl_sctp_sk_clone(struct
 int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (family != PF_INET && family != PF_INET6)
@@ -510,7 +511,7 @@ int selinux_netlbl_socket_setsockopt(str
 {
 	int rc = 0;
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr secattr;
 
 	if (selinux_netlbl_option(level, optname) &&
@@ -548,7 +549,7 @@ static int selinux_netlbl_socket_connect
 						struct sockaddr *addr)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	/* connected sockets are allowed to disconnect when the address family
@@ -587,7 +588,7 @@ static int selinux_netlbl_socket_connect
 int selinux_netlbl_socket_connect_locked(struct sock *sk,
 					 struct sockaddr *addr)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sksec->nlbl_state != NLBL_REQSKB &&
 	    sksec->nlbl_state != NLBL_CONNLABELED)
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -355,6 +355,11 @@ static inline struct superblock_smack *s
 	return superblock->s_security + smack_blob_sizes.lbs_superblock;
 }
 
+static inline struct socket_smack *smack_sock(const struct sock *sock)
+{
+	return sock->sk_security + smack_blob_sizes.lbs_sock;
+}
+
 /*
  * Is the directory transmuting?
  */
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1606,7 +1606,7 @@ static int smack_inode_getsecurity(struc
 		if (sock == NULL || sock->sk == NULL)
 			return -EOPNOTSUPP;
 
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 
 		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 			isp = ssp->smk_in;
@@ -1994,7 +1994,7 @@ static int smack_file_receive(struct fil
 
 	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		tsp = smack_cred(current_cred());
 		/*
 		 * If the receiving process can't write to the
@@ -2409,11 +2409,7 @@ static void smack_task_to_inode(struct t
 static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 {
 	struct smack_known *skp = smk_of_current();
-	struct socket_smack *ssp;
-
-	ssp = kzalloc(sizeof(struct socket_smack), gfp_flags);
-	if (ssp == NULL)
-		return -ENOMEM;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Sockets created by kernel threads receive web label.
@@ -2427,11 +2423,10 @@ static int smack_sk_alloc_security(struc
 	}
 	ssp->smk_packet = NULL;
 
-	sk->sk_security = ssp;
-
 	return 0;
 }
 
+#ifdef SMACK_IPV6_PORT_LABELING
 /**
  * smack_sk_free_security - Free a socket blob
  * @sk: the socket
@@ -2440,7 +2435,6 @@ static int smack_sk_alloc_security(struc
  */
 static void smack_sk_free_security(struct sock *sk)
 {
-#ifdef SMACK_IPV6_PORT_LABELING
 	struct smk_port_label *spp;
 
 	if (sk->sk_family == PF_INET6) {
@@ -2453,9 +2447,8 @@ static void smack_sk_free_security(struc
 		}
 		rcu_read_unlock();
 	}
-#endif
-	kfree(sk->sk_security);
 }
+#endif
 
 /**
  * smack_sk_clone_security - Copy security context
@@ -2466,8 +2459,8 @@ static void smack_sk_free_security(struc
  */
 static void smack_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct socket_smack *ssp_old = sk->sk_security;
-	struct socket_smack *ssp_new = newsk->sk_security;
+	struct socket_smack *ssp_old = smack_sock(sk);
+	struct socket_smack *ssp_new = smack_sock(newsk);
 
 	*ssp_new = *ssp_old;
 }
@@ -2583,7 +2576,7 @@ static struct smack_known *smack_ipv6hos
  */
 static int smack_netlbl_add(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = ssp->smk_out;
 	int rc;
 
@@ -2616,7 +2609,7 @@ static int smack_netlbl_add(struct sock
  */
 static void smack_netlbl_delete(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Take the label off the socket if one is set.
@@ -2648,7 +2641,7 @@ static int smk_ipv4_check(struct sock *s
 	struct smack_known *skp;
 	int rc = 0;
 	struct smack_known *hkp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smk_audit_info ad;
 
 	rcu_read_lock();
@@ -2721,7 +2714,7 @@ static void smk_ipv6_port_label(struct s
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_in6 *addr6;
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smk_port_label *spp;
 	unsigned short port = 0;
 
@@ -2809,7 +2802,7 @@ static int smk_ipv6_port_check(struct so
 				int act)
 {
 	struct smk_port_label *spp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	unsigned short port;
 	struct smack_known *object;
@@ -2912,7 +2905,7 @@ static int smack_inode_setsecurity(struc
 	if (sock == NULL || sock->sk == NULL)
 		return -EOPNOTSUPP;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 		ssp->smk_in = skp;
@@ -2960,7 +2953,7 @@ static int smack_socket_post_create(stru
 	 * Sockets created by kernel threads receive web label.
 	 */
 	if (unlikely(current->flags & PF_KTHREAD)) {
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		ssp->smk_in = &smack_known_web;
 		ssp->smk_out = &smack_known_web;
 	}
@@ -2985,8 +2978,8 @@ static int smack_socket_post_create(stru
 static int smack_socket_socketpair(struct socket *socka,
 		                   struct socket *sockb)
 {
-	struct socket_smack *asp = socka->sk->sk_security;
-	struct socket_smack *bsp = sockb->sk->sk_security;
+	struct socket_smack *asp = smack_sock(socka->sk);
+	struct socket_smack *bsp = smack_sock(sockb->sk);
 
 	asp->smk_packet = bsp->smk_out;
 	bsp->smk_packet = asp->smk_out;
@@ -3049,7 +3042,7 @@ static int smack_socket_connect(struct s
 		if (__is_defined(SMACK_IPV6_SECMARK_LABELING))
 			rsp = smack_ipv6host_label(sip);
 		if (rsp != NULL) {
-			struct socket_smack *ssp = sock->sk->sk_security;
+			struct socket_smack *ssp = smack_sock(sock->sk);
 
 			rc = smk_ipv6_check(ssp->smk_out, rsp, sip,
 					    SMK_CONNECTING);
@@ -3844,9 +3837,9 @@ static int smack_unix_stream_connect(str
 {
 	struct smack_known *skp;
 	struct smack_known *okp;
-	struct socket_smack *ssp = sock->sk_security;
-	struct socket_smack *osp = other->sk_security;
-	struct socket_smack *nsp = newsk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock);
+	struct socket_smack *osp = smack_sock(other);
+	struct socket_smack *nsp = smack_sock(newsk);
 	struct smk_audit_info ad;
 	int rc = 0;
 #ifdef CONFIG_AUDIT
@@ -3898,8 +3891,8 @@ static int smack_unix_stream_connect(str
  */
 static int smack_unix_may_send(struct socket *sock, struct socket *other)
 {
-	struct socket_smack *ssp = sock->sk->sk_security;
-	struct socket_smack *osp = other->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
+	struct socket_smack *osp = smack_sock(other->sk);
 	struct smk_audit_info ad;
 	int rc;
 
@@ -3936,7 +3929,7 @@ static int smack_socket_sendmsg(struct s
 	struct sockaddr_in6 *sap = (struct sockaddr_in6 *) msg->msg_name;
 #endif
 #ifdef SMACK_IPV6_SECMARK_LABELING
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smack_known *rsp;
 #endif
 	int rc = 0;
@@ -4148,7 +4141,7 @@ static struct smack_known *smack_from_ne
 	netlbl_secattr_init(&secattr);
 
 	if (sk)
-		ssp = sk->sk_security;
+		ssp = smack_sock(sk);
 
 	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
 		skp = smack_from_secattr(&secattr, ssp);
@@ -4170,7 +4163,7 @@ static struct smack_known *smack_from_ne
  */
 static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	int rc = 0;
 	struct smk_audit_info ad;
@@ -4274,7 +4267,7 @@ static int smack_socket_getpeersec_strea
 	u32 slen = 1;
 	int rc = 0;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 	if (ssp->smk_packet != NULL) {
 		rcp = ssp->smk_packet->smk_known;
 		slen = strlen(rcp) + 1;
@@ -4324,7 +4317,7 @@ static int smack_socket_getpeersec_dgram
 
 	switch (family) {
 	case PF_UNIX:
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		s = ssp->smk_out->smk_secid;
 		break;
 	case PF_INET:
@@ -4373,7 +4366,7 @@ static void smack_sock_graft(struct sock
 	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
 		return;
 
-	ssp = sk->sk_security;
+	ssp = smack_sock(sk);
 	ssp->smk_in = skp;
 	ssp->smk_out = skp;
 	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
@@ -4393,7 +4386,7 @@ static int smack_inet_conn_request(const
 {
 	u16 family = sk->sk_family;
 	struct smack_known *skp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct sockaddr_in addr;
 	struct iphdr *hdr;
 	struct smack_known *hskp;
@@ -4479,7 +4472,7 @@ static int smack_inet_conn_request(const
 static void smack_inet_csk_clone(struct sock *sk,
 				 const struct request_sock *req)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp;
 
 	if (req->peer_secid != 0) {
@@ -5049,6 +5042,7 @@ struct lsm_blob_sizes smack_blob_sizes _
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
 	.lbs_msg_msg = sizeof(struct smack_known *),
+	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
 };
@@ -5173,7 +5167,9 @@ static struct security_hook_list smack_h
 	LSM_HOOK_INIT(socket_getpeersec_stream, smack_socket_getpeersec_stream),
 	LSM_HOOK_INIT(socket_getpeersec_dgram, smack_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
+#ifdef SMACK_IPV6_PORT_LABELING
 	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
+#endif
 	LSM_HOOK_INIT(sk_clone_security, smack_sk_clone_security),
 	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -26,8 +26,8 @@ static unsigned int smack_ip_output(void
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk && sk->sk_security) {
-		ssp = sk->sk_security;
+	if (sk) {
+		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
 	}



