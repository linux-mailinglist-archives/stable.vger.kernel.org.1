Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA487A3A82
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbjIQUFX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240389AbjIQUE6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:04:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7D2103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:04:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C06BC433C7;
        Sun, 17 Sep 2023 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981092;
        bh=qMCxQ14k/IGveMaeE2VHGgEW7dLCvYKizKaXgik4b9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlWND2zQmTUdrxvraolz2ZkbDhNgtznvV18N4bjuHsnbm0/T4K4WvFgJqqU4vWMJ2
         r7DWXIYxHXPRKwMYPFx6XSa8a1K8G8ACOsN2w7l6v4pVd97548VkQ8F2LYdDUbGO98
         55HQ1/4n8Pg+NFVdB1C5btJamFyEmDFZjkSPxpf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mohamed Mahmoud <mmahmoud@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Tucker <datucker@redhat.com>,
        Derek Barbosa <debarbos@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 072/219] perf annotate bpf: Dont enclose non-debug code with an assert()
Date:   Sun, 17 Sep 2023 21:13:19 +0200
Message-ID: <20230917191043.600205405@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 979e9c9fc9c2a761303585e07fe2699bdd88182f ]

In 616b14b47a86d880 ("perf build: Conditionally define NDEBUG") we
started using NDEBUG=1 when DEBUG=1 isn't present, so code that is
enclosed with assert() is not called.

In dd317df072071903 ("perf build: Make binutil libraries opt in") we
stopped linking against binutils-devel, for licensing reasons.

Recently people asked me why annotation of BPF programs wasn't working,
i.e. this:

  $ perf annotate bpf_prog_5280546344e3f45c_kfree_skb

was returning:

  case SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF:
     scnprintf(buf, buflen, "Please link with binutils's libopcode to enable BPF annotation");

This was on a fedora rpm, so its new enough that I had to try to test by
rebuilding using BUILD_NONDISTRO=1, only to get it segfaulting on me.

This combination made this libopcode function not to be called:

        assert(bfd_check_format(bfdf, bfd_object));

Changing it to:

	if (!bfd_check_format(bfdf, bfd_object))
		abort();

Made it work, looking at this "check" function made me realize it
changes the 'bfdf' internal state, i.e. we better call it.

So stop using assert() on it, just call it and abort if it fails.

Probably it is better to propagate the error, etc, but it seems it is
unlikely to fail from the usage done so far and we really need to stop
using libopcodes, so do the quick fix above and move on.

With it we have BPF annotation back working when built with
BUILD_NONDISTRO=1:

  ⬢[acme@toolbox perf-tools-next]$ perf annotate --stdio2 bpf_prog_5280546344e3f45c_kfree_skb   | head
  No kallsyms or vmlinux with build-id 939bc71a1a51cdc434e60af93c7e734f7d5c0e7e was found
  Samples: 12  of event 'cpu-clock:ppp', 4000 Hz, Event count (approx.): 3000000, [percent: local period]
  bpf_prog_5280546344e3f45c_kfree_skb() bpf_prog_5280546344e3f45c_kfree_skb
  Percent      int kfree_skb(struct trace_event_raw_kfree_skb *args) {
                 nop
   33.33         xchg   %ax,%ax
                 push   %rbp
                 mov    %rsp,%rbp
                 sub    $0x180,%rsp
                 push   %rbx
                 push   %r13
  ⬢[acme@toolbox perf-tools-next]$

Fixes: 6987561c9e86eace ("perf annotate: Enable annotation of BPF programs")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mohamed Mahmoud <mmahmoud@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Dave Tucker <datucker@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/lkml/ZMrMzoQBe0yqMek1@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index db475e44f42fa..a9122ea3b44c4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1756,8 +1756,11 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	perf_exe(tpath, sizeof(tpath));
 
 	bfdf = bfd_openr(tpath, NULL);
-	assert(bfdf);
-	assert(bfd_check_format(bfdf, bfd_object));
+	if (bfdf == NULL)
+		abort();
+
+	if (!bfd_check_format(bfdf, bfd_object))
+		abort();
 
 	s = open_memstream(&buf, &buf_size);
 	if (!s) {
@@ -1805,7 +1808,8 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 #else
 	disassemble = disassembler(bfdf);
 #endif
-	assert(disassemble);
+	if (disassemble == NULL)
+		abort();
 
 	fflush(s);
 	do {
-- 
2.40.1



