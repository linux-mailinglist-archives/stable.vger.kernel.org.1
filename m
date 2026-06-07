Return-Path: <stable+bounces-261226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yKhBMJtGJWoIFwIAu9opvQ
	(envelope-from <stable+bounces-261226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:23:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E5F64F9AA
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:23:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=1J9c79ok;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261226-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261226-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 363CA3010B93
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776AC2EC54A;
	Sun,  7 Jun 2026 10:22:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F406E2ECEB9;
	Sun,  7 Jun 2026 10:22:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827737; cv=none; b=jEg3nJhZi6P95DnDR+KGIzHVnfxxi7XA0u0Y6dCVq8EaFKixQ9coPpPLUlsNPTBxUM2RZ5SxphKLmIRYj2E/KseDi4O2x2D45tKzYkwGb6KEA7IipOpbKcFwa/J6fXH0HX1E64XK32+8axqmN9c0E2i9ozB9jSymHI+6e7iObYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827737; c=relaxed/simple;
	bh=S4LXJZ9tiSPtfEDy1dd+wvtZy/4zfIE7FOo2ODVkGb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4T/Jg/52EOmOjIqviuIk2UgxW1ocBtV7MCgMfhfPTMhB++yo+d56Fc+Z5nJuWAQ+D1XFlTTMawOmcvTRwr7wcdqVzydB+p9bvdyqcakK0yaAwZAvUrtglNEiqLkzv0L/PbQigpNXM+5W/BnKRslnfjJMt8mcRDV+W9cl56gmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1J9c79ok; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6C01F00893;
	Sun,  7 Jun 2026 10:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827735;
	bh=cXyLjeFPjUBB935DwnJB+pE99MNXrw+shzL3ZoTU1Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1J9c79okH6ckj4QQvchrwrDra1WUVDObksHxDpOEEqtBYTUYDJlnCzU/aV2CevEl/
	 fj6g77isT2/G6p3AxHdJuPTsBLTRP5QTZ3T606fMGy8l3bM4+KJVzv0IYw3PMRspkM
	 tNqh6NUvN4ou6x+EhNGojgeoVd11t/BCPnJmPw6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 082/307] net/handshake: Pass negative errno through handshake_complete()
Date: Sun,  7 Jun 2026 11:57:59 +0200
Message-ID: <20260607095730.785926462@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261226-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:chuck.lever@oracle.com,m:hare@kernel.org,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,oracle.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32E5F64F9AA

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 6b22d433aa13f68e3cd9534ca9a5f4277bfa01c2 ]

handshake_complete() declares status as unsigned int and
tls_handshake_done() negates that value (-status) before handing
it to the TLS consumer. Consumers match on negative errno
constants -- xs_tls_handshake_done() has

	switch (status) {
	case 0:
	case -EACCES:
	case -ETIMEDOUT:
		lower_transport->xprt_err = status;
		break;
	default:
		lower_transport->xprt_err = -EACCES;
	}

so the API as designed expects callers to pass positive errno
values that the tlshd shim then negates.

Three internal callers in handshake_nl_accept_doit(), the
net-exit drain, and a kunit test follow kernel convention and
pass negative errnos -- -EIO, -ETIMEDOUT, -ETIMEDOUT. The
implicit conversion to unsigned int turns -ETIMEDOUT into
0xFFFFFF92; the subsequent -status in tls_handshake_done()
wraps back to 110, the consumer's switch falls through, and
the xprt reports -EACCES on what should be -ETIMEDOUT or -EIO.

Fix the API rather than the call sites. The natural kernel
convention is negative errno in, negative errno out. Change
handshake_complete() and hp_done to take int status, drop the
negation in tls_handshake_done(), and negate once in
handshake_nl_done_doit() where status arrives from the wire
as an unsigned netlink attribute. The three internal callers
were already correct under that convention and need no change.

