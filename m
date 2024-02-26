Return-Path: <stable+bounces-23651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E1867166
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB31C1C24BD9
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4902556455;
	Mon, 26 Feb 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u/HgZEc6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046FE55C3F
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943432; cv=none; b=UcFKJxqlBxl2ewvNiac7Fux3ICEzddxYKVu76oiOHe6xDnyPS5KUy0MDaq+uxTLM//V9W42wKnumtFAATKJhjSyD1Qw6B2ePqMwC0T/Jc3YBGu0MbjeWLsjiCfl94DjB8qPbegIrm+zgUDb/nal6rJaC2dNWlVXX2uTIdXItA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943432; c=relaxed/simple;
	bh=+VCPOL1lKLYKHxf+stDyWryzyns485o88uTv6L/JYbs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K+zGafEzFLQLwwYX0osV4SZuCWdlhi6WBrk3eRfGtU6AbuNCM8SvY7G971B0rJ64nZNaOb4j3sqS4ivrbJD88K1OjEHzCOtNK1EdxWBRHInAoQwCGqDheZh1o2zn/E9hZENFyLyTCUyiM/OUvpBdk9fX8X1ZpymxSa/U8Rm1C6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u/HgZEc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22891C433F1;
	Mon, 26 Feb 2024 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943431;
	bh=+VCPOL1lKLYKHxf+stDyWryzyns485o88uTv6L/JYbs=;
	h=Subject:To:Cc:From:Date:From;
	b=u/HgZEc6B6kbTpIvmGu+2Fmk7QaYQ4Dc4EzqVHtCVNL6fVcP8nHP1hkWCq4LyebfP
	 ec1oN45WXLI/yx97epRffhGPjPUHyi94AP79CWL0bxKr7HpeZu1Lev4eXtalBa+3zi
	 2eO8ERwHk+PkNIF/kv/UqiZOKoAsyO1xuRZWisd0=
Subject: FAILED: patch "[PATCH] mm/zswap: invalidate duplicate entry when !zswap_enabled" failed to apply to 6.7-stable tree
To: zhouchengming@bytedance.com,akpm@linux-foundation.org,hannes@cmpxchg.org,nphamcs@gmail.com,stable@vger.kernel.org,yosryahmed@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:30:22 +0100
Message-ID: <2024022622-agony-salvaging-5082@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 678e54d4bb9a4822f8ae99690ac131c5d490cdb1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022622-agony-salvaging-5082@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

678e54d4bb9a ("mm/zswap: invalidate duplicate entry when !zswap_enabled")
a65b0e7607cc ("zswap: make shrinking memcg-aware")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 678e54d4bb9a4822f8ae99690ac131c5d490cdb1 Mon Sep 17 00:00:00 2001
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 8 Feb 2024 02:32:54 +0000
Subject: [PATCH] mm/zswap: invalidate duplicate entry when !zswap_enabled

We have to invalidate any duplicate entry even when !zswap_enabled since
zswap can be disabled anytime.  If the folio store success before, then
got dirtied again but zswap disabled, we won't invalidate the old
duplicate entry in the zswap_store().  So later lru writeback may
overwrite the new data in swapfile.

Link: https://lkml.kernel.org/r/20240208023254.3873823-1-chengming.zhou@linux.dev
Fixes: 42c06a0e8ebe ("mm: kill frontswap")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zswap.c b/mm/zswap.c
index 36903d938c15..db4625af65fb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1518,7 +1518,7 @@ bool zswap_store(struct folio *folio)
 	if (folio_test_large(folio))
 		return false;
 
-	if (!zswap_enabled || !tree)
+	if (!tree)
 		return false;
 
 	/*
@@ -1533,6 +1533,10 @@ bool zswap_store(struct folio *folio)
 		zswap_invalidate_entry(tree, dupentry);
 	}
 	spin_unlock(&tree->lock);
+
+	if (!zswap_enabled)
+		return false;
+
 	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg)) {
 		memcg = get_mem_cgroup_from_objcg(objcg);


