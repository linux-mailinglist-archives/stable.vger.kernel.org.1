Return-Path: <stable+bounces-152268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D12AD3392
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D17170E59
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0069A28C2AF;
	Tue, 10 Jun 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="QvgBPDx5"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78915284680;
	Tue, 10 Jun 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551334; cv=none; b=pnNNhqp2f2aWApw6GitlDaQAFwdNPAC8C5E0hmjqITkxyLbiRUop3tuVl3pm8JbNvhF9gb+oTC6zOU5zIuMuRKywCI2GuoSlDB03KFJZ8iAt3SP2MdlsUhIxmZjMlxTzhdnIpNr0Y21l+N/f5KZzy6EN/uGoNVxslEnj4DIU458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551334; c=relaxed/simple;
	bh=87Sa9prsqBujVHU75yypG7WaYPYPhnkJiAVyIBtkY/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjGyqZBgvjWxPkBNWZ/Z1BEbAQ5Un2DO1lUhUCLqwuZp5E+PyN5dt1uqW5GIBkATKdG2EXqKFZt2TSDq5KOvHFVFyBjC8+DJDp9QClWdr4haxgGW7G956OGld4YR/fHVnQep7YIyCL/oMRXj0NTCqoTbtaUgD6y/J8nNhUvZUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=QvgBPDx5; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1749551321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qwQf2HtjJGXqLDF6pu9d9rM8pZBwE9ppbLVIKcMXujs=;
	b=QvgBPDx55WS4tlLWumz95aTE0ZvL0wGpgD4TCsjIGZ64GqS1qP4qMZotYCg5j+ZlXAgxfv
	HXCHNjAokdI5+qOFP67VDrlSB080xxvkLXdVhuXyWK+ZXWMpqwoZ2NZXtcS4/x1B6iXv5Y
	EHsLwQklLlx/1IffMIeBVYGcZDySMoU=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 5.10] lib/generic-radix-tree.c: Don't overflow in peek()
Date: Tue, 10 Jun 2025 13:28:39 +0300
Message-ID: <20250610102841.18225-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kent Overstreet <kent.overstreet@gmail.com>

commit 9492261ff2460252cf2d8de89cdf854c7e2b28a0 upstream. 

When we started spreading new inode numbers throughout most of the 64
bit inode space, that triggered some corner case bugs, in particular
some integer overflows related to the radix tree code. Oops.

Fixes: ba20ba2e3743 ("generic radix trees")
Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
[Denis: minor fix to resolve merge conflict and add tag Fixes]                                           
Signed-off-by: Denis Arefev <arefev@swemel.ru>                                    
---
Backport fix for CVE-2021-47432
Link: https://nvd.nist.gov/vuln/detail/cve-2021-47432
---
 include/linux/generic-radix-tree.h |  7 +++++++
 lib/generic-radix-tree.c           | 17 ++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index bfd00320c7f3..0e7abc635e5f 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -39,6 +39,7 @@
 #include <asm/page.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/log2.h>
 
 struct genradix_root;
@@ -183,6 +184,12 @@ void *__genradix_iter_peek(struct genradix_iter *, struct __genradix *, size_t);
 static inline void __genradix_iter_advance(struct genradix_iter *iter,
 					   size_t obj_size)
 {
+	if (iter->offset + obj_size < iter->offset) {
+		iter->offset	= SIZE_MAX;
+		iter->pos	= SIZE_MAX;
+		return;
+	}
+
 	iter->offset += obj_size;
 
 	if (!is_power_of_2(obj_size) &&
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 34d3ac52de89..78f081d695d0 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -168,6 +168,10 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 	struct genradix_root *r;
 	struct genradix_node *n;
 	unsigned level, i;
+
+	if (iter->offset == SIZE_MAX)
+		return NULL;
+
 restart:
 	r = READ_ONCE(radix->root);
 	if (!r)
@@ -186,10 +190,17 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 			(GENRADIX_ARY - 1);
 
 		while (!n->children[i]) {
+			size_t objs_per_ptr = genradix_depth_size(level);
+
+			if (iter->offset + objs_per_ptr < iter->offset) {
+				iter->offset	= SIZE_MAX;
+				iter->pos	= SIZE_MAX;
+				return NULL;
+			}
+
 			i++;
-			iter->offset = round_down(iter->offset +
-					   genradix_depth_size(level),
-					   genradix_depth_size(level));
+			iter->offset = round_down(iter->offset + objs_per_ptr,
+						  objs_per_ptr);
 			iter->pos = (iter->offset >> PAGE_SHIFT) *
 				objs_per_page;
 			if (i == GENRADIX_ARY)
-- 
2.43.0


