Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9F755481
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjGPUbF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjGPUbE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:31:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F4E9F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF8160E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDD4C433C9;
        Sun, 16 Jul 2023 20:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539461;
        bh=JBc2Jo75qwMc3kdTIC620agapLJ7tOwUc+7EGv49kGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSuF2fBiN6WFbpIBV8x7Fu3lj17SLpohkfsXWwIaPPzWL/sqLwo58b3nn0fJBCHaM
         8VOzwgbmlOneVqz2BIo/lSsA7EqzA3SKRiywQUOjwShA9LzA5RJD+27qw6CBOf42j8
         07CDWfM/cD3xsBwzg8MvmHpikd9VTVxoLLUZfuc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yue Hu <huyue2@coolpad.com>,
        Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 006/591] erofs: remove tagged pointer helpers
Date:   Sun, 16 Jul 2023 21:42:25 +0200
Message-ID: <20230716194924.028974031@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit b1ed220c6262bff63cdcb53692e492be0b05206c ]

Just open-code the remaining one to simplify the code.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230204093040.97967-3-hsiangkao@linux.alibaba.com
Stable-dep-of: 967c28b23f6c ("erofs: kill hooked chains to avoid loops on deduplicated compressed images")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/tagptr.h | 107 ----------------------------------------------
 fs/erofs/zdata.c  |  26 +++--------
 fs/erofs/zdata.h  |   1 -
 3 files changed, 6 insertions(+), 128 deletions(-)
 delete mode 100644 fs/erofs/tagptr.h

diff --git a/fs/erofs/tagptr.h b/fs/erofs/tagptr.h
deleted file mode 100644
index 64ceb7270b5c1..0000000000000
--- a/fs/erofs/tagptr.h
+++ /dev/null
@@ -1,107 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * A tagged pointer implementation
- */
-#ifndef __EROFS_FS_TAGPTR_H
-#define __EROFS_FS_TAGPTR_H
-
-#include <linux/types.h>
-#include <linux/build_bug.h>
-
-/*
- * the name of tagged pointer types are tagptr{1, 2, 3...}_t
- * avoid directly using the internal structs __tagptr{1, 2, 3...}
- */
-#define __MAKE_TAGPTR(n) \
-typedef struct __tagptr##n {	\
-	uintptr_t v;	\
-} tagptr##n##_t;
-
-__MAKE_TAGPTR(1)
-__MAKE_TAGPTR(2)
-__MAKE_TAGPTR(3)
-__MAKE_TAGPTR(4)
-
-#undef __MAKE_TAGPTR
-
-extern void __compiletime_error("bad tagptr tags")
-	__bad_tagptr_tags(void);
-
-extern void __compiletime_error("bad tagptr type")
-	__bad_tagptr_type(void);
-
-/* fix the broken usage of "#define tagptr2_t tagptr3_t" by users */
-#define __tagptr_mask_1(ptr, n)	\
-	__builtin_types_compatible_p(typeof(ptr), struct __tagptr##n) ? \
-		(1UL << (n)) - 1 :
-
-#define __tagptr_mask(ptr)	(\
-	__tagptr_mask_1(ptr, 1) ( \
-	__tagptr_mask_1(ptr, 2) ( \
-	__tagptr_mask_1(ptr, 3) ( \
-	__tagptr_mask_1(ptr, 4) ( \
-	__bad_tagptr_type(), 0)))))
-
-/* generate a tagged pointer from a raw value */
-#define tagptr_init(type, val) \
-	((typeof(type)){ .v = (uintptr_t)(val) })
-
-/*
- * directly cast a tagged pointer to the native pointer type, which
- * could be used for backward compatibility of existing code.
- */
-#define tagptr_cast_ptr(tptr) ((void *)(tptr).v)
-
-/* encode tagged pointers */
-#define tagptr_fold(type, ptr, _tags) ({ \
-	const typeof(_tags) tags = (_tags); \
-	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(type))) \
-		__bad_tagptr_tags(); \
-tagptr_init(type, (uintptr_t)(ptr) | tags); })
-
-/* decode tagged pointers */
-#define tagptr_unfold_ptr(tptr) \
-	((void *)((tptr).v & ~__tagptr_mask(tptr)))
-
-#define tagptr_unfold_tags(tptr) \
-	((tptr).v & __tagptr_mask(tptr))
-
-/* operations for the tagger pointer */
-#define tagptr_eq(_tptr1, _tptr2) ({ \
-	typeof(_tptr1) tptr1 = (_tptr1); \
-	typeof(_tptr2) tptr2 = (_tptr2); \
-	(void)(&tptr1 == &tptr2); \
-(tptr1).v == (tptr2).v; })
-
-/* lock-free CAS operation */
-#define tagptr_cmpxchg(_ptptr, _o, _n) ({ \
-	typeof(_ptptr) ptptr = (_ptptr); \
-	typeof(_o) o = (_o); \
-	typeof(_n) n = (_n); \
-	(void)(&o == &n); \
-	(void)(&o == ptptr); \
-tagptr_init(o, cmpxchg(&ptptr->v, o.v, n.v)); })
-
-/* wrap WRITE_ONCE if atomic update is needed */
-#define tagptr_replace_tags(_ptptr, tags) ({ \
-	typeof(_ptptr) ptptr = (_ptptr); \
-	*ptptr = tagptr_fold(*ptptr, tagptr_unfold_ptr(*ptptr), tags); \
-*ptptr; })
-
-#define tagptr_set_tags(_ptptr, _tags) ({ \
-	typeof(_ptptr) ptptr = (_ptptr); \
-	const typeof(_tags) tags = (_tags); \
-	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(*ptptr))) \
-		__bad_tagptr_tags(); \
-	ptptr->v |= tags; \
-*ptptr; })
-
-#define tagptr_clear_tags(_ptptr, _tags) ({ \
-	typeof(_ptptr) ptptr = (_ptptr); \
-	const typeof(_tags) tags = (_tags); \
-	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(*ptptr))) \
-		__bad_tagptr_tags(); \
-	ptptr->v &= ~tags; \
-*ptptr; })
-
-#endif	/* __EROFS_FS_TAGPTR_H */
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8e80871a8c1d7..3b5f73224c22a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -175,15 +175,6 @@ static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
 	DBG_BUGON(1);
 }
 
