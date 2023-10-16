Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E467CA215
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjJPIpr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJPIpq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:45:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA95A1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:45:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40986C433C7;
        Mon, 16 Oct 2023 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445943;
        bh=Pp3Y0FnLckvBzveMfajO0zi/VguKIBimVVHQwaLCwFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TKc822TDgpva1dqexEfP+bhr2rlWEaQMbHxRGUaHM/peTGKrj7M6t6/ofyG43qrfa
         fmwnUeJ9cv0KFGoCSi0VrlzoMzyirtYtwscXBci90gI8lL1nppq0fd8nxAvROAyLD3
         j2vKyoWTTT0v0Tqp560E2Xm/8/Xn810gzxbX/+a4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lieven Hey <lieven.hey@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 042/102] perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
Date:   Mon, 16 Oct 2023 10:40:41 +0200
Message-ID: <20231016083954.821877131@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 89b15d00527b7825ff19130ed83478e80e3fae99 ]

When a program header was added, it moved the text section but
GEN_ELF_TEXT_OFFSET was not updated.

Fix by adding the program header size and aligning.

Fixes: babd04386b1df8c3 ("perf jit: Include program header in ELF files")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Lieven Hey <lieven.hey@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20221014170905.64069-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/genelf.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index ac638945b4cb0..159c69bcc33e6 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -2,6 +2,8 @@
 #ifndef __GENELF_H__
 #define __GENELF_H__
 
+#include <linux/math.h>
+
 /* genelf.c */
 int jit_write_elf(int fd, uint64_t code_addr, const char *sym,
 		  const void *code, int csize, void *debug, int nr_debug_entries,
@@ -73,6 +75,6 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #endif
 
 /* The .text section is directly after the ELF header */
-#define GEN_ELF_TEXT_OFFSET sizeof(Elf_Ehdr)
+#define GEN_ELF_TEXT_OFFSET round_up(sizeof(Elf_Ehdr) + sizeof(Elf_Phdr), 16)
 
 #endif
-- 
2.40.1



