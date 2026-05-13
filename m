Return-Path: <stable+bounces-246805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK+TIsNXBGqjHAIAu9opvQ
	(envelope-from <stable+bounces-246805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:51:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC39531A95
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 622B1303863D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC16B3F9F22;
	Wed, 13 May 2026 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="h73615tz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9333F661F
	for <stable@vger.kernel.org>; Wed, 13 May 2026 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669496; cv=none; b=GsgN78HvhK/h9kn0rz1eALmlFi/uDnAWNt/1Xz2AMRxk4PHmWA36Vr7+W3C+KyPKnK155BW6Hv3cNgVGxwKaEalLMUhnpUX5gIKyML5YP3wGXyuouz+ymYZyKDhayKPe+IEZILigoXTrlFJxOwGKSGoKmaLe2ds5hnQv67IGXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669496; c=relaxed/simple;
	bh=ZBat0gz5r2HYR0mFQEmBGLl1xOCE0BCxQ73lFhCi4oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOYBL6FcQcLUM3dnBjL+D8ycLLEm5Q9XEJUOW0i4x5Dh8OuYZBMrqhNBDZzmoUD8l81mRaSnsWh2s1qd9vdIwIwzfzGa6ykeM/kebIHvmeOf2Q3ASB3pp4JVQS62MbY2Y4xxsCr7e50IYj6P3E4h2CxIyws/eK5/G+CaYkcAcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=h73615tz; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gFqyR3SXKzZcD;
	Wed, 13 May 2026 12:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1778669487;
	bh=TR+npEwXsiHWo2aYB9UuJbOsGkOrIvCASZvUoiFn+Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h73615tzqn9mWz/q2q0uAx9ZcS6oLQ5cthAmP3Gd9yJKtjsErOIycKz2tm7f1ow3J
	 sBQS8TtgS5+BlNDhfeBKt2NNLCSx/v38EQ5YcFmuzVVX9soIiwzCj5E513MmupZjV+
	 c46sGFkXhfpeXZfc775g9ZjQld/Q4Xe7kifGEXYk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gFqyQ3n6DzkBH;
	Wed, 13 May 2026 12:51:26 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: 
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	stable@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v1 2/2] selftests/landlock: Increase default audit socket timeout
Date: Wed, 13 May 2026 12:51:09 +0200
Message-ID: <20260513105112.140137-2-mic@digikod.net>
In-Reply-To: <20260513105112.140137-1-mic@digikod.net>
References: <20260513105112.140137-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Rspamd-Queue-Id: 3BC39531A95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.05 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.71)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[digikod.net,google.com,kernel.org,linuxfoundation.org,linutronix.de,intel.com,vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-246805-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,digikod.net:email,digikod.net:mid,digikod.net:dkim,intel.com:email,linutronix.de:email]
X-Rspamd-Action: no action

matches_log_fs() and other audit_match_record() callers intermittently
return -EAGAIN under heavy debug configs (KASAN, lockdep).  The audit
record delivery pipeline is asynchronous: landlock_log_denial() queues
the record to audit_queue, and kauditd_thread dequeues and delivers via
netlink.  Under debug configs, kauditd scheduling between
audit_log_end() and netlink_unicast() can exceed a syscall round trip
(more than 1 usec), which was the value of the socket timeout used for
the recvfrom() calls.

The observed failure [1] is an EAGAIN error code (-11) which means that
the access record had not arrived within the 1 usec timeout of
recvfrom().  The expected record does arrive, but only after
matches_log_fs() has already returned.  It is then consumed by a later
audit_count_records() call, making records.access == 1 instead of 0.

Switch the default socket timeout to the slow value (1 second) so all
audit_match_record() callers wait long enough for kauditd delivery, and
lower it to the fast value (1 usec) only on the two paths that expect no
record: audit_count_records() and the expected_domain_id == 0 probe in
matches_log_domain_deallocated().  audit_init() drains stale records
with the fast timeout (terminating on -EAGAIN once the backlog is empty)
and switches to the patient default before returning.  1 second gives
~10x margin over the observed maximum (~100 ms, while the happy path is
~23 us).

Rename the timeval constants to reflect their new roles:
- audit_tv_dom_drop (1 second) -> audit_tv_default: default socket
  timeout, patient enough for asynchronous kauditd delivery.
- audit_tv_default (1 usec) -> audit_tv_fast: fast timeout for paths
  that expect no record (drain, audit_count_records(), probes).

Invert the conditional in matches_log_domain_deallocated().  Check
setsockopt returns on both the lower and restore paths; preserve the
first error via !err when the restore fails after a prior error so the
actionable return code is not masked by a bookkeeping failure.

Cc: Günther Noack <gnoack@google.com>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Cc: stable@vger.kernel.org
Depends-on: 07c2572a8757 ("selftests/landlock: Skip stale records in audit_match_record()")
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Reported-by: Günther Noack <gnoack3000@gmail.com>
Closes: https://lore.kernel.org/r/20260402.eb5c4e85f472@gnoack.org [1]
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202605111649.a8b30a62-lkp@intel.com
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/audit.h | 80 +++++++++++++++++++-----
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 699aed5ffab4..936fe20f020e 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -45,17 +45,25 @@ struct audit_message {
 	};
 };
 
