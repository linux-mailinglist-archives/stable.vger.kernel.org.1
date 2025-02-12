Return-Path: <stable+bounces-114996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 139E8A31D87
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 05:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68346188BA87
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 04:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165701E7C2D;
	Wed, 12 Feb 2025 04:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bynaYepH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690027183B
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739335476; cv=none; b=UlSUtkixIQS6PnIFWBArQz/GqRfbh7Be3i7lIXv2y6bPACIOIgdEZ0XRjQWtkI2vVQhgx3VmMD3CZqGVPh2VU9EkXkCG0YNCC7OmCrVtuwh1Y9KHT0UVVqoOyrMMCd+9FQx073JU3Vs5GD5YPzCHR4D7LeU/hzwAZJ5swlHQqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739335476; c=relaxed/simple;
	bh=csc3BasZu+34zhBMEegsmSSqnIa1G3ZjwDUmLwuxv5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAZ5mYHtxWnKei3AH/2gF/6kouSAJQ3zQPMKp278XZyGRfx3gtDAK0ekD4i3Mx7xMhr3egchkLVfMZW6VTLyFuDpFgiNJ2V+xXvPdg9nhJQWPe0cpBAhX8Zw3Gnl1XFEv78QvRN1ECnKEpR386eq2lIjEYz3ZZPHDcOlT9XbgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bynaYepH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739335475; x=1770871475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=csc3BasZu+34zhBMEegsmSSqnIa1G3ZjwDUmLwuxv5U=;
  b=bynaYepHcCtmkGM8Ckcxh7yK4oKJpPzIuZAXfxHT1klw59lvK7iaYApn
   Lg4tL3PEr4Lo8Koarvb5XKZj+Whs8DHiIYdFvgFk3EQpCUTH63eQa2c+K
   nRr+2jvew95mwxHJxMn/0+wKI0nRUcxpD7CnF76DDEhsBRxHfatu9wqSo
   pGj0uqOfzX0dYc7+ZeqfkzfH2uvgamrSJbltujgVG9Ud7OkBPRS/ILBp5
   491wLsx9xhn1oVxAdSCJZWYijEczgAsDt5jvoeQSiTph1xMyd6WMy6j6x
   KRo1ZXSO3EoGSrM3YIdIVZSiBsB/23f3E3gdYl+qQpYsRzXuhwjKnZltN
   w==;
X-CSE-ConnectionGUID: jbexIDeZR1iRg6J6sTQJmg==
X-CSE-MsgGUID: Yp8GIH83SHiTb2MOjErORA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39839749"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39839749"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 20:44:34 -0800
X-CSE-ConnectionGUID: w1UkAnMAT+i5ROxsDWz7Lg==
X-CSE-MsgGUID: PJeqaM7ERvaxExumbzXN1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112540116"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 20:44:33 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12.y] drm/xe: Fix and re-enable xe_print_blob_ascii85()
Date: Tue, 11 Feb 2025 20:44:10 -0800
Message-ID: <20250212044410.4114791-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025021018-attire-arrange-51d4@gregkh>
References: <2025021018-attire-arrange-51d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa
debug tool") partially reverted some changes to workaround breakage
caused to mesa tools. However, in doing so it also broke fetching the
GuC log via debugfs since xe_print_blob_ascii85() simply bails out.

The fix is to avoid the extra newlines: the devcoredump interface is
line-oriented and adding random newlines in the middle breaks it. If a
tool is able to parse it by looking at the data and checking for chars
that are out of the ascii85 space, it can still do so. A format change
that breaks the line-oriented output on devcoredump however needs better
coordination with existing tools.

