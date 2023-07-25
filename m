Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25577613D7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjGYLO1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjGYLOJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:14:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69312D7B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BCCA61683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7E0C433C9;
        Tue, 25 Jul 2023 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283596;
        bh=5KjnoObbHKoyc07/efBU47taV0h4TWQKIrEMvz8sGIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDL5S0OQ5ENUawj7NSgjCo6LqsJkzM9vO6tPlJjtC7OZNuzEa00Q1B2joht7gOE4r
         1m78dcYCKrnofx7/Hwe1/kQUmBQD6F9H5Px4CTruOOR7uhvBnbg1rZV+XaHbPDIFTG
         NAOg+kTRlXcOLY4Je2JgEdF7rKRFmx33po8bA+fA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nicky Veitch <nicky.veitch@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 053/509] bpftool: JIT limited misreported as negative value on aarch64
Date:   Tue, 25 Jul 2023 12:39:52 +0200
Message-ID: <20230725104556.104060289@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index 359960a8f1def..5f0b1397798ed 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -135,12 +135,12 @@ static void print_end_section(void)
 
 /* Probing functions */
 
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
@@ -162,7 +162,7 @@ static int read_procfs(const char *path)
 
 static void probe_unprivileged_disabled(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -181,14 +181,14 @@ static void probe_unprivileged_disabled(void)
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
 
@@ -210,7 +210,7 @@ static void probe_jit_enable(void)
 			printf("Unable to retrieve JIT-compiler status\n");
 			break;
 		default:
-			printf("JIT-compiler status has unknown value %d\n",
+			printf("JIT-compiler status has unknown value %ld\n",
 			       res);
 		}
 	}
@@ -218,7 +218,7 @@ static void probe_jit_enable(void)
 
 static void probe_jit_harden(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -240,7 +240,7 @@ static void probe_jit_harden(void)
 			printf("Unable to retrieve JIT hardening status\n");
 			break;
 		default:
-			printf("JIT hardening status has unknown value %d\n",
+			printf("JIT hardening status has unknown value %ld\n",
 			       res);
 		}
 	}
@@ -248,7 +248,7 @@ static void probe_jit_harden(void)
 
 static void probe_jit_kallsyms(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -267,14 +267,14 @@ static void probe_jit_kallsyms(void)
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
 
@@ -287,7 +287,7 @@ static void probe_jit_limit(void)
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



