Return-Path: <stable+bounces-233105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDAJH77DzmmqpwYAu9opvQ
	(envelope-from <stable+bounces-233105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 21:30:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC20038DADE
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 21:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C675A308685C
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01E368282;
	Thu,  2 Apr 2026 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="sjuEnKk2"
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FC536C9CC
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157988; cv=none; b=GN+uU/nlpiVOye1eMKx5LWsNiIJEMjLryGnBE6AmLStUGGNcme/3clwC60hvBlR5PiXCqM5zfoAuxzgqJ8cXz0Sj3QKtgGG5EGZ+eEPMuFE3elTRVpZwhCXjCEREBLcUI2AH+6TCn/ljaGKoGeDPlAjmnaiUpCVPnINTpKnFcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157988; c=relaxed/simple;
	bh=hGk7UU5OBDAdbMC9dbd1lpAs5ggdtSjxRp3GiA4cItA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6HWrSAULONo5lMRRIpckofa/18T2xZZlyrbETsH5Etb1eeuzYkqk7K2cpC6dGtMS0vxbxeLZyfFEjlVkggh6L6nB888oy7EJ4Vs+gigBl95NP8bkkdUPREQ/L/eeMjYBoV4100zvUun7MHeUlFUEKvOrbBiyaMK3pZPcGKByvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=sjuEnKk2; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fmsKQ6XBCzdCP;
	Thu,  2 Apr 2026 21:26:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775157978;
	bh=cMGpc0iislnQs9+i1c+u4tPPT35aVoKk1K60+LJ2sAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjuEnKk2ni7VpBQYGHFJBjStT3ebMsqXGxb97ADGILDvGahxJkKoijB63p9hgDZJa
	 YAYokSleMHYHam7V0Z8Kj1nXk3YLlYr+GVFdtEnqoFChOEceq+2fUaK41kYUkoeRqU
	 yzystLBnP9FOs3sLrS0XOw3zEwSWzByyYVNDYCiU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fmsKQ28GGzn2H;
	Thu,  2 Apr 2026 21:26:18 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/5] selftests/landlock: Skip stale records in audit_match_record()
