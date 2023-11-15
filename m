Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693467ECD21
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjKOTed (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjKOTec (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:34:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2533130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3DCC433C8;
        Wed, 15 Nov 2023 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076868;
        bh=bd54vJAWIuvyBxkY1mStIPBFz8eyz4dmKwNYdJ7n5zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMVARLg3E8kUvpj5UxrQlxengcXlNHALe0iQ/RZDQ48slPeTZQo9C9L+x1mG7t9pJ
         uWjGUjD6lvEhFaJBDhtLu5mYkgBP5mwEzSEW91U18jx0lCvXZRbHzu+/2man50z35V
         yTbHrkAfLFdOhpTq4AIgmz7+nmoIWSyaVQBrmA6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 424/550] perf build: Add missing comment about NO_LIBTRACEEVENT=1
Date:   Wed, 15 Nov 2023 14:16:48 -0500
Message-ID: <20231115191630.149949188@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit c1783ddfb62420c44cdf4672dad2046f056c624b ]

By default perf will fail the build if the development files for
libtraceevent are not available.

To build perf without libtraceevent support, disabling several features
such as 'perf trace', one needs to add NO_LIBTRACEVENT=1 to the make
command line.

Add the missing comments about that to the tools/perf/Makefile.perf
file, just like all the other such command line toggles.

Fixes: 378ef0f5d9d7f465 ("perf build: Use libtraceevent from the system")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/ZR6+MhXtLnv6ow6E@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.perf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f178b36c69402..997b9387ab273 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -69,6 +69,10 @@ include ../scripts/utilities.mak
 # Define NO_LIBDW_DWARF_UNWIND if you do not want libdw support
 # for dwarf backtrace post unwind.
 #
+# Define NO_LIBTRACEEVENT=1 if you don't want libtraceevent to be linked,
+# this will remove multiple features and tools, such as 'perf trace',
+# that need it to read tracefs event format files, etc.
+#
 # Define NO_PERF_READ_VDSO32 if you do not want to build perf-read-vdso32
 # for reading the 32-bit compatibility VDSO in 64-bit mode
 #
-- 
2.42.0



