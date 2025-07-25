Return-Path: <stable+bounces-164720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8CDB118AB
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 08:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DE63AB7BF
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 06:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0595E285C80;
	Fri, 25 Jul 2025 06:49:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 937401DED4A;
	Fri, 25 Jul 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426194; cv=none; b=Rkwfbf6BKqVey/Uk6iW/qPgU4xJTK1l3JpDkdc6RVjKNZ5aoYO7FPMj9KcsD/MFitWsVmMcBk1RBfogGF/lvwI4ZkR6AqQtdts+FZ82R7Ck80ik2qB/Tq8YXDYhHcBFRmml1Keil/TE11pJXgVzdUyrKOVYkjZ1cVP+qyl59VeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426194; c=relaxed/simple;
	bh=YFGGRGFngZDD0B+4i694TrviuPP8FTx4Syr6rEqNZCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=iptTRFKB9pFW3EXxK151uKD6/be/hJMg8ZyHq/vqKA5Yw3U9rkjQ9jHiDuMZg2DWjv47xOvkEoVgpgR5tknOW2/++lLg1dcBDGIuMUoWRn79Ugxi6Fku0c184nk1FxSe33fStiXRZtlVqN4Ly2aCHlYHY/b16rz0tB0l0iBHw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from liqiong-suma.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 2FB9E6018DA72;
	Fri, 25 Jul 2025 14:49:41 +0800 (CST)
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
Subject: [PATCH v2] mm: slub: avoid deref of free pointer in sanity checks if object is invalid
Date: Fri, 25 Jul 2025 14:49:19 +0800
Message-Id: <20250725064919.1785537-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250725024854.1201926-1-liqiong@nfschina.com>
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
Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
v2:
- rephrase the commit message, add comment for object_err().
---
 mm/slub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 31e11ef256f9..8b24f1cf3079 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1097,6 +1097,10 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 			      size_from_object(s) - off);
 }
 
+/*
+ * object - should be a valid object.
+ * check_valid_pointer(s, slab, object) should be true.
+ */
 static void object_err(struct kmem_cache *s, struct slab *slab,
 			u8 *object, const char *reason)
 {
@@ -1587,7 +1591,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 		return 0;
 
 	if (!check_valid_pointer(s, slab, object)) {
-		object_err(s, slab, object, "Freelist Pointer check fails");
+		slab_err(s, slab, "Invalid object pointer 0x%p", object);
 		return 0;
 	}
 
-- 
2.30.2


