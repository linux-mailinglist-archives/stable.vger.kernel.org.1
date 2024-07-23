Return-Path: <stable+bounces-60945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF83D93A622
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FCFB2253D
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E93D156F29;
	Tue, 23 Jul 2024 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P9XZwvKR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46D1586CB;
	Tue, 23 Jul 2024 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759515; cv=none; b=u8hjjZ01UnUvuSopqb6heSK+Py4YjSaJ9lrb6Zg0rU5OwEcO7ds9JoPsF2kkFAm27tQogAKb54KO31I7ZFkd2qKcwPtykJhhYISBxEtsz8Bqn/s9AmOFOOiejZ9mK3ujw06W7L3en3wMVbQIMFAOxhnDC/E/GBtEJtodnPEPFkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759515; c=relaxed/simple;
	bh=qkZ9yaLz921x2D2MaMXQIiPD+aAGSiDIl9V/1WlzbWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxOEK/dYas1u6MtYIui1B4N1xfHqrVd0pYzKzTbb0DwRIzpQ2cGu+4geDHFCxOiPROvPFjlw14fpXUwAkfEJelNF7D66bSMAv1ZAFUCZvkr3320FrnkksA9iSxitMN1jalNwlDNy4WZb5rki6EjuTNZ7ek85YMYOHl3wOOMksxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P9XZwvKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528F1C4AF0A;
	Tue, 23 Jul 2024 18:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759515;
	bh=qkZ9yaLz921x2D2MaMXQIiPD+aAGSiDIl9V/1WlzbWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9XZwvKRf5QiYoHJdVbLGO/6/nlXDt/TCqD+rZ2hZcKDtEHvcLqxWodEHI+UGj7vL
	 H0jMXfj0uZrZsX2WyR3whRpg8Aw3gR8CcZjG8YZdqqC9KVamk5+Qs2qruKLTtUwcmq
	 gn5j1xF9asT83Lln+np03XTXfWKEM6QKaXya2LiA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Aloni <dan.aloni@vastdata.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 037/129] nfs: propagate readlink errors in nfs_symlink_filler
Date: Tue, 23 Jul 2024 20:23:05 +0200
Message-ID: <20240723180406.223366892@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
References: <20240723180404.759900207@linuxfoundation.org>
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 134d0b3f2440cdddd12fc3444c9c0f62331ce6fc ]

There is an inherent race where a symlink file may have been overriden
(by a different client) between lookup and readlink, resulting in a
spurious EIO error returned to userspace. Fix this by propagating back
ESTALE errors such that the vfs will retry the lookup/get_link (similar
to nfs4_file_open) at least once.

Cc: Dan Aloni <dan.aloni@vastdata.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 0e27a2e4e68b8..13818129d268f 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -41,7 +41,7 @@ static int nfs_symlink_filler(struct file *file, struct folio *folio)
 error:
 	folio_set_error(folio);
 	folio_unlock(folio);
-	return -EIO;
+	return error;
 }
 
 static const char *nfs_get_link(struct dentry *dentry,
-- 
2.43.0




