Return-Path: <stable+bounces-43961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8FB8C5071
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0DA1C2136A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA8A13D613;
	Tue, 14 May 2024 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HrAqsY5U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F4E13D60E;
	Tue, 14 May 2024 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683364; cv=none; b=oKMdC66sTJiOWo27HIYd2fHNv7Mty8HekYEG1IGJMdAAkMuvzbxep/nWnOEYzewgq6GaSySosVUZBJoTnb6gl9mlBpIxaDtK+V0mkUIpDv3UrrHLtpl/dDqxXiPbWcVYLlos29rbKu+6tvktGvMBYAwvJ1VlkctdadBUbxMPvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683364; c=relaxed/simple;
	bh=DSlZ6Genijz12N200yjPDZqNuR7UlQ9oWGTYkGVdl8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UELzFxkEjhHPcIgS6JL3Adx8aTIGUmA7Nw9dkKaOxjnVObmjtFxMIfATpG+9h4FhNMaKfhufm2mYkv/SWTTjmZyq/qNUA/ERThO/P7XsxGGTGVJZEnXuXgEqXnW5Vm+XVxZaaEJt+UoY+iK4aHYwzCwTqxFlpQNf6RKOCHW05qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HrAqsY5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8544BC2BD10;
	Tue, 14 May 2024 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683364;
	bh=DSlZ6Genijz12N200yjPDZqNuR7UlQ9oWGTYkGVdl8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrAqsY5UWBb75GDwC9zoeidnWLqGaNniL8N0MyFvq8U7IXZB6BP4zmpRnIB4eoFqH
	 vED44p3c8QgkVA8RyLwBhC3a3myuXJYVRmE03ZSqAfmAUXl7+jNQZcab0LYfGm9vMu
	 e19/71Y4K/cKV/XJglDV8L3n9FJoVNF1IHcWPRqc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 178/336] fs/9p: translate O_TRUNC into OTRUNC
Date: Tue, 14 May 2024 12:16:22 +0200
Message-ID: <20240514101045.324531497@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joakim Sindholt <opensource@zhasha.com>

[ Upstream commit 87de39e70503e04ddb58965520b15eb9efa7eef3 ]

This one hits both 9P2000 and .u as it appears v9fs has never translated
the O_TRUNC flag.

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index ae3623bc4ef46..7ba7efe47b40d 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -178,6 +178,9 @@ int v9fs_uflags2omode(int uflags, int extended)
 		break;
 	}
 
+	if (uflags & O_TRUNC)
+		ret |= P9_OTRUNC;
+
 	if (extended) {
 		if (uflags & O_EXCL)
 			ret |= P9_OEXCL;
-- 
2.43.0




