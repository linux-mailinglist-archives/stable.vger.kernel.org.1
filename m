Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10457554EB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjGPUfZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjGPUfX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8FD1BF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E59C60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9D5C433C9;
        Sun, 16 Jul 2023 20:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539720;
        bh=bRgny+4ViXIMQcE84GK7DZDKpjLAjh73tXHqXFr7rV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ywk3m4mbI9F3DBfVBEuGa/+o3VsS9mhOq3JFe6B5Vs7DibvFtAFoQRd8v1/JTfGcA
         EF9AaGgZmcgKp0CKn9bAAww8WC9g+/DPfUAsc7PQdO6knI/1vu3WIk69YrkLl8lgt+
         NAy1GcHGm/unFNcmynzBT3F9br5C8KFPizGZ8L08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nicky Veitch <nicky.veitch@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 080/591] bpftool: JIT limited misreported as negative value on aarch64
Date:   Sun, 16 Jul 2023 21:43:39 +0200
Message-ID: <20230716194925.952615615@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alan Maguire <alan.maguire@oracle.com>

[ Upstream commit 04cb8453a91c7c22f60ddadb6cef0d19abb33bb5 ]

On aarch64, "bpftool feature" reports an incorrect BPF JIT limit:

$ sudo /sbin/bpftool feature
Scanning system configuration...
bpf() syscall restricted to privileged users
JIT compiler is enabled
JIT compiler hardening is disabled
JIT compiler kallsyms exports are enabled for root
skipping kernel config, can't open file: No such file or directory
Global memory limit for JIT compiler for unprivileged users is -201326592 bytes

This is because /proc/sys/net/core/bpf_jit_limit reports

$ sudo cat /proc/sys/net/core/bpf_jit_limit
68169519595520

...and an int is assumed in read_procfs().  Change read_procfs()
to return a long to avoid negative value reporting.

Fixes: 7a4522bbef0c ("tools: bpftool: add probes for /proc/ eBPF parameters")
Reported-by: Nicky Veitch <nicky.veitch@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Quentin Monnet <quentin@isovalent.com>
Link: https://lore.kernel.org/bpf/20230512113134.58996-1-alan.maguire@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/feature.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 36cf0f1517c94..4460399bc8ed8 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -167,12 +167,12 @@ static int get_vendor_id(int ifindex)
 	return strtol(buf, NULL, 0);
 }
 
-static int read_procfs(const char *path)
+static long read_procfs(const char *path)
 {
 	char *endptr, *line = NULL;
 	size_t len = 0;
 	FILE *fd;
-	int res;
+	long res;
 
 	fd = fopen(path, "r");
 	if (!fd)
@@ -194,7 +194,7 @@ static int read_procfs(const char *path)
 
 static void probe_unprivileged_disabled(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -216,14 +216,14 @@ static void probe_unprivileged_disabled(void)
 			printf("Unable to retrieve required privileges for bpf() syscall\n");
 			break;
 		default:
-			printf("bpf() syscall restriction has unknown value %d\n", res);
+			printf("bpf() syscall restriction has unknown value %ld\n", res);
 		}
 	}
 }
 
 static void probe_jit_enable(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -245,7 +245,7 @@ static void probe_jit_enable(void)
 			printf("Unable to retrieve JIT-compiler status\n");
 			break;
 		default:
-			printf("JIT-compiler status has unknown value %d\n",
+			printf("JIT-compiler status has unknown value %ld\n",
 			       res);
 		}
 	}
@@ -253,7 +253,7 @@ static void probe_jit_enable(void)
 
 static void probe_jit_harden(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -275,7 +275,7 @@ static void probe_jit_harden(void)
 			printf("Unable to retrieve JIT hardening status\n");
 			break;
 		default:
-			printf("JIT hardening status has unknown value %d\n",
+			printf("JIT hardening status has unknown value %ld\n",
 			       res);
 		}
 	}
@@ -283,7 +283,7 @@ static void probe_jit_harden(void)
 
 static void probe_jit_kallsyms(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -302,14 +302,14 @@ static void probe_jit_kallsyms(void)
 			printf("Unable to retrieve JIT kallsyms export status\n");
 			break;
 		default:
-			printf("JIT kallsyms exports status has unknown value %d\n", res);
+			printf("JIT kallsyms exports status has unknown value %ld\n", res);
 		}
 	}
 }
 
 static void probe_jit_limit(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -322,7 +322,7 @@ static void probe_jit_limit(void)
 			printf("Unable to retrieve global memory limit for JIT compiler for unprivileged users\n");
 			break;
 		default:
-			printf("Global memory limit for JIT compiler for unprivileged users is %d bytes\n", res);
+			printf("Global memory limit for JIT compiler for unprivileged users is %ld bytes\n", res);
 		}
 	}
 }
-- 
2.39.2