v2: Add suffix description comment
v3: Reword explanation of xe_print_blob_ascii85() calling drm_puts()
    in a loop

Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Julia Filipchuk <julia.filipchuk@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: stable@vger.kernel.org
Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa debug tool")
Fixes: ec1455ce7e35 ("drm/xe/devcoredump: Add ASCII85 dump helper function")
Link: https://patchwork.freedesktop.org/patch/msgid/20250123202307.95103-2-jose.souza@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 2c95bbf5002776117a69caed3b31c10bf7341bec)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit a9ab6591b45258b79af1cb66112fd9f83c8855da)
[ Fix conflicts due to missing CTB handling and 2-phase GuC log dump ]
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 34 +++++++++++------------------
 drivers/gpu/drm/xe/xe_devcoredump.h |  2 +-
 drivers/gpu/drm/xe/xe_guc_log.c     |  2 +-
 3 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 85aa3ab0da3b8..6fcb6ce769c1a 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -337,42 +337,34 @@ int xe_devcoredump_init(struct xe_device *xe)
 /**
  * xe_print_blob_ascii85 - print a BLOB to some useful location in ASCII85
  *
- * The output is split to multiple lines because some print targets, e.g. dmesg
- * cannot handle arbitrarily long lines. Note also that printing to dmesg in
- * piece-meal fashion is not possible, each separate call to drm_puts() has a
- * line-feed automatically added! Therefore, the entire output line must be
- * constructed in a local buffer first, then printed in one atomic output call.
+ * The output is split into multiple calls to drm_puts() because some print
+ * targets, e.g. dmesg, cannot handle arbitrarily long lines. These targets may
+ * add newlines, as is the case with dmesg: each drm_puts() call creates a
+ * separate line.
  *
  * There is also a scheduler yield call to prevent the 'task has been stuck for
  * 120s' kernel hang check feature from firing when printing to a slow target
  * such as dmesg over a serial port.
  *
- * TODO: Add compression prior to the ASCII85 encoding to shrink huge buffers down.
- *
  * @p: the printer object to output to
  * @prefix: optional prefix to add to output string
+ * @suffix: optional suffix to add at the end. 0 disables it and is
+ *          not added to the output, which is useful when using multiple calls
+ *          to dump data to @p
  * @blob: the Binary Large OBject to dump out
  * @offset: offset in bytes to skip from the front of the BLOB, must be a multiple of sizeof(u32)
  * @size: the size in bytes of the BLOB, must be a multiple of sizeof(u32)
  */
-void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
+void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
 			   const void *blob, size_t offset, size_t size)
 {
 	const u32 *blob32 = (const u32 *)blob;
 	char buff[ASCII85_BUFSZ], *line_buff;
 	size_t line_pos = 0;
 
-	/*
-	 * Splitting blobs across multiple lines is not compatible with the mesa
-	 * debug decoder tool. Note that even dropping the explicit '\n' below
-	 * doesn't help because the GuC log is so big some underlying implementation
-	 * still splits the lines at 512K characters. So just bail completely for
-	 * the moment.
-	 */
-	return;
-
 #define DMESG_MAX_LINE_LEN	800
-#define MIN_SPACE		(ASCII85_BUFSZ + 2)		/* 85 + "\n\0" */
+	/* Always leave space for the suffix char and the \0 */
+#define MIN_SPACE		(ASCII85_BUFSZ + 2)	/* 85 + "<suffix>\0" */
 
 	if (size & 3)
 		drm_printf(p, "Size not word aligned: %zu", size);
@@ -404,7 +396,6 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
 		line_pos += strlen(line_buff + line_pos);
 
 		if ((line_pos + MIN_SPACE) >= DMESG_MAX_LINE_LEN) {
-			line_buff[line_pos++] = '\n';
 			line_buff[line_pos++] = 0;
 
 			drm_puts(p, line_buff);
@@ -416,10 +407,11 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
 		}
 	}
 
+	if (suffix)
+		line_buff[line_pos++] = suffix;
+
 	if (line_pos) {
-		line_buff[line_pos++] = '\n';
 		line_buff[line_pos++] = 0;
-
 		drm_puts(p, line_buff);
 	}
 
diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
index a4eebc285fc83..b231c8ad799f6 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.h
+++ b/drivers/gpu/drm/xe/xe_devcoredump.h
@@ -26,7 +26,7 @@ static inline int xe_devcoredump_init(struct xe_device *xe)
 }
 #endif
 
-void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
+void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
 			   const void *blob, size_t offset, size_t size);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
index be47780ec2a7e..50851638003b9 100644
--- a/drivers/gpu/drm/xe/xe_guc_log.c
+++ b/drivers/gpu/drm/xe/xe_guc_log.c
@@ -78,7 +78,7 @@ void xe_guc_log_print(struct xe_guc_log *log, struct drm_printer *p)
 
 	xe_map_memcpy_from(xe, copy, &log->bo->vmap, 0, size);
 
-	xe_print_blob_ascii85(p, "Log data", copy, 0, size);
+	xe_print_blob_ascii85(p, "Log data", '\n', copy, 0, size);
 
 	vfree(copy);
 }
-- 
2.48.1


