Return-Path: <stable+bounces-89865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016349BD223
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9C61F21ABB
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB41384B3;
	Tue,  5 Nov 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJKROhKt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E71877
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823478; cv=none; b=u/O5yQwrhDlCY234dQ0AOP35aF4dJB19CpUPfO6pWXtWFDk0rQ/hk73Swh1qZ9x4S/IHtBiXLk/6xJxJAa9gigyHnHVdCZCGz/Uiwvqeh0ainv+0kZAPtExlwretIBf9yWJatS+9q7VnWwS9woAI9yEwpccPhEwU2X0cD+wYtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823478; c=relaxed/simple;
	bh=lMTu9cjPnSJb4TTDuaG2NKDZBEWVlGInJ/owPMVfEGA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YLddzwTh62nmYHsbRhSsZOmQFr/NAAvSeXZTaeq8U5JUj9Ocj1fZmBtngdngoc+4zrSd+P0UKm69H33rHg9mGPLwwMbL796izICHAShw+JjXNHA5mQrYf7zgHrCy2L+9Dkli+yDjQd1G00evvMGrvKZOFapJEuUoHTPzGXCqXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJKROhKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6955C4CECF;
	Tue,  5 Nov 2024 16:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730823476;
	bh=lMTu9cjPnSJb4TTDuaG2NKDZBEWVlGInJ/owPMVfEGA=;
	h=Subject:To:Cc:From:Date:From;
	b=LJKROhKtyBi+op0PBy8BByyepiOlQ7JGZ4Fu9uMX1m6mQGvdf09oFD6X7g/7i9kN9
	 xkOItAJfZv8yM5fZhQivJBC4jrRRO/l+3jsQL6vj/uh/yDztTgi7r+vRKFmyQxfTR7
	 O/pXv7fSWQSSBheimaS7Z0oS5jhScDSp2bs0aWX8=
Subject: FAILED: patch "[PATCH] nilfs2: fix kernel bug due to missing clearing of checked" failed to apply to 5.15-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:17:31 +0100
Message-ID: <2024110530-diligence-author-75bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 41e192ad2779cae0102879612dfe46726e4396aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110530-diligence-author-75bb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


