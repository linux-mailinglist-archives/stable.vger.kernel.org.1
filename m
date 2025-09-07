Return-Path: <stable+bounces-178018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041DBB478B8
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 04:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946283BDB72
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 02:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D4919FA93;
	Sun,  7 Sep 2025 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACX7uz+1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EB185B67
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757212704; cv=none; b=TRAr6xErqNAA5s6AIfB0a1Fj3UbatKhIB3RpTKTpiW9Bzh8KsdfGKMQeH0S1tGTAxIQb7E//pNYumk8HlDYLhcnBWGZQH5xU/vOVHBSOTDwhoXxZwrrGkSsc726bDBWVrs39byjoUxpAYzgIL2/XUNJDutbaQHCact4UKoJyUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757212704; c=relaxed/simple;
	bh=S6KeXAe3+dFsVOSMTYP26khvqABFwgQk2W67xsuo2zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEBOe56JxaJ7ja/ujO8zCgL/rF88Qt1ZbNxIp78DD/cFfJdc4/dMWpCHWIRncUpfeJMGu0r0Z2kiAISsURT6W1V+wpXGKUZdZb8+rnhFAiWtlx+KkbiGTYdPryvg2ZlhMMcj0rMyR53E5wL/oihqOtOaaEnri1943zt4KRbBl5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACX7uz+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101C2C4CEE7;
	Sun,  7 Sep 2025 02:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757212703;
	bh=S6KeXAe3+dFsVOSMTYP26khvqABFwgQk2W67xsuo2zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACX7uz+1F9qomuYVufpzh56GRwESoNCzpZOruX2QMSBZ3+JhLUecDIqkDiwLP9Ttl
	 rWk/0QyKXahg2ftv+K1HU6Y7yShDZVWRzvhH7uW8q1Fk/Mj0tiQw4Mdg9acatKmc1h
	 dlC7xnUQF0425cyU9YDtpJSD16tNsxQX1ObxHqZluDaOqCkSOywfPXfzYkiT7TsZKj
	 dAzLzOJ48QOz/y7ZWAJ78SfBaibet/URzEK7C88U3S6bJUg0EajB1nWyOWu91boaoj
	 b5SYZQPQEXWDRg4h6+z28sAe6zKXe5R2etw0p6q7OWIaDWUvTNjFX3r5o6DE1fXJ6v
	 NHPvPjm2hTMdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Qiong <liqiong@nfschina.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] mm/slub: avoid accessing metadata when pointer is invalid in object_err()
Date: Sat,  6 Sep 2025 22:38:21 -0400
Message-ID: <20250907023821.418818-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090622-herald-satirical-de89@gregkh>
References: <2025090622-herald-satirical-de89@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Qiong <liqiong@nfschina.com>

[ Upstream commit b4efccec8d06ceb10a7d34d7b1c449c569d53770 ]

object_err() reports details of an object for further debugging, such as
the freelist pointer, redzone, etc. However, if the pointer is invalid,
attempting to access object metadata can lead to a crash since it does
not point to a valid object.

One known path to the crash is when alloc_consistency_checks()
determines the pointer to the allocated object is invalid because of a
freelist corruption, and calls object_err() to report it. The debug code
should report and handle the corruption gracefully and not crash in the
process.

In case the pointer is NULL or check_valid_pointer() returns false for
the pointer, only print the pointer value and skip accessing metadata.

Fixes: 81819f0fc828 ("SLUB core")
Cc: <stable@vger.kernel.org>
Signed-off-by: Li Qiong <liqiong@nfschina.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
[ struct page + print_page_info() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index e978f647e92aa..734f763e7d2e2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -719,7 +719,12 @@ void object_err(struct kmem_cache *s, struct page *page,
 			u8 *object, char *reason)
 {
 	slab_bug(s, "%s", reason);
-	print_trailer(s, page, object);
+	if (!object || !check_valid_pointer(s, page, object)) {
+		print_page_info(page);
+		pr_err("Invalid pointer 0x%p\n", object);
+	} else {
+		print_trailer(s, page, object);
+	}
 }
 
 static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
-- 
2.51.0


