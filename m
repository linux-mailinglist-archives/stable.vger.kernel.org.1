Return-Path: <stable+bounces-53247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98E090D0D4
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31839287A3D
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788918E765;
	Tue, 18 Jun 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a9NfBqN5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C018E75E;
	Tue, 18 Jun 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715764; cv=none; b=i/LI2a0/K6Ji87RzZzWqD861LF3FJFp1DEWjQiwASfVmNHCa73+Jd5ir5Z8cLlbHqli7nKtqnubauQc269xX5h+yct2IV/GS/j/jH15OhS5x6FRh3dv9jiX+E/7rWvLB9DaOJJsFK/OLRmUNJTNDUwEmRBRtc05Wqjlbb7/pHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715764; c=relaxed/simple;
	bh=zGeOFMGZ9Rr0jfCvHsn84Rv0iZB/uMOxgD1H7/ufsvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbiKZfx6SvCVI/3mVEfxrVdOQPCZvFXGQw7gpTUSQ0OQewFucFM2aC0ZGkMticzQ7e1AkEyC5oBnpNrf3mUzKHF8ynTaVnF8b4SxtWw8JsIT5r1xk9YeaqyyFoiGQTRJNAtSN3RIxMXxZUvPq97WLVKN+j+HTBIh6klrOE6RBKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a9NfBqN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADFFC3277B;
	Tue, 18 Jun 2024 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715763;
	bh=zGeOFMGZ9Rr0jfCvHsn84Rv0iZB/uMOxgD1H7/ufsvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9NfBqN5/aToxrGPvcwkyZfb8iy6g8qzwlu+O3PT9umIRFFi7Cqbk5adhBv+Cyu5z
	 pEBXR2/FZur9lRZ1mjJg3P8vNbwn3v2zkexhUQ5ZNXHnY3Gv76gHXL5tk0YPBrHG4n
	 KBR9/T6z6k3Oq0fmJ837OHW3anYTPAZud5ZX3nqg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 411/770] fanotify: support secondary dir fh and name in fanotify_info
Date: Tue, 18 Jun 2024 14:34:24 +0200
Message-ID: <20240618123423.149319676@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 3cf984e950c1c3f41d407ed31db33beb996be132 ]

Allow storing a secondary dir fh and name tupple in fanotify_info.
This will be used to store the new parent and name information in
FAN_RENAME event.

Link: https://lore.kernel.org/r/20211129201537.1932819-8-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify.c      | 20 ++++++--
 fs/notify/fanotify/fanotify.h      | 79 +++++++++++++++++++++++++++---
 fs/notify/fanotify/fanotify_user.c |  3 +-
 3 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 2b13c79cebc62..5f184b2d6ea7c 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -76,8 +76,10 @@ static bool fanotify_info_equal(struct fanotify_info *info1,
 				struct fanotify_info *info2)
 {
 	if (info1->dir_fh_totlen != info2->dir_fh_totlen ||
+	    info1->dir2_fh_totlen != info2->dir2_fh_totlen ||
 	    info1->file_fh_totlen != info2->file_fh_totlen ||
-	    info1->name_len != info2->name_len)
+	    info1->name_len != info2->name_len ||
+	    info1->name2_len != info2->name2_len)
 		return false;
 
 	if (info1->dir_fh_totlen &&
@@ -85,14 +87,24 @@ static bool fanotify_info_equal(struct fanotify_info *info1,
 			       fanotify_info_dir_fh(info2)))
 		return false;
 
+	if (info1->dir2_fh_totlen &&
+	    !fanotify_fh_equal(fanotify_info_dir2_fh(info1),
+			       fanotify_info_dir2_fh(info2)))
+		return false;
+
 	if (info1->file_fh_totlen &&
 	    !fanotify_fh_equal(fanotify_info_file_fh(info1),
 			       fanotify_info_file_fh(info2)))
 		return false;
 
