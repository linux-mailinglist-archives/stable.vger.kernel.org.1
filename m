Return-Path: <stable+bounces-177178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6536BB403FB
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1839188B224
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74AB324B3B;
	Tue,  2 Sep 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X6Od7VWJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A4830FC1F;
	Tue,  2 Sep 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819831; cv=none; b=uctayZzuxt0aaSnGelG4WPbj8G+DlI6l9IFQ4sih/3nR3xHH0hZZLPEwHs4yMQbyW/PJn+SaJpPn8KOI1Dl0YM3m6hnmkz9I9FbBvb1aIemF7OtVOkXO3SZSN/9SOhrHnIaRHRmZYZjBc14C9nxMX3MjpG0C132/8TnafP/8mAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819831; c=relaxed/simple;
	bh=qad/X1OGe2F8jM0B+ri5dDdxow1EJW9jwTC4tc1bECg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNm8gDCfwe9XX4+XLErDTxmQXVh/LnFkSSUVplWmbt2OWktFsoMXN73UsUC5Iw7WhnjE6uG4Q8NlX3G8igMSczw55Hzg1GsJJ767xTkVQHtlDV3hYEFy3WRXuN62UfS8S1hOj5InLV+j6Rd2WH8MlURwesLazG/rVjIRDFV0gzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X6Od7VWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5283C4CEF4;
	Tue,  2 Sep 2025 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819831;
	bh=qad/X1OGe2F8jM0B+ri5dDdxow1EJW9jwTC4tc1bECg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6Od7VWJZQCzv7PO/VNo+HipfDw+Bu7lts3HGrV4rxCFUY0ZkyXC6EumP7g22teCq
	 beg32jfcBmfbfz4xRx/Gr4hwU+vuCTx4D3tM73HVcNK01XuNYF4CoStPB6d/ZOg3u7
	 FE6QsPV9zneHBmg5Pqi/VpxEZ9y1ShYJoMfvQ9xQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 10/95] perf symbol-minimal: Fix ehdr reading in filename__read_build_id
Date: Tue,  2 Sep 2025 15:19:46 +0200
Message-ID: <20250902131940.010821977@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
References: <20250902131939.601201881@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit ba0b7081f7a521d7c28b527a4f18666a148471e7 ]

The e_ident is part of the ehdr and so reading it a second time would
mean the read ehdr was displaced by 16-bytes. Switch from stdio to
open/read/lseek syscalls for similarity with the symbol-elf version of
the function and so that later changes can alter then open flags.

Fixes: fef8f648bb47 ("perf symbol: Fix use-after-free in filename__read_build_id")
Signed-off-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20250823000024.724394-2-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/symbol-minimal.c | 55 ++++++++++++++++----------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 36c1d3090689f..f114f75ebeb98 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -4,7 +4,6 @@
 
 #include <errno.h>
 #include <unistd.h>
-#include <stdio.h>
 #include <fcntl.h>
 #include <string.h>
 #include <stdlib.h>