Date: Thu,  2 Apr 2026 21:26:05 +0200
Message-ID: <20260402192608.1458252-5-mic@digikod.net>
In-Reply-To: <20260402192608.1458252-1-mic@digikod.net>
References: <20260402192608.1458252-1-mic@digikod.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[digikod.net,vger.kernel.org,gmail.com,maowtm.org];
	TAGGED_FROM(0.00)[bounces-233105-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[last_mismatch.data:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,digikod.net:dkim,digikod.net:email,digikod.net:mid,msg.data:url]
X-Rspamd-Queue-Id: CC20038DADE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Domain deallocation records are emitted asynchronously from kworker
threads (via free_ruleset_work()).  Stale deallocation records from a
previous test can arrive during the current test's deallocation read
loop and be picked up by audit_match_record() instead of the expected
record, causing a domain ID mismatch.  The audit.layers test (which
creates 16 nested domains) is particularly vulnerable because it reads
16 deallocation records in sequence, providing a large window for stale
records to interleave.

The same issue affects audit_flags.signal, where deallocation records
from a previous test (audit.layers) can leak into the next test and be
picked up by audit_match_record() instead of the expected record.

Fix this by continuing to read records when the type matches but the
content pattern does not.  Stale records are silently consumed, and the
loop only stops when both type and pattern match (or the socket times
out with -EAGAIN).

Additionally, extend matches_log_domain_deallocated() with an
expected_domain_id parameter.  When set, the regex pattern includes the
specific domain ID as a literal hex value, so that deallocation records
for a different domain do not match the pattern at all.  This handles
the case where the stale record has the same denial count as the
expected one (e.g. both have denials=1), which the type+pattern loop
alone cannot distinguish.  Callers that already know the expected domain
ID (from a prior denial or allocation record) now pass it to filter
precisely.

When expected_domain_id is set, matches_log_domain_deallocated() also
temporarily increases the socket timeout to audit_tv_dom_drop (1 second)
to wait for the asynchronous kworker deallocation, and restores
audit_tv_default afterward.  This removes the need for callers to manage
the timeout switch manually.

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://lore.kernel.org/r/20260401161503.1136946-1-mic@digikod.net
- Fix __u64 format warnings on powerpc64 (cast to unsigned long long
  for %llx).

Changes since v1:
https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
- New patch.
---
 tools/testing/selftests/landlock/audit.h      | 82 ++++++++++++++-----
 tools/testing/selftests/landlock/audit_test.c | 34 ++++----
 2 files changed, 77 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 74e1c3d763be..834005b2b0f0 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -249,9 +249,9 @@ static __maybe_unused char *regex_escape(const char *const src, char *dst,
 static int audit_match_record(int audit_fd, const __u16 type,
 			      const char *const pattern, __u64 *domain_id)
 {
-	struct audit_message msg;
+	struct audit_message msg, last_mismatch = {};
 	int ret, err = 0;
-	bool matches_record = !type;
+	int num_type_match = 0;
 	regmatch_t matches[2];
 	regex_t regex;
 
@@ -259,21 +259,35 @@ static int audit_match_record(int audit_fd, const __u16 type,
 	if (ret)
 		return -EINVAL;
 
-	do {
+	/*
+	 * Reads records until one matches both the expected type and the
+	 * pattern.  Type-matching records with non-matching content are
+	 * silently consumed, which handles stale domain deallocation records
+	 * from a previous test emitted asynchronously by kworker threads.
+	 */
+	while (true) {
 		memset(&msg, 0, sizeof(msg));
 		err = audit_recv(audit_fd, &msg);
-		if (err)
+		if (err) {
+			if (num_type_match) {
+				printf("DATA: %s\n", last_mismatch.data);
+				printf("ERROR: %d record(s) matched type %u"
+				       " but not pattern: %s\n",
+				       num_type_match, type, pattern);
+			}
 			goto out;
+		}
 
-		if (msg.header.nlmsg_type == type)
-			matches_record = true;
-	} while (!matches_record);
+		if (type && msg.header.nlmsg_type != type)
+			continue;
 
-	ret = regexec(&regex, msg.data, ARRAY_SIZE(matches), matches, 0);
-	if (ret) {
-		printf("DATA: %s\n", msg.data);
-		printf("ERROR: no match for pattern: %s\n", pattern);
-		err = -ENOENT;
+		ret = regexec(&regex, msg.data, ARRAY_SIZE(matches), matches,
+			      0);
+		if (!ret)
+			break;
+
+		num_type_match++;
+		last_mismatch = msg;
 	}
 
 	if (domain_id) {
@@ -316,21 +330,49 @@ static int __maybe_unused matches_log_domain_allocated(int audit_fd, pid_t pid,
 				  domain_id);
 }
 
-static int __maybe_unused matches_log_domain_deallocated(
-	int audit_fd, unsigned int num_denials, __u64 *domain_id)
+/*
+ * Matches a domain deallocation record.  When expected_domain_id is non-zero,
+ * the pattern includes the specific domain ID so that stale deallocation
+ * records from a previous test (with a different domain ID) are skipped by
+ * audit_match_record(), and the socket timeout is temporarily increased to
+ * audit_tv_dom_drop to wait for the asynchronous kworker deallocation.
+ */
+static int __maybe_unused
+matches_log_domain_deallocated(int audit_fd, unsigned int num_denials,
+			       __u64 expected_domain_id, __u64 *domain_id)
 {
 	static const char log_template[] = REGEX_LANDLOCK_PREFIX
 		" status=deallocated denials=%u$";
-	char log_match[sizeof(log_template) + 10];
-	int log_match_len;
+	static const char log_template_with_id[] =
+		"^audit([0-9.:]\\+): domain=\\(%llx\\)"
+		" status=deallocated denials=%u$";
+	char log_match[sizeof(log_template_with_id) + 32];
+	int log_match_len, err;
+
+	if (expected_domain_id)
+		log_match_len = snprintf(log_match, sizeof(log_match),
+					 log_template_with_id,
+					 (unsigned long long)expected_domain_id,
+					 num_denials);
+	else
+		log_match_len = snprintf(log_match, sizeof(log_match),
+					 log_template, num_denials);
 
-	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
-				 num_denials);
 	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
-	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
-				  domain_id);
+	if (expected_domain_id)
+		setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
+			   &audit_tv_dom_drop, sizeof(audit_tv_dom_drop));
+
+	err = audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
+				 domain_id);
+
+	if (expected_domain_id)
+		setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
+			   sizeof(audit_tv_default));
+
+	return err;
 }
 
 struct audit_records {
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index f92ba6774faa..60de97bd0153 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -139,23 +139,24 @@ TEST_F(audit, layers)
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->exit_code = KSFT_FAIL;
 
-	/* Purges log from deallocated domains. */
-	EXPECT_EQ(0, setsockopt(self->audit_fd, SOL_SOCKET, SO_RCVTIMEO,
-				&audit_tv_dom_drop, sizeof(audit_tv_dom_drop)));
+	/*
+	 * Purges log from deallocated domains.  Records arrive in LIFO order
+	 * (innermost domain first) because landlock_put_hierarchy() walks the
+	 * chain sequentially in a single kworker context.
+	 */
 	for (i = ARRAY_SIZE(*domain_stack) - 1; i >= 0; i--) {
 		__u64 deallocated_dom = 2;
 
 		EXPECT_EQ(0, matches_log_domain_deallocated(self->audit_fd, 1,
+							    (*domain_stack)[i],
 							    &deallocated_dom));
 		EXPECT_EQ((*domain_stack)[i], deallocated_dom)
 		{
 			TH_LOG("Failed to match domain %llx (#%d)",
-			       (*domain_stack)[i], i);
+			       (unsigned long long)(*domain_stack)[i], i);
 		}
 	}
 	EXPECT_EQ(0, munmap(domain_stack, sizeof(*domain_stack)));
