Return-Path: <stable+bounces-53511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C47F90D218
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB540284C9C
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADB31AB51A;
	Tue, 18 Jun 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vVz1K+dT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586FE159205;
	Tue, 18 Jun 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716546; cv=none; b=HV+WhsmkWp+T/sVmpripX/NA0kFVte6Yof06zxLc3VUxwKBEvrLGFFGj+pQwXmDjmSJSw32f6X0od8bR/bHxGGl5qUDBxve2UtU+EsUh9J7uEZ7LkLsspJOAnSonXZM61cQ4scQg3kxwSkkLTTjnHgImSEzf9mf8TfKyGZA/JTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716546; c=relaxed/simple;
	bh=NEg47CL5hq/SiQY4TczCCJrjvuyH0aLfr0dpoqQi+zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+kTZctLwNlJP11l1NqaVLmVOzmr1MM9uttJ51Gdod1jmFgSIKCEWn58RVUVz+axSKCGGu0WJc1VGRAvHIMNB1e4DYPPKDkl1pj84CY7jM41J7VA4C06WBjBfsce2XIG695Mge1tD0Klklv6TfB/xMS+klbul9BrSbwok8sT8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vVz1K+dT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69CCC3277B;
	Tue, 18 Jun 2024 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716546;
	bh=NEg47CL5hq/SiQY4TczCCJrjvuyH0aLfr0dpoqQi+zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vVz1K+dT1yfguDSoIQ0yXo3uzPr9cSNIHQdfdB+PSil7akvAznCCtES4dDAEkYcKT
	 4JfLO7TeKGe0YinMGWz/MM1kqPaRs/FPlUpYF08ky6RcvmBlu+zSzZ7fsf8UuKpeLY
	 t8mUzlg/l4bDHubzBeGGkGpEDkTa+PVQX8SwtEMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 680/770] lockd: use locks_inode_context helper
Date: Tue, 18 Jun 2024 14:38:53 +0200
Message-ID: <20240618123433.524848314@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 98b41ffe0afdfeaa1439a5d6bd2db4a94277e31b ]

lockd currently doesn't access i_flctx safely. This requires a
smp_load_acquire, as the pointer is set via cmpxchg (a release
operation).

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svcsubs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index e1c4617de7714..720684345817c 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -207,7 +207,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
 {
 	struct inode	 *inode = nlmsvc_file_inode(file);
 	struct file_lock *fl;
-	struct file_lock_context *flctx = inode->i_flctx;
+	struct file_lock_context *flctx = locks_inode_context(inode);
 	struct nlm_host	 *lockhost;
 
 	if (!flctx || list_empty_careful(&flctx->flc_posix))
@@ -262,7 +262,7 @@ nlm_file_inuse(struct nlm_file *file)
 {
 	struct inode	 *inode = nlmsvc_file_inode(file);
 	struct file_lock *fl;
-	struct file_lock_context *flctx = inode->i_flctx;
+	struct file_lock_context *flctx = locks_inode_context(inode);
 
 	if (file->f_count || !list_empty(&file->f_blocks) || file->f_shares)
 		return 1;
-- 
2.43.0




