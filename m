Return-Path: <stable+bounces-89863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3CD9BD220
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614AD28821B
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A31714B6;
	Tue,  5 Nov 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lw30On8F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D4768E1
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823470; cv=none; b=HXzU+SCJzIzWN5SsZXN1a1qibkr2vFSWRcTgvR55nCSuDR7T98Z47ISYCZ/6UwMMfoeWPgcGoPng4O2iIWvBBDaBJVQVPkg8v97SaSqSlSdeydmip0/vYshIhBDB7+z9SG5nOaeQenhpvlg/mWxm9NVhtLifMa6PsWh34n6tJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823470; c=relaxed/simple;
	bh=q5yT2r5VA/0DCebFLooG90ejdDnuGae9hW3KVWMI6+4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DlQCuB2sguTZyyKwJieQDLipaa+Bt/yJtlBGO7bMsyciP3Q8TEb3jyF2fYGB5Et++dkQC756p9e7xky9JiLBkKcs779GyavTuTLhC+h+aGrl8k5v/RRtkg9eyHp+fBRT6E/xACVko0HBlIMiE1NUTb4iNuN6ke4Po5/61ZeA0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lw30On8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E3CC4CECF;
	Tue,  5 Nov 2024 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730823470;
	bh=q5yT2r5VA/0DCebFLooG90ejdDnuGae9hW3KVWMI6+4=;
	h=Subject:To:Cc:From:Date:From;
	b=Lw30On8FCDzUeAJR7D7UTgOi1gJVA1erJt9NKco9RI70aFblo+jqwynreM8W3QdQm
	 Ep77kQfppZOfK8mgPsqbnNBGDt4G3Gb2jhtkXPG38SlP2UqOwoyKkfhIGdIjaE+TNm
	 gUeLyMVB5/7R7P3U+dJMd263uR5ijq+AHewbraCM=
Subject: FAILED: patch "[PATCH] nilfs2: fix kernel bug due to missing clearing of checked" failed to apply to 6.1-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:17:30 +0100
Message-ID: <2024110530-elastic-reproduce-14c4@gregkh>
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
git cherry-pick -x 41e192ad2779cae0102879612dfe46726e4396aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110530-elastic-reproduce-14c4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 41e192ad2779cae0102879612dfe46726e4396aa Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 18 Oct 2024 04:33:10 +0900
Subject: [PATCH] nilfs2: fix kernel bug due to missing clearing of checked
 flag

Syzbot reported that in directory operations after nilfs2 detects
filesystem corruption and degrades to read-only,
__block_write_begin_int(), which is called to prepare block writes, may
fail the BUG_ON check for accesses exceeding the folio/page size,
triggering a kernel bug.

This was found to be because the "checked" flag of a page/folio was not
cleared when it was discarded by nilfs2's own routine, which causes the
sanity check of directory entries to be skipped when the directory
page/folio is reloaded.  So, fix that.

This was necessary when the use of nilfs2's own page discard routine was
applied to more than just metadata files.

Link: https://lkml.kernel.org/r/20241017193359.5051-1-konishi.ryusuke@gmail.com
Fixes: 8c26c4e2694a ("nilfs2: fix issue with flush kernel thread after remount in RO mode because of driver's internal error or metadata corruption")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+d6ca2daf692c7a82f959@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d6ca2daf692c7a82f959
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 5436eb0424bd..10def4b55995 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -401,6 +401,7 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 
 	folio_clear_uptodate(folio);
 	folio_clear_mappedtodisk(folio);
+	folio_clear_checked(folio);
 
 	head = folio_buffers(folio);
 	if (head) {


