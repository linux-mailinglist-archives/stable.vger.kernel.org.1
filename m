Return-Path: <stable+bounces-129199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711CA7FE82
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219314420B9
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915CE26988A;
	Tue,  8 Apr 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ooEQjUv/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A4267B7F;
	Tue,  8 Apr 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110385; cv=none; b=jApXgXw5N7tDTU2kQMXsWHYq/fc2ai5jqwVYZaYCCQCzq4VeEinUnHwzRsb8qTQpEdlWLS4pHpqAH3/uGTiYCMWchNlxyzxTaqiHcdm7TyJGQ5tIpV35PommXE65Hcc1JwqBqEs99hIwjNBjkHc97NXTdFoRKv5Un4Zm96tqBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110385; c=relaxed/simple;
	bh=ZPLT87GT9lsFp+pe7PJ33fv/eu4uNE2UJzkEL6CWBV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5Rrj4rl/1DBJWeqOhNZfJmIAsbrD+hPofMfLJPaCG9AA/Fr1caqbFWJK8ohr+Rx5f6ND+aQ8JglNCXxK6x4DzVJzvFUSo9D10QAFc402eCGXbVGKsZAv0JA3TzNUKKfw25q43Y3j5h7dbvWLzxciiSirFtTy/75w74StfLmgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ooEQjUv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4722C4CEE5;
	Tue,  8 Apr 2025 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110385;
	bh=ZPLT87GT9lsFp+pe7PJ33fv/eu4uNE2UJzkEL6CWBV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ooEQjUv/Ne4rHJ1sCUHoHvtd/COCkTSDBdDrDyt3eSU6i8IcJxy0norqCnhcnZ97D
	 uuJzjMfUpxD9z7qRjYGo3PGGoVdCk69IWpu0va3u+UL7Lg6B5KxW5C3HPXnQHQ4aB7
	 6RjQF1YxHlS0iftIXzG0nEstjYPS1NBBy8YyKzho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Andreev <andreev@swemel.ru>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 008/731] smack: dont compile ipv6 code unless ipv6 is configured
Date: Tue,  8 Apr 2025 12:38:25 +0200
Message-ID: <20250408104914.453539805@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Andreev <andreev@swemel.ru>

[ Upstream commit bfcf4004bcbce2cb674b4e8dbd31ce0891766bac ]

I want to be sure that ipv6-specific code
is not compiled in kernel binaries
if ipv6 is not configured.

[1] was getting rid of "unused variable" warning, but,
with that, it also mandated compilation of a handful ipv6-
specific functions in ipv4-only kernel configurations:

smk_ipv6_localhost, smack_ipv6host_label, smk_ipv6_check.

Their compiled bodies are likely to be removed by compiler
from the resulting binary, but, to be on the safe side,
I remove them from the compiler view.

[1]
Fixes: 00720f0e7f28 ("smack: avoid unused 'sip' variable warning")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack.h     |  6 ++++++
 security/smack/smack_lsm.c | 10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 4608b07607a3d..c4d998972ba56 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -152,6 +152,7 @@ struct smk_net4addr {
 	struct smack_known	*smk_label;	/* label */
 };
 
+#if IS_ENABLED(CONFIG_IPV6)
 /*
  * An entry in the table identifying IPv6 hosts.
  */
@@ -162,7 +163,9 @@ struct smk_net6addr {
 	int			smk_masks;	/* mask size */
 	struct smack_known	*smk_label;	/* label */
 };
+#endif /* CONFIG_IPV6 */
 
+#ifdef SMACK_IPV6_PORT_LABELING
 /*
  * An entry in the table identifying ports.
  */
@@ -175,6 +178,7 @@ struct smk_port_label {
 	short			smk_sock_type;	/* Socket type */
 	short			smk_can_reuse;
 };
+#endif /* SMACK_IPV6_PORT_LABELING */
 
 struct smack_known_list_elem {
 	struct list_head	list;
@@ -315,7 +319,9 @@ extern struct smack_known smack_known_web;
 extern struct mutex	smack_known_lock;
 extern struct list_head smack_known_list;
 extern struct list_head smk_net4addr_list;
+#if IS_ENABLED(CONFIG_IPV6)
 extern struct list_head smk_net6addr_list;
+#endif /* CONFIG_IPV6 */
 
 extern struct mutex     smack_onlycap_lock;
 extern struct list_head smack_onlycap_list;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 239773cdcdcf4..85f3d4337ca19 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2492,6 +2492,7 @@ static struct smack_known *smack_ipv4host_label(struct sockaddr_in *sip)
 	return NULL;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 /*
  * smk_ipv6_localhost - Check for local ipv6 host address
  * @sip: the address
@@ -2559,6 +2560,7 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
 
 	return NULL;
 }
+#endif /* CONFIG_IPV6 */
 
 /**
  * smack_netlbl_add - Set the secattr on a socket
@@ -2663,6 +2665,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 	return rc;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 /**
  * smk_ipv6_check - check Smack access
  * @subject: subject Smack label
@@ -2695,6 +2698,7 @@ static int smk_ipv6_check(struct smack_known *subject,
 	rc = smk_bu_note("IPv6 check", subject, object, MAY_WRITE, rc);
 	return rc;
 }
+#endif /* CONFIG_IPV6 */
 
 #ifdef SMACK_IPV6_PORT_LABELING
 /**
@@ -3027,7 +3031,9 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 		return 0;
 	if (addrlen < offsetofend(struct sockaddr, sa_family))
 		return 0;
-	if (IS_ENABLED(CONFIG_IPV6) && sap->sa_family == AF_INET6) {
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sap->sa_family == AF_INET6) {
 		struct sockaddr_in6 *sip = (struct sockaddr_in6 *)sap;
 		struct smack_known *rsp = NULL;
 
@@ -3047,6 +3053,8 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 
 		return rc;
 	}
+#endif /* CONFIG_IPV6 */
+
 	if (sap->sa_family != AF_INET || addrlen < sizeof(struct sockaddr_in))
 		return 0;
 	rc = smk_ipv4_check(sock->sk, (struct sockaddr_in *)sap);
-- 
2.39.5




