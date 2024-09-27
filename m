Return-Path: <stable+bounces-77939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A29988453
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A28B21A06
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45B618C033;
	Fri, 27 Sep 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mDaX064p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E018BC29;
	Fri, 27 Sep 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439975; cv=none; b=oaZarPQe4eZ0vtS8JJr4VaVP7ossIKKg//wDmqlLBTysbUsqyTVBeLZkyoCLH8sx9bpJ2QwtwT4MabL/V2btWxBOB/zHCQbLb2J1QSubfuwNZaic6xSM6s8BZLvIgs9d3QCMQqREUd7uyLuAPvWtVMmJmgwWCN+WXKiJp1G+Yew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439975; c=relaxed/simple;
	bh=zLEVvweewJoOcvVeOf0GSX4zpJCUoXw9r/yY0ylm0pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAnaLNbcgXY8G5x3jtimAgWd8IEcKeN9M2h2b2CKNVnZXk9RkusB92yZaMs9zhbrZnE2ujjpzbr7HwsG8OFUMhDPYHtulbgOHuMu4s3Vi6pySWqrj5dYVFvNQwldCqgtwO8FjM+2mH8odJLQt8ZbgJcgsmkdiv3FlLHUf2GDi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mDaX064p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F189C4CEC4;
	Fri, 27 Sep 2024 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727439975;
	bh=zLEVvweewJoOcvVeOf0GSX4zpJCUoXw9r/yY0ylm0pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDaX064porTDYX2EIKWIcwRFPULqukrlS4bI8PcOkNr6Ij4fn/Bp4aSHg2nJm/THT
	 0T6aQ1cRBZLYf7La/fu3HDuNjfIuTkMYxLYe//DbS0LGkHHMXWR4clLOA6q49qGL4l
	 JVMAJUQ8gpbwQ7ZYM9+kI2ZdcmSgDCUpmlDh/sRo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	cgroups@vger.kernel.org,
	Nadia Pinaeva <n.m.pinaeva@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 6.6 43/54] netfilter: nft_socket: make cgroupsv2 matching work with namespaces
Date: Fri, 27 Sep 2024 14:23:35 +0200
Message-ID: <20240927121721.547965110@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
References: <20240927121719.714627278@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 7f3287db654395f9c5ddd246325ff7889f550286 upstream.

When running in container environmment, /sys/fs/cgroup/ might not be
the real root node of the sk-attached cgroup.

Example:

In container:
% stat /sys//fs/cgroup/
Device: 0,21    Inode: 2214  ..
% stat /sys/fs/cgroup/foo
Device: 0,21    Inode: 2264  ..

The expectation would be for:

  nft add rule .. socket cgroupv2 level 1 "foo" counter

to match traffic from a process that got added to "foo" via
"echo $pid > /sys/fs/cgroup/foo/cgroup.procs".

However, 'level 3' is needed to make this work.

Seen from initial namespace, the complete hierarchy is:

% stat /sys/fs/cgroup/system.slice/docker-.../foo
  Device: 0,21    Inode: 2264 ..

i.e. hierarchy is
0    1               2              3
/ -> system.slice -> docker-1... -> foo

... but the container doesn't know that its "/" is the "docker-1.."
cgroup.  Current code will retrieve the 'system.slice' cgroup node
and store its kn->id in the destination register, so compare with
2264 ("foo" cgroup id) will not match.

Fetch "/" cgroup from ->init() and add its level to the level we try to
extract.  cgroup root-level is 0 for the init-namespace or the level
of the ancestor that is exposed as the cgroup root inside the container.

In the above case, cgrp->level of "/" resolved in the container is 2
(docker-1...scope/) and request for 'level 1' will get adjusted
to fetch the actual level (3).

v2: use CONFIG_SOCK_CGROUP_DATA, eval function depends on it.
    (kernel test robot)

Cc: cgroups@vger.kernel.org
Fixes: e0bb96db96f8 ("netfilter: nft_socket: add support for cgroupsv2")
Reported-by: Nadia Pinaeva <n.m.pinaeva@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_socket.c |   41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -9,7 +9,8 @@
 
 struct nft_socket {
 	enum nft_socket_keys		key:8;
-	u8				level;
+	u8				level;		/* cgroupv2 level to extract */
+	u8				level_user;	/* cgroupv2 level provided by userspace */
 	u8				len;
 	union {
 		u8			dreg;
@@ -53,6 +54,28 @@ nft_sock_get_eval_cgroupv2(u32 *dest, st
 	memcpy(dest, &cgid, sizeof(u64));
 	return true;
 }
+
+/* process context only, uses current->nsproxy. */
+static noinline int nft_socket_cgroup_subtree_level(void)
+{
+	struct cgroup *cgrp = cgroup_get_from_path("/");
+	int level;
+
+	if (!cgrp)
+		return -ENOENT;
+
+	level = cgrp->level;
+
+	cgroup_put(cgrp);
+
+	if (WARN_ON_ONCE(level > 255))
+		return -ERANGE;
+
+	if (WARN_ON_ONCE(level < 0))
+		return -EINVAL;
+
+	return level;
+}
 #endif
 
 static struct sock *nft_socket_do_lookup(const struct nft_pktinfo *pkt)
@@ -174,9 +197,10 @@ static int nft_socket_init(const struct
 	case NFT_SOCKET_MARK:
 		len = sizeof(u32);
 		break;
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_SOCK_CGROUP_DATA
 	case NFT_SOCKET_CGROUPV2: {
 		unsigned int level;
+		int err;
 
 		if (!tb[NFTA_SOCKET_LEVEL])
 			return -EINVAL;
@@ -185,6 +209,17 @@ static int nft_socket_init(const struct
 		if (level > 255)
 			return -EOPNOTSUPP;
 
+		err = nft_socket_cgroup_subtree_level();
+		if (err < 0)
+			return err;
+
+		priv->level_user = level;
+
+		level += err;
+		/* Implies a giant cgroup tree */
+		if (WARN_ON_ONCE(level > 255))
+			return -EOPNOTSUPP;
+
 		priv->level = level;
 		len = sizeof(u64);
 		break;
@@ -209,7 +244,7 @@ static int nft_socket_dump(struct sk_buf
 	if (nft_dump_register(skb, NFTA_SOCKET_DREG, priv->dreg))
 		return -1;
 	if (priv->key == NFT_SOCKET_CGROUPV2 &&
-	    nla_put_be32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level)))
+	    nla_put_be32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level_user)))
 		return -1;
 	return 0;
 }



