Return-Path: <stable+bounces-182432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172DDBAD94E
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D42D3C6703
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA492FCBFC;
	Tue, 30 Sep 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vkKHcknm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F041487F4;
	Tue, 30 Sep 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244929; cv=none; b=Z5dyh5wy4WOKMgyuyDmekL3FS+XCpCls6pqRmypYyLSafxOgXi94GKMV1VeC4LJCcaE8IlamarE8hZk0VkXjsVslDv9hZ0wUt/yqTJ5+PNvt9ivrDWt+4cwjp94Jbg/gn2Z5Ilz9aIBaSqcxkwem7xPEzOZCMV5wfq0zayVKtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244929; c=relaxed/simple;
	bh=0R2j3m7cEXdX+/Kt4jQ5V3G6N6h//VALZPoJ1NcHB74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/uecT9dffqAJV576NV5arFlJX65itkr6cwIk6se70edVximYAymNf9wp++CF72il93AHTrLEbQnzBe59zjqFEzoAwuZSNqg2ZH2CFxD7E8+7esWyy1EycJ0jxt+o2LARZCqXhBztm8//fLLdR5vMBzWQ2FkTWoQYOo4BkVsMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vkKHcknm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4E1C4CEF0;
	Tue, 30 Sep 2025 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244928;
	bh=0R2j3m7cEXdX+/Kt4jQ5V3G6N6h//VALZPoJ1NcHB74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vkKHcknmUe5WaMH8bvjX+HbzNMavnZPsj74jJmzNyahNg+THe4qRhcNGjaJkjMbBW
	 fWEJNUfQR8TN7E68F/SZkzEMdiv4p7V3fzbq1JWCuaQOXzZJTSgbIcbLDwi1Kmh3ix
	 vQMPNfk26PADS2TcQeZAdcZGzcoMuzXC+zYek4ZI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 013/151] NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server
Date: Tue, 30 Sep 2025 16:45:43 +0200
Message-ID: <20250930143828.133159967@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
References: <20250930143827.587035735@linuxfoundation.org>
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

[ Upstream commit 4fb2b677fc1f70ee642c0beecc3cabf226ef5707 ]

nfs_server_set_fsinfo() shouldn't assume that NFS_CAP_XATTR is unset
on entry to the function.

Fixes: b78ef845c35d ("NFSv4.2: query the server for extended attribute support")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 443b67beec376..c29bc0a30dd75 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -862,6 +862,8 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 
 	if (fsinfo->xattr_support)
 		server->caps |= NFS_CAP_XATTR;
+	else
+		server->caps &= ~NFS_CAP_XATTR;
 #endif
 }
 
-- 
2.51.0




