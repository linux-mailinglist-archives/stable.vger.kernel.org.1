Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09779BA68
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358117AbjIKWHu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbjIKPFX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:05:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F35E125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:05:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49204C433C9;
        Mon, 11 Sep 2023 15:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444718;
        bh=MwUaGA0zpRLLSvCRZnUUjtrtvlIIkG6Hc3bf8Nk7H+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ent+3uZsKWULCMOm4es7nkng1KulM10irxc7bxn67LdLBTtwndI3qrqUv8Pc3wvwu
         ZKnfrZpJz9PSIM15mXSLvxeKnE0oYtCB6XV6oRbwGJCV0RqoTp6J7UfTYSYqpJ+PAp
         IG7w1GzZGK5E/Aim7LlMIa4QemNyOppLvJaTLb0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Stephane Eranian <eranian@google.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.1 092/600] tools lib subcmd: Make install_headers clearer
Date:   Mon, 11 Sep 2023 15:42:05 +0200
Message-ID: <20230911134636.324469928@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

commit 77dce6890a2a715b186bdc149c843571a5bb47df upstream.

Add libsubcmd to the name so that this install_headers build appears
different to similar targets in different libraries.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Hao Luo <haoluo@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20221117004356.279422-6-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/subcmd/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -101,7 +101,7 @@ install_lib: $(LIBFILE)
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
 install_headers:
-	$(call QUIET_INSTALL, headers) \
+	$(call QUIET_INSTALL, libsubcmd_headers) \
 		$(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644); \
 		$(call do_install,help.h,$(prefix)/include/subcmd,644); \
 		$(call do_install,pager.h,$(prefix)/include/subcmd,644); \


