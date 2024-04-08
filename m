Return-Path: <stable+bounces-37468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8590D89C4F8
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6ECA1C20306
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8303471B20;
	Mon,  8 Apr 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xCoZtIGu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4171342046;
	Mon,  8 Apr 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584322; cv=none; b=FBBSSEibnZlYQNa21iI//aA0Ne4VOw0dKc4lHwz07MGCEL1E82GTHEODaymqrN+GgaIQxf6gIavijRMRS1RLHi0MlSewuw2aof2s3v0ghtm29InQH+4gMv4gizlwCHdCMiUDoU85D/L1MuTqwfQ1Q3vpX/X63bTQiEBo9XKX2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584322; c=relaxed/simple;
	bh=IGgINQaV6PH4VBUPIRq1f7l2Sa74o8GvhMGMd44MVvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctXh73QpfevEzO5z6CTMzJtnpqcnAc0x2w+KUVZ4C6tEB08621Rvmcb8vaA01u+TpI4q8iYDdUzU/jPLAij8cOGunafILqJCfCEwXNhHKWnSfA0ogrs9o88dEmY0nUDiJ8NNUAtG5F5dwyxJVwD0XLs3/FMBFN1fCPuWc6gZAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xCoZtIGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB66C433F1;
	Mon,  8 Apr 2024 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584322;
	bh=IGgINQaV6PH4VBUPIRq1f7l2Sa74o8GvhMGMd44MVvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xCoZtIGujietBrWpIy1hxoBNDEOEam8ylELXfeUSDYvoGs8bHVOJixj4dKSO6k0Fi
	 FLHgCHFcdODYb2XM/LhYHJlUlZYvP24Uhn7fgCfzuKZrX36Y5EZXVhg35mbrqeUx+s
	 2VUDNo3fuvZ5zTvao0XWk/U/tKHwksJVQ/k+XoeY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 399/690] NFSD: Add nfsd4_send_cb_offload()
Date: Mon,  8 Apr 2024 14:54:25 +0200
Message-ID: <20240408125414.003540466@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit e72f9bc006c08841c46d27747a4debc747a8fe13 ]

Refactor for legibility.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f63c3c4c10ca7..be51338deda46 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1755,6 +1755,27 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 	nfs4_put_copy(copy);
 }
 
+static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
+{
+	struct nfsd4_copy *cb_copy;
+
+	cb_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
+	if (!cb_copy)
+		return;
+
+	refcount_set(&cb_copy->refcount, 1);
+	memcpy(&cb_copy->cp_res, &copy->cp_res, sizeof(copy->cp_res));
+	cb_copy->cp_clp = copy->cp_clp;
+	cb_copy->nfserr = copy->nfserr;
+	memcpy(&cb_copy->fh, &copy->fh, sizeof(copy->fh));
+
+	nfsd4_init_cb(&cb_copy->cp_cb, cb_copy->cp_clp,
+			&nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
+	trace_nfsd_cb_offload(copy->cp_clp, &copy->cp_res.cb_stateid,
+			      &copy->fh, copy->cp_count, copy->nfserr);
+	nfsd4_run_cb(&cb_copy->cp_cb);
+}
+
 /**
  * nfsd4_do_async_copy - kthread function for background server-side COPY
  * @data: arguments for COPY operation
@@ -1765,7 +1786,6 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 static int nfsd4_do_async_copy(void *data)
 {
 	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
-	struct nfsd4_copy *cb_copy;
 
 	if (nfsd4_ssc_is_inter(copy)) {
 		struct file *filp;
@@ -1787,20 +1807,7 @@ static int nfsd4_do_async_copy(void *data)
 	}
 
 do_callback:
-	cb_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
-	if (!cb_copy)
-		goto out;
-	refcount_set(&cb_copy->refcount, 1);
-	memcpy(&cb_copy->cp_res, &copy->cp_res, sizeof(copy->cp_res));
-	cb_copy->cp_clp = copy->cp_clp;
-	cb_copy->nfserr = copy->nfserr;
-	memcpy(&cb_copy->fh, &copy->fh, sizeof(copy->fh));
-	nfsd4_init_cb(&cb_copy->cp_cb, cb_copy->cp_clp,
-			&nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
-	trace_nfsd_cb_offload(copy->cp_clp, &copy->cp_res.cb_stateid,
-			      &copy->fh, copy->cp_count, copy->nfserr);
-	nfsd4_run_cb(&cb_copy->cp_cb);
-out:
+	nfsd4_send_cb_offload(copy);
 	cleanup_async_copy(copy);
 	return 0;
 }
-- 
2.43.0




