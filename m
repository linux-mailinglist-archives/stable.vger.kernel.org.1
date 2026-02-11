Return-Path: <stable+bounces-215794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAYQN0FvjGlmngAAu9opvQ
	(envelope-from <stable+bounces-215794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:00:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 402FA124083
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7FA4302261B
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28358315D35;
	Wed, 11 Feb 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFlEnHu5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwXDUIi5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485273148A8
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811198; cv=none; b=AvQjrI0njfZTvjqUUp8rEYqCUIwnGkR9kx2kZ0OXi2287ZMlDRWKyCGg442CQjXPnBI8lTAZPyUtLKl1wZfg4238LHibPPVriNkoLroSEz9f6ExvH0ff44nD+FJ7h/5r9WYR4S+yM03Xlclw4fojz+qaBIOLVTPTkVUF3NkFjHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811198; c=relaxed/simple;
	bh=PMF77V1aQXnrEX+KvwYttYaLIz/J1dQcL8rgOqAEzPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTt4scpfh7WNy6jhyzv7ERcam/54xYbpkdSVcLhnLOX/ioNrBnwGilFdeEp4ASmPJQ/t0zxU2kJXua/eX+sg0KWy6JItXuZ0lowg0/IHS9l4G3qbHu2dSZtf6EbyjbXn/NIHG/3hqWtfSHh53RYIQnnwa/COttDnu/MdyrlRfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFlEnHu5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwXDUIi5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770811196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fGxrdj1WdLWdMGwzT+N4Ov9tYu2f4uhQaIJR6idpwdo=;
	b=AFlEnHu5p7WM09BEN+mFNPJissVVc675Qsdc5sScp+PlGFt1PToQ+jZdF1f1BWLIhcErhV
	nwssOvMhW1KEfNi5mbc0y8e8cO1Csr9yA9QlhHkDcAqDTh2gdtMSJGlS4dl+na3T6zTCD9
	qzNUfhetAvDlg1r6d8iz1PSOwMeZXKE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-oq154ZMuOWSr0dX87pWLyg-1; Wed, 11 Feb 2026 06:59:55 -0500
X-MC-Unique: oq154ZMuOWSr0dX87pWLyg-1
X-Mimecast-MFC-AGG-ID: oq154ZMuOWSr0dX87pWLyg_1770811194
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48057c39931so64129305e9.0
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 03:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770811192; x=1771415992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGxrdj1WdLWdMGwzT+N4Ov9tYu2f4uhQaIJR6idpwdo=;
        b=QwXDUIi5HuEGrdTewjIabgHiqs3pH2gEYcEsW3JB9qzXQfGoqt0EG9WcpqHuNeeclo
         g4zy9G3VF1u/TEULqpH06fDHU8GTkY84p1XGtg5RPgQqTmgd0FNkmtY8wAr8UHsTwS9F
         LChn3HB01wTTRE72aVEJCQgpf4koclIeWi5A/9UA+jhViIWz/cHWXS4d+FYYfGVCnJp6
         rTPDy5LdzGYIYENcmJbrqWldyWQHr6Wqsnl1tMYUHk85k2Kfz4q+TUUKkDc4kL0T6ykF
         Fs3Zd09hQ2R7qWAGlYf680XZHmM3oPmrKomNHEKxIlRIqjNJHlnkNTalDkFkKKdFuK6J
         +jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770811192; x=1771415992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGxrdj1WdLWdMGwzT+N4Ov9tYu2f4uhQaIJR6idpwdo=;
        b=cuoMvqTZnSYLsIsZvvu/OC3RHvPQZ18Z1l2E+qZwxnHUIJ9Y4Ri3fktnI29rWNFRPc
         Qq3NkCqIyqL92BXyCNZdkMLwRXsFKrLaj0uxpjjez6DsLhJUfOSyaZVfvTIB8Ql7k+z2
         49zTN6ZGJG9+epRBTBXtzyDznnPYTZPpbdwz+SUZeSAb+Kl0r788zvvpzFJJc4o5aAXL
         l14Qw3sooDFkDwebLjwG5vV+HnFZ3lPzDMA9Gbmh8sXso9ODt4c5Kn92oKJBa75Vgou9
         /wY8uT9SYoMztbBYHYpE+4HI6zQfkIKRhs+uJEhantibaFAXlwnbZzDT43pOHowf/hJ+
         M74Q==
X-Gm-Message-State: AOJu0YzhiIzQxQDzGtkyWJGJvflV71Tsv1NlwZs8vrOQw2qze0BteSEW
	CPxkB6uQmFvB2+Dw3r57kc/1eqxZKKJp5BvMomPo7krEwjPjO6CxyUUN6u3bniwsSqOfyHvioHw
	y7XnuTI6QJmh1n3RyAX9e1BGtMX58EEFL1OTEMfbVbyjaTu4C5owZCJKjvyFGvlUFNYkooBWwcC
	etI8rP56A3oiSiVMA4NmKFVCA9aOZ2ptd1FJXQD2LZCg==
X-Gm-Gg: AZuq6aI5wl2x/dMR+QXg2jKnWjsHJTMTo5TkYpb6AO9vQHU9BLT0v2MCpKvi5Db3LUj
	cW4wiG6kBFnEwE29pa3zTTv2E6MQA7opNWCCJtuLhdWmEuNUigufwWInjBgBTyca2Y9+7fDrd6V
	Ogs9aLkTV7SLyGQQTrxxT/GBtfBn+QkWjoSxjqC7Fnd/Nr5V3ICDE8f6UfCuWWKRTAx8lbpiCIr
	zqqT7I7Jp1a4T7/Nm+39DSvSVhCG9cxQs9yE6Txt/jIG+J8YMP6iO8EJJU19AKwhbUQMFEclCC6
	6fwtCVE2w4itW2GCFLoYQoWkHarfL5FF+mfiCaANdz+g/BYHN1LZbY2X6FJYfuWrOZfrCN27vFq
	GO0q/EcgfyO0eMoLgyJhcv4BoKFQDxwKMe8bTp5MJD/i+lbM2kuJ1bAzv82xpNfiYuGvPelRt
X-Received: by 2002:a05:600c:c48f:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-4835b91d58bmr30347135e9.15.1770811191807;
        Wed, 11 Feb 2026 03:59:51 -0800 (PST)
X-Received: by 2002:a05:600c:c48f:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-4835b91d58bmr30346625e9.15.1770811191243;
        Wed, 11 Feb 2026 03:59:51 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm134065265e9.7.2026.02.11.03.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 03:59:50 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: stable@vger.kernel.org
Cc: Johan Korsnes <johan.korsnes@remarkable.no>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Konstantin Shkolnyy <kshk@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12] vsock/test: verify socket options after setting them
Date: Wed, 11 Feb 2026 12:59:48 +0100
Message-ID: <20260211115948.108140-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215794-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 402FA124083
X-Rspamd-Action: no action

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

