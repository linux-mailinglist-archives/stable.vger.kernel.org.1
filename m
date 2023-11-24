Return-Path: <stable+bounces-639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D19B7F7BEE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFC11C21040
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C339FD4;
	Fri, 24 Nov 2023 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ALPbmpka"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5C5381D7;
	Fri, 24 Nov 2023 18:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753C6C433C8;
	Fri, 24 Nov 2023 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849403;
	bh=ee0T5pvOjn0TGm7JIaXUGLWQlsu+BKRNzwabdmOZdN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALPbmpkabHkMToUYAZrc53fMBCphqiN21mEkVtO3A21FQg/qp2n6n6f8/sl4T9vwC
	 b+TPgDko3hPG2SNOmYRpZgYyVJyUV8mIyjybLc4AcjC0VG5AcM7Epv9XW2A9mDj5fx
	 KZK44wiluc5kCHiuIKHLZXlQhUQxiCl10A6Ix/Vg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 168/530] SUNRPC: Add an IS_ERR() check back to where it was
Date: Fri, 24 Nov 2023 17:45:34 +0000
Message-ID: <20231124172033.193632310@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 4f3ed837186fc0d2722ba8d2457a594322e9c2ef ]

This IS_ERR() check was deleted during in a cleanup because, at the time,
the rpcb_call_async() function could not return an error pointer.  That
changed in commit 25cf32ad5dba ("SUNRPC: Handle allocation failure in
rpc_new_task()") and now it can return an error pointer.  Put the check
back.

A related revert was done in commit 13bd90141804 ("Revert "SUNRPC:
Remove unreachable error condition"").

Fixes: 037e910b52b0 ("SUNRPC: Remove unreachable error condition in rpcb_getport_async()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/rpcb_clnt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 5988a5c5ff3f0..102c3818bc54d 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -769,6 +769,10 @@ void rpcb_getport_async(struct rpc_task *task)
 
 	child = rpcb_call_async(rpcb_clnt, map, proc);
 	rpc_release_client(rpcb_clnt);
+	if (IS_ERR(child)) {
+		/* rpcb_map_release() has freed the arguments */
+		return;
+	}
 
 	xprt->stat.bind_count++;
 	rpc_put_task(child);
-- 
2.42.0




