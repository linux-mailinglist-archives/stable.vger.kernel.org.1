Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E356675D86E
	for <lists+stable@lfdr.de>; Sat, 22 Jul 2023 02:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGVAqJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 20:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGVAqI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 20:46:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349DE1FCB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 17:46:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b703caf344so36171471fa.1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 17:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689986765; x=1690591565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiMv/DqXyMU0T5XJGTVrsRNjjYWgHT5nqe7rNKmDMBs=;
        b=sxlUtBHgjoRglbjjwmjfttUpvg3TxYhz8DO24CKgFebz3w98UCtFNmX6QaIqGX1yZs
         IXUzoRwoDgRhTxlU/bLXfRFd8RwaBi0n0KKm+8n7ei67nA+g2AVip5+QaMiBS/ITvcka
         4eEFiely999yOssVoZqeTBQUe141cg9X84NUUGpOLSdFzAP9NjH2alM8dgG9cicvdzV9
         OcHdHuYMeEygyfwUig0k+X0R9I5FFhIABVUL11dfmuvlTqHgCwncrl+LrvSOue1wn/cu
         jhsnRbo4AUR9CFD41v6i1PQjMaVrEJAQ7fDoSXJDHoCBHuQ/oLRqlyF8fTuVrDJHNYww
         tnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689986765; x=1690591565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiMv/DqXyMU0T5XJGTVrsRNjjYWgHT5nqe7rNKmDMBs=;
        b=M1L1UPwtAStBF3kS7iw8172c+kE7kZ45TqnoeuFUr0ulWvbKYixnGT02QpmleqATDs
         HPvQBnmiJ64GEElU2w4V1N369p2pqjLfGbOf1/Zv+GRpAKodh5dhZIQZQWko/OkCI+ka
         Z23U9/iFOA5v/+lT9IY0yBjja0LZnyTOv1f0qvXB1ZRPCQLBtHoUmIwZVj/+/DAEe1q+
         aOg8BE+vlOXtEVPvP0l+M3cbwJBIKq1SH7NWAWpM21W4pxV/viesuuMFaWuF0gPh7/cf
         BxtIavVUXpel6A+sn9718NVqyhS4gw/1r9iFChcenp8zSduGLRXu/LXUJHRnFTA5lelW
         /HtQ==
X-Gm-Message-State: ABy/qLbBHGj6n6V4KwvKyUt+d6thhL8rt8ECvif1gHQ9ZsKkthq4FErE
        DAuPhS8NWKXXNJUsJ/4RiUijjEiKOf0gRQ==
X-Google-Smtp-Source: APBJJlFpumN7xuAKmAgrZhq+05NNOiKZ9z8llYM0SNj3lIuM+PwGYHTKEJqe9J4cmHzFnfYthz37RQ==
X-Received: by 2002:a2e:3316:0:b0:2b6:e6ad:25c4 with SMTP id d22-20020a2e3316000000b002b6e6ad25c4mr2914961ljc.45.1689986765203;
        Fri, 21 Jul 2023 17:46:05 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e8002000000b002b69febf515sm1224585ljg.125.2023.07.21.17.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:46:04 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     stable@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, mykolal@fb.com, luizcap@amazon.com,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 6.1.y 6/6] selftests/bpf: Fix sk_assign on s390x
Date:   Sat, 22 Jul 2023 03:45:14 +0300
Message-ID: <20230722004514.767618-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230722004514.767618-1-eddyz87@gmail.com>
References: <20230722004514.767618-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit 7ce878ca81bca7811e669db4c394b86780e0dbe4 ]

sk_assign is failing on an s390x machine running Debian "bookworm" for
2 reasons: legacy server_map definition and uninitialized addrlen in
recvfrom() call.

Fix by adding a new-style server_map definition and dropping addrlen
(recvfrom() allows NULL values for src_addr and addrlen).

Since the test should support tc built without libbpf, build the prog
twice: with the old-style definition and with the new-style definition,
then select the right one at runtime. This could be done at compile
time too, but this would not be cross-compilation friendly.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Link: https://lore.kernel.org/r/20230129190501.1624747-2-iii@linux.ibm.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/sk_assign.c      | 25 ++++++++++++++-----
 .../selftests/bpf/progs/test_sk_assign.c      | 11 ++++++++
 .../bpf/progs/test_sk_assign_libbpf.c         |  3 +++
 3 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 3e190ed63976..1374b626a985 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -29,7 +29,23 @@ static int stop, duration;
 static bool
 configure_stack(void)
 {
+	char tc_version[128];
 	char tc_cmd[BUFSIZ];
+	char *prog;
+	FILE *tc;
+
+	/* Check whether tc is built with libbpf. */
+	tc = popen("tc -V", "r");
+	if (CHECK_FAIL(!tc))
+		return false;
+	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
+		return false;
+	if (strstr(tc_version, ", libbpf "))
+		prog = "test_sk_assign_libbpf.bpf.o";
+	else
+		prog = "test_sk_assign.bpf.o";
+	if (CHECK_FAIL(pclose(tc)))
+		return false;
 
 	/* Move to a new networking namespace */
 	if (CHECK_FAIL(unshare(CLONE_NEWNET)))
@@ -46,8 +62,8 @@ configure_stack(void)
 	/* Load qdisc, BPF program */
 	if (CHECK_FAIL(system("tc qdisc add dev lo clsact")))
 		return false;
-	sprintf(tc_cmd, "%s %s %s %s", "tc filter add dev lo ingress bpf",
-		       "direct-action object-file ./test_sk_assign.bpf.o",
+	sprintf(tc_cmd, "%s %s %s %s %s", "tc filter add dev lo ingress bpf",
+		       "direct-action object-file", prog,
 		       "section tc",
 		       (env.verbosity < VERBOSE_VERY) ? " 2>/dev/null" : "verbose");
 	if (CHECK(system(tc_cmd), "BPF load failed;",
@@ -129,15 +145,12 @@ get_port(int fd)
 static ssize_t
 rcv_msg(int srv_client, int type)
 {
-	struct sockaddr_storage ss;
 	char buf[BUFSIZ];
-	socklen_t slen;
 
 	if (type == SOCK_STREAM)
 		return read(srv_client, &buf, sizeof(buf));
 	else
-		return recvfrom(srv_client, &buf, sizeof(buf), 0,
-				(struct sockaddr *)&ss, &slen);
+		return recvfrom(srv_client, &buf, sizeof(buf), 0, NULL, NULL);
 }
 
 static int
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
index 98c6493d9b91..21b19b758c4e 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
@@ -16,6 +16,16 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#if defined(IPROUTE2_HAVE_LIBBPF)
+/* Use a new-style map definition. */
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__type(key, int);
+	__type(value, __u64);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+	__uint(max_entries, 1);
+} server_map SEC(".maps");
+#else
 /* Pin map under /sys/fs/bpf/tc/globals/<map name> */
 #define PIN_GLOBAL_NS 2
 
@@ -35,6 +45,7 @@ struct {
 	.max_elem = 1,
 	.pinning = PIN_GLOBAL_NS,
 };
+#endif
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c b/tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c
new file mode 100644
index 000000000000..dcf46adfda04
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+#define IPROUTE2_HAVE_LIBBPF
+#include "test_sk_assign.c"
-- 
2.41.0

