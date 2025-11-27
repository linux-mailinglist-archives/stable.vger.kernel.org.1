Return-Path: <stable+bounces-197317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6098AC8F06D
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A12304ECE7C
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB39332EA0;
	Thu, 27 Nov 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JDM88QA5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58032C301;
	Thu, 27 Nov 2025 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255470; cv=none; b=EU89IMBsbYaE8qkp3/GubOZDo3xL8e/AqscMbVuhNRK5OueQ+omqILBCZbOsAlGs3yF5VHe0lLmkyfJ8qHnqotDgIyNts7z9u7GCJ6Qo/FaeGDz4TJS+6Ul8QXBUQS4pP2sF6plXeif7Je79l6Emwg0KrffLZS6ucv9U0/XPQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255470; c=relaxed/simple;
	bh=2s4frs8t3SID9FYWLOFF74BgnIc72SaTy/7VZ1yFWmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxFdc8/oUvr7EzFeggsMhvePPFxq9OhFG3+7yUe0JkItBPj97ZjoN2Ez9PsLZv06zmqMiINCPpsgqMUBmvCuhuSKY0FixRmNx0bviKlUo0oNKQb+yF682yBShmSnhu//xN2ffKaxVxg1AhsHaIy9nuIfFS8XoVEIQIexhKgyhgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JDM88QA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F467C4CEF8;
	Thu, 27 Nov 2025 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255470;
	bh=2s4frs8t3SID9FYWLOFF74BgnIc72SaTy/7VZ1yFWmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDM88QA5Za7aJUEZe7aHNCxsfUV912GDmDYWfD01UNkSHyb6MADUgIb+c/+LBi4k0
	 hazwlZzZrXsgW5m//JpxYdZYHauR4b8UEJhno5pHx0ZOrjD26XlRJ2ePRvX+v5bbpO
	 ypVsL8noFIfb28H8bqDhwiqc7CS5PoulMnzLZ294=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henrique Carvalho <henrique.carvalho@suse.com>
Subject: [PATCH 6.12 102/112] smb: client: fix incomplete backport in cfids_invalidation_worker()
Date: Thu, 27 Nov 2025 15:46:44 +0100
Message-ID: <20251127144036.574953666@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144032.705323598@linuxfoundation.org>
References: <20251127144032.705323598@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henrique Carvalho <henrique.carvalho@suse.com>

The previous commit bdb596ceb4b7 ("smb: client: fix potential UAF in
smb2_close_cached_fid()") was an incomplete backport and missed one
kref_put() call in cfids_invalidation_worker() that should have been
converted to close_cached_dir().

Fixes: 065bd6241227 ("smb: client: fix potential UAF in smb2_close_cached_fid()")"
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cached_dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -727,7 +727,7 @@ static void cfids_invalidation_worker(st
 	list_for_each_entry_safe(cfid, q, &entry, entry) {
 		list_del(&cfid->entry);
 		/* Drop the ref-count acquired in invalidate_all_cached_dirs */
-		kref_put(&cfid->refcount, smb2_close_cached_fid);
+		close_cached_dir(cfid);
 	}
 }
 



