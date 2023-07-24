Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBFA75F691
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 14:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjGXMmp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGXMmo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 08:42:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E0DD8
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 05:42:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98e39784a85so1139399266b.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690202561; x=1690807361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wg0YJZyk6Wqd1FXUAP8LR8DxVneW7g4dzYsaVQl4Hzo=;
        b=evjZalJQLWGSISiqs7v284AcVO5rQqBz1WKUnuNdZMgPqkmtk5Ui8OaeA15kQREp4D
         73Znoa60FW+93E1w+f8lP613f97fN90e/U8ntzLr28Fe1unPAk2PK9MobpbwCQOWzi6y
         D+lVoUj8YWyoyCeMo0LjcEJR29WH33vyCj/VKuO5LgHeJchQVpYXHbJVM+QFlJvhtK0+
         6JPnCd2dfnTW/4MVtEhdEqRMjICVv38bSmqoVY9NhLOyTyimDzMHGeK4q72pQKsStpqa
         SPmXwLXkysXqzE1klhm5b4W+rsabiJoZByNIfTOram9jNh+NBOcLi38xjRPmgTp0ONu6
         sXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690202561; x=1690807361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wg0YJZyk6Wqd1FXUAP8LR8DxVneW7g4dzYsaVQl4Hzo=;
        b=k+VtK8oYk9mAJYLfZh12hJ4dywaRPcyoR+jiZpIOUvh2+Ng742RMxWiQ2wMwFLC3v9
         vnKX6IKr7liAl1zWUF199VUAABhBbu+hIbbwjdNtCe5n4fRCutaTyYyqwNNVc+L0xZ73
         aGkhYVX6JctcvusEVb6a2iYXEG2AfaHk3fwbNvEc4IED8c8c9ammZQz0aQiKeSdXsqL+
         cvL2TeVz0bmTW63hEJXzMMr22TDa06GvpJJZgIXSfAGbQOlVKXfAx4JIIWslX21+1Hly
         WbPwo3NN2dVhFwHr+1QT/h5BY7XJKMNBV1uHcspofuOIWatqR2QCLd2sxIO030I8g6hs
         yRFw==
X-Gm-Message-State: ABy/qLZD7Tgv2u1cKROEVX4+ML0EHGrEGLWpZU4pjNV12tAjJxRhud3p
        D2+lENSaQhK/I7fxwy5EHtYDaRN0SKWZKw==
X-Google-Smtp-Source: APBJJlFqdrDI0zklSCOyMt95xQn5RVkbwcUPPYfCLlpY2bvil2p9YCUs2lsjzlZD05eE52QP3nCdXg==
X-Received: by 2002:a17:906:6a07:b0:99b:4b6d:f2bf with SMTP id qw7-20020a1709066a0700b0099b4b6df2bfmr14304879ejc.10.1690202560768;
        Mon, 24 Jul 2023 05:42:40 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709062b0600b0099297782aa9sm6628490ejg.49.2023.07.24.05.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 05:42:40 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     stable@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, mykolal@fb.com, luizcap@amazon.com,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.1.y v2 6/6] selftests/bpf: Fix sk_assign on s390x
Date:   Mon, 24 Jul 2023 15:42:23 +0300
Message-ID: <20230724124223.1176479-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724124223.1176479-1-eddyz87@gmail.com>
References: <20230724124223.1176479-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
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

