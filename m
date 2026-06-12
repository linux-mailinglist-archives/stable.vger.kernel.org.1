Return-Path: <stable+bounces-262957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KJaNLBJCLGrwOQQAu9opvQ
	(envelope-from <stable+bounces-262957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 19:29:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CA067B583
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 19:29:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=digikod.net header.s=20191114 header.b=jJjUIBYn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262957-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262957-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC0B231FEECE
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 17:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140C94071F5;
	Fri, 12 Jun 2026 17:28:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2FB407569
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 17:28:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285299; cv=none; b=dpBAqdKg0of3ueCGw4m4tw01sbYUn7TylOqpDq2BmD+RRllsJjlmqyEn9DZMkmVLf9hURO/Gwn/OiVCc6Vn2sa3n09EzxMhKGKr2nyPr7Y9JJUhELIh+iobm5pSsNEr/Yv9EBYjsLpnGsM3bDq0xwbsNX+OWzhYKqeiWimoNOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285299; c=relaxed/simple;
	bh=UlvAvuQWbi916cPi3vd2hGdWyMhMGyJ8nVfPJ8HJzUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u5pWMvRdyPJZQuwNFrYwIuDXTCddPpvFUY9bZf0hTNEapWn9KOsa3EmOEowcO72nG+0qTUfmni4e4pIZJUOFxJMNsTfpxYp2p2tUY6pUAKiOz6jQU2gn2IcbKIuKJJj1K+lRXt+mu5KVpzVbmUouz46ZN0AwGXOJHVvP1as4xps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jJjUIBYn; arc=none smtp.client-ip=45.157.188.12
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gcRLH1NkMzFfP;
	Fri, 12 Jun 2026 19:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781285287;
	bh=sDCihnMM6e2PYF53CG6R2LkXlUSqFxRVN5xeVo/MXqs=;
	h=From:To:Cc:Subject:Date:From;
	b=jJjUIBYnhlYxMkejfqsj9acvWky3jud1X62xkUDGHdnq475Q8TDkAMcAZeQwrob0u
	 PAplumpngjg/Fd/gRK/A516vTctbU7dVBnI3j/W5GOnyOEXEA1XjHkMPYco2YV9pG7
	 KzTeIK7c1QQy1/NAeVBb9J5dfOBX6+EOqmbebF+U=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gcRLG3QkmzK5Q;
	Fri, 12 Jun 2026 19:28:06 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Matthieu Buffet <matthieu@buffet.re>,
	stable@vger.kernel.org
Subject: [PATCH v2] landlock: Set audit_net.sk for socket access checks
Date: Fri, 12 Jun 2026 19:27:55 +0200
Message-ID: <20260612172757.1003481-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.17 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.83)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262957-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gnoack@google.com,m:mic@digikod.net,m:linux-security-module@vger.kernel.org,m:m@maowtm.org,m:matthieu@buffet.re,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mic@digikod.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,maowtm.org:email,digikod.net:dkim,digikod.net:email,digikod.net:mid,digikod.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21CA067B583

Set audit_net.sk in current_check_access_socket() to provide the socket
object to audit_log_lsm_data().  This makes Landlock consistent with
AppArmor, which always sets .sk for socket operations, and with
SELinux's generic socket permission checks.

The socket's local and foreign address information (laddr, lport, faddr,
fport) is logged by the shared lsm_audit.c infrastructure when the
socket has bound or connected state.  Fields with zero values are
suppressed by print_ipv4_addr()/print_ipv6_addr(), so the audit output
is unchanged for the common case of bind denials on unbound sockets.
For connect denials after a prior bind, the bound local address (laddr,
lport) appears before the existing sockaddr fields (daddr, dest).

No existing fields are removed or reordered, and the new field names
(laddr, lport, faddr, fport) are standard audit fields already emitted
by other LSMs through the same lsm_audit.c code path.

Add a connect_tcp_bound audit test that binds to an allowed port and
then connects to a denied one, verifying that the denial record reports
laddr/lport from the bound socket in addition to the connect
destination.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Cc: stable@vger.kernel.org
Fixes: 9f74411a40ce ("landlock: Log TCP bind and connect denials")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20260406143717.1815792-11-mic@digikod.net
- Move the new socket-audit coverage into the network test fixture,
  which sets up an isolated network namespace with a configured
  loopback interface; the previous location ran without a network
  namespace (reported by Tingmao Wang).  Cover the enriched laddr/lport
  via a connect-after-bind denial.
---
 security/landlock/net.c                     |  1 +
 tools/testing/selftests/landlock/net_test.c | 62 +++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index c368649985c5..a38bdfcffc22 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -198,6 +198,7 @@ static int current_check_access_socket(struct socket *const sock,
 		return 0;
 
 	audit_net.family = address->sa_family;
+	audit_net.sk = sock->sk;
 	landlock_log_denial(subject,
 			    &(struct landlock_request){
 				    .type = LANDLOCK_REQUEST_NET_ACCESS,
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 4c528154ea92..0c256e7c8675 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -2026,4 +2026,66 @@ TEST_F(audit, connect)
 	EXPECT_EQ(0, close(sock_fd));
 }
 
+static int matches_log_tcp_bound(int audit_fd, const char *const addr,
+				 __u16 lport, __u16 dport)
+{
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=net\\.connect_tcp laddr=%s lport=%u daddr=%s dest=%u$";
+	/* Slack for two addresses and two port numbers. */
+	char log_match[sizeof(log_template) + 40];
+	int log_match_len;
+
+	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
+				 addr, lport, addr, dport);
+	if (log_match_len > sizeof(log_match))
+		return -E2BIG;
+
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
+				  NULL);
+}
+
+/*
+ * After a bind() to an allowed port, a denied connect must report laddr/lport
+ * from the bound socket (made available through audit_net.sk) in addition to
+ * the connect sockaddr's daddr/dest.
+ */
+TEST_F(audit, connect_tcp_bound)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+	const struct landlock_net_port_attr rule_bind = {
+		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.port = self->srv0.port,
+	};
+	struct service_fixture srv_remote;
+	struct audit_records records;
+	int ruleset_fd, sock_fd;
+
+	/* Uses a second port as the denied connect target. */
+	ASSERT_EQ(0, set_service(&srv_remote, variant->prot, 1));
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &rule_bind, 0));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	sock_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(0, bind_variant(sock_fd, &self->srv0));
+	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &srv_remote));
+	EXPECT_EQ(0, matches_log_tcp_bound(self->audit_fd, variant->addr,
+					   self->srv0.port, srv_remote.port));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	EXPECT_EQ(0, close(sock_fd));
+}
+
 TEST_HARNESS_MAIN

base-commit: d8dfb4c7faa87c3e41a8678f38f136c2c7c036fa
-- 
2.54.0


