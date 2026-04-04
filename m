Return-Path: <stable+bounces-233276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCJEMlXS0GlBAwcAu9opvQ
	(envelope-from <stable+bounces-233276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:56:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5163C39A79D
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 848E930065E8
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B0356A38;
	Sat,  4 Apr 2026 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QzagD4BS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97383A5444
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775293008; cv=none; b=SVA7yKcwgnriMTFgDJZo+AyuVZ1uD0ULK+kutS9tQZgJdib9sIQaTid4dtHVwNBGE8q6crXzxDkN91wLE7PNWiWB9kEAwWpSfdVn2dtRwOESTGA4F207P240xUN6gDITRggWXLenpqDUy4bwV/oVKuH/dt0GHzlskk7UnxqWTpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775293008; c=relaxed/simple;
	bh=te9taUu33WNDkL8yJbwE7rHh+TgdW2Vpw2+f2tyLhtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpFWWExFtWGT4fb5gXWLI1YgwB0KiwwU1Cyg6k+H8F9ApETW5f8ztEp0x5EQKFqZaa51wbCjj+AhQujOIdgZzIGYrjO/Rn9Q6u6WNiHQdgO+usrXn5r6tptlDj/lDtpMupmmZf+vyixFb8Bv1ahX3pF1g8dAEal30LwmSwL0u7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QzagD4BS; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fnq6V35k7zKwJ;
	Sat,  4 Apr 2026 10:50:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775292610;
	bh=A+Xb3VXjs/ZCWBcnUudRLtw/qRMjOhNeEIpC/6IdfdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzagD4BS95SMm9taRIAOvOAwmaGbVqyJ54fch1ogIvLAT+idwULi1dHDLxvTU5J9S
	 hpPmnrQWB8OyD10NZ7bwO42ysz0RbmSwlV8SwnJ8oliUk48PJAFsGzlnMecfIIPHGo
	 mGOkxv9a9ZNayRL6RWePnwE+ifBlfnBk3i/FECYw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fnq6V05mjzLjm;
	Sat,  4 Apr 2026 10:50:10 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] landlock: Allow TSYNC with LOG_SUBDOMAINS_OFF and fd=-1
Date: Sat,  4 Apr 2026 10:49:58 +0200
Message-ID: <20260404085001.1604405-2-mic@digikod.net>
In-Reply-To: <20260404085001.1604405-1-mic@digikod.net>
References: <20260404085001.1604405-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [0.01 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.67)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233276-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digikod.net:dkim,digikod.net:email,digikod.net:mid]
X-Rspamd-Queue-Id: 5163C39A79D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

LANDLOCK_RESTRICT_SELF_TSYNC does not allow
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF with ruleset_fd=-1, preventing
a multithreaded process from atomically propagating subdomain log muting
to all threads without creating a domain layer.  Relax the fd=-1
condition to accept TSYNC alongside LOG_SUBDOMAINS_OFF, and update the
documentation accordingly.

