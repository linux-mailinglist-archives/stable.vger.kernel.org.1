Return-Path: <stable+bounces-215798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFf9DihyjGn6oAAAu9opvQ
	(envelope-from <stable+bounces-215798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:12:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 984B71241EC
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3773230078F9
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8072E32E745;
	Wed, 11 Feb 2026 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGxuncUV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sXNPQyEp"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594230C606
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811906; cv=none; b=ElegD2DMlp5FMm+4pRCGLvTYRRNjsjp3a+xs7F6NI7oxgmCRJDLnilaRsDbgKe5xS8edxGNrEuQLRCUfd3CTKWQjdOPGAqOh2kO3tHJ4p0nqgIJTf4wnFR6rGNKq0sltHqRhTz4JEN8orXS2tOgcSwwHmVviwDf8YZZ+aEoYg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811906; c=relaxed/simple;
	bh=IxH2XhtjhD9kU5BtonW4tLaXoAh7jCdWE2DSn80zI1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NM4ZC9ePSCdE7T2JcBH6bp/SHrlrRe5+EajApwW/2x5zLoe5fRkzI8yIvOD7nUXS+NNSlfkB1IFwI7JS1hSx5hBJpmPvXNpuFh9qdZ/4siNflXtqJU061Wbt9Uf+8Rn/YGY+IEhr4hqZ5nuMzUt2PFz3p20nuEzK3W/3qRl7q2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGxuncUV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sXNPQyEp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770811903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eyECnvnxxSRB8mQa+WZ212wsx+QZRVH7QtNLo2aWwTA=;
	b=HGxuncUVdEQScmy9P8/CrLXxb+Y8itXoaDAp4KMonC62lPEqf9WpusLu+H1MZGI/+ENTAk
	s+W19MvScRdkhIQo8TpYIOlAaHjmafYSyECxSlrHJCo7NzQPxegNzF2I1Kc/GvmZ7M8MJW
	HagDbiJJD+tzA+V9fRKHMuJCfqC3U9s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-uGxvt_NLPtCkoPBh45TJmw-1; Wed, 11 Feb 2026 07:11:42 -0500
X-MC-Unique: uGxvt_NLPtCkoPBh45TJmw-1
X-Mimecast-MFC-AGG-ID: uGxvt_NLPtCkoPBh45TJmw_1770811901
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso66672145e9.0
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 04:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770811899; x=1771416699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyECnvnxxSRB8mQa+WZ212wsx+QZRVH7QtNLo2aWwTA=;
        b=sXNPQyEpPUC/1qANhbTzVi1Lil1DWW9a72RqG4xa+pa0K2z4wBw+u/GK67+jaU/OQc
         kvpMSaSPT97XoNs98pT1UtcXLOUP82ySLSgtVAVh5Vs/Ts86CMt9cLMbDVtokXAcZecq
         p9fQ5mQOiybu0N+XOsSUgIPIsicnQp2+TOQ+S9DfYdxCpcvYz8dIcoFtTPZnsisi8rmf
         OimjIZFmWNUMxj17HqoEm49dL2gdfrUyjWXLUwBBW5CNMhRdvbcsJ06hcGwWNp+2JwjO
         7bgoJxv0EKHNMXbrTD/1XREALLS9i0fvkREH9K6P9nC6eo1QBwr6MB4IM03nQKmwONzZ
         jNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770811899; x=1771416699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyECnvnxxSRB8mQa+WZ212wsx+QZRVH7QtNLo2aWwTA=;
        b=UDHRwpWVvARFnODoPvyncGAl0OzV+sWowQMzaDNa11mOWIkXQRvxJVQqBe70Pwe76r
         lpCt/I4g5porT/xD+3eNbdVRfNmflJ4TAyeqSmYuQF9NRQXe98JRnYVLNMld5Xhf3cLG
         BGi1ikW7sojrSmvdpjukfbMTuMAavIOb4k/ftzz8Xw/qI4z1FrsZ6lpYpft3EIJprc8V
         v3EJ5zTSZh3calNRNAxOwptlQ9c8RMNjCCAVlYdZiBkNuRw9rdZp16plPDNfizcoRZEl
         HwvmWIZ+ZG6CIf/wdrhE6V/eJDKMO4oSauZuUHJy7QRD3YRc3tV6bIckUnZmB4eGLI3n
         Ugfg==
X-Gm-Message-State: AOJu0YwTXisJ2Um64e+9ZZaJGOYA50jRmpSWOX8cotzJqnkLrxwrxyxZ
	v07CXjnBEA5o/XosRbM6cCrYeoVYhmwPCRh3PW7oF8szdTS+1Qiuk0R8VBd+r6xsFPYfdGGe992
	FG6FQ99l2xSJggJW7eEmmIgKF0nhSLHeH0OTahzexPJSQEANCjYCASqq/WQRd9u2HUC8/3b1MHS
	MBLv74a05JswJCexU6oKF3v5Xva/11/HGOtN3GD9ScqA==
X-Gm-Gg: AZuq6aJIU7FWOucD3CMWPjo3Ma9Z40xg/ZikDAlrOgEYEgmCQca64b6h9kwMPoKV6os
	0KvaJoqysXkWirmQGoZy0G1Mfy/vjbtC7xYgRsr3ld4nXQoUqeGbCzH9M0TyvMblv0dRMSNbCHD
	GdQN3oWoU80o1NR7ha9GmD254v2MpAyf0cX2C1RBt2TQfYiTmdbs8SuN/Q049bz/peMqa7iW47K
	7TlSn7nk9u7MsNf4ND9l1754++mQm2WRH9cYk8G1aASTYlwQJhwSv/mLkYpdVE6bXfdCA7cec9w
	toJ3ESoWrfhvQFpHlpcKa+y8izCQ+o8KiJXKsU+CWU+yA5kFDHEWzDwVK9IKnBBIy742l1DBcWa
	oI81QXCpo8usnx0YWC0u+5SD3f7rqqUzgsvlc+N7x8Q62n9uBxhzacBrvqedD1RuWxBlPqT+G
X-Received: by 2002:a05:600c:1da8:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-4835dfcf9d3mr23192005e9.21.1770811898540;
        Wed, 11 Feb 2026 04:11:38 -0800 (PST)
X-Received: by 2002:a05:600c:1da8:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-4835dfcf9d3mr23191595e9.21.1770811898021;
        Wed, 11 Feb 2026 04:11:38 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835ba69160sm16711465e9.8.2026.02.11.04.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 04:11:36 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: stable@vger.kernel.org
Cc: Johan Korsnes <johan.korsnes@remarkable.no>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Konstantin Shkolnyy <kshk@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6] vsock/test: verify socket options after setting them
Date: Wed, 11 Feb 2026 13:11:35 +0100
Message-ID: <20260211121135.116071-1-sgarzare@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215798-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 984B71241EC
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
 seqpacket message bounds test") in 6.6-stable tree. Several tests are
 missing here compared to upstream, so this version has been adapted by
 removing some hunks.]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.h       |   7 ++
 tools/testing/vsock/control.c    |   9 +-
 tools/testing/vsock/util.c       | 143 +++++++++++++++++++++++++++++++
 tools/testing/vsock/vsock_test.c |  29 +++----
 4 files changed, 163 insertions(+), 25 deletions(-)

diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fb99208a95eab..a05438851919c 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -50,4 +50,11 @@ void list_tests(const struct test_case *test_cases);
 void skip_test(struct test_case *test_cases, size_t test_cases_len,
 	       const char *test_id_str);
 unsigned long hash_djb2(const void *data, size_t len);
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
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 751fe7c6632ea..e67e26636f579 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -12,6 +12,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <signal.h>
+#include <string.h>
 #include <unistd.h>
 #include <assert.h>
 #include <sys/epoll.h>
@@ -420,3 +421,145 @@ unsigned long hash_djb2(const void *data, size_t len)
 
 	return hash;
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
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 793d688cd4da6..01ad8cfa9bde3 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -503,17 +503,13 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 
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
@@ -648,10 +644,8 @@ static void test_seqpacket_timeout_client(const struct test_opts *opts)
 	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
 	tv.tv_usec = 0;
 
-	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
-		perror("setsockopt(SO_RCVTIMEO)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_timeval_check(fd, SOL_SOCKET, SO_RCVTIMEO, tv,
+				 "setsockopt(SO_RCVTIMEO)");
 
 	read_enter_ns = current_nsec();
 
@@ -928,11 +922,8 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
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
 
-- 
2.53.0