-static const struct timeval audit_tv_dom_drop = {
+static const struct timeval audit_tv_default = {
 	/*
-	 * Because domain deallocation is tied to asynchronous credential
-	 * freeing, receiving such event may take some time.  In practice,
-	 * on a small VM, it should not exceed 100k usec, but let's wait up
-	 * to 1 second to be safe.
+	 * Default socket timeout for audit_match_record() callers that expect a
+	 * record to arrive.  Asynchronous kauditd delivery can exceed 1 usec
+	 * under heavy debug configs (KASAN, lockdep), where kauditd_thread
+	 * scheduling between audit_log_end() and netlink_unicast() takes longer
+	 * than the previous 1 usec timeout. 1 second is a generous ceiling: on
+	 * the happy path, kauditd delivers within dozens of usec.
 	 */
 	.tv_sec = 1,
 };
 
-static const struct timeval audit_tv_default = {
+static const struct timeval audit_tv_fast = {
+	/*
+	 * Fast timeout for paths that expect no record (audit_init() drain,
+	 * audit_count_records(), probes).  Causes audit_recv() to return
+	 * -EAGAIN once the socket buffer is empty, naturally terminating the
+	 * read loop.
+	 */
 	.tv_usec = 1,
 };
 
@@ -334,8 +342,13 @@ static int __maybe_unused matches_log_domain_allocated(int audit_fd, pid_t pid,
  * Matches a domain deallocation record.  When expected_domain_id is non-zero,
  * the pattern includes the specific domain ID so that stale deallocation
  * records from a previous test (with a different domain ID) are skipped by
- * audit_match_record(), and the socket timeout is temporarily increased to
- * audit_tv_dom_drop to wait for the asynchronous kworker deallocation.
+ * audit_match_record(), waiting for the asynchronous kworker deallocation with
+ * the default patient timeout.
+ *
+ * When expected_domain_id is zero, the caller is probing for any dealloc record
+ * that may or may not arrive.  Temporarily lowers the socket timeout to
+ * audit_tv_fast for this probe so it returns promptly when no record is
+ * pending; restores audit_tv_default after.
  */
 static int __maybe_unused
 matches_log_domain_deallocated(int audit_fd, unsigned int num_denials,
@@ -361,16 +374,21 @@ matches_log_domain_deallocated(int audit_fd, unsigned int num_denials,
 	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
-	if (expected_domain_id)
-		setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
-			   &audit_tv_dom_drop, sizeof(audit_tv_dom_drop));
+	if (!expected_domain_id) {
+		if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
+			       &audit_tv_fast, sizeof(audit_tv_fast)))
+			return -errno;
+	}
 
 	err = audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
 				 domain_id);
 
-	if (expected_domain_id)
-		setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
-			   sizeof(audit_tv_default));
+	if (!expected_domain_id) {
+		if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
+			       &audit_tv_default, sizeof(audit_tv_default)) &&
+		    !err)
+			err = -errno;
+	}
 
 	return err;
 }
@@ -387,6 +405,11 @@ struct audit_records {
  * audit_init() and after the preceding audit_match_record() call.  Allocation
  * records are emitted synchronously during landlock_log_denial() in the current
  * test's syscall context, so only those are counted in records->domain.
+ *
+ * Temporarily lowers SO_RCVTIMEO to audit_tv_fast for the read loop: this is a
+ * "no record expected" path that should terminate on the first -EAGAIN.  The
+ * default patient timeout is restored on exit for subsequent
+ * audit_match_record() callers.
  */
 static int audit_count_records(int audit_fd, struct audit_records *records)
 {
@@ -403,6 +426,12 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
 	records->access = 0;
 	records->domain = 0;
 
+	if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_fast,
+		       sizeof(audit_tv_fast))) {
+		err = -errno;
+		goto out;
+	}
+
 	do {
 		memset(&msg, 0, sizeof(msg));
 		err = audit_recv(audit_fd, &msg);
@@ -429,6 +458,10 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
 	} while (true);
 
 out:
+	if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
+		       sizeof(audit_tv_default)) &&
+	    !err)
+		err = -errno;
 	regfree(&dealloc_re);
 	return err;
 }
@@ -449,9 +482,9 @@ static int audit_init(void)
 	if (err)
 		goto err_close;
 
-	/* Sets a timeout for negative tests. */
-	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
-			 sizeof(audit_tv_default));
+	/* Uses the fast timeout to drain stale records below. */
+	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_fast,
+			 sizeof(audit_tv_fast));
 	if (err) {
 		err = -errno;
 		goto err_close;
@@ -467,6 +500,19 @@ static int audit_init(void)
 	while (audit_recv(fd, NULL) == 0)
 		;
 
+	/*
+	 * Restores the default timeout for audit_match_record() callers that
+	 * expect a record to arrive.  Paths that expect no record restore the
+	 * fast timeout locally (audit_count_records(), the expected_domain_id
+	 * == 0 probe in matches_log_domain_deallocated()).
+	 */
+	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
+			 sizeof(audit_tv_default));
+	if (err) {
+		err = -errno;
+		goto err_close;
+	}
+
 	return fd;
 
 err_close:
-- 
2.54.0