[ Upstream commit 86814d8ffd55fd4ad19c512eccd721522a370fb2 ]

Replace setsockopt() calls with calls to functions that follow
setsockopt() with getsockopt() and check that the returned value and its
size are the same as have been set. (Except in vsock_perf.)

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[Stefano: patch needed to avoid vsock test build failure reported by
 Johan Korsnes after backporting commit 0a98de8013696 ("vsock/test: fix
 seqpacket message bounds test") in 6.12-stable tree]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/msg_zerocopy_common.h |   1 -
 tools/testing/vsock/util.h                |   7 ++
 tools/testing/vsock/control.c             |   9 +-
 tools/testing/vsock/msg_zerocopy_common.c |  10 --
 tools/testing/vsock/util.c                | 142 ++++++++++++++++++++++
 tools/testing/vsock/vsock_perf.c          |  10 ++
 tools/testing/vsock/vsock_test.c          |  51 +++-----
 tools/testing/vsock/vsock_test_zerocopy.c |   2 +-
 tools/testing/vsock/vsock_uring_test.c    |   2 +-
 9 files changed, 181 insertions(+), 53 deletions(-)

diff --git a/tools/testing/vsock/msg_zerocopy_common.h b/tools/testing/vsock/msg_zerocopy_common.h
index 3763c5ccedb95..ad14139e93ca3 100644
--- a/tools/testing/vsock/msg_zerocopy_common.h
+++ b/tools/testing/vsock/msg_zerocopy_common.h
@@ -12,7 +12,6 @@
 #define VSOCK_RECVERR	1
 #endif
 
-void enable_so_zerocopy(int fd);
 void vsock_recv_completion(int fd, const bool *zerocopied);
 
 #endif /* MSG_ZEROCOPY_COMMON_H */
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fff22d4a14c0f..ba84d296d8b71 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -68,4 +68,11 @@ unsigned long iovec_hash_djb2(const struct iovec *iov, size_t iovnum);
 struct iovec *alloc_test_iovec(const struct iovec *test_iovec, int iovnum);
 void free_test_iovec(const struct iovec *test_iovec,
 		     struct iovec *iovec, int iovnum);
+void setsockopt_ull_check(int fd, int level, int optname,
+			  unsigned long long val, char const *errmsg);
+void setsockopt_int_check(int fd, int level, int optname, int val,
+			  char const *errmsg);
+void setsockopt_timeval_check(int fd, int level, int optname,
+			      struct timeval val, char const *errmsg);
+void enable_so_zerocopy_check(int fd);
 #endif /* UTIL_H */
diff --git a/tools/testing/vsock/control.c b/tools/testing/vsock/control.c
index d2deb4b15b943..0066e0324d35c 100644
--- a/tools/testing/vsock/control.c
+++ b/tools/testing/vsock/control.c
@@ -27,6 +27,7 @@
 
 #include "timeout.h"
 #include "control.h"
+#include "util.h"
 
 static int control_fd = -1;
 
@@ -50,7 +51,6 @@ void control_init(const char *control_host,
 
 	for (ai = result; ai; ai = ai->ai_next) {
 		int fd;
-		int val = 1;
 
 		fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
 		if (fd < 0)
@@ -65,11 +65,8 @@ void control_init(const char *control_host,
 			break;
 		}
 
-		if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR,
-			       &val, sizeof(val)) < 0) {
-			perror("setsockopt");
-			exit(EXIT_FAILURE);
-		}
+		setsockopt_int_check(fd, SOL_SOCKET, SO_REUSEADDR, 1,
+				     "setsockopt SO_REUSEADDR");
 
 		if (bind(fd, ai->ai_addr, ai->ai_addrlen) < 0)
 			goto next;
diff --git a/tools/testing/vsock/msg_zerocopy_common.c b/tools/testing/vsock/msg_zerocopy_common.c
index 5a4bdf7b51328..8622e5a0f8b77 100644
--- a/tools/testing/vsock/msg_zerocopy_common.c
+++ b/tools/testing/vsock/msg_zerocopy_common.c
@@ -14,16 +14,6 @@
 
 #include "msg_zerocopy_common.h"
 
-void enable_so_zerocopy(int fd)
-{
-	int val = 1;
-
-	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
-		perror("setsockopt");
-		exit(EXIT_FAILURE);
-	}
-}
-
 void vsock_recv_completion(int fd, const bool *zerocopied)
 {
 	struct sock_extended_err *serr;
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 8a899a9fc9a98..894221a1ff317 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -663,3 +663,145 @@ void free_test_iovec(const struct iovec *test_iovec,
 
 	free(iovec);
 }
+
+/* Set "unsigned long long" socket option and check that it's indeed set */
+void setsockopt_ull_check(int fd, int level, int optname,
+			  unsigned long long val, char const *errmsg)
+{
+	unsigned long long chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	chkval = ~val; /* just make storage != val */
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+			chklen);
+		goto fail;
+	}
+
+	if (chkval != val) {
+		fprintf(stderr, "value mismatch: set %llu got %llu\n", val,
+			chkval);
+		goto fail;
+	}
+	return;
+fail:
+	fprintf(stderr, "%s  val %llu\n", errmsg, val);
+	exit(EXIT_FAILURE);
+;
+}
+
+/* Set "int" socket option and check that it's indeed set */
+void setsockopt_int_check(int fd, int level, int optname, int val,
+			  char const *errmsg)
+{
+	int chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	chkval = ~val; /* just make storage != val */
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+			chklen);
+		goto fail;
+	}
+
+	if (chkval != val) {
+		fprintf(stderr, "value mismatch: set %d got %d\n", val, chkval);
+		goto fail;
+	}
+	return;
+fail:
+	fprintf(stderr, "%s val %d\n", errmsg, val);
+	exit(EXIT_FAILURE);
+}
+
+static void mem_invert(unsigned char *mem, size_t size)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++)
+		mem[i] = ~mem[i];
+}
+
+/* Set "timeval" socket option and check that it's indeed set */
+void setsockopt_timeval_check(int fd, int level, int optname,
+			      struct timeval val, char const *errmsg)
+{
+	struct timeval chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	 /* just make storage != val */
+	chkval = val;
+	mem_invert((unsigned char *)&chkval, sizeof(chkval));
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+			chklen);
+		goto fail;
+	}
+
+	if (memcmp(&chkval, &val, sizeof(val)) != 0) {
+		fprintf(stderr, "value mismatch: set %ld:%ld got %ld:%ld\n",
+			val.tv_sec, val.tv_usec, chkval.tv_sec, chkval.tv_usec);
+		goto fail;
+	}
+	return;
+fail:
+	fprintf(stderr, "%s val %ld:%ld\n", errmsg, val.tv_sec, val.tv_usec);
+	exit(EXIT_FAILURE);
+}
+
+void enable_so_zerocopy_check(int fd)
+{
+	setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
+			     "setsockopt SO_ZEROCOPY");
+}
diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
index 8e0a6c0770d37..75971ac708c9a 100644
--- a/tools/testing/vsock/vsock_perf.c
+++ b/tools/testing/vsock/vsock_perf.c
@@ -251,6 +251,16 @@ static void run_receiver(int rcvlowat_bytes)
 	close(fd);
 }
 