At the same wire boundary, declare MAX_ERRNO as the netlink
policy upper bound for HANDSHAKE_A_DONE_STATUS. Attribute
validation rejects out-of-range values before
handshake_nl_done_doit() runs, and negating a bounded u32 there
stays within int range -- closing the UBSAN-visible signed-
integer overflow that an unconstrained u32 would invoke.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260525-handshake-file-pin-v3-3-66c616906ead@oracle.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/handshake.yaml | 8 ++++++++
 net/handshake/genl.c                       | 3 ++-
 net/handshake/genl.h                       | 1 +
 net/handshake/handshake-test.c             | 2 +-
 net/handshake/handshake.h                  | 4 ++--
 net/handshake/netlink.c                    | 2 +-
 net/handshake/request.c                    | 2 +-
 net/handshake/tlshd.c                      | 4 ++--
 8 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index b934cc513e3d6f..090fc11da4604a 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -12,6 +12,12 @@ protocol: genetlink
 doc: Netlink protocol to request a transport layer security handshake.
 
 definitions:
+  -
+    type: const
+    name: max-errno
+    value: 4095
+    header: linux/err.h
+    scope: kernel
   -
     type: enum
     name: handler-class
@@ -77,6 +83,8 @@ attribute-sets:
       -
         name: status
         type: u32
+        checks:
+          max: max-errno
       -
         name: sockfd
         type: s32
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index f55d14d7b7269d..a5fa8b27f22423 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -9,6 +9,7 @@
 #include "genl.h"
 
 #include <uapi/linux/handshake.h>
+#include <linux/err.h>
 
 /* HANDSHAKE_CMD_ACCEPT - do */
 static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HANDLER_CLASS + 1] = {
@@ -17,7 +18,7 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 
 /* HANDSHAKE_CMD_DONE - do */
 static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
-	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_STATUS] = NLA_POLICY_MAX(NLA_U32, MAX_ERRNO),
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
 };
diff --git a/net/handshake/genl.h b/net/handshake/genl.h
index ae72a596f6cc3e..684e5fd684481b 100644
--- a/net/handshake/genl.h
+++ b/net/handshake/genl.h
@@ -10,6 +10,7 @@
 #include <net/genetlink.h>
 
 #include <uapi/linux/handshake.h>
+#include <linux/err.h>
 
 int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info);
 int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 34fd1d9b2db861..a331b308aaa240 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -25,7 +25,7 @@ static int test_accept_func(struct handshake_req *req, struct genl_info *info,
 	return 0;
 }
 
-static void test_done_func(struct handshake_req *req, unsigned int status,
+static void test_done_func(struct handshake_req *req, int status,
 			   struct genl_info *info)
 {
 }
diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a1d..2289b0e274f40a 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -57,7 +57,7 @@ struct handshake_proto {
 	int			(*hp_accept)(struct handshake_req *req,
 					     struct genl_info *info, int fd);
 	void			(*hp_done)(struct handshake_req *req,
-					   unsigned int status,
+					   int status,
 					   struct genl_info *info);
 	void			(*hp_destroy)(struct handshake_req *req);
 };
@@ -86,7 +86,7 @@ struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class);
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
-void handshake_complete(struct handshake_req *req, unsigned int status,
+void handshake_complete(struct handshake_req *req, int status,
 			struct genl_info *info);
 bool handshake_req_cancel(struct sock *sk);
 
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 394e270cc505cb..d8211e0ba75c69 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -161,7 +161,7 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 
 	status = -EIO;
 	if (info->attrs[HANDSHAKE_A_DONE_STATUS])
-		status = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
+		status = -(int)nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
 
 	handshake_complete(req, status, info);
 	sockfd_put(sock);
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 75562f6629e050..2f58d74f16554b 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -285,7 +285,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 }
 EXPORT_SYMBOL(handshake_req_submit);
 
-void handshake_complete(struct handshake_req *req, unsigned int status,
+void handshake_complete(struct handshake_req *req, int status,
 			struct genl_info *info)
 {
 	struct sock *sk = req->hr_sk;
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index fd71ef2d18ceb2..5464e57c347b9c 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -93,7 +93,7 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
  *
  */
 static void tls_handshake_done(struct handshake_req *req,
-			       unsigned int status, struct genl_info *info)
+			       int status, struct genl_info *info)
 {
 	struct tls_handshake_req *treq = handshake_req_private(req);
 
@@ -104,7 +104,7 @@ static void tls_handshake_done(struct handshake_req *req,
 	if (!status)
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
-	treq->th_consumer_done(treq->th_consumer_data, -status,
+	treq->th_consumer_done(treq->th_consumer_data, status,
 			       treq->th_peerid[0]);
 }
 
-- 
2.53.0




