Return-Path: <stable+bounces-177974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 705F8B47631
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661E61C20B08
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE78255F39;
	Sat,  6 Sep 2025 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijFZkEYD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26B1E5B88
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183961; cv=none; b=uKLbw+4iB+HjHzuywhoQPeRE4qxkoub/XxxOIQHybegbDrKl2spFCJVrAHZTF++yCHNsAVWr5e2qSzjvzqgL/7vN0KV5BkEBD9BlOZyv7ma9GXE8ZD+l6Orcrs/lQvvOhREHAC8SNeprtwcrivId14vPnJN7nOi0fExGdWczhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183961; c=relaxed/simple;
	bh=CrfkWMTlJycAPah5Xvz0C7rcnZQMgqmtJYQbpV5TKdY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i4mk/f8OCVUNur8jADWVkmHpQHv1YQwH+fKpzJMSzN1aBdhcbkrM9/5D/6R4fniECK6hJBtPpTCgHox8AVNx2qLUoKfy3F2H5+49QOBQHbB9DqLI2cnS5zkzioBAihxpuH72oInoWMu6o1fqBljRAsexlJNRwt5q7ZljlRvv820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ijFZkEYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09640C4CEE7;
	Sat,  6 Sep 2025 18:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757183961;
	bh=CrfkWMTlJycAPah5Xvz0C7rcnZQMgqmtJYQbpV5TKdY=;
	h=Subject:To:Cc:From:Date:From;
	b=ijFZkEYDUP04gkNGRriJGtUx1EFLPFeLI+rgeqyvGgys1nGa33Pw1F8+jMCC33PuR
	 lRi2bB0qtMRzTUMbgfzGaYfqGYMkocpmB4swnXX/jfNnibB18VX0SERH3H9Wbv1uQu
	 5UGXkyXPd7GTbOlmpc59kAE+REx5sRpWnrz8xRcU=
Subject: FAILED: patch "[PATCH] mm/slub: avoid accessing metadata when pointer is invalid in" failed to apply to 6.12-stable tree
To: liqiong@nfschina.com,harry.yoo@oracle.com,stable@vger.kernel.org,vbabka@suse.cz,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 06 Sep 2025 20:39:18 +0200
Message-ID: <2025090618-patient-manlike-340f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b4efccec8d06ceb10a7d34d7b1c449c569d53770
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025090618-patient-manlike-340f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


