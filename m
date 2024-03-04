Return-Path: <stable+bounces-26167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B25870D66
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96F628F327
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA4C7BAE6;
	Mon,  4 Mar 2024 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="syrETlyX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8177B3C3;
	Mon,  4 Mar 2024 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588016; cv=none; b=Bwz/3LHGhctvlLYV8Y3vpWqkcieQNC1VLcg6Oy0ETh48X2VyFtLCo5433fATOV7tloYSu6ygHrVFUap9hKi42y6dYjrHIjRTHyzf2IThlnOSkFnozgRAB7ebH6pgHBgOLKBQyRTACQlb2AvolOeMZ4C9fOghuAqJJhUM8Y4xoN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588016; c=relaxed/simple;
	bh=XQ1pjmjFPCOlvHE0ATSTeyHTRZsvChImDuySMHv3Td0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmbjrA9NGWOHjS7tT19/gwr0jetQLBvSOY+IdaWzxnxU8epLhfn3KBOxIqe3zXL18SGdAvpJJogVkw2bXZKboDub7zOSiWPqI/sJmBQS70Z4+5VGy+NYbkTuSChQ1k+0sil+ltH1Bp4gnAjGDzgmgGd+tzuLeJF45jIsI54rP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=syrETlyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31FBC433F1;
	Mon,  4 Mar 2024 21:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588016;
	bh=XQ1pjmjFPCOlvHE0ATSTeyHTRZsvChImDuySMHv3Td0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=syrETlyXT2q8Gv5VmtwUte0vlvvsil7Q8koMvoZ+1E3shsdighLkupUbaEdanAF6R
	 ETTZxFkbYHLfkECfPYTWQdCSrEcLaRkfwOHs0CBRkbpyD8vYL5M+Z9FaWBsMMUYm0f
	 AdGdYshG8QpiokZ7dsK47BGNttNt6A7a/DrljpK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 15/25] afs: Fix endless loop in directory parsing
Date: Mon,  4 Mar 2024 21:23:51 +0000
Message-ID: <20240304211536.253048464@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211535.741936181@linuxfoundation.org>
References: <20240304211535.741936181@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 5f7a07646655fb4108da527565dcdc80124b14c4 ]

If a directory has a block with only ".__afsXXXX" files in it (from
uncompleted silly-rename), these .__afsXXXX files are skipped but without
advancing the file position in the dir_context.  This leads to
afs_dir_iterate() repeating the block again and again.

Fix this by making the code that skips the .__afsXXXX file also manually
advance the file position.

The symptoms are a soft lookup:

        watchdog: BUG: soft lockup - CPU#3 stuck for 52s! [check:5737]
        ...
        RIP: 0010:afs_dir_iterate_block+0x39/0x1fd
        ...
         ? watchdog_timer_fn+0x1a6/0x213
        ...
         ? asm_sysvec_apic_timer_interrupt+0x16/0x20
         ? afs_dir_iterate_block+0x39/0x1fd
         afs_dir_iterate+0x10a/0x148
         afs_readdir+0x30/0x4a
         iterate_dir+0x93/0xd3
         __do_sys_getdents64+0x6b/0xd4

This is almost certainly the actual fix for:

        https://bugzilla.kernel.org/show_bug.cgi?id=218496

Fixes: 57e9d49c5452 ("afs: Hide silly-rename files from userspace")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/786185.1708694102@warthog.procyon.org.uk
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Markus Suvanto <markus.suvanto@gmail.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 8bed9df092301..1ada9b9cb21ec 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -426,8 +426,10 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 		    dire->u.name[0] == '.' &&
 		    ctx->actor != afs_lookup_filldir &&
 		    ctx->actor != afs_lookup_one_filldir &&
-		    memcmp(dire->u.name, ".__afs", 6) == 0)
+		    memcmp(dire->u.name, ".__afs", 6) == 0) {
+			ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
 			continue;
+		}
 
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
-- 
2.43.0




