Return-Path: <stable+bounces-164712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07837B116B0
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 04:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 968277A94EC
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 02:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4877D23AB90;
	Fri, 25 Jul 2025 02:49:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0C898230BD2;
	Fri, 25 Jul 2025 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753411777; cv=none; b=BDJTTRO2RzrNC79pTWxUdq5wQDejOoB6h/cexAEOBGMAaAI32PeYpiU1Puic/QDiJ7BgPF4ExKoAtHpwVW3tzqBW4iYV9phlwUYE/ZucjJufm0IQzri9uT8k2+1R50NQGM9tHGfFsqFrvcPaPNwLJtb0J6MIHZzoKdSJP3CDwQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753411777; c=relaxed/simple;
	bh=bu26tGuEinAdBeSGy8/0dQi7Mta9faIB03YdcSPptrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cixipY+vrtJo1qpWlc3asX0cSXOLlp0KrSfBQ9Xhp3JVTRqQ8XuUDgIH4TO4+7DI54VLCTDm0EQT9AJu6+se67fITryRHqdHmEoerq2Sq56g82V7Ix1F6ABah3CWf7JfQApt50Z65PP6EYCe0IcB0AW8L+FXIOyqTvWEWD1q1XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from liqiong-suma.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 82BB560187F56;
	Fri, 25 Jul 2025 10:49:17 +0800 (CST)
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
Subject: [PATCH] mm: slub: fix dereference invalid pointer in alloc_consistency_checks
Date: Fri, 25 Jul 2025 10:48:54 +0800
Message-Id: <20250725024854.1201926-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In object_err(), need dereference the 'object' pointer, it may cause
a invalid pointer fault. Use slab_err() instead.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 31e11ef256f9..3a2e57e2e2d7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1587,7 +1587,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 		return 0;
 
 	if (!check_valid_pointer(s, slab, object)) {
-		object_err(s, slab, object, "Freelist Pointer check fails");
+		slab_err(s, slab, "Freelist Pointer (0x%p) check fails", object);
 		return 0;
 	}
 
-- 
2.30.2


