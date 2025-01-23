Return-Path: <stable+bounces-110330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101A4A1AB22
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 21:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95213AB9E1
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 20:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B989A1C3BE0;
	Thu, 23 Jan 2025 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEvMaBoX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43351C3BF8
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663808; cv=none; b=DFV2c+xKq1AWL1hT4m3fkk54ieWYMW5TqosPyAN45/Ltl5oqory1Kiyj7IEUFV/0cOgXE9NWdN/5/GuE4gW42rEgmHJGRK0QNgMNGWVXoT3GiB2gyUBTBTTiPswLVrNBNMcmyu5i/m3jTTU9NvbZFeFprQMwSbvQGJwyievzmjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663808; c=relaxed/simple;
	bh=+xq0xxT5ZX2m9js4plcbPhC4jdjW07e0d1BbRLOxY1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suEwFTZpgtpscaRYIlxMzyI5z5Gc/iNzlZ5PQ4OK4NdRAHtuC5qXiPho5APEiKZ+lWh75z85XVwVl+q6EKX07SMhmakG4ki9HvnUhLqC/S9nzv71lISo6gpCt+DoPbAzgoMgoGfMCS75M/E27xaYt+g4WNWkOjdsz4KpJIIhSCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEvMaBoX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737663807; x=1769199807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+xq0xxT5ZX2m9js4plcbPhC4jdjW07e0d1BbRLOxY1c=;
  b=SEvMaBoXhxpBvywFHLH146UQRlXWfINZOPABMbRe0Q/3KHL/0sUUDmWe
   iIaaR2TKjROLVv+t7S8ENovA046I1Sq4HGS5GyYinvJ3oJnPEFb/zK6n9
   8x4r7qLRR/E69xg9ucNlwwOnspNA6jm/VSJkFmjsE8mTJ6LxQKoCdXPBl
   GSEisZ6MBE1vNr4yxMBC0v4oF3l+Q+YNKTnHZ5jbrJckG4F3EVmoBw0+P
   MVPF4WQZlH++0crcLWKolTGNywYRHOvFCOT9ZvjSx2LnHEin0SP5k7Hoo
   NpfVmlApVsIr/E6XNnG2JGqtcGr5hbCLmwkNx4KKwdVlbi1OOWbcBwGa5
   g==;
X-CSE-ConnectionGUID: ZoUnlSHjRoWGJe8nWZVzPw==
X-CSE-MsgGUID: zq0BQ5sdQY6stv93YVh1fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41946309"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="41946309"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 12:23:21 -0800
X-CSE-ConnectionGUID: SfJ7UlSHRfOkJnaMUHALqQ==
X-CSE-MsgGUID: mKmuYcykQeWUp8kWkLon3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138437920"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 12:23:13 -0800
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	stable@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v2 1/2] drm/xe: Fix and re-enable xe_print_blob_ascii85()
Date: Thu, 23 Jan 2025 12:22:03 -0800
Message-ID: <20250123202307.95103-2-jose.souza@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123202307.95103-1-jose.souza@intel.com>
References: <20250123202307.95103-1-jose.souza@intel.com>
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

v2:
- added suffix description comment

Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Julia Filipchuk <julia.filipchuk@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: stable@vger.kernel.org
Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa debug tool")
Fixes: ec1455ce7e35 ("drm/xe/devcoredump: Add ASCII85 dump helper function")
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 33 +++++++++++------------------
 drivers/gpu/drm/xe/xe_devcoredump.h |  2 +-
 drivers/gpu/drm/xe/xe_guc_ct.c      |  3 ++-
 drivers/gpu/drm/xe/xe_guc_log.c     |  4 +++-
 4 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 81dc7795c0651..6f73b1ba0f2aa 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -395,42 +395,33 @@ int xe_devcoredump_init(struct xe_device *xe)
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
@@ -462,7 +453,6 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
 		line_pos += strlen(line_buff + line_pos);
 
 		if ((line_pos + MIN_SPACE) >= DMESG_MAX_LINE_LEN) {
-			line_buff[line_pos++] = '\n';
 			line_buff[line_pos++] = 0;
 
 			drm_puts(p, line_buff);
@@ -474,10 +464,11 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
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