-/*
- * tagged pointer with 1-bit tag for all compressed pages
- * tag 0 - the page is just found with an extra page reference
- */
-typedef tagptr1_t compressed_page_t;
-
-#define tag_compressed_page_justfound(page) \
-	tagptr_fold(compressed_page_t, page, 1)
-
 static struct workqueue_struct *z_erofs_workqueue __read_mostly;
 
 void z_erofs_exit_zip_subsystem(void)
@@ -319,7 +310,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 
 	for (i = 0; i < pcl->pclusterpages; ++i) {
 		struct page *page;
-		compressed_page_t t;
+		void *t;	/* mark pages just found for debugging */
 		struct page *newpage = NULL;
 
 		/* the compressed page was loaded before */
@@ -329,7 +320,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 		page = find_get_page(mc, pcl->obj.index + i);
 
 		if (page) {
-			t = tag_compressed_page_justfound(page);
+			t = (void *)((unsigned long)page | 1);
 		} else {
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
@@ -345,11 +336,10 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 			if (!newpage)
 				continue;
 			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
-			t = tag_compressed_page_justfound(newpage);
+			t = (void *)((unsigned long)newpage | 1);
 		}
 
-		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL,
-				     tagptr_cast_ptr(t)))
+		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL, t))
 			continue;
 
 		if (page)
@@ -1192,8 +1182,6 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 
 	struct address_space *mapping;
 	struct page *oldpage, *page;
-
-	compressed_page_t t;
 	int justfound;
 
 repeat:
@@ -1203,10 +1191,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	if (!page)
 		goto out_allocpage;
 
-	/* process the target tagged pointer */
-	t = tagptr_init(compressed_page_t, page);
-	justfound = tagptr_unfold_tags(t);
-	page = tagptr_unfold_ptr(t);
+	justfound = (unsigned long)page & 1UL;
+	page = (struct page *)((unsigned long)page & ~1UL);
 
 	/*
 	 * preallocated cached pages, which is used to avoid direct reclaim
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index b139de5473a97..f196a729c7e85 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -7,7 +7,6 @@
 #define __EROFS_FS_ZDATA_H
 
 #include "internal.h"
-#include "tagptr.h"
 
 #define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
 #define Z_EROFS_INLINE_BVECS		2
-- 
2.39.2



