Return-Path: <stable+bounces-53542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60F90D23E
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A0A1C24695
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E098415957E;
	Tue, 18 Jun 2024 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wv6m6iSA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F715958A;
	Tue, 18 Jun 2024 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716637; cv=none; b=LeGKzCi1pdVqyYtg95++UljNarejIezIs9c00dwqRE7y+gNSLON8X8wGASyPA1HrusG2fUXp9JW3GZzrUy5zcszhTb5CWLyxz3WfzPn5qT1sWcWDKBTp+HCHliOHoW6Wn48YVNNIiGvBmozDz+oYSgUBRrOs2T51c7/BALg2jxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716637; c=relaxed/simple;
	bh=kFjF1QFkC/3DhlFJPAkmBJp8pzJ+Gn2JwVeJzFn5uxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMD1v/CsatQ9VFU9QSW0eitmLeDrNxHCX3hIfoK5bchGRqJiUqW4Nzim+tHy4dss1M2JHUMgm3owdPgPU+BRrLKeAWl2Q0XZK1yWFafvcsisRK7kwCftgu/XCztnMUQryvaZ436UCym1lv4NBanNwMK3h+S+UyAPRmi5lJhFg/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wv6m6iSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B9BC3277B;
	Tue, 18 Jun 2024 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716637;
	bh=kFjF1QFkC/3DhlFJPAkmBJp8pzJ+Gn2JwVeJzFn5uxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wv6m6iSAC90LP6dmHbtWYEq9vbTOuj0I6+OFgL5r4mPJy3GNIlgbZ4d+RE8PCyPz6
	 y1KIJefDeXM+q0WFOvcNOIcWqZqo9gor/5gIBqNgsI6/Apy4TdM+Ar68eJrEx3U923
	 vIqjcdGvQNSkn9GrNEEuKNgHYqA7AuxMDnxb0cFk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 712/770] lockd: set missing fl_flags field when retrieving args
Date: Tue, 18 Jun 2024 14:39:25 +0200
Message-ID: <20240618123434.754169365@linuxfoundation.org>
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

[ Upstream commit 75c7940d2a86d3f1b60a0a265478cb8fc887b970 ]

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svc4proc.c | 1 +
 fs/lockd/svcproc.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 284b019cb6529..b72023a6b4c16 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -52,6 +52,7 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 		*filp = file;
 
 		/* Set up the missing parts of the file_lock structure */
+		lock->fl.fl_flags = FL_POSIX;
 		lock->fl.fl_file  = file->f_file[mode];
 		lock->fl.fl_pid = current->tgid;
 		lock->fl.fl_start = (loff_t)lock->lock_start;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index e35c05e278061..32784f508c810 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -77,6 +77,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 		/* Set up the missing parts of the file_lock structure */
 		mode = lock_to_openmode(&lock->fl);
+		lock->fl.fl_flags = FL_POSIX;
 		lock->fl.fl_file  = file->f_file[mode];
 		lock->fl.fl_pid = current->tgid;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
-- 
2.43.0




