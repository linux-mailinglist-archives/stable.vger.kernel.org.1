Return-Path: <stable+bounces-89979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFDA9BDC30
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90A31F21965
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F5B1DBB35;
	Wed,  6 Nov 2024 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U23z9XtD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36211DBB2C;
	Wed,  6 Nov 2024 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859059; cv=none; b=WLHVK2RWmkQv3GMzOO0zi9B1yBYiW8MuxdWMGfHzboKLH9CcpqeMSBi/Be/uFos975vmDdUTZI76FarLfueXlsQeKELGIQFqLjhBOUqXvI0tX2uaqszxSQDB+8+wPgKyhn/wycYbk1MO5PJnMBy7VEI+66hPql8i0tEjYI7Z39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859059; c=relaxed/simple;
	bh=YOmbBYYcUiTkw6zfvx9dq7CjIfavSKjjHtkGTjxffMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bC9lBGc8IkgsgHRT80u89OY64IdAj6Xz73GfCWpCPP1czDIpSBY3OZYi/9lMj01remhPnOV3tXvXTxLFBf2XItLAMfZ83r5Q9NZsQQSjJNv+/7OQoExvHV68fE3iCB+Y+s+ASqcwlKCU579HiYOCKAeZAHbPehNaS5l5xNSzEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U23z9XtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04E1C4CECF;
	Wed,  6 Nov 2024 02:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859058;
	bh=YOmbBYYcUiTkw6zfvx9dq7CjIfavSKjjHtkGTjxffMw=;
	h=From:To:Cc:Subject:Date:From;
	b=U23z9XtDrjy4igsXH/CODbTG7gxzbSGI+LPVwRMuumWo3GK6RiClGU9uEfaWNbb3C
	 DUe6OeZ+BQNbo11ZFjcmS8wtPCjscTJdNccWMHf+t/jqO8LS10geULLK6T0jJkVoS5
	 ags3H65X+ZsJEuq+grxpS89wJ+M7JJgAqkNIocgrKvhPg6gKEtpAnLhUXTHASZjbNO
	 AjnM4R/CwXR4C4QuOQ7yZCwMhMUPAtlhAPG07tr6jjEn1DeAYGBov7K3JAYF9NA+y0
	 tynHsh5o8LCczw4uHYIgLXHWvqm8vXUMMyywmM/Zgnld4lEi02FdNAO2Ie6Xb1mSD3
	 M2H2k8x3WhbzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	konishi.ryusuke@gmail.com
Cc: syzbot+d6ca2daf692c7a82f959@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "nilfs2: fix kernel bug due to missing clearing of checked flag" failed to apply to v6.1-stable tree
Date: Tue,  5 Nov 2024 21:10:56 -0500
Message-ID: <20241106021056.181894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

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
---
 fs/nilfs2/page.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 5436eb0424bd1..10def4b559956 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -401,6 +401,7 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 
 	folio_clear_uptodate(folio);
 	folio_clear_mappedtodisk(folio);
+	folio_clear_checked(folio);
 
 	head = folio_buffers(folio);
 	if (head) {
-- 
2.43.0