+static void enable_so_zerocopy(int fd)
+{
+	int val = 1;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
+		perror("setsockopt");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static void run_sender(int peer_cid, unsigned long to_send_bytes)
 {
 	time_t tx_begin_ns;
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 79ef11c0ab14f..8855094202d40 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -455,17 +455,13 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 
 	sock_buf_size = SOCK_BUF_SIZE;
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
 
 	/* Ready to receive data. */
 	control_writeln("SRVREADY");
@@ -597,10 +593,8 @@ static void test_seqpacket_timeout_client(const struct test_opts *opts)
 	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
 	tv.tv_usec = 0;
 
-	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
-		perror("setsockopt(SO_RCVTIMEO)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_timeval_check(fd, SOL_SOCKET, SO_RCVTIMEO, tv,
+				 "setsockopt(SO_RCVTIMEO)");
 
 	read_enter_ns = current_nsec();
 
@@ -866,11 +860,8 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-		       &lowat_val, sizeof(lowat_val))) {
-		perror("setsockopt(SO_RCVLOWAT)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+			     lowat_val, "setsockopt(SO_RCVLOWAT)");
 
 	control_expectln("SRVSENT");
 
@@ -1398,11 +1389,9 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	/* size_t can be < unsigned long long */
 	sock_buf_size = buf_size;
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
 
 	if (low_rx_bytes_test) {
 		/* Set new SO_RCVLOWAT here. This enables sending credit
@@ -1411,11 +1400,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 		 */
 		recv_buf_size = 1 + VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
 
-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-			       &recv_buf_size, sizeof(recv_buf_size))) {
-			perror("setsockopt(SO_RCVLOWAT)");
-			exit(EXIT_FAILURE);
-		}
+		setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+				     recv_buf_size, "setsockopt(SO_RCVLOWAT)");
 	}
 
 	/* Send one dummy byte here, because 'setsockopt()' above also
@@ -1457,11 +1443,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 		recv_buf_size++;
 
 		/* Updating SO_RCVLOWAT will send credit update. */