Add flag validation tests for all TSYNC combinations with ruleset_fd=-1,
and audit tests verifying both transition directions: muting via TSYNC
(logged to not logged) and override via TSYNC (not logged to logged).

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/uapi/linux/landlock.h                 |   4 +-
 security/landlock/syscalls.c                  |  14 +-
 tools/testing/selftests/landlock/audit_test.c | 233 ++++++++++++++++++
 tools/testing/selftests/landlock/tsync_test.c |  74 ++++++
 4 files changed, 319 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f88fa1f68b77..d37603efc273 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -116,7 +116,9 @@ struct landlock_ruleset_attr {
  *     ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``, this flag only affects
  *     future nested domains, not the one being created. It can also be used
  *     with a @ruleset_fd value of -1 to mute subdomain logs without creating a
- *     domain.
+ *     domain.  When combined with %LANDLOCK_RESTRICT_SELF_TSYNC and a
+ *     @ruleset_fd value of -1, this configuration is propagated to all threads
+ *     of the current process.
  *
  * The following flag supports policy enforcement in multithreaded processes:
  *
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 0d66a68677b7..a0bb664e0d31 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -512,10 +512,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 
 	/*
 	 * It is allowed to set LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF with
-	 * -1 as ruleset_fd, but no other flag must be set.
+	 * -1 as ruleset_fd, optionally combined with
+	 * LANDLOCK_RESTRICT_SELF_TSYNC to propagate this configuration to all
+	 * threads.  No other flag must be set.
 	 */
 	if (!(ruleset_fd == -1 &&
-	      flags == LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
+	      (flags & ~LANDLOCK_RESTRICT_SELF_TSYNC) ==
+		      LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
 		/* Gets and checks the ruleset. */
 		ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
 		if (IS_ERR(ruleset))
@@ -537,9 +540,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 
 	/*
 	 * The only case when a ruleset may not be set is if
-	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF is set and ruleset_fd is -1.
-	 * We could optimize this case by not calling commit_creds() if this flag
-	 * was already set, but it is not worth the complexity.
+	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF is set (optionally with
+	 * LANDLOCK_RESTRICT_SELF_TSYNC) and ruleset_fd is -1.  We could
+	 * optimize this case by not calling commit_creds() if this flag was
+	 * already set, but it is not worth the complexity.
 	 */
 	if (ruleset) {
 		/*
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 20099b8667e7..a193d8a97560 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -162,6 +162,7 @@ TEST_F(audit, layers)
 struct thread_data {
 	pid_t parent_pid;
 	int ruleset_fd, pipe_child, pipe_parent;
+	bool mute_subdomains;
 };
 
 static void *thread_audit_test(void *arg)
@@ -367,6 +368,238 @@ TEST_F(audit, log_subdomains_off_fork)
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
+/*
+ * Thread function: runs two rounds of (create domain, trigger denial, signal
+ * back), waiting for the main thread before each round.  When mute_subdomains
+ * is set, phase 1 also mutes subdomain logs via the fd=-1 path before creating
+ * the domain.  The ruleset_fd is kept open across both rounds so each
+ * restrict_self call stacks a new domain layer.
+ */
+static void *thread_sandbox_deny_twice(void *arg)
+{
+	const struct thread_data *data = (struct thread_data *)arg;
+	uintptr_t err = 0;
+	char buffer;
+
+	/* Phase 1: optionally mutes, creates a domain, and triggers a denial. */
+	if (read(data->pipe_parent, &buffer, 1) != 1) {
+		err = 1;
+		goto out;
+	}
+
+	if (data->mute_subdomains &&
+	    landlock_restrict_self(-1,
+				   LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
+		err = 2;
+		goto out;
+	}
+
+	if (landlock_restrict_self(data->ruleset_fd, 0)) {
+		err = 3;
+		goto out;
+	}
+
+	if (kill(data->parent_pid, 0) != -1 || errno != EPERM) {
+		err = 4;
+		goto out;
+	}
+
+	if (write(data->pipe_child, ".", 1) != 1) {
+		err = 5;
+		goto out;
+	}
+
+	/* Phase 2: stacks another domain and triggers a denial. */
+	if (read(data->pipe_parent, &buffer, 1) != 1) {
+		err = 6;
+		goto out;
+	}
+
+	if (landlock_restrict_self(data->ruleset_fd, 0)) {
+		err = 7;
+		goto out;
+	}
+
+	if (kill(data->parent_pid, 0) != -1 || errno != EPERM) {
+		err = 8;
+		goto out;
+	}
+
+	if (write(data->pipe_child, ".", 1) != 1) {
+		err = 9;
+		goto out;
+	}
+
+out:
+	close(data->ruleset_fd);
+	close(data->pipe_child);
+	close(data->pipe_parent);
+	return (void *)err;
+}
+
+/*
+ * Verifies that LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF with
+ * LANDLOCK_RESTRICT_SELF_TSYNC and ruleset_fd=-1 propagates log_subdomains_off
+ * to a sibling thread, suppressing audit logging on domains it subsequently
+ * creates.
+ *
+ * Phase 1 (before TSYNC) acts as an inline baseline: the sibling creates a
+ * domain and triggers a denial that IS logged.
+ *
+ * Phase 2 (after TSYNC) verifies suppression: the sibling stacks another domain
+ * and triggers a denial that is NOT logged.
+ */
+TEST_F(audit, log_subdomains_off_tsync)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.scoped = LANDLOCK_SCOPE_SIGNAL,
+	};
+	struct audit_records records;
+	struct thread_data child_data;
+	int pipe_child[2], pipe_parent[2];
+	char buffer;
+	pthread_t thread;
+	void *thread_ret;
+
+	child_data.parent_pid = getppid();
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	child_data.pipe_child = pipe_child[1];
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	child_data.pipe_parent = pipe_parent[0];
+	child_data.ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, child_data.ruleset_fd);
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	/* Creates the sibling thread. */
+	ASSERT_EQ(0, pthread_create(&thread, NULL, thread_sandbox_deny_twice,
+				    &child_data));
+
+	/*
+	 * Phase 1: the sibling creates a domain and triggers a denial before
+	 * any log muting.  This proves the audit path works.
+	 */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(1, read(pipe_child[0], &buffer, 1));
+
+	/* The denial must be logged. */
+	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd,
+					child_data.parent_pid, NULL));
+
+	/* Drains any remaining records (e.g. domain allocation). */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+
+	/*
+	 * Mutes subdomain logs and propagates to the sibling thread via TSYNC,
+	 * without creating a domain.
+	 */
+	ASSERT_EQ(0, landlock_restrict_self(
+			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
+					 LANDLOCK_RESTRICT_SELF_TSYNC));
+
+	/*
+	 * Phase 2: the sibling stacks another domain and triggers a denial.
+	 * Because log_subdomains_off was propagated via TSYNC, the new domain
+	 * has log_status=LANDLOCK_LOG_DISABLED.
+	 */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(1, read(pipe_child[0], &buffer, 1));
+
+	/* No denial record should appear. */
+	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
+					      child_data.parent_pid, NULL));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	EXPECT_EQ(0, close(pipe_child[0]));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+	ASSERT_EQ(0, pthread_join(thread, &thread_ret));
+	EXPECT_EQ(NULL, thread_ret);
+}
+
+/*
+ * Verifies that LANDLOCK_RESTRICT_SELF_TSYNC without
+ * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF overrides a sibling thread's
+ * log_subdomains_off, re-enabling audit logging on domains the sibling
+ * subsequently creates.
+ *
+ * Phase 1: the sibling sets log_subdomains_off, creates a muted domain, and
+ * triggers a denial that is NOT logged.
+ *
+ * Phase 2 (after TSYNC without LOG_SUBDOMAINS_OFF): the sibling stacks another
+ * domain and triggers a denial that IS logged, proving the muting was
+ * overridden.
+ */
+TEST_F(audit, tsync_override_log_subdomains_off)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.scoped = LANDLOCK_SCOPE_SIGNAL,
+	};
+	struct audit_records records;
+	struct thread_data child_data;
+	int pipe_child[2], pipe_parent[2];
+	char buffer;
+	pthread_t thread;
+	void *thread_ret;
+
+	child_data.parent_pid = getppid();
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	child_data.pipe_child = pipe_child[1];
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	child_data.pipe_parent = pipe_parent[0];
+	child_data.ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, child_data.ruleset_fd);
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	child_data.mute_subdomains = true;
+
+	/* Creates the sibling thread. */
+	ASSERT_EQ(0, pthread_create(&thread, NULL, thread_sandbox_deny_twice,
+				    &child_data));
+
+	/*
+	 * Phase 1: the sibling mutes subdomain logs, creates a domain, and
+	 * triggers a denial.  The denial must not be logged.
+	 */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(1, read(pipe_child[0], &buffer, 1));
+
+	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
+					      child_data.parent_pid, NULL));
+
+	/* Drains any remaining records. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	/*
+	 * Overrides the sibling's log_subdomains_off by calling TSYNC without
+	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF.
+	 */
+	ASSERT_EQ(0, landlock_restrict_self(child_data.ruleset_fd,
+					    LANDLOCK_RESTRICT_SELF_TSYNC));
+
+	/*
+	 * Phase 2: the sibling stacks another domain and triggers a denial.
+	 * Because TSYNC replaced its log_subdomains_off with 0, the new domain
+	 * has log_status=LANDLOCK_LOG_PENDING.
+	 */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(1, read(pipe_child[0], &buffer, 1));
+
+	/* The denial must be logged. */
+	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd,
+					child_data.parent_pid, NULL));
+
+	EXPECT_EQ(0, close(pipe_child[0]));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+	ASSERT_EQ(0, pthread_join(thread, &thread_ret));
+	EXPECT_EQ(NULL, thread_ret);
+}
+
 FIXTURE(audit_flags)
 {
 	struct audit_filter audit_filter;
diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testing/selftests/landlock/tsync_test.c
index 2b9ad4f154f4..abc290271a1a 100644
--- a/tools/testing/selftests/landlock/tsync_test.c
+++ b/tools/testing/selftests/landlock/tsync_test.c
@@ -247,4 +247,78 @@ TEST(tsync_interrupt)
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
+/* clang-format off */
+FIXTURE(tsync_without_ruleset) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(tsync_without_ruleset)
+{
+	const __u32 flags;
+	const int expected_errno;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(tsync_without_ruleset, tsync_only) {
+	/* clang-format on */
+	.flags = LANDLOCK_RESTRICT_SELF_TSYNC,
+	.expected_errno = EBADF,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(tsync_without_ruleset, subdomains_off_same_exec_off) {
+	/* clang-format on */
+	.flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
+		 LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
+		 LANDLOCK_RESTRICT_SELF_TSYNC,
+	.expected_errno = EBADF,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(tsync_without_ruleset, subdomains_off_new_exec_on) {
+	/* clang-format on */
+	.flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
+		 LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
+		 LANDLOCK_RESTRICT_SELF_TSYNC,
+	.expected_errno = EBADF,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(tsync_without_ruleset, all_flags) {
+	/* clang-format on */
+	.flags = LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
+		 LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
+		 LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
+		 LANDLOCK_RESTRICT_SELF_TSYNC,
+	.expected_errno = EBADF,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(tsync_without_ruleset, subdomains_off) {
+	/* clang-format on */
+	.flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
+		 LANDLOCK_RESTRICT_SELF_TSYNC,
+	.expected_errno = 0,
+};
+
+FIXTURE_SETUP(tsync_without_ruleset)
+{
+}
+
+FIXTURE_TEARDOWN(tsync_without_ruleset)
+{
+}
+
+TEST_F(tsync_without_ruleset, check)
+{
+	int ret;
+
+	ret = landlock_restrict_self(-1, variant->flags);
+	if (variant->expected_errno) {
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(variant->expected_errno, errno);
+	} else {
+		EXPECT_EQ(0, ret);
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.53.0


