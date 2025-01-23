Return-Path: <stable+bounces-110316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B25A1A952
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 19:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FFC3A2F3F
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544414F9ED;
	Thu, 23 Jan 2025 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqqW6DSI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5B70817
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655424; cv=none; b=LtAilEPyyjlMhrsqhfvk4OnSyRo/Gg79E4gWk2pDGAf0BSVrIlSUesaIu7EkbxfR3rS1FtW3gHbZ/LG3ipxzgars6nODLLQ0JBsa4H1htpCSZza0QVAat6iod8FJPPviShgWMPcQycHOSuHVMTRiQUdtvJJvIljZdjmCFwQmz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655424; c=relaxed/simple;
	bh=27maxQOVid9+Minx7FyXvnK5oYyPcJhXdxqdR53S+nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1BIjIg/TvMQMuh6D26KbZCnQjgNR+vtFeFT2TyfSvCYdTeHkLaYqgWp0NiOvq2yUUPMiIOLE4r7dDmrNgwx1oMOZWqpLv/rcvdzzpf585GMAnGv+d7FvEvqAavGGRdO9NqlVg/JkrzzXK3hnyyBh9tVvW4u6H50mbX8rjH9dN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqqW6DSI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737655422; x=1769191422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=27maxQOVid9+Minx7FyXvnK5oYyPcJhXdxqdR53S+nw=;
  b=NqqW6DSISoH4woIaTrq4yJP5FnJJNlt5qeR+NaV1TeCFiLebWKouSoP7
   DTKfddUTJooFozYCYDXs5+Ek84p7uyAm5f+OwtTLbCj2Z+VXqlDyKYPZK
   oZRWnEHExBM2+jJ+Eo32gD4oYf2Qg2p2eQOPyHm3XPRc1CBpoxaaCwztu
   r0cMVX2lgxwi2nL9YO3c5jMuazyk+EHQYhWXLtnAEwrvr86Tl/cB89Oto
   YnN0kFGUpP0WMTC5KJ3nizJs1/oEM/FGOw4pG0nOC+MzPiRrmMzoA1Jys
   pcZ/OGHl5T5fmPA6cARKOzSmlprhPMDAT3JbrRJhhu2Ha18TLVlovVlzY
   A==;
X-CSE-ConnectionGUID: K2TjwU5TRoKtCm0uDku2Ag==
X-CSE-MsgGUID: 5v65B8S4SkirgwI6vcnJhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="49162873"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="49162873"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:03:42 -0800
X-CSE-ConnectionGUID: k0QDV1qSTaSCelgYAx5YlA==
X-CSE-MsgGUID: UY1mlTMETbODCfbdoQX77A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107964037"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:03:40 -0800
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	stable@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 1/3] drm/xe: Fix and re-enable xe_print_blob_ascii85()
Date: Thu, 23 Jan 2025 09:59:41 -0800
Message-ID: <20250123180320.66198-2-jose.souza@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123180320.66198-1-jose.souza@intel.com>
References: <20250123180320.66198-1-jose.souza@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lucas De Marchi <lucas.demarchi@intel.com>

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

Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Julia Filipchuk <julia.filipchuk@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: stable@vger.kernel.org
Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa debug tool")
Fixes: ec1455ce7e35 ("drm/xe/devcoredump: Add ASCII85 dump helper function")
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 30 +++++++++--------------------
 drivers/gpu/drm/xe/xe_devcoredump.h |  2 +-
 drivers/gpu/drm/xe/xe_guc_ct.c      |  3 ++-
 drivers/gpu/drm/xe/xe_guc_log.c     |  4 +++-
 4 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 81dc7795c0651..1c86e6456d60f 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -395,42 +395,30 @@ int xe_devcoredump_init(struct xe_device *xe)
 /**
  * xe_print_blob_ascii85 - print a BLOB to some useful location in ASCII85
  *
- * The output is split to multiple lines because some print targets, e.g. dmesg
- * cannot handle arbitrarily long lines. Note also that printing to dmesg in
- * piece-meal fashion is not possible, each separate call to drm_puts() has a
- * line-feed automatically added! Therefore, the entire output line must be
- * constructed in a local buffer first, then printed in one atomic output call.
+ * The output is split to multiple print calls because some print targets, e.g.
+ * dmesg cannot handle arbitrarily long lines. These targets may add newline
+ * between calls.
  *
  * There is also a scheduler yield call to prevent the 'task has been stuck for
  * 120s' kernel hang check feature from firing when printing to a slow target
  * such as dmesg over a serial port.
  *
- * TODO: Add compression prior to the ASCII85 encoding to shrink huge buffers down.
- *
  * @p: the printer object to output to
  * @prefix: optional prefix to add to output string
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
@@ -462,7 +450,6 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
 		line_pos += strlen(line_buff + line_pos);
 
 		if ((line_pos + MIN_SPACE) >= DMESG_MAX_LINE_LEN) {
-			line_buff[line_pos++] = '\n';
 			line_buff[line_pos++] = 0;
 
 			drm_puts(p, line_buff);
@@ -474,10 +461,11 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
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
index 6a17e6d601022..5391a80a4d1ba 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.h
+++ b/drivers/gpu/drm/xe/xe_devcoredump.h
@@ -29,7 +29,7 @@ static inline int xe_devcoredump_init(struct xe_device *xe)
 }
 #endif
 
-void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
+void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
 			   const void *blob, size_t offset, size_t size);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 8b65c5e959cc2..50c8076b51585 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -1724,7 +1724,8 @@ void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot,
 			   snapshot->g2h_outstanding);
 
 		if (snapshot->ctb)
-			xe_print_blob_ascii85(p, "CTB data", snapshot->ctb, 0, snapshot->ctb_size);
+			xe_print_blob_ascii85(p, "CTB data", '\n',
+					      snapshot->ctb, 0, snapshot->ctb_size);
 	} else {
 		drm_puts(p, "CT disabled\n");
 	}
diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
index 80151ff6a71f8..44482ea919924 100644
--- a/drivers/gpu/drm/xe/xe_guc_log.c
+++ b/drivers/gpu/drm/xe/xe_guc_log.c
@@ -207,8 +207,10 @@ void xe_guc_log_snapshot_print(struct xe_guc_log_snapshot *snapshot, struct drm_
 	remain = snapshot->size;
 	for (i = 0; i < snapshot->num_chunks; i++) {
 		size_t size = min(GUC_LOG_CHUNK_SIZE, remain);
+		const char *prefix = i ? NULL : "Log data";
+		char suffix = i == snapshot->num_chunks - 1 ? '\n' : 0;
 
-		xe_print_blob_ascii85(p, i ? NULL : "Log data", snapshot->copy[i], 0, size);
+		xe_print_blob_ascii85(p, prefix, suffix, snapshot->copy[i], 0, size);
 		remain -= size;
 	}
 }
-- 
2.48.1


