Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1BC79B677
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbjIKWPm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbjIKOhK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:37:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FF0F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:37:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E282C433C7;
        Mon, 11 Sep 2023 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443025;
        bh=6d0JIFcC4NvrdsCX+qk08MnG/gSIev14sdN+a6NWO4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ly3RDzgcIfnQSBP2OhHzFU2xIrnoY2U5jFq0Px51rqGZKsPp7U1f79EPiYIsg0oS4
         m7Gtkbz5Plr9xL4qlMXbAJ6B9A1+qERYBIXqF0x1LFnuPNWYYm9OIQ4U8NlkFIxmRj
         f0nZX4rpdeH2gLXozx1lAh9spvm1/VVmnNKyxPek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Daniel T. Lee" <danieltimlee@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 231/737] samples/bpf: fix broken map lookup probe
Date:   Mon, 11 Sep 2023 15:41:30 +0200
Message-ID: <20230911134657.031563406@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel T. Lee <danieltimlee@gmail.com>

[ Upstream commit d93a7cf6ca2cfcd7de5d06f753ce8d5e863316ac ]

In the commit 7c4cd051add3 ("bpf: Fix syscall's stackmap lookup
potential deadlock"), a potential deadlock issue was addressed, which
resulted in *_map_lookup_elem not triggering BPF programs.
(prior to lookup, bpf_disable_instrumentation() is used)

To resolve the broken map lookup probe using "htab_map_lookup_elem",
this commit introduces an alternative approach. Instead, it utilize
"bpf_map_copy_value" and apply a filter specifically for the hash table
with map_type.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
Fixes: 7c4cd051add3 ("bpf: Fix syscall's stackmap lookup potential deadlock")
Link: https://lore.kernel.org/r/20230818090119.477441-8-danieltimlee@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/tracex6_kern.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/tracex6_kern.c b/samples/bpf/tracex6_kern.c
index acad5712d8b4f..fd602c2774b8b 100644
--- a/samples/bpf/tracex6_kern.c
+++ b/samples/bpf/tracex6_kern.c
@@ -2,6 +2,8 @@
 #include <linux/version.h>
 #include <uapi/linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -45,13 +47,24 @@ int bpf_prog1(struct pt_regs *ctx)
 	return 0;
 }
 
-SEC("kprobe/htab_map_lookup_elem")
-int bpf_prog2(struct pt_regs *ctx)
+/*
+ * Since *_map_lookup_elem can't be expected to trigger bpf programs
+ * due to potential deadlocks (bpf_disable_instrumentation), this bpf
+ * program will be attached to bpf_map_copy_value (which is called
+ * from map_lookup_elem) and will only filter the hashtable type.
+ */
+SEC("kprobe/bpf_map_copy_value")
+int BPF_KPROBE(bpf_prog2, struct bpf_map *map)
 {
 	u32 key = bpf_get_smp_processor_id();
 	struct bpf_perf_event_value *val, buf;
+	enum bpf_map_type type;
 	int error;
 
+	type = BPF_CORE_READ(map, map_type);
+	if (type != BPF_MAP_TYPE_HASH)
+		return 0;
+
 	error = bpf_perf_event_read_value(&counters, key, &buf, sizeof(buf));
 	if (error)
 		return 0;
-- 
2.40.1



