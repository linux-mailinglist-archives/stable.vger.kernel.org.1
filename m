Return-Path: <stable+bounces-177977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659CB47634
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A711C20B6A
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE61E5B88;
	Sat,  6 Sep 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pk1yOywN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0017B1F4CAF
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183971; cv=none; b=iGEViM7TxA9POJPl8NCzcU+dsDpfhjqjW5ThRWWondj8EjPbgpw8ivz4pSo9/0NbCWjWoyhUIMUxe00fGhcQyBCOSv20GomAwsUCwOAwGj8PMLLVEG0+0QOCHh8jb7BiGFcPCLD/7QvBdjOBFyO6jL5a5Rg07KmDqnxnh7f6aIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183971; c=relaxed/simple;
	bh=r8ZL1TY2716pPYt9qh7HYLnTYRd+hchm2r4Sew2vys8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MkzInPabK7eoPzIX1osSyBI4QWR98q1xfCU86/nT482r7GsKgAFXrq7deS80KeXrXEKe6no83p1/WlKQMw3oUWDL9T4bPzZRVUCCqdpdJhId2EOQIHASnGzYi70x51GKklPTOpAKaJeIpjOXnoVym8jbhqf8r92Hl4nttp3fZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pk1yOywN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286BAC4CEF7;
	Sat,  6 Sep 2025 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757183970;
	bh=r8ZL1TY2716pPYt9qh7HYLnTYRd+hchm2r4Sew2vys8=;
	h=Subject:To:Cc:From:Date:From;
	b=pk1yOywN+UGpXjPlOIenu9WyxZPuZj/kZ+tpoKWRnj4uEB65qdFKT3d51f1nzRHzw
	 wyzuGO2e1+q+52bcSWb0FcS5UCBJcx2avOTorcU9Ots0MbL7IQvWgajWqTJhIKoKdI
	 I3yxQqQrpYkHA+y1F6NDVdyHoaoo2/yrZnQcJBR4=
Subject: FAILED: patch "[PATCH] mm/slub: avoid accessing metadata when pointer is invalid in" failed to apply to 6.1-stable tree
To: liqiong@nfschina.com,harry.yoo@oracle.com,stable@vger.kernel.org,vbabka@suse.cz,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 06 Sep 2025 20:39:20 +0200
Message-ID: <2025090620-evaluator-visiting-ac7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b4efccec8d06ceb10a7d34d7b1c449c569d53770
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025090620-evaluator-visiting-ac7e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b4efccec8d06ceb10a7d34d7b1c449c569d53770 Mon Sep 17 00:00:00 2001
From: Li Qiong <liqiong@nfschina.com>
Date: Mon, 4 Aug 2025 10:57:59 +0800
Subject: [PATCH] mm/slub: avoid accessing metadata when pointer is invalid in
 object_err()

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

diff --git a/mm/slub.c b/mm/slub.c
index 30003763d224..1787e4d51e48 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1140,7 +1140,12 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
 		return;
 
 	slab_bug(s, reason);
-	print_trailer(s, slab, object);
+	if (!object || !check_valid_pointer(s, slab, object)) {
+		print_slab_info(slab);
+		pr_err("Invalid pointer 0x%p\n", object);
+	} else {
+		print_trailer(s, slab, object);
+	}
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
 	WARN_ON(1);


