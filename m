Return-Path: <stable+bounces-60905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A07093A5F0
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B65C1F233DA
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C525158A04;
	Tue, 23 Jul 2024 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="to2q0YiS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF27C158A03;
	Tue, 23 Jul 2024 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759397; cv=none; b=CXqDzfM80FR3wE47Fh2CMyChHhOkNSIIjtCSzXZqqCX0ei5B6fqYVdOWmBOmp8J77zhPy7InSmjaWDaomppYjV4Xx/5gxUP9wDpMAC6Uh4zjH7t0wWEXNfndRPLsXLIaFGqBBEKEXPZBKrLR2+wJUxxohRKW0ziM/NIxinC3pOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759397; c=relaxed/simple;
	bh=Eh2wKF1f1/D6+K5BzF1shBxvVZyObL2QdqlypengchY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ela8PRUDidE7jb8tOU5DjFmxjvKy57ozLvb6FURJSHkCSXic6180HicIZ+FYvYJ6EqUmbIi0HJ3vw3ClTumBI8IUV7TeQ0VKqDES2p9Ylx2DEOy1+CK4wjET7sJSrOMZ7hEoceFjl3NLIfd6ASDZnxk5fOCp9ITsPKNUVeMq5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=to2q0YiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125E2C4AF0A;
	Tue, 23 Jul 2024 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759397;
	bh=Eh2wKF1f1/D6+K5BzF1shBxvVZyObL2QdqlypengchY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=to2q0YiSHSYwYOL/ZJLi/Qxp1D2vhaWRMkAjICYPN1RKxg+pFVDfu7VZDyuTX/NJ2
	 44ET/IGNS6oHQtjYhNhgxL0ARAwHTbCADIKRO6YZvrhgLtm5eAcax7sw9JEPYWoBX2
	 RK4sfDN9jmB6/kF2DiSaVhV/9KVZ/xIEy3/rPqEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1 103/105] netfs, fscache: export fscache_put_volume() and add fscache_try_get_volume()
Date: Tue, 23 Jul 2024 20:24:20 +0200
Message-ID: <20240723180407.211980130@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180402.490567226@linuxfoundation.org>
References: <20240723180402.490567226@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 85b08b31a22b481ec6528130daf94eee4452e23f ]

Export fscache_put_volume() and add fscache_try_get_volume()
helper function to allow cachefiles to get/put fscache_volume
via linux/fscache-cache.h.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240628062930.2467993-2-libaokun@huaweicloud.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 522018a0de6b ("cachefiles: fix slab-use-after-free in fscache_withdraw_volume()")
Stable-dep-of: 5d8f80578907 ("cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fscache/internal.h         |    2 --
 fs/fscache/volume.c           |   14 ++++++++++++++
 include/linux/fscache-cache.h |    6 ++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -145,8 +145,6 @@ extern const struct seq_operations fscac
 
 struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
 					  enum fscache_volume_trace where);
-void fscache_put_volume(struct fscache_volume *volume,
-			enum fscache_volume_trace where);
 bool fscache_begin_volume_access(struct fscache_volume *volume,
 				 struct fscache_cookie *cookie,
 				 enum fscache_access_trace why);
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -27,6 +27,19 @@ struct fscache_volume *fscache_get_volum
 	return volume;
 }
 
+struct fscache_volume *fscache_try_get_volume(struct fscache_volume *volume,
+					      enum fscache_volume_trace where)
+{
+	int ref;
+
+	if (!__refcount_inc_not_zero(&volume->ref, &ref))
+		return NULL;
+
+	trace_fscache_volume(volume->debug_id, ref + 1, where);
+	return volume;
+}
+EXPORT_SYMBOL(fscache_try_get_volume);
+
 static void fscache_see_volume(struct fscache_volume *volume,
 			       enum fscache_volume_trace where)
 {
@@ -420,6 +433,7 @@ void fscache_put_volume(struct fscache_v
 			fscache_free_volume(volume);
 	}
 }
+EXPORT_SYMBOL(fscache_put_volume);
 
 /*
  * Relinquish a volume representation cookie.
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -19,6 +19,7 @@
 enum fscache_cache_trace;
 enum fscache_cookie_trace;
 enum fscache_access_trace;
+enum fscache_volume_trace;
 
 enum fscache_cache_state {
 	FSCACHE_CACHE_IS_NOT_PRESENT,	/* No cache is present for this name */
@@ -97,6 +98,11 @@ extern void fscache_withdraw_cookie(stru
 
 extern void fscache_io_error(struct fscache_cache *cache);
 
+extern struct fscache_volume *
+fscache_try_get_volume(struct fscache_volume *volume,
+		       enum fscache_volume_trace where);
+extern void fscache_put_volume(struct fscache_volume *volume,
+			       enum fscache_volume_trace where);
 extern void fscache_end_volume_access(struct fscache_volume *volume,
 				      struct fscache_cookie *cookie,
 				      enum fscache_access_trace why);



