Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FFA79B2D7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjIKUv4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbjIKPFc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:05:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF96125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:05:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12965C433C7;
        Mon, 11 Sep 2023 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444727;
        bh=3gc4see7GF1oAWamXa1PPC6YsiVsMBC58wf/u0bJP2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9ev5rlnTxdkQqnpAlKl1ocOHE7ZJlBNqgED2NK5jMrDWLJ+uesVNTnqVnlJHx+94
         Vwdost15dm+WHT2RxAp+c9WyusbKXTFqS35I1WRk4vIqNA/U9CO6NXlUQg8RguM0JX
         KtRIfT5g5AJLScqSfkC+abwDs5uAkJfVJdnW1D88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.1 095/600] tools/resolve_btfids: Install subcmd headers
Date:   Mon, 11 Sep 2023 15:42:08 +0200
Message-ID: <20230911134636.412692881@linuxfoundation.org>
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

commit af03299d8536d62b49c7f3cb929349eb2d66bcd5 upstream.

Previously tools/lib/subcmd was added to the include path, switch to
installing the headers and then including from that directory. This
avoids dependencies on headers internal to tools/lib/subcmd. Add the
missing subcmd directory to the affected #include.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20230124064324.672022-1-irogers@google.com
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/bpf/resolve_btfids/Makefile |   19 ++++++++++++++-----
 tools/bpf/resolve_btfids/main.c   |    2 +-
 2 files changed, 15 insertions(+), 6 deletions(-)

--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -35,21 +35,29 @@ SUBCMD_SRC := $(srctree)/tools/lib/subcm
 BPFOBJ     := $(OUTPUT)/libbpf/libbpf.a
 LIBBPF_OUT := $(abspath $(dir $(BPFOBJ)))/
 SUBCMDOBJ  := $(OUTPUT)/libsubcmd/libsubcmd.a
+SUBCMD_OUT := $(abspath $(dir $(SUBCMDOBJ)))/
 
 LIBBPF_DESTDIR := $(LIBBPF_OUT)
 LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
 
+SUBCMD_DESTDIR := $(SUBCMD_OUT)
+SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
+
 BINARY     := $(OUTPUT)/resolve_btfids
 BINARY_IN  := $(BINARY)-in.o
 
 all: $(BINARY)
 
+prepare: $(BPFOBJ) $(SUBCMDOBJ)
+
 $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
 	$(call msg,MKDIR,,$@)
 	$(Q)mkdir -p $(@)
 
 $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
-	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
+	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
+		    DESTDIR=$(SUBCMD_DESTDIR) prefix= \
+		    $(abspath $@) install_headers
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
@@ -63,7 +71,7 @@ CFLAGS += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
-          -I$(SUBCMD_SRC) \
+          -I$(SUBCMD_INCLUDE) \
           $(LIBELF_FLAGS)
 
 LIBS = $(LIBELF_LIBS) -lz
@@ -71,7 +79,7 @@ LIBS = $(LIBELF_LIBS) -lz
 export srctree OUTPUT CFLAGS Q
 include $(srctree)/tools/build/Makefile.include
 
-$(BINARY_IN): $(BPFOBJ) fixdep FORCE | $(OUTPUT)
+$(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
 	$(Q)$(MAKE) $(build)=resolve_btfids
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
@@ -83,7 +91,8 @@ clean_objects := $(wildcard $(OUTPUT)/*.
                             $(OUTPUT)/.*.o.d             \
                             $(LIBBPF_OUT)                \
                             $(LIBBPF_DESTDIR)            \
-                            $(OUTPUT)/libsubcmd          \
+                            $(SUBCMD_OUT)                \
+                            $(SUBCMD_DESTDIR)            \
                             $(OUTPUT)/resolve_btfids)
 
 ifneq ($(clean_objects),)
@@ -100,4 +109,4 @@ tags:
 
 FORCE:
 
-.PHONY: all FORCE clean tags
+.PHONY: all FORCE clean tags prepare
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -75,7 +75,7 @@
 #include <linux/err.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
-#include <parse-options.h>
+#include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
 #define BTF_ID		"__BTF_ID__"


