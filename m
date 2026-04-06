Return-Path: <stable+bounces-233385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLe2Ix7H02kZmAcAu9opvQ
	(envelope-from <stable+bounces-233385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 16:45:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 065EF3A45F2
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 16:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B71C6301FABE
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D3F3822B3;
	Mon,  6 Apr 2026 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OLZpHYS+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD8385507
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486688; cv=none; b=jnBCrdEebsIBzhb3RVB7nfz857lDgvAF4OWCCClMsI7PaQcv1grogKbAUnsGM9u3luft7ZF37VPUOXmSL2lzOZi2rdAG+WZVJbJq231Fa/sH7dF+p38WJM8cFuAhL9csjsR6w42IQOXBxaD4ajmSU4tawRqlOkGbHOuOF3FuG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486688; c=relaxed/simple;
	bh=ujga4dFI9dWwHaRfTSBdB+g7VWGx6035MIETE1656U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYnD92HQttvLLZjdU2pVq7/WX5ChsPIFkiCn1N5jqplcMHiMRyQ9g0a09G1o3Wc7DKi/IXp2FWq9xpS2nw+dpglD49GwDLf2DYV+w0eJ3FA+mpomMFRNxwNcZRkM1wAPR4L0QPurjnjLyoqHzxG5hCuKChgDQ1zTfnEyeAaJ5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OLZpHYS+; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkV22XWzVgb;
	Mon,  6 Apr 2026 16:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486258;
	bh=JRvB0HadKMRsR9F16YiSQx7UudPxyEJoOVF1nCr4teI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLZpHYS+PzQZ3B5EAilPYE6RCi4iB5SbLBkj8urPEY2K3TU+nXf0Zt7ak86QOMZ1b
	 ptnBXnvvz+3E4L1sNiiMIckmODliGbsFw5GV7wV/QkcOi82cKlTlk1fibB32vYNwe3
	 tL7phBq2rPYhX4TGmMQdTUCVo5+H7XcOAodYyZus=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkT4YC6zYLm;
	Mon,  6 Apr 2026 16:37:37 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 10/17] landlock: Set audit_net.sk for socket access checks
Date: Mon,  6 Apr 2026 16:37:08 +0200
Message-ID: <20260406143717.1815792-11-mic@digikod.net>
In-Reply-To: <20260406143717.1815792-1-mic@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [0.05 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.71)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[digikod.net,google.com,gmail.com,kernel.org,efficios.com,buffet.re,huawei-partners.com,maowtm.org,cloudflare.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233385-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digikod.net:dkim,digikod.net:email,digikod.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,audit_net.sk:url]
X-Rspamd-Queue-Id: 065EF3A45F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Add net_bind and net_connect audit tests.  The net_bind test verifies
basic net denial auditing.  The net_connect test binds to an allowed
port, then connects to a denied port, and verifies that the audit record
includes laddr/lport from the socket state.