-	EXPECT_EQ(0, setsockopt(self->audit_fd, SOL_SOCKET, SO_RCVTIMEO,
-				&audit_tv_default, sizeof(audit_tv_default)));
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
@@ -270,13 +271,9 @@ TEST_F(audit, thread)
 	EXPECT_EQ(0, close(pipe_parent[1]));
 	ASSERT_EQ(0, pthread_join(thread, NULL));
 
-	EXPECT_EQ(0, setsockopt(self->audit_fd, SOL_SOCKET, SO_RCVTIMEO,
-				&audit_tv_dom_drop, sizeof(audit_tv_dom_drop)));
-	EXPECT_EQ(0, matches_log_domain_deallocated(self->audit_fd, 1,
-						    &deallocated_dom));
+	EXPECT_EQ(0, matches_log_domain_deallocated(
+			     self->audit_fd, 1, denial_dom, &deallocated_dom));
 	EXPECT_EQ(denial_dom, deallocated_dom);
-	EXPECT_EQ(0, setsockopt(self->audit_fd, SOL_SOCKET, SO_RCVTIMEO,
-				&audit_tv_default, sizeof(audit_tv_default)));
 }
 
 FIXTURE(audit_flags)
@@ -432,22 +429,21 @@ TEST_F(audit_flags, signal)
 
 	if (variant->restrict_flags &
 	    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+		/*
+		 * No deallocation record: denials=0 never matches a real
+		 * record.
+		 */
 		EXPECT_EQ(-EAGAIN,
-			  matches_log_domain_deallocated(self->audit_fd, 0,
+			  matches_log_domain_deallocated(self->audit_fd, 0, 0,
 							 &deallocated_dom));
 		EXPECT_EQ(deallocated_dom, 2);
 	} else {
-		EXPECT_EQ(0, setsockopt(self->audit_fd, SOL_SOCKET, SO_RCVTIMEO,
-					&audit_tv_dom_drop,
-					sizeof(audit_tv_dom_drop)));
 		EXPECT_EQ(0, matches_log_domain_deallocated(self->audit_fd, 2,
+							    *self->domain_id,
 							    &deallocated_dom));
 		EXPECT_NE(deallocated_dom, 2);
 		EXPECT_NE(deallocated_dom, 0);
 		EXPECT_EQ(deallocated_dom, *self->domain_id);
-		EXPECT_EQ(0, setsockopt(self->audit_fd, SOL_SOCKET, SO_RCVTIMEO,
-					&audit_tv_default,
-					sizeof(audit_tv_default)));
 	}
 }
 
-- 
2.53.0


