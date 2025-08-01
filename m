Return-Path: <stable+bounces-165712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BDB17CCC
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 08:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249757B0101
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 06:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3042E1F12FB;
	Fri,  1 Aug 2025 06:11:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 975D42E36EA;
	Fri,  1 Aug 2025 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754028664; cv=none; b=KiIKpszFVSEus5wzPYDzJQc1w9mnNBYIqtZmUpv9LF1xryCub4qPLwYygb1uUcnZa3ZkpZcRl5y9HK6ko2jDE/dHv4XZKUerNkBSrdRg/8XhNvUSR8/9s3GdnbOG3R7xmwBkNATobC4631CH+6BLyhiYtJO/rvdLXHiIwDvTeLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754028664; c=relaxed/simple;
	bh=Ym9LS3yppxibgeF7HIrF3lh1orpt7YhnVslPDlwYK2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gbaZSHnY6/dsG/sKzoeye1cL0BiYnEIe7w4YtvWbWXqP7egA5V3SdKw1kU00zJ49fu1fxU/CASdmAS6Aueyx6yafLHZhCxhKMyjFaJLtiUBgN/yeMK4X2M9vRzATcYDWZI3oMKPUjcvObU6oljusLYHIN94yLYp+zWY0/XWFIxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from liqiong-suma.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 1632060260753;
	Fri,  1 Aug 2025 14:10:47 +0800 (CST)
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
Subject: [PATCH v4] mm: slub: avoid deref of invalid free pointer in object_err()
Date: Fri,  1 Aug 2025 14:10:36 +0800
Message-Id: <20250801061036.528069-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging, object_err() prints free pointer of the object.
However, if object is a invalid pointer, dereferncing `object + s->offset`
can lead to a crash. Therefore, add check_valid_pointer() for
the object.

Fixes: 81819f0fc828 ("SLUB core")
Cc: <stable@vger.kernel.org>
Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
v2:
- rephrase the commit message, add comment for object_err().
v3:
- check object pointer in object_err().
v4:
- restore changes in alloc_consistency_checks().
---
 mm/slub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 31e11ef256f9..17b91e74f7d9 100644
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
-- 
2.30.2


