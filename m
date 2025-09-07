Return-Path: <stable+bounces-178013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEBCB47884
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 03:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BBB7B177D
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 01:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D0815665C;
	Sun,  7 Sep 2025 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/n6xcy0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC75223
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208405; cv=none; b=ABnfqTTXhZKHBB8VxMx5vMzD8DBLethnbc2h5K7zSaTrJmfPTRztvCFUZEwO50Rif2iowTJrpALeA/CkP8SVCOxgJOHd0rAZgijohF71Nv7/XoI/60lVKnmnVZ/hcLYEyrXBv1H6GzQTSOum/WiPv1yXa9DLg2OyNE7l/fiPh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208405; c=relaxed/simple;
	bh=toH7jb/Tqc9r2lRQ4ZSLEpFNP0YKoZexKBMR/21N5Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyfQENNgXQMFJFeDjfwju5D/d/j1MI2HbweZsRUISdh1pm4PR3BiZ82zD44/7eLWSYJTzkqoq1A3BRLGtaDT0Wa3uQH3pzXTumJtPAByWWEZ+gXJuqGRrzZF/KLX4k9deA+xs5CTH6apye+9ZjcTlRV0GWLfAN6j+tXxILRFHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/n6xcy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4761C4CEE7;
	Sun,  7 Sep 2025 01:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208404;
	bh=toH7jb/Tqc9r2lRQ4ZSLEpFNP0YKoZexKBMR/21N5Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/n6xcy0HmyynRru0PEhTHJ6gCmu84DKXyP3GRyXjQYvZetUveZ6LoYoAG0UP3t18
	 UFdStka/Il/vD657M1dRfSX1sII030XQCpw5KudFC3vcaI5mQEWGNTPHyARVGzL5LG
	 k/Ldecxk7mXVT+DvQ6a/FpffNdvbGuiXm2xWh6m/n8cEY1fOiLeV/qyD6xdeXRGo/O
	 ZeGia9skUf+K5rK3QsgaDT8OG/9AD8bioulcbml9v/ZBlkz0l7FOsIvLsh/9Rs1b5j
	 XLtFZWbW3WrqKwgdSgsj2TEWd4TMHTYRwbzij7EluxemDYLxCIdG8A7y8qsx7YbEK1
	 NtK1qpuMtN1vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Qiong <liqiong@nfschina.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/slub: avoid accessing metadata when pointer is invalid in object_err()
Date: Sat,  6 Sep 2025 21:26:41 -0400
Message-ID: <20250907012641.385388-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090620-evaluator-visiting-ac7e@gregkh>
References: <2025090620-evaluator-visiting-ac7e@gregkh>
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
index 157527d7101be..f118fcc6af6e4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -927,7 +927,12 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
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