-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-			       &recv_buf_size, sizeof(recv_buf_size))) {
-			perror("setsockopt(SO_RCVLOWAT)");
-			exit(EXIT_FAILURE);
-		}
+		setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+				     recv_buf_size, "setsockopt(SO_RCVLOWAT)");
 	}
 
 	fds.fd = fd;
diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
index 04c376b6937f5..9d9a6cb9614ad 100644
--- a/tools/testing/vsock/vsock_test_zerocopy.c
+++ b/tools/testing/vsock/vsock_test_zerocopy.c
@@ -162,7 +162,7 @@ static void test_client(const struct test_opts *opts,
 	}
 
 	if (test_data->so_zerocopy)
-		enable_so_zerocopy(fd);
+		enable_so_zerocopy_check(fd);
 
 	iovec = alloc_test_iovec(test_data->vecs, test_data->vecs_cnt);
 
diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock/vsock_uring_test.c
index 6c3e6f70c457d..5c3078969659f 100644
--- a/tools/testing/vsock/vsock_uring_test.c
+++ b/tools/testing/vsock/vsock_uring_test.c
@@ -73,7 +73,7 @@ static void vsock_io_uring_client(const struct test_opts *opts,
 	}
 
 	if (msg_zerocopy)
-		enable_so_zerocopy(fd);
+		enable_so_zerocopy_check(fd);
 
 	iovec = alloc_test_iovec(test_data->vecs, test_data->vecs_cnt);
 
-- 
2.53.0


