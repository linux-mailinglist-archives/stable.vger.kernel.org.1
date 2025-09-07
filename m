Return-Path: <stable+bounces-178016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7046AB478B4
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 04:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113603C2748
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 02:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BA31AA7BF;
	Sun,  7 Sep 2025 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDugXCVI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A627707
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757212056; cv=none; b=us11Ml8l1wRI6Y0EGpGMV42dtl89/4CpgsflDbGBw1X7X1h+3zOmOVBa72rubTremkLFWieMdAzoOmMOFb9VkG8xFbnPPxfpnqCZJ7aMynOAc84x0DTPKCP7ioPKlaqtI1T616s3kOXCErOr4b7sbAlK3Y44BON8DmPu/JKR0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757212056; c=relaxed/simple;
	bh=0rB1T3W8IbmzS2nz38OFj8dj/ItPzLmz4eJ/5it+KcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWLnKXIxX4bGUQG47q/ocIRci4S5oUqyD+uvF7kqrmnLQq0+DKYGZjoqOyW52qBxK6GA9BK0GVaao4l8ImTMoq5r0OyaRFAhSughLx0FA3XNpYzzN5OZJ7FHoMc8O8mevZn1alRXnDG2Yf1VPnkAs+2LG7jXmAnrlI5nApcyzek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDugXCVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160D9C4CEE7;
	Sun,  7 Sep 2025 02:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757212055;
	bh=0rB1T3W8IbmzS2nz38OFj8dj/ItPzLmz4eJ/5it+KcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDugXCVI1koh/aLVVASqLCMXMGJfBY26mjhSTYNHSYT1kw9IWvK4JLEjWdhSEFaWR
	 K+aSW69UznIKQwsNFKuIuV9lJq4W4+zCxV5b9V95oGFSjWJQrPz0zr7CNfjwRPBYU4
	 XOITMlvEmuE0wjO928LFSX2kK1rvXlz0SZUnazQdBFDnA9VXIab0PBIbPwuEUlLz7Y
	 ZdmxPWlCcox8SbTbONxjmSDw2ANDdPCQ3lbdLx+CwDP9IfeE5f19kbvcEl2jk/mkdp
	 9d6ShqeuqwtV0FYUQKERcMvPPQLfYogob1WT7nZ06pk7yQoG7Z+l/Vhdn1XqmKXmzb
	 wMKhAkO7I0rEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Qiong <liqiong@nfschina.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/slub: avoid accessing metadata when pointer is invalid in object_err()
Date: Sat,  6 Sep 2025 22:27:33 -0400
Message-ID: <20250907022733.411422-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090621-plank-carry-3541@gregkh>
References: <2025090621-plank-carry-3541@gregkh>
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
index b0f637519ac99..30daba09da35d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -729,7 +729,12 @@ void object_err(struct kmem_cache *s, struct page *page,
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


