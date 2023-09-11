Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C5679C019
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjIKVRS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbjIKPFe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:05:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E9125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:05:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC400C433C9;
        Mon, 11 Sep 2023 15:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444730;
        bh=dozTN6aNcmZHmhWBpnSVBJKAZfX7HJ4KrR/TXvILNr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0PF5TK+mszHdutfkWH2/0EvYAsIPr+eoNuORyXCCycAfM+7zt+Sy4WrONqE8+R8fe
         r5uGKp5U0T6ScilNHoDUbQhKIEra3Fvry0an1jbyRp07yUwRy8RrPnG8HJ4eabknaN
         DdsaYFlUmdSDdkcRB1Fcm+IqVckKs8OfEl2k9Nv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.1 096/600] tools/resolve_btfids: Alter how HOSTCC is forced
Date:   Mon, 11 Sep 2023 15:42:09 +0200
Message-ID: <20230911134636.440791027@linuxfoundation.org>
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

commit 13e07691a16ff31b209fbfce25c01ff296b05e45 upstream.

HOSTCC is always wanted when building. Setting CC to HOSTCC happens
after tools/scripts/Makefile.include is included, meaning flags are
set assuming say CC is gcc, but then it can be later set to HOSTCC
which may be clang. tools/scripts/Makefile.include is needed for host
set up and common macros in objtool's Makefile. Rather than override
CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the libsubcmd
builds and the linkage step. This means the Makefiles don't see things
like CC changing and tool flag determination, and similar, work
properly.

Also, clear the passed subdir as otherwise an outer build may break by
inadvertently passing an inappropriate value.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20230124064324.672022-2-irogers@google.com
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/bpf/resolve_btfids/Makefile |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -18,14 +18,11 @@ else
 endif
 
 # always use the host compiler
-AR       = $(HOSTAR)
-CC       = $(HOSTCC)
-LD       = $(HOSTLD)
-ARCH     = $(HOSTARCH)
+HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
+		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
+
 RM      ?= rm
 CROSS_COMPILE =
-CFLAGS  := $(KBUILD_HOSTCFLAGS)
-LDFLAGS := $(KBUILD_HOSTLDFLAGS)
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
 
@@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_O
 
 $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
 	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
-		    DESTDIR=$(SUBCMD_DESTDIR) prefix= \
+		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
 		    $(abspath $@) install_headers
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
-		    DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
+		    DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
 		    $(abspath $@) install_headers
 
 LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
@@ -80,11 +77,11 @@ export srctree OUTPUT CFLAGS Q
 include $(srctree)/tools/build/Makefile.include
 
 $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
-	$(Q)$(MAKE) $(build)=resolve_btfids
+	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
 	$(call msg,LINK,$@)
-	$(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
+	$(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
 
 clean_objects := $(wildcard $(OUTPUT)/*.o                \
                             $(OUTPUT)/.*.o.cmd           \


