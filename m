Return-Path: <stable+bounces-86693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535409A2E57
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36FB1F2347D
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3244144D21;
	Thu, 17 Oct 2024 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AHyjkdJB"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E71DD0DE
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196427; cv=none; b=Z4+rl0ZWJ7vUp6SZANIZEcuAVqIlandqmy25ObDQqf2jmhqdrLkDXDvdqWAong1XjOOxKHypoYhB4R/FEdPOEl21uXyy2lh5Vn1uCs3++VtdmxY40+avCo73MDOR8W5jkh111l0YXSMg9YtqaqlLCXSktFsHDbkdVvpD2xmopnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196427; c=relaxed/simple;
	bh=9N+I+VJRdnkMlxvjjcwvp0REZNNDP0lfLiRusZLWpks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sxjrv5TUsaP/e58yiAiIjAgcv/yTrj3DkWDut1LfUZ8s6lWdfJ2MP85r/9Z8e5Sn4XHgHR8Gy52DyzaywKDdfqDq5MHRdMvg5byHKGGFrxDN1DJhwnZ1dxRjHHhtpwmB03j42oXJyujaZvR7J4Xb9uh1xe7ecqfO5/aQmhsGjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AHyjkdJB; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WuUxomUe9WrqtvgJ4Duhk4Y6BV1zC7CPGxctltLt53k=; b=AHyjkdJBQPm3mlbFDmQTJ15PRj
	lJ/+xOObMWaqtnJC2saDGj483dslhY2ByP8u5V+X07kN0zvt+6UMJkrtnisksprorcCPvxIHQsT/t
	stQO/2SgXcmzqFhCqrmmMf1EmmmUDisYdKiURNsibk1b46+/pkqYuZgsp+GHrT8WiiG5qCei+cXmF
	F+YrO4JDjepPdrUGUC0Z37xSNrt1A2S0MxmvmgaJkKFlzFBRrybjQ8eml3WXwx8dgNfdtnrRmS6Bh
	c4D8yBmvOtGPSA+2oLvSd2PSo0lD2d9qKMjD46fsMouLv+I7tkvVSDrEyVf6ElpTKCr7S6wA0xYxG
	RNgVOJZg==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Wyq-00BmZ7-0Z; Thu, 17 Oct 2024 22:20:20 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	syzbot+69c9fdccc6dd08961d34@syzkaller.appspotmail.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 04/20] udf: Implement searching for directory entry using new iteration code
Date: Thu, 17 Oct 2024 17:19:46 -0300
Message-Id: <20241017202002.406428-5-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017202002.406428-1-cascardo@igalia.com>
References: <20241017202002.406428-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 1c80afa04db39c98aebea9aabfafa37a208cdfee ]

Implement searching for directory entry - udf_fiiter_find_entry() -
using new directory iteration code.

Reported-by: syzbot+69c9fdccc6dd08961d34@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 1ed84cf411af..61a7a7ab9aa7 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -140,6 +140,73 @@ int udf_write_fi(struct inode *inode, struct fileIdentDesc *cfi,
 	return 0;
 }
 
+/**
+ * udf_fiiter_find_entry - find entry in given directory.
+ *
+ * @dir:	directory inode to search in
+ * @child:	qstr of the name
+ * @iter:	iter to use for searching
+ *
+ * This function searches in the directory @dir for a file name @child. When
+ * found, @iter points to the position in the directory with given entry.
+ *
+ * Returns 0 on success, < 0 on error (including -ENOENT).
+ */
+static int udf_fiiter_find_entry(struct inode *dir, const struct qstr *child,
+				 struct udf_fileident_iter *iter)
+{
+	int flen;
+	unsigned char *fname = NULL;
+	struct super_block *sb = dir->i_sb;
+	int isdotdot = child->len == 2 &&
+		child->name[0] == '.' && child->name[1] == '.';
+	int ret;
+
+	fname = kmalloc(UDF_NAME_LEN, GFP_NOFS);
+	if (!fname)
+		return -ENOMEM;
+
+	for (ret = udf_fiiter_init(iter, dir, 0);
+	     !ret && iter->pos < dir->i_size;
+	     ret = udf_fiiter_advance(iter)) {
+		if (iter->fi.fileCharacteristics & FID_FILE_CHAR_DELETED) {
+			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNDELETE))
+				continue;
+		}
+
+		if (iter->fi.fileCharacteristics & FID_FILE_CHAR_HIDDEN) {
+			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNHIDE))
+				continue;
+		}
+
+		if ((iter->fi.fileCharacteristics & FID_FILE_CHAR_PARENT) &&
+		    isdotdot)
+			goto out_ok;
+
+		if (!iter->fi.lengthFileIdent)
+			continue;
+
+		flen = udf_get_filename(sb, iter->name,
+				iter->fi.lengthFileIdent, fname, UDF_NAME_LEN);
+		if (flen < 0) {
+			ret = flen;
+			goto out_err;
+		}
+
+		if (udf_match(flen, fname, child->len, child->name))
+			goto out_ok;
+	}
+	if (!ret)
+		ret = -ENOENT;
+
+out_err:
+	udf_fiiter_release(iter);
+out_ok:
+	kfree(fname);
+
+	return ret;
+}
+
 /**
  * udf_find_entry - find entry in given directory.
  *
-- 
2.34.1


