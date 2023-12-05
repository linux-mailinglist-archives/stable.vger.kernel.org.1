Return-Path: <stable+bounces-4392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9F80474A
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E90281601
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE88BF1;
	Tue,  5 Dec 2023 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aqe+1xI2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE546FB1;
	Tue,  5 Dec 2023 03:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA90C433C8;
	Tue,  5 Dec 2023 03:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747419;
	bh=lSoKwKJ5X6oS3WjW/z1+RgMZexPzD6ydcfX27krHZQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqe+1xI2FuxTk/Pahi4CFnCfni//5WfnHohSAGG5B4qhKaS8E2LIwe6uh0WF3LLag
	 rALUGkZmUc/cDv8BgYQ46i9ZIH8MTdg9b2rqxmSn5JsBD9DipFxE9mujK1D/xbGHin
	 uQRem77mpZyko/20cHMViOlu5lPqAzFDaiCNLJvw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Lieven Hey <lieven.hey@kdab.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 5.10 070/135] perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
Date: Tue,  5 Dec 2023 12:16:31 +0900
Message-ID: <20231205031534.880575262@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 89b15d00527b7825ff19130ed83478e80e3fae99 upstream.

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
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/genelf.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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
@@ -73,6 +75,6 @@ int jit_add_debug_info(Elf *e, uint64_t
 #endif
 
 /* The .text section is directly after the ELF header */
-#define GEN_ELF_TEXT_OFFSET sizeof(Elf_Ehdr)
+#define GEN_ELF_TEXT_OFFSET round_up(sizeof(Elf_Ehdr) + sizeof(Elf_Phdr), 16)
 
 #endif



