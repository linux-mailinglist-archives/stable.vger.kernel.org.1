Return-Path: <stable+bounces-177975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B03B47632
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82385A1D11
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 18:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E727BF95;
	Sat,  6 Sep 2025 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="00ahFJZ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8E1E5B88
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183964; cv=none; b=mvfa/U5s4crS5Kgbf1cmu4ZKbydl+/anVi54JaX1SF/cswTlO4Yh9c7VJRtUmq7wvOABOr39kItU0tZXz+/ZmHH9Y8/rY2hgFpcP2XQoa4HeU7uzy6lF7HAo/Mac+Se8PwvkFXL18TMasaYJ1J3GjEk+EtYhdRVdxiHG6MmQrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183964; c=relaxed/simple;
	bh=H3uDzYcJsAfFpeiRqWChOnukifno8Sk/2L1zxutaNJQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HGBvZiVW5o2HPnGaWoPK2y9X+4plN+zh86/G0GKfWmxyB56nz37Yh6MNpS76GzeX3DYKJY84RPyt//0YSxJ/BqvzYxqDZ9WH5AgQaz2gmZl9RAYQz0Z9OHfqVzSryvGhT+6KbudXmArxEPoGSNcCACt22+gMUt7bpD3VWSCIBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=00ahFJZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F684C4CEE7;
	Sat,  6 Sep 2025 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757183964;
	bh=H3uDzYcJsAfFpeiRqWChOnukifno8Sk/2L1zxutaNJQ=;
	h=Subject:To:Cc:From:Date:From;
	b=00ahFJZ5H/CxbzWdllsNHz3djXsp8y4tpqkVMIXU1/z2Ut/3LKnEFcPeXyiS/RQu6
	 fX0APpUZQujABk9wZ7cnxCuQLcTskOcVHx7W+e+Nx1jT/r48LpgIqOr0pKd+CLt7T8
	 dcvl2U6dFRqZXURED8obpiYZC+jqdmFJqw+vQCVQ=
Subject: FAILED: patch "[PATCH] mm/slub: avoid accessing metadata when pointer is invalid in" failed to apply to 6.6-stable tree
To: liqiong@nfschina.com,harry.yoo@oracle.com,stable@vger.kernel.org,vbabka@suse.cz,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 06 Sep 2025 20:39:19 +0200
Message-ID: <2025090619-wolverine-overlaid-618b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b4efccec8d06ceb10a7d34d7b1c449c569d53770
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025090619-wolverine-overlaid-618b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


