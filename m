Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012C97553D2
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGPUXW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGPUXV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:23:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B69F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E35A60EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B39C433C8;
        Sun, 16 Jul 2023 20:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538999;
        bh=h2DqHnEYLipCEUriIhS7YVQK7VOmNl8Us9VrKPHhJNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ws7TTyhKV1+9txhmI4yHWH5lKvDBL1EOq4rj0CXO6GClNbOaxRIO6l4QE3oNyo4+C
         wKU5eYFkNxJA+aiUrMIjYBrWwRbSi6xLCLxkm7nCmwbJQ+gTLz8DeyditILND9mVx1
         aO4lhjUBr59LwtATRYhzS1EDSQ4704ht2H8eKrF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ingo Molnar <mingo@redhat.com>, bpf@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 651/800] perf bpf: Move the declaration of struct rq
Date:   Sun, 16 Jul 2023 21:48:24 +0200
Message-ID: <20230716195004.234781377@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Ian Rogers <irogers@google.com>

[ Upstream commit 5c45b210479bffe068d38902fcdcb52c4c60a264 ]

struct rq is defined in vmlinux.h when the vmlinux.h is generated,
this causes a redefinition failure if it is declared in
lock_contention.bpf.c. Move the definition to vmlinux.h for
consistency with the generated version.

Fixes: 760ebc45746b ("perf lock contention: Add empty 'struct rq' to satisfy libbpf 'runqueue' type verification")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: James Clark <james.clark@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Yang Jihong <yangjihong1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20230623041405.4039475-3-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c |  2 --
 tools/perf/util/bpf_skel/vmlinux.h             | 10 ++++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 1d48226ae75d4..8d3cfbb3cc65b 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -416,8 +416,6 @@ int contention_end(u64 *ctx)
 	return 0;
 }
 
-struct rq {};
-
 extern struct rq runqueues __ksym;
 
 struct rq___old {
diff --git a/tools/perf/util/bpf_skel/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux.h
index c7ed51b0c1ef9..ab84a6e1da5ee 100644
--- a/tools/perf/util/bpf_skel/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux.h
@@ -171,4 +171,14 @@ struct bpf_perf_event_data_kern {
 	struct perf_sample_data *data;
 	struct perf_event	*event;
 } __attribute__((preserve_access_index));
+
+/*
+ * If 'struct rq' isn't defined for lock_contention.bpf.c, for the sake of
+ * rq___old and rq___new, then the type for the 'runqueue' variable ends up
+ * being a forward declaration (BTF_KIND_FWD) while the kernel has it defined
+ * (BTF_KIND_STRUCT). The definition appears in vmlinux.h rather than
+ * lock_contention.bpf.c for consistency with a generated vmlinux.h.
+ */
+struct rq {};
+
 #endif // __VMLINUX_H
-- 
2.39.2



