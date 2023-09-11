Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386A879BA94
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376667AbjIKWUL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbjIKPF0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:05:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DECA125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:05:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF5BC433C9;
        Mon, 11 Sep 2023 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444721;
        bh=ZW+Q1JOHZ/uDaaroiW9oP5TW2ELU1qx2psiVBuG2scQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFzQEkS/HF0zKqCIdwlTu/T50chShWZjHXyfSt98Ubj9+pA7qH3pSyZTkFsn3dGV5
         fMtUR9T59JoSLujFOQa8PBxN3pPjBlgglscoA7eG+apOR4tABcbix4QKW01y3nwvlV
         jSETHIRks23rdXqmTQCMcAjCCBDYHV4BTIVJohe8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        llvm@lists.linux.dev, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1 093/600] tools lib subcmd: Add dependency test to install_headers
Date:   Mon, 11 Sep 2023 15:42:06 +0200
Message-ID: <20230911134636.353908314@linuxfoundation.org>
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

commit 5d890591db6bed8ca69bd4bfe0cdaca372973033 upstream.

Compute the headers to be installed from their source headers and make
each have its own build target to install it. Using dependencies
avoids headers being reinstalled and getting a new timestamp which
then causes files that depend on the header to be rebuilt.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: bpf@vger.kernel.org
Cc: llvm@lists.linux.dev
Link: https://lore.kernel.org/r/20221202045743.2639466-4-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/subcmd/Makefile |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -89,10 +89,10 @@ define do_install_mkdir
 endef
 
 define do_install
-	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	if [ ! -d '$2' ]; then             \
+		$(INSTALL) -d -m 755 '$2'; \
 	fi;                                             \
-	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+	$(INSTALL) $1 $(if $3,-m $3,) '$2'
 endef
 
 install_lib: $(LIBFILE)
@@ -100,13 +100,16 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-install_headers:
-	$(call QUIET_INSTALL, libsubcmd_headers) \
-		$(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,help.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,pager.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,parse-options.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,run-command.h,$(prefix)/include/subcmd,644);
+HDRS := exec-cmd.h help.h pager.h parse-options.h run-command.h
+INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/subcmd
+INSTALL_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
+
+$(INSTALL_HDRS): $(INSTALL_HDRS_PFX)/%.h: %.h
+	$(call QUIET_INSTALL, $@) \
+		$(call do_install,$<,$(INSTALL_HDRS_PFX)/,644)
+
+install_headers: $(INSTALL_HDRS)
+	$(call QUIET_INSTALL, libsubcmd_headers)
 
 install: install_lib install_headers
 


