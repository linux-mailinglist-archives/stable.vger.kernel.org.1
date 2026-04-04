Return-Path: <stable+bounces-233275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLFpD9HQ0GlBAwcAu9opvQ
	(envelope-from <stable+bounces-233275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:50:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8969339A6FC
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BC8A300D6A1
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05E2E6CA8;
	Sat,  4 Apr 2026 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hPaVxlfV"
X-Original-To: stable@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048C1FF7C8
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775292620; cv=none; b=UuCW2h4UvEJRdmtoe+FVfg+oCVHgDeculdWj3ENdBrhbz4Tb6yxv76x7f8ewB0NIqZb0pnUh9ytdOgcbuSahEcZrM5Iwk3kL2M1yx4kVDJ4SDpXgLpLfmHu4C8yS3wrT+IpFnKLlJmCsAQfjDxeJzl0019fcWTeF2Y+70UtS/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775292620; c=relaxed/simple;
	bh=xnQenmXYE5hgnU2UxLtdhHNYoTYo0J1/kQiKDDQEvW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d/h1uMGuDj+dqKd9vDmnKgK1W2oGnX7kbqTPFJkefShu0y+jzvgqiR71K+dWL9dOBbb5M/EAPdleT8xFv/E68gvD3hHGgMmbOioBdtWhW3JmJcFHbTNllXc4AGdZ9zfU1G7xXYO/zLCPVzx22Uhw2IzuoI9l4dldugrMZQQUJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hPaVxlfV; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fnq6T11ZZzMkN;
	Sat,  4 Apr 2026 10:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775292609;
	bh=qkZXkcmbq2XwyKAcJKC4wMcKLyFKer/3w3GgHHgddbA=;
	h=From:To:Cc:Subject:Date:From;
	b=hPaVxlfVHCdrQmwpCPkds6x49GKWNfRo2lcGL4EOZTzteFtBbsSaxATtMeIARGwjF
	 8yTZeIr/Ef4x1RqBMN8arQ0ju4X/B66I5sVh4Ay7bWOITuaNoVgN5CwZ7VttQcdQUK
	 Gp2p9rcn0KR1smvoXTnLvSqbXiraxC4Agc3WFlSY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fnq6S4Zh8zMY4;
	Sat,  4 Apr 2026 10:50:08 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] landlock: Fix log_subdomains_off inheritance across fork()
Date: Sat,  4 Apr 2026 10:49:57 +0200
Message-ID: <20260404085001.1604405-1-mic@digikod.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233275-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digikod.net:dkim,digikod.net:email,digikod.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8969339A6FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hook_cred_transfer() only copies the Landlock security blob when the
source credential has a domain.  This is inconsistent with
landlock_restrict_self() which can set log_subdomains_off on a
credential without creating a domain (via the ruleset_fd=-1 path): the
field is committed but not preserved across fork() because the child's
prepare_creds() calls hook_cred_transfer() which skips the copy when
domain is NULL.

This breaks the documented use case where a process mutes subdomain logs
before forking sandboxed children: the children lose the muting and
their domains produce unexpected audit records.

Fix this by unconditionally copying the Landlock credential blob.
landlock_get_ruleset(NULL) is already a safe no-op.

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: ead9079f7569 ("landlock: Add LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
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


