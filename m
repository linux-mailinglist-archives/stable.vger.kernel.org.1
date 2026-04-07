Return-Path: <stable+bounces-233687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB7MILQz1Wly2QcAu9opvQ
	(envelope-from <stable+bounces-233687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:41:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DAC3B1F04
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67194300DF4D
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F57F3CD8A5;
	Tue,  7 Apr 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Wi4pxJiF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177133D503
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580082; cv=none; b=UQMuE2isKAFnAzN7fvYN4wv2eXHHL9a/3BqBAX/ikDbsZqz1cBSsIh8jg6j+h1j2lbbUhleaKmRvCkR2/0das3QcAyptHTJDLhMqiAx+REzw6WYjuJGq61uYwdBH8DKFN5W/WCKroqbvN3WGYJQxy5G+lzFJWnJ/Gky4hxHI24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580082; c=relaxed/simple;
	bh=KW9Z+dWXoZbHQ+Kpu7nKJqDmvtbNS30sfVgLj4yUFSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rNPfaxRkINk8Z5WIiv+e2icPYdtInKDzFhcE5uL50aifq+E4NQZp/oQHP3bcizMXt/vWfrvlE8LOhS5kkryPmfgfVCPEuZNkAcUOfME+A55u0lmiNXFx0m3WD+tgy36u/3aj+luwY7iXEteSmy5rqOoqoLZsOXvHUwG8xlHEVBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Wi4pxJiF; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqsQd1Nx6zDr4;
	Tue,  7 Apr 2026 18:41:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775580073;
	bh=7JfkIrcrg5YzSoTZZQx5a9A3cN1/JoWif7ZCi9ZSveM=;
	h=From:To:Cc:Subject:Date:From;
	b=Wi4pxJiFEHcCfz0SfuBqbSBQ2aQCEwzPXnjn5CVZoiUNWciK7nhWBxmuUDhtqz0H1
	 +EYeD7L5mkHN1q/vtCV3F0kyRjimcrhKweN5ayhiJ875tKvTj/m1yaPjYpdmfe0HVd
	 jUnPJhgUBUEwdLTJIDx823WducbBx9I7HObHdc/o=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqsQc5HcgzpN3;
	Tue,  7 Apr 2026 18:41:12 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 1/2] landlock: Fix LOG_SUBDOMAINS_OFF inheritance across fork()
Date: Tue,  7 Apr 2026 18:41:04 +0200
Message-ID: <20260407164107.2012589-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [0.11 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.77)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[digikod.net,vger.kernel.org,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-233687-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,digikod.net:dkim,digikod.net:email,digikod.net:mid]
X-Rspamd-Queue-Id: 33DAC3B1F04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hook_cred_transfer() only copies the Landlock security blob when the
source credential has a domain.  This is inconsistent with
landlock_restrict_self() which can set LOG_SUBDOMAINS_OFF on a
credential without creating a domain (via the ruleset_fd=-1 path): the
field is committed but not preserved across fork() because the child's
prepare_creds() calls hook_cred_transfer() which skips the copy when
domain is NULL.

This breaks the documented use case where a process mutes subdomain logs
before forking sandboxed children: the children lose the muting and
their domains produce unexpected audit records.

Fix this by unconditionally copying the Landlock credential blob.

Cc: Günther Noack <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: stable@vger.kernel.org
Fixes: ead9079f7569 ("landlock: Add LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF")
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20260404085001.1604405-1-mic@digikod.net
- Improve subject.
- Add Reviewed-by Günther.
---
 security/landlock/cred.c                      |  6 +-
 tools/testing/selftests/landlock/audit_test.c | 88 +++++++++++++++++++
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 0cb3edde4d18..cc419de75cd6 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -22,10 +22,8 @@ static void hook_cred_transfer(struct cred *const new,
 	const struct landlock_cred_security *const old_llcred =
 		landlock_cred(old);
 
-	if (old_llcred->domain) {
-		landlock_get_ruleset(old_llcred->domain);
-		*landlock_cred(new) = *old_llcred;
-	}
+	landlock_get_ruleset(old_llcred->domain);
+	*landlock_cred(new) = *old_llcred;
 }
 
 static int hook_cred_prepare(struct cred *const new,
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 46d02d49835a..20099b8667e7 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -279,6 +279,94 @@ TEST_F(audit, thread)
 				&audit_tv_default, sizeof(audit_tv_default)));
 }
 
+/*
+ * Verifies that log_subdomains_off set via the ruleset_fd=-1 path (without
+ * creating a domain) is inherited by children across fork().  This exercises
+ * the hook_cred_transfer() fix: the Landlock credential blob must be copied
+ * even when the source credential has no domain.
+ *
+ * Phase 1 (baseline): a child without muting creates a domain and triggers a
+ * denial that IS logged.
+ *
+ * Phase 2 (after muting): the parent mutes subdomain logs, forks another child
+ * who creates a domain and triggers a denial that is NOT logged.
+ */
+TEST_F(audit, log_subdomains_off_fork)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.scoped = LANDLOCK_SCOPE_SIGNAL,
+	};
+	struct audit_records records;
+	int ruleset_fd, status;
+	pid_t child;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	/*
+	 * Phase 1: forks a child that creates a domain and triggers a denial
+	 * before any muting.  This proves the audit path works.
+	 */
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+		ASSERT_EQ(-1, kill(getppid(), 0));
+		ASSERT_EQ(EPERM, errno);
+		_exit(0);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(true, WIFEXITED(status));
+	ASSERT_EQ(0, WEXITSTATUS(status));
+
+	/* The denial must be logged (baseline). */
+	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd, getpid(),
+					NULL));
+
+	/* Drains any remaining records (e.g. domain allocation). */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+
+	/*
+	 * Mutes subdomain logs without creating a domain.  The parent's
+	 * credential has domain=NULL and log_subdomains_off=1.
+	 */
+	ASSERT_EQ(0, landlock_restrict_self(
+			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+
+	/*
+	 * Phase 2: forks a child that creates a domain and triggers a denial.
+	 * Because log_subdomains_off was inherited via fork(), the child's
+	 * domain has log_status=LANDLOCK_LOG_DISABLED.
+	 */
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+		ASSERT_EQ(-1, kill(getppid(), 0));
+		ASSERT_EQ(EPERM, errno);
+		_exit(0);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(true, WIFEXITED(status));
+	ASSERT_EQ(0, WEXITSTATUS(status));
+
+	/* No denial record should appear. */
+	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
+					      getpid(), NULL));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 FIXTURE(audit_flags)
 {
 	struct audit_filter audit_filter;
-- 
2.53.0