Fixes: 9f74411a40ce ("landlock: Log TCP bind and connect denials")
Cc: stable@vger.kernel.org
Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 security/landlock/net.c                       |   1 +
 tools/testing/selftests/landlock/audit_test.c | 187 ++++++++++++++++++
 2 files changed, 188 insertions(+)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index a2aefc7967a1..d8bc9e0d012a 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -225,6 +225,7 @@ static int current_check_access_socket(struct socket *const sock,
 		return 0;
 
 	audit_net.family = address->sa_family;
+	audit_net.sk = sock->sk;
 	landlock_log_denial(subject,
 			    &(struct landlock_request){
 				    .type = LANDLOCK_REQUEST_NET_ACCESS,
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index da0bfd06391e..65dfb272c825 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -6,14 +6,17 @@
  */
 
 #define _GNU_SOURCE
+#include <arpa/inet.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
 #include <linux/landlock.h>
+#include <netinet/in.h>
 #include <pthread.h>
 #include <stdlib.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
+#include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
@@ -160,6 +163,190 @@ TEST_F(audit, layers)
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
+static int matches_log_net_bind(struct __test_metadata *const _metadata,
+				int audit_fd, __u16 port, __u64 *domain_id)
+{
+	/*
+	 * The socket is unbound at bind() time, so laddr/lport/faddr/fport from
+	 * the socket object are zero and not printed.  Only the sockaddr fields
+	 * (src) appear.
+	 */
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=net\\.bind_tcp src=%u$";
+	char log_match[sizeof(log_template) + 10];
+
+	snprintf(log_match, sizeof(log_match), log_template, port);
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
+				  domain_id);
+}
+
+/*
+ * Verifies that network denial audit records include enriched socket
+ * information (laddr/lport/faddr/fport) from the socket object.
+ */
+TEST_F(audit, net_bind)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+	struct landlock_net_port_attr net_port = {
+		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.port = 1024,
+	};
+	int status, ruleset_fd;
+	pid_t child;
+	__u64 denial_dom = 1;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Allow port 1024 only. */
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &net_port, 0));
+
+	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		struct sockaddr_in addr = {
+			.sin_family = AF_INET,
+			.sin_port = htons(1025),
+			.sin_addr.s_addr = htonl(INADDR_ANY),
+		};
+		int sock_fd;
+
+		EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+		close(ruleset_fd);
+
+		/* Bind to port 1025 (not allowed). */
+		sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		ASSERT_LE(0, sock_fd);
+		EXPECT_EQ(-1, bind(sock_fd, (struct sockaddr *)&addr,
+				   sizeof(addr)));
+		EXPECT_EQ(EACCES, errno);
+		close(sock_fd);
+
+		/* Verify audit record with enriched socket info. */
+		EXPECT_EQ(0, matches_log_net_bind(_metadata, self->audit_fd,
+						  1025, &denial_dom));
+		EXPECT_NE(denial_dom, 1);
+		EXPECT_NE(denial_dom, 0);
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+static int matches_log_net_connect(struct __test_metadata *const _metadata,
+				   int audit_fd, __u16 denied_port,
+				   __u16 bound_port, __u64 *domain_id)
+{
+	/*
+	 * After bind(), the socket has local address state.  The audit record
+	 * should include laddr/lport from the socket (via audit_net.sk) and
+	 * daddr/dest from the connect sockaddr.
+	 */
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=net\\.connect_tcp"
+		" laddr=127\\.0\\.0\\.1 lport=%u"
+		" daddr=127\\.0\\.0\\.1 dest=%u$";
+	char log_match[sizeof(log_template) + 20];
+
+	snprintf(log_match, sizeof(log_match), log_template, bound_port,
+		 denied_port);
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
+				  domain_id);
+}
+
+/*
+ * Verifies that network denial audit records for connect include enriched
+ * socket information (laddr/lport) from the socket object after a prior bind.
+ * This complements net_bind which tests the unbound case.
+ */
+TEST_F(audit, net_connect)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+	struct landlock_net_port_attr net_port;
+	int status, ruleset_fd;
+	pid_t child;
+	__u64 denial_dom = 1;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Allow bind to port 1024 and connect to port 1024. */
+	net_port.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
+				  LANDLOCK_ACCESS_NET_CONNECT_TCP;
+	net_port.port = 1024;
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &net_port, 0));
+
+	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		struct sockaddr_in bind_addr = {
+			.sin_family = AF_INET,
+			.sin_port = htons(1024),
+			.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		};
+		struct sockaddr_in conn_addr = {
+			.sin_family = AF_INET,
+			.sin_port = htons(1025),
+			.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		};
+		int sock_fd, optval = 1;
+
+		EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+		close(ruleset_fd);
+
+		sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		ASSERT_LE(0, sock_fd);
+		ASSERT_EQ(0, setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR,
+					&optval, sizeof(optval)));
+
+		/* Bind to allowed port 1024 (succeeds). */
+		ASSERT_EQ(0, bind(sock_fd, (struct sockaddr *)&bind_addr,
+				  sizeof(bind_addr)));
+
+		/* Connect to denied port 1025 (fails). */
+		EXPECT_EQ(-1, connect(sock_fd, (struct sockaddr *)&conn_addr,
+				      sizeof(conn_addr)));
+		EXPECT_EQ(EACCES, errno);
+		close(sock_fd);
+
+		/* Verify audit record with laddr/lport from bound socket. */
+		EXPECT_EQ(0, matches_log_net_connect(_metadata, self->audit_fd,
+						     1025, 1024, &denial_dom));
+		EXPECT_NE(denial_dom, 1);
+		EXPECT_NE(denial_dom, 0);
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 struct thread_data {
 	pid_t parent_pid;
 	int ruleset_fd, pipe_child, pipe_parent;
-- 
2.53.0


