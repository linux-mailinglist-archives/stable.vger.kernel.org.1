Return-Path: <stable+bounces-9483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC4D823292
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA15281C26
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806C1C28A;
	Wed,  3 Jan 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PwccQkgy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5B1BDDE;
	Wed,  3 Jan 2024 17:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08B5C433C7;
	Wed,  3 Jan 2024 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301734;
	bh=mnLgzuloh9Pn8y7CdocL5wyefmbpeNMVBmUy6+1+gB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PwccQkgy17b/nJlEl0RsxnqFGdLLTTkiHb2p6so8+zXyA5xDiOplGinqH1eOa3E/w
	 8+qonKF+Xdwupw4Z3cUtIHH/WGCp8va3PfzC4m0Zj2XhIC7L9qomm1li+xkiipIA2n
	 SriSFm4WsByVxIvnteW2VsqJ5fDm3/KNP65FJZZY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 15/75] afs: Fix the dynamic roots d_delete to always delete unused dentries
Date: Wed,  3 Jan 2024 17:54:56 +0100
Message-ID: <20240103164845.523450604@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>
References: <20240103164842.953224409@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 71f8b55bc30e82d6355e07811213d847981a32e2 ]

Fix the afs dynamic root's d_delete function to always delete unused
dentries rather than only deleting them if they're positive.  With things
as they stand upstream, negative dentries stemming from failed DNS lookups
stick around preventing retries.

Fixes: 66c7e1d319a5 ("afs: Split the dynroot stuff out and give it its own ops tables")
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Markus Suvanto <markus.suvanto@gmail.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dynroot.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index b35c6081dbfe1..4ddc4846a8072 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -251,20 +251,9 @@ static int afs_dynroot_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return 1;
 }
 
-/*
- * Allow the VFS to enquire as to whether a dentry should be unhashed (mustn't
- * sleep)
- * - called from dput() when d_count is going to 0.
- * - return 1 to request dentry be unhashed, 0 otherwise
- */
-static int afs_dynroot_d_delete(const struct dentry *dentry)
-{
-	return d_really_is_positive(dentry);
-}
-
 const struct dentry_operations afs_dynroot_dentry_operations = {
 	.d_revalidate	= afs_dynroot_d_revalidate,
-	.d_delete	= afs_dynroot_d_delete,
+	.d_delete	= always_delete_dentry,
 	.d_release	= afs_d_release,
 	.d_automount	= afs_d_automount,
 };
-- 
2.43.0