@@ -88,11 +87,8 @@ int filename__read_debuglink(const char *filename __maybe_unused,
  */
 int filename__read_build_id(const char *filename, struct build_id *bid)
 {
-	FILE *fp;
-	int ret = -1;
+	int fd, ret = -1;
 	bool need_swap = false, elf32;
-	u8 e_ident[EI_NIDENT];
-	int i;
 	union {
 		struct {
 			Elf32_Ehdr ehdr32;
@@ -103,28 +99,27 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			Elf64_Phdr *phdr64;
 		};
 	} hdrs;
-	void *phdr;
-	size_t phdr_size;
-	void *buf = NULL;
-	size_t buf_size = 0;
+	void *phdr, *buf = NULL;
+	ssize_t phdr_size, ehdr_size, buf_size = 0;
 
-	fp = fopen(filename, "r");
-	if (fp == NULL)
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
 		return -1;
 
-	if (fread(e_ident, sizeof(e_ident), 1, fp) != 1)
+	if (read(fd, hdrs.ehdr32.e_ident, EI_NIDENT) != EI_NIDENT)
 		goto out;
 
-	if (memcmp(e_ident, ELFMAG, SELFMAG) ||
-	    e_ident[EI_VERSION] != EV_CURRENT)
+	if (memcmp(hdrs.ehdr32.e_ident, ELFMAG, SELFMAG) ||
+	    hdrs.ehdr32.e_ident[EI_VERSION] != EV_CURRENT)
 		goto out;
 
-	need_swap = check_need_swap(e_ident[EI_DATA]);
-	elf32 = e_ident[EI_CLASS] == ELFCLASS32;
+	need_swap = check_need_swap(hdrs.ehdr32.e_ident[EI_DATA]);
+	elf32 = hdrs.ehdr32.e_ident[EI_CLASS] == ELFCLASS32;
+	ehdr_size = (elf32 ? sizeof(hdrs.ehdr32) : sizeof(hdrs.ehdr64)) - EI_NIDENT;
 
-	if (fread(elf32 ? (void *)&hdrs.ehdr32 : (void *)&hdrs.ehdr64,
-		  elf32 ? sizeof(hdrs.ehdr32) : sizeof(hdrs.ehdr64),
-		  1, fp) != 1)
+	if (read(fd,
+		 (elf32 ? (void *)&hdrs.ehdr32 : (void *)&hdrs.ehdr64) + EI_NIDENT,
+		 ehdr_size) != ehdr_size)
 		goto out;
 
 	if (need_swap) {
@@ -138,14 +133,18 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			hdrs.ehdr64.e_phnum = bswap_16(hdrs.ehdr64.e_phnum);
 		}
 	}
-	phdr_size = elf32 ? hdrs.ehdr32.e_phentsize * hdrs.ehdr32.e_phnum
-			  : hdrs.ehdr64.e_phentsize * hdrs.ehdr64.e_phnum;
+	if ((elf32 && hdrs.ehdr32.e_phentsize != sizeof(Elf32_Phdr)) ||
+	    (!elf32 && hdrs.ehdr64.e_phentsize != sizeof(Elf64_Phdr)))
+		goto out;
+
+	phdr_size = elf32 ? sizeof(Elf32_Phdr) * hdrs.ehdr32.e_phnum
+			  : sizeof(Elf64_Phdr) * hdrs.ehdr64.e_phnum;
 	phdr = malloc(phdr_size);
 	if (phdr == NULL)
 		goto out;
 
-	fseek(fp, elf32 ? hdrs.ehdr32.e_phoff : hdrs.ehdr64.e_phoff, SEEK_SET);
-	if (fread(phdr, phdr_size, 1, fp) != 1)
+	lseek(fd, elf32 ? hdrs.ehdr32.e_phoff : hdrs.ehdr64.e_phoff, SEEK_SET);
+	if (read(fd, phdr, phdr_size) != phdr_size)
 		goto out_free;
 
 	if (elf32)
@@ -153,8 +152,8 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	else
 		hdrs.phdr64 = phdr;
 
-	for (i = 0; i < elf32 ? hdrs.ehdr32.e_phnum : hdrs.ehdr64.e_phnum; i++) {
-		size_t p_filesz;
+	for (int i = 0; i < (elf32 ? hdrs.ehdr32.e_phnum : hdrs.ehdr64.e_phnum); i++) {
+		ssize_t p_filesz;
 
 		if (need_swap) {
 			if (elf32) {
@@ -180,8 +179,8 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 				goto out_free;
 			buf = tmp;
 		}
-		fseek(fp, elf32 ? hdrs.phdr32[i].p_offset : hdrs.phdr64[i].p_offset, SEEK_SET);
-		if (fread(buf, p_filesz, 1, fp) != 1)
+		lseek(fd, elf32 ? hdrs.phdr32[i].p_offset : hdrs.phdr64[i].p_offset, SEEK_SET);
+		if (read(fd, buf, p_filesz) != p_filesz)
 			goto out_free;
 
 		ret = read_build_id(buf, p_filesz, bid, need_swap);
@@ -194,7 +193,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	free(buf);
 	free(phdr);
 out:
-	fclose(fp);
+	close(fd);
 	return ret;
 }
 
-- 
2.50.1




