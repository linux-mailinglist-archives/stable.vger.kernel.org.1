Return-Path: <stable+bounces-68138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 812469530D1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3010B1F24B93
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592E18D64F;
	Thu, 15 Aug 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wt8YlRKi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917BA1714A1;
	Thu, 15 Aug 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729610; cv=none; b=IAwhajZzu35/aQkjSaY6yKoCgh+3IJzbSoVf5S+aHZALk4bnSmqYj8mXCIOFtmwcwbYLJ22r+kUy0S0+tSpZ4S22OeqIRiNlkluKe8bt/j5fglTp1dgGndjGSpsa9pTJO6uJkOq1rKv7KLhPNCKtwEbf8pjhJCaDApT7yYpLOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729610; c=relaxed/simple;
	bh=58L3umAgJI977wLgE8UfjJCHBY6arZe3Yk3+dd9/4zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgqtTvH2O9dpHMJ0I9JCtlCyQzTxVccDk3Y5IFMdbJC6QI607ML3azj3jvJI66/Vrxv/k5ALKJ31QO9bqcx7+3AfHU5F1z+JJnB6gwjPe+RIvgmnNVHdYpvUMLMZZNK1VqmfhOazVDADczoG0amNACvxng3cb+z4CU8BzVRe1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wt8YlRKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11698C32786;
	Thu, 15 Aug 2024 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729610;
	bh=58L3umAgJI977wLgE8UfjJCHBY6arZe3Yk3+dd9/4zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wt8YlRKi4fxz49sNU2kaTHAKe4zyyrtQBBUupykoskwjAItKuYEOaeX1/25CFtTPe
	 9WRsLmaYqLtcr8A2wA+wW5UlDBEOwA6giY0HSQUpRqSHtpogWXNbpfoDMliaZYKQgQ
	 AUkDD17tiraQ8eNdmdMYqCRdwjZFfrPWvhO7mrLo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 152/484] fs/ntfs3: Missed NI_FLAG_UPDATE_PARENT setting
Date: Thu, 15 Aug 2024 15:20:10 +0200
Message-ID: <20240815131947.288106990@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 1c308ace1fd6de93bd0b7e1a5e8963ab27e2c016 ]

Fixes: be71b5cba2e64 ("fs/ntfs3: Add attrib operations")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index e8fc86dab6114..83c15c70f5945 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1565,6 +1565,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 
 	attr_b->nres.total_size = cpu_to_le64(total_size);
 	inode_set_bytes(&ni->vfs_inode, total_size);
+	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
 
 	mi_b->dirty = true;
 	mark_inode_dirty(&ni->vfs_inode);
-- 
2.43.0




