Return-Path: <stable+bounces-92230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DF59C5477
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A0FB2B3B2
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173902123F7;
	Tue, 12 Nov 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hp5OtpBR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E320DD62;
	Tue, 12 Nov 2024 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406973; cv=none; b=cp80o/x0Bu70jjr4/YmYp6CjRe3wAxkj771KNwLfeirLdXRZQ1TSK8k9i6oytH2dinqa1FXnKO90GlmVWpYR2C4WUKoVWSvxkuixSG3EEh0ESN7Tc9zuNGcMfmkTLp5xIdzifzYFm9kosb5Zpfica3xsBFGnAwfFke7aiT93wtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406973; c=relaxed/simple;
	bh=OSGVvaKndjAw2Ye1egS7BZPx2UO+WhP4qn4IOInITqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWYftfJ7Nro332fg4kQB1MeGQUqM8IW1iCJ88hGjmivwYNnGiEgma8MZCigBujXojQPYae4bexaOVMRyzXOKpKFuA4YPX+ftg+nZsflQuyFB3tSU5nX5QtPlfrVf+90JSoqClYOxjd3hvGilq8B654veL4mFF5wTpeSjG9Kek3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hp5OtpBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEFDC4CECD;
	Tue, 12 Nov 2024 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731406973;
	bh=OSGVvaKndjAw2Ye1egS7BZPx2UO+WhP4qn4IOInITqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hp5OtpBRpLU+StHgbv2OwDxpb2YgVbXw4cK5Q5cg1yUo1uRD2+gY/ifhhh1rh5wpR
	 Hx8UOeuX9fB12Fy/Cc5OVIpqskuwt4QAJw0IGD3GlBCMRjsZRIW7K4z4WXw+vKKDfK
	 ABvQU+LdLy1LuGbl3kJgCqafHgdzi4KraWZ9a3hE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 13/76] NFS: Add a tracepoint to show the results of nfs_set_cache_invalid()
Date: Tue, 12 Nov 2024 11:20:38 +0100
Message-ID: <20241112101840.286944596@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
References: <20241112101839.777512218@linuxfoundation.org>
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

From: Benjamin Coddington <bcodding@redhat.com>

[ Upstream commit 93c2e5e0a9ecfc183ab1204e1ecaa7ee7eb2a61a ]

This provides some insight into the client's invalidation behavior to show
both when the client uses the helper, and the results of calling the
helper which can vary depending on how the helper is called.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: 867da60d463b ("nfs: avoid i_lock contention in nfs_clear_invalid_mapping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/inode.c    | 1 +
 fs/nfs/nfstrace.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 48ade92d4ce8c..3861cd056cec3 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -219,6 +219,7 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 					  NFS_INO_DATA_INVAL_DEFER);
 	else if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
 		nfsi->cache_validity &= ~NFS_INO_DATA_INVAL_DEFER;
+	trace_nfs_set_cache_invalid(inode, 0);
 }
 EXPORT_SYMBOL_GPL(nfs_set_cache_invalid);
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 6804ca2efbf99..cbdfe091f56a6 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -162,6 +162,7 @@ DEFINE_NFS_INODE_EVENT_DONE(nfs_writeback_inode_exit);
 DEFINE_NFS_INODE_EVENT(nfs_fsync_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_fsync_exit);
 DEFINE_NFS_INODE_EVENT(nfs_access_enter);
+DEFINE_NFS_INODE_EVENT_DONE(nfs_set_cache_invalid);
 
 TRACE_EVENT(nfs_access_exit,
 		TP_PROTO(
-- 
2.43.0




