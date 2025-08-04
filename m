Return-Path: <stable+bounces-166430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1620BB199FE
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 03:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F563B75E9
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 01:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08D215624D;
	Mon,  4 Aug 2025 01:46:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id CE8121D554;
	Mon,  4 Aug 2025 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754272016; cv=none; b=i54rhc05KyUs0NGQJ7Rf5oBbx5KliaadGIOkDhKZER82Ya2qeQxa/Aa2pH/kWlSwKgLEwAS6IZvCWQExwNPioo84OZklJTRePiT8DmR3xKHPshy7eWYcwk71gKqqyMsLReXmJCAA4ppYYL3di1uYr+LkCbBoh7YslTM8P4SObrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754272016; c=relaxed/simple;
	bh=2QKwTsRobFd0MuAOwfvasN22K0nOFK16xy32eEWdvPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pq+Jr5DisZlNDHfBP/7jn/PFa0AW6HKLkYVJqNyAHPcg43O5l6OoZkW5Hqi6TzvThwU4lGIyr5ReFUZ7K/fSaqnwZcdadegSj41FYFUepjWcxA1+TvAeKXAjxoQrSiSBj6GAhm7ZAoRilvYL7fgxKr6kWE1QslA6PvbCZs7847A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from liqiong-suma.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id B20F7601096DA;
	Mon,  4 Aug 2025 09:46:45 +0800 (CST)
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
Subject: [PATCH v5] mm/slub: avoid accessing metadata when pointer is invalid in object_err()
Date: Mon,  4 Aug 2025 09:46:25 +0800
Message-Id: <20250804014626.134396-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

object_err() reports details of an object for further debugging, such as
the freelist pointer, redzone, etc. However, if the pointer is invalid,
attempting to access object metadata can lead to a crash since it does
not point to a valid object.

In case check_valid_pointer() returns false for the pointer, only print
the pointer value and skip accessing metadata.

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
v5:
- rephrase message, fix code style.
---
 mm/slub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 31e11ef256f9..b3eff1476c85 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1104,7 +1104,12 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
 		return;
 
 	slab_bug(s, reason);
-	print_trailer(s, slab, object);
+	if (!check_valid_pointer(s, slab, object)) {
+		print_slab_info(slab);
+		pr_err("Invalid pointer 0x%p\n", object);
+	} else {
+		print_trailer(s, slab, object);
+	}
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
 	WARN_ON(1);
-- 
2.30.2


