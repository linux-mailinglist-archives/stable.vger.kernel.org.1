Return-Path: <stable+bounces-102903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E919EF61C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA44189FA79
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECCD2165EA;
	Thu, 12 Dec 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iQUbCIiX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE0C1487CD;
	Thu, 12 Dec 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022928; cv=none; b=SRLXV/LpyHsJpO25sWvf5frAAYfewE++MMqtrB7hKXYyu0o7MNeAnDdK5BeQkTlm3mfaDYe2qnfAvb5FMYR3c9EMvx3glVsFHzgEyt3gywyTVTqaDdeC0PqaIrcrIePbud6MOoAxNDHnDy9DahzsRNEqIgsW8mvttqYt9992e7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022928; c=relaxed/simple;
	bh=v4VVzs+PtZS894MBKe8Azg+p2Eja7JYrQoEtlid/mh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDLJItHxpn1wU7H58x8PLnaLXth01xsp+x3h2Nwz7X/yjsZtlMYUX2C63JNPMkyYX6tnDfJ+/AuLEwwod2GKPix6kr9/pvxZ29bYKLuP3SxI9Q78JDcOGg8De5KuQvozLdgSkWBhziSPwFMlbFSqf/7XpOvzXGnm0lZ0b9Z9Lwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iQUbCIiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB9FC4CECE;
	Thu, 12 Dec 2024 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022928;
	bh=v4VVzs+PtZS894MBKe8Azg+p2Eja7JYrQoEtlid/mh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQUbCIiXyp3vzzETt/IvWxJnkBjzHTMHD8uheN7ZXqxfMV4ItX2ccT+MRiM37Ivdb
	 iwaQKBV7itKRBtas23uTJy5dwnUrXnMW/Ih5WdwKS8u3F+vPmWfoqdPvJ69SGG/+RB
	 YgI+E/DCZQwSCXYfdCC5INqOsm/ukrMw/Uu18US4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thiago Rafael Becker <trbecker@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 371/565] sunrpc: remove unnecessary test in rpc_task_set_client()
Date: Thu, 12 Dec 2024 15:59:26 +0100
Message-ID: <20241212144326.288698009@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thiago Rafael Becker <trbecker@gmail.com>

[ Upstream commit 023859ce6f88f7cfc223752fb56ec453a147b852 ]

In rpc_task_set_client(), testing for a NULL clnt is not necessary, as
clnt should always be a valid pointer to a rpc_client.

Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: 4db9ad82a6c8 ("sunrpc: clear XPRT_SOCK_UPD_TIMEOUT when reset transport")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 38071a6780211..5de2fc7af268a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1096,24 +1096,21 @@ void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
 static
 void rpc_task_set_client(struct rpc_task *task, struct rpc_clnt *clnt)
 {
-
-	if (clnt != NULL) {
-		rpc_task_set_transport(task, clnt);
-		task->tk_client = clnt;
-		refcount_inc(&clnt->cl_count);
-		if (clnt->cl_softrtry)
-			task->tk_flags |= RPC_TASK_SOFT;
-		if (clnt->cl_softerr)
-			task->tk_flags |= RPC_TASK_TIMEOUT;
-		if (clnt->cl_noretranstimeo)
-			task->tk_flags |= RPC_TASK_NO_RETRANS_TIMEOUT;
-		if (atomic_read(&clnt->cl_swapper))
-			task->tk_flags |= RPC_TASK_SWAPPER;
-		/* Add to the client's list of all tasks */
-		spin_lock(&clnt->cl_lock);
-		list_add_tail(&task->tk_task, &clnt->cl_tasks);
-		spin_unlock(&clnt->cl_lock);
-	}
+	rpc_task_set_transport(task, clnt);
+	task->tk_client = clnt;
+	refcount_inc(&clnt->cl_count);
+	if (clnt->cl_softrtry)
+		task->tk_flags |= RPC_TASK_SOFT;
+	if (clnt->cl_softerr)
+		task->tk_flags |= RPC_TASK_TIMEOUT;
+	if (clnt->cl_noretranstimeo)
+		task->tk_flags |= RPC_TASK_NO_RETRANS_TIMEOUT;
+	if (atomic_read(&clnt->cl_swapper))
+		task->tk_flags |= RPC_TASK_SWAPPER;
+	/* Add to the client's list of all tasks */
+	spin_lock(&clnt->cl_lock);
+	list_add_tail(&task->tk_task, &clnt->cl_tasks);
+	spin_unlock(&clnt->cl_lock);
 }
 
 static void
-- 
2.43.0




