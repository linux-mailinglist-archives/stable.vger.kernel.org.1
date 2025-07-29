Return-Path: <stable+bounces-165042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7EEB149DF
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 10:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AF61899B5F
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296D9277800;
	Tue, 29 Jul 2025 08:15:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AD51729B0;
	Tue, 29 Jul 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776932; cv=none; b=afBHrYMCxXROf/vJcq5PFnTS3bqyw2A00V/0PCuC80nWY/URySbtS6GwMair/YFlQPsn9UvAEW1AqLXibt1+ZzThpZIITM//qsJaS1V0QzakEDi1ykWdy0k8UvzQhiJXj3K3wsAPlHfc6UsqIA2GhK0dD/kAiBsZHbLOVKW1HAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776932; c=relaxed/simple;
	bh=Bs/X5R/GBALhH9VjVnGog552EPM5nbD0DNhgnYK7alc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MK9qVN2ynLzbIFYvposf7R6b26Nm4E4F4UR+LpvD0VjRdAp7XZgfEI8wys6HcTF+4Cw345RxmH8CkgJIu9gLubmuKZE4VftDsd4mUqyfKSGXgLgcchDVag5hKrp/DwUABV6UmwiWTpoTYyWxVYARw+mCZNXgOSDpTA1Rxegg+zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from liqiong-suma.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 72C7D6019D27D;
	Tue, 29 Jul 2025 16:15:12 +0800 (CST)
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Li Qiong <liqiong@nfschina.com>
To: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Li Qiong <liqiong@nfschina.com>
Subject: [PATCH v3] mm: slub: avoid deref of free pointer in sanity checks if object is invalid
Date: Tue, 29 Jul 2025 16:14:55 +0800
Message-Id: <20250729081455.3311961-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging, object_err() prints free pointer of the object.
However, if check_valid_pointer() returns false for a object,
dereferncing `object + s->offset` can lead to a crash. Therefore,
print the object's address in such cases.

Fixes: bb192ed9aa71 ("mm/slub: Convert most struct page to struct slab by spatch")
Cc: <stable@vger.kernel.org>
Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
v2:
- rephrase the commit message, add comment for object_err().
v3:
- check object pointer in object_err().
---
 mm/slub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 31e11ef256f9..d3abae5a2193 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1104,7 +1104,11 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
 		return;
 
 	slab_bug(s, reason);
-	print_trailer(s, slab, object);
+	if (!check_valid_pointer(s, slab, object)) {
+		print_slab_info(slab);
+		pr_err("invalid object 0x%p\n", object);
+	} else
+		print_trailer(s, slab, object);
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
 	WARN_ON(1);
@@ -1587,7 +1591,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 		return 0;
 
 	if (!check_valid_pointer(s, slab, object)) {
-		object_err(s, slab, object, "Freelist Pointer check fails");
+		slab_err(s, slab, "Freelist Pointer(0x%p) check fails", object);
 		return 0;
 	}
 
-- 
2.30.2


