Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43ED79BE0C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbjIKVNc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbjIKPF3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:05:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA39125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:05:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3066EC433CA;
        Mon, 11 Sep 2023 15:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444724;
        bh=KTe6XUlOxy3mYQvleNBaw/jhQicexNNR0UGLG/P4WHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQ4ufM9olH0iqVK48gtyYmD9hm4kE8Z/Fi4C4fqHFB612aHc9Osa3XPc6D7B9d5e3
         3gpRT2ihTo+FRZRro2aqlVjLamAqxC6fxo1965Cj6IJzqIn3Hq6GWFA/IiuXyZB/Qo
         xoa0UMJdB7+0CfOkbmq4ssu7K3mImbN1z2L++xB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shen Jiamin <shen_jiamin@comp.nus.edu.sg>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.1 094/600] tools/resolve_btfids: Use pkg-config to locate libelf
Date:   Mon, 11 Sep 2023 15:42:07 +0200
Message-ID: <20230911134636.382707711@linuxfoundation.org>
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

From: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>

commit 0e43662e61f2569500ab83b8188c065603530785 upstream.

When libelf was not installed in the standard location, it cannot be
located by the current building config.

Use pkg-config to help locate libelf in such cases.

Signed-off-by: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20221215044703.400139-1-shen_jiamin@comp.nus.edu.sg
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/bpf/resolve_btfids/Makefile |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -56,13 +56,17 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[c
 		    DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
 		    $(abspath $@) install_headers
 
+LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
+LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
+
 CFLAGS += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
-          -I$(SUBCMD_SRC)
+          -I$(SUBCMD_SRC) \
+          $(LIBELF_FLAGS)
 
-LIBS = -lelf -lz
+LIBS = $(LIBELF_LIBS) -lz
 
 export srctree OUTPUT CFLAGS Q
 include $(srctree)/tools/build/Makefile.include


