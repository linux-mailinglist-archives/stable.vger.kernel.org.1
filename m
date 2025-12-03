Return-Path: <stable+bounces-198938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31853CA0E2C
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF5073276D5C
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F6230E822;
	Wed,  3 Dec 2025 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Diq4Lbvm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06C30ACF4;
	Wed,  3 Dec 2025 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778162; cv=none; b=Com/cayOeUgt2XRYH8s1cakRyavECyNa0d5asJFdfW9e+XSnOw0t0k6MXBlFI+ZS0pjFtXYncHHAXMUWLwUzKfFyuwsOxVoRFoJVTdffhsUYoGkyy9Z3/IHbgyCEW1hAddGK1HQu4nx4AlK4FT+gmuWdDk8vPPYZXW8MmS9EibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778162; c=relaxed/simple;
	bh=faugFwRJc/YpqNPS+N0yakorTBt+cPqOMKWQMUVkiyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xews8luRuT3F6jz1+T3W9Py1pXqoR0Ubm1TydjQhy/vBBTf+sf39gu0HLlqgGmFjzi1K91xyVQy3P58j/Z6uBMeOj72pifRTEmF5gNRBV8UGhXGSwDOQ10LCkX3Bw4OJSxS20Y3FBHWMYeiAwdQT+IBfIyv4EmG+xtiSwOTuN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Diq4Lbvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B681C4CEF5;
	Wed,  3 Dec 2025 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764778162;
	bh=faugFwRJc/YpqNPS+N0yakorTBt+cPqOMKWQMUVkiyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Diq4Lbvme8CtpzsrKlEjllx28iFz0/GQX3trFnnqLlFojPT250kjn3RyIoTphgO91
	 uIWYqoCg2NwLIZvCNeJqtzdCG4xZgeiSXAAhn1Ey7L4hQw9rwM7HwhYG9SD/5HECDh
	 5FlJuJdc96Cxr/Fd+vajlzcOdjMk4WqImm/gnMXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 262/392] NFSv4: Fix an incorrect parameter when calling nfs4_call_sync()
Date: Wed,  3 Dec 2025 16:26:52 +0100
Message-ID: <20251203152423.808367403@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 1f214e9c3aef2d0936be971072e991d78a174d71 ]

The Smatch static checker noted that in _nfs4_proc_lookupp(), the flag
RPC_TASK_TIMEOUT is being passed as an argument to nfs4_init_sequence(),
which is clearly incorrect.
Since LOOKUPP is an idempotent operation, nfs4_init_sequence() should
not ask the server to cache the result. The RPC_TASK_TIMEOUT flag needs
to be passed down to the RPC layer.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Fixes: 76998ebb9158 ("NFSv4: Observe the NFS_MOUNT_SOFTREVAL flag in _nfs4_proc_lookupp")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5c29e2d383639..768433688cb2f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4533,16 +4533,19 @@ static int _nfs4_proc_lookupp(struct inode *inode,
 	};
 	unsigned short task_flags = 0;
 
-	if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
+	if (server->flags & NFS_MOUNT_SOFTREVAL)
 		task_flags |= RPC_TASK_TIMEOUT;
+	if (server->caps & NFS_CAP_MOVEABLE)
+		task_flags |= RPC_TASK_MOVEABLE;
 
 	args.bitmask = nfs4_bitmask(server, label);
 
 	nfs_fattr_init(fattr);
+	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
 
 	dprintk("NFS call  lookupp ino=0x%lx\n", inode->i_ino);
-	status = nfs4_call_sync(clnt, server, &msg, &args.seq_args,
-				&res.seq_res, task_flags);
+	status = nfs4_do_call_sync(clnt, server, &msg, &args.seq_args,
+				   &res.seq_res, task_flags);
 	dprintk("NFS reply lookupp: %d\n", status);
 	return status;
 }
-- 
2.51.0




