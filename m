Return-Path: <stable+bounces-178012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37860B47875
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 03:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2803C12BA
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 01:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8A28F48;
	Sun,  7 Sep 2025 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUsVk2j3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD465315D38
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757207846; cv=none; b=HW7YzKN+kzJC9ZqetUyRUQflOShLax1e0mREe6qvJ3UBgeYdKZ/p8+joZAcbps4SnJSrZhnod93aFLLHwvBYq0zt80FkPijn5cSzDGzX5yB7tjbsm/NlnBQGFh065RUoo/KYSQvGcyAvQJktzb20IPhGgs+ragO0x5JX4qtEJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757207846; c=relaxed/simple;
	bh=lYr+0L8Sj/cFb65QLDwy4ERYn6/2sKqIw2qu+c8VaV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9LpTab7muGlLkkOyldBMk5exgcWv5sgBV4bvHbGKjIsNPdD7vA4LbsovWqZLSvJsjLIxy1EpByN1wGT4sAECGwM3euJEnmVxRbYPBFpaithblb/3KgjdV3XrwQmadY5/vRNmzb9ojSZodzaGvkl1GUpO5VxkEAueY6O24wMUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUsVk2j3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9518FC4CEE7;
	Sun,  7 Sep 2025 01:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757207846;
	bh=lYr+0L8Sj/cFb65QLDwy4ERYn6/2sKqIw2qu+c8VaV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUsVk2j3wEMP/KXE2Dw0NpGsJmknRZ+vstguTZdHGuflDrXh6UcUmb66jafVlVzYq
	 Apq9/lkHFzTRtQg0VPMTfylpu5g3ozu/It0drjkIOuG6ls/br3LRl1FF0hDIYPEYwc
	 E4w/eC8bKpNhsLgQvnsnskro92GHh/N8C1Jjj3W5oT/5WSHk5uJsC58bJ2XyfmdcHe
	 H3vjFbvDvgZAFQRcJ7XI0bxLF9VRSV0D4Xw5SJln27OXTYtZ7WTYQ9C3U5dMcp/A4o
	 2wUzgYwFJDVexmex6VixNQQBrE51/FnPBooMeG8Hqu7gokP3IEoOtVoMG/J3ewAVWC
	 xdDQR0+IWcKJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Qiong <liqiong@nfschina.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/slub: avoid accessing metadata when pointer is invalid in object_err()
Date: Sat,  6 Sep 2025 21:17:23 -0400
Message-ID: <20250907011723.378381-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090619-wolverine-overlaid-618b@gregkh>
References: <2025090619-wolverine-overlaid-618b@gregkh>
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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index d2544c88a5c43..391f9db1c8f38 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -988,7 +988,12 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
 		return;
 
 	slab_bug(s, "%s", reason);
-	print_trailer(s, slab, object);
+	if (!object || !check_valid_pointer(s, slab, object)) {
+		print_slab_info(slab);
+		pr_err("Invalid pointer 0x%p\n", object);
+	} else {
+		print_trailer(s, slab, object);
+	}
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
-- 
2.51.0


