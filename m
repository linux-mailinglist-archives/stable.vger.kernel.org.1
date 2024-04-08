Return-Path: <stable+bounces-37599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CED389C59E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8CC1F21243
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C247C08C;
	Mon,  8 Apr 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYAhjJdz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E979F0;
	Mon,  8 Apr 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584706; cv=none; b=XySQwViA1yPPLXz5P/iS0GuxFra5bkX+twpWsTtLu+SDBQ2YYSG8XccGeNMPc80k8Pg2rMcy7Zv0dUbTFjxpJEfcQG2q5TmjK2vxjqoorE4MXNVg25mqU+GB0aljmXlq88or0dmNEED2gIJbHcXCEHkv0pccj1CO3ZchiPMcXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584706; c=relaxed/simple;
	bh=kjXT+9MQngyZsx2xAXD2LP4hj06lL8qq55KKvB+0w9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utde1YC56TwXZq5YOiDfABkxhZbt5na9bb2qnhNlfnmowmApSPVUII38cQdU0ua+1X1ckjraIQvWmMkwrb96HXcUmEzO4diG2juJGvaYdu4iqUSPcdx3bUHycA6l9W/sz1GTjhLyzhnbda8Ypu3/ZqGjsGibp7EcJ9/DMXw1Cws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYAhjJdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A365C433C7;
	Mon,  8 Apr 2024 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584706;
	bh=kjXT+9MQngyZsx2xAXD2LP4hj06lL8qq55KKvB+0w9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYAhjJdzzi2JAngp+fSo2lxjzKuCH2RSrLUSjZV46QUOu25GWdmOQEaAqPqdhDASh
	 A0Fj0KTf6VHDi5aJTWX1LgThdo8Q4r74dWU3CbUMhOThvEzXHJSetACUEt43rg35lM
	 P9GLSLmqNaPAc+q1yck19X4AHgWyzJZVdw04W68U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 530/690] nfsd: NFSD_FILE_KEY_INODE only needs to find GCed entries
Date: Mon,  8 Apr 2024 14:56:36 +0200
Message-ID: <20240408125418.850054341@linuxfoundation.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 6c31e4c98853a4ba47355ea151b36a77c42b7734 ]

Since v4 files are expected to be long-lived, there's little value in
closing them out of the cache when there is conflicting access.

Change the comparator to also match the gc value in the key. Change both
of the current users of that key to set the gc value in the key to
"true".

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 677a8d935ccc2..4ddc82b84f7c4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -174,6 +174,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
 
 	switch (key->type) {
 	case NFSD_FILE_KEY_INODE:
+		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
+			return 1;
 		if (nf->nf_inode != key->inode)
 			return 1;
 		break;
@@ -694,6 +696,7 @@ nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_INODE,
 		.inode	= inode,
+		.gc	= true,
 	};
 	struct nfsd_file *nf;
 
@@ -1048,6 +1051,7 @@ nfsd_file_is_cached(struct inode *inode)
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_INODE,
 		.inode	= inode,
+		.gc	= true,
 	};
 	bool ret = false;
 
-- 
2.43.0