-	return !info1->name_len ||
-		!memcmp(fanotify_info_name(info1), fanotify_info_name(info2),
-			info1->name_len);
+	if (info1->name_len &&
+	    memcmp(fanotify_info_name(info1), fanotify_info_name(info2),
+		   info1->name_len))
+		return false;
+
+	return !info1->name2_len ||
+		!memcmp(fanotify_info_name2(info1), fanotify_info_name2(info2),
+			info1->name2_len);
 }
 
 static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 7ac6f9f1e4148..8fa3bc0effd45 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -40,31 +40,45 @@ struct fanotify_fh {
 struct fanotify_info {
 	/* size of dir_fh/file_fh including fanotify_fh hdr size */
 	u8 dir_fh_totlen;
+	u8 dir2_fh_totlen;
 	u8 file_fh_totlen;
 	u8 name_len;
-	u8 pad;
+	u8 name2_len;
+	u8 pad[3];
 	unsigned char buf[];
 	/*
 	 * (struct fanotify_fh) dir_fh starts at buf[0]
-	 * (optional) file_fh starts at buf[dir_fh_totlen]
-	 * name starts at buf[dir_fh_totlen + file_fh_totlen]
+	 * (optional) dir2_fh starts at buf[dir_fh_totlen]
+	 * (optional) file_fh starts at buf[dir_fh_totlen + dir2_fh_totlen]
+	 * name starts at buf[dir_fh_totlen + dir2_fh_totlen + file_fh_totlen]
+	 * ...
 	 */
 #define FANOTIFY_DIR_FH_SIZE(info)	((info)->dir_fh_totlen)
+#define FANOTIFY_DIR2_FH_SIZE(info)	((info)->dir2_fh_totlen)
 #define FANOTIFY_FILE_FH_SIZE(info)	((info)->file_fh_totlen)
 #define FANOTIFY_NAME_SIZE(info)	((info)->name_len + 1)
+#define FANOTIFY_NAME2_SIZE(info)	((info)->name2_len + 1)
 
 #define FANOTIFY_DIR_FH_OFFSET(info)	0
-#define FANOTIFY_FILE_FH_OFFSET(info) \
+#define FANOTIFY_DIR2_FH_OFFSET(info) \
 	(FANOTIFY_DIR_FH_OFFSET(info) + FANOTIFY_DIR_FH_SIZE(info))
+#define FANOTIFY_FILE_FH_OFFSET(info) \
+	(FANOTIFY_DIR2_FH_OFFSET(info) + FANOTIFY_DIR2_FH_SIZE(info))
 #define FANOTIFY_NAME_OFFSET(info) \
 	(FANOTIFY_FILE_FH_OFFSET(info) + FANOTIFY_FILE_FH_SIZE(info))
+#define FANOTIFY_NAME2_OFFSET(info) \
+	(FANOTIFY_NAME_OFFSET(info) + FANOTIFY_NAME_SIZE(info))
 
 #define FANOTIFY_DIR_FH_BUF(info) \
 	((info)->buf + FANOTIFY_DIR_FH_OFFSET(info))
+#define FANOTIFY_DIR2_FH_BUF(info) \
+	((info)->buf + FANOTIFY_DIR2_FH_OFFSET(info))
 #define FANOTIFY_FILE_FH_BUF(info) \
 	((info)->buf + FANOTIFY_FILE_FH_OFFSET(info))
 #define FANOTIFY_NAME_BUF(info) \
 	((info)->buf + FANOTIFY_NAME_OFFSET(info))
+#define FANOTIFY_NAME2_BUF(info) \
+	((info)->buf + FANOTIFY_NAME2_OFFSET(info))
 } __aligned(4);
 
 static inline bool fanotify_fh_has_ext_buf(struct fanotify_fh *fh)
@@ -106,6 +120,20 @@ static inline struct fanotify_fh *fanotify_info_dir_fh(struct fanotify_info *inf
 	return (struct fanotify_fh *)FANOTIFY_DIR_FH_BUF(info);
 }
 
+static inline int fanotify_info_dir2_fh_len(struct fanotify_info *info)
+{
+	if (!info->dir2_fh_totlen ||
+	    WARN_ON_ONCE(info->dir2_fh_totlen < FANOTIFY_FH_HDR_LEN))
+		return 0;
+
+	return info->dir2_fh_totlen - FANOTIFY_FH_HDR_LEN;
+}
+
+static inline struct fanotify_fh *fanotify_info_dir2_fh(struct fanotify_info *info)
+{
+	return (struct fanotify_fh *)FANOTIFY_DIR2_FH_BUF(info);
+}
+
 static inline int fanotify_info_file_fh_len(struct fanotify_info *info)
 {
 	if (!info->file_fh_totlen ||
@@ -128,31 +156,55 @@ static inline char *fanotify_info_name(struct fanotify_info *info)
 	return FANOTIFY_NAME_BUF(info);
 }
 
+static inline char *fanotify_info_name2(struct fanotify_info *info)
+{
+	if (!info->name2_len)
+		return NULL;
+
+	return FANOTIFY_NAME2_BUF(info);
+}
+
 static inline void fanotify_info_init(struct fanotify_info *info)
 {
 	BUILD_BUG_ON(FANOTIFY_FH_HDR_LEN + MAX_HANDLE_SZ > U8_MAX);
 	BUILD_BUG_ON(NAME_MAX > U8_MAX);
 
 	info->dir_fh_totlen = 0;
+	info->dir2_fh_totlen = 0;
 	info->file_fh_totlen = 0;
 	info->name_len = 0;
+	info->name2_len = 0;
 }
 
 /* These set/copy helpers MUST be called by order */
 static inline void fanotify_info_set_dir_fh(struct fanotify_info *info,
 					    unsigned int totlen)
 {
-	if (WARN_ON_ONCE(info->file_fh_totlen > 0) ||
-	    WARN_ON_ONCE(info->name_len > 0))
+	if (WARN_ON_ONCE(info->dir2_fh_totlen > 0) ||
+	    WARN_ON_ONCE(info->file_fh_totlen > 0) ||
+	    WARN_ON_ONCE(info->name_len > 0) ||
+	    WARN_ON_ONCE(info->name2_len > 0))
 		return;
 
 	info->dir_fh_totlen = totlen;
 }
 
+static inline void fanotify_info_set_dir2_fh(struct fanotify_info *info,
+					     unsigned int totlen)
+{
+	if (WARN_ON_ONCE(info->file_fh_totlen > 0) ||
+	    WARN_ON_ONCE(info->name_len > 0) ||
+	    WARN_ON_ONCE(info->name2_len > 0))
+		return;
+
+	info->dir2_fh_totlen = totlen;
+}
+
 static inline void fanotify_info_set_file_fh(struct fanotify_info *info,
 					     unsigned int totlen)
 {
-	if (WARN_ON_ONCE(info->name_len > 0))
+	if (WARN_ON_ONCE(info->name_len > 0) ||
+	    WARN_ON_ONCE(info->name2_len > 0))
 		return;
 
 	info->file_fh_totlen = totlen;
@@ -161,13 +213,24 @@ static inline void fanotify_info_set_file_fh(struct fanotify_info *info,
 static inline void fanotify_info_copy_name(struct fanotify_info *info,
 					   const struct qstr *name)
 {
-	if (WARN_ON_ONCE(name->len > NAME_MAX))
+	if (WARN_ON_ONCE(name->len > NAME_MAX) ||
+	    WARN_ON_ONCE(info->name2_len > 0))
 		return;
 
 	info->name_len = name->len;
 	strcpy(fanotify_info_name(info), name->name);
 }
 
+static inline void fanotify_info_copy_name2(struct fanotify_info *info,
+					    const struct qstr *name)
+{
+	if (WARN_ON_ONCE(name->len > NAME_MAX))
+		return;
+
+	info->name2_len = name->len;
+	strcpy(fanotify_info_name2(info), name->name);
+}
+
 /*
  * Common structure for fanotify events. Concrete structs are allocated in
  * fanotify_handle_event() and freed when the information is retrieved by
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6b058d652f47b..d69570db5efd2 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -327,11 +327,10 @@ static int process_access_response(struct fsnotify_group *group,
 static size_t copy_error_info_to_user(struct fanotify_event *event,
 				      char __user *buf, int count)
 {
-	struct fanotify_event_info_error info;
+	struct fanotify_event_info_error info = { };
 	struct fanotify_error_event *fee = FANOTIFY_EE(event);
 
 	info.hdr.info_type = FAN_EVENT_INFO_TYPE_ERROR;
-	info.hdr.pad = 0;
 	info.hdr.len = FANOTIFY_ERROR_INFO_LEN;
 
 	if (WARN_ON(count < info.hdr.len))
-- 
2.43.0




