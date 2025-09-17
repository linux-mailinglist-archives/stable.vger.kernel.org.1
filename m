Return-Path: <stable+bounces-180057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2905FB7E7FE
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC3416A167
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A493233F3;
	Wed, 17 Sep 2025 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGUV96Ba"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848B2C3278;
	Wed, 17 Sep 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113243; cv=none; b=dxDZw6fK36Ztvv1UQ4c/YwPFXeNaQiTwVJQ9s2WhYrXEyiZVj/SbxTQTwsFw7+2CMcDGlqA3iJZrWkLRvQTRCES+Qd03bXiSWfOTIJ1JOlF5kqqgA9vUNnug/akcGv6NtNQqik4QAEiKfAyxcse7NSZJoUofqM3x0QHgUfs+rZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113243; c=relaxed/simple;
	bh=Eey2G+00qhM6j8Lz9jHJ6/XJ9GNAx8cWHOP2XFbx1Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IViKigzTosXsAq5r4QSusDzl61CONuaczcKvFbV/HkcvFPfnKrc55CbhWrEUTRX++9tJtZXD2ejFPf9Cq4R0j+L2Letog8UIFvxZJK2lypK2JWoYIBDu6WEObR5sF0nYU3j0IIWKOgt20Y/DoIhIxNUFrakP5IBUYVdVhZU6avs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGUV96Ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D22C4CEFA;
	Wed, 17 Sep 2025 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113243;
	bh=Eey2G+00qhM6j8Lz9jHJ6/XJ9GNAx8cWHOP2XFbx1Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGUV96BaP/WRLWzdme7WuHb/7qR7uuh/sGx4eKdT1Jx32WKVrKvALHpuOuqGoACOT
	 drLpu+EllBl1zDPvVAaIggLv7SRQN9ly5aPdv6pam1QDi2zx6bUlORwQU7E4DoMxGH
	 yanKbFJnzd+WzkBbkzJ7DQM4d3qg6petTzMN5//4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 026/140] NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server
Date: Wed, 17 Sep 2025 14:33:18 +0200
Message-ID: <20250917123344.944151924@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 17edc124d03f2..035474f3fb8f3 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -881,6 +881,8 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 
 	if (fsinfo->xattr_support)
 		server->caps |= NFS_CAP_XATTR;
+	else
+		server->caps &= ~NFS_CAP_XATTR;
 #endif
 }
 
-- 
2.51.0




