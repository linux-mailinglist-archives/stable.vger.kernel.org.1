Return-Path: <stable+bounces-130127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7157EA80313
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E472C17B64C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0A2676DE;
	Tue,  8 Apr 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pLRsnHvF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364C2641CC;
	Tue,  8 Apr 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112889; cv=none; b=UZFjewAW2ASCEX6PVD2fC6C+NEi1JBGEHavO2ue2bUWlj5GxQVl44ujXZn6p+Q/0WTsvGC50ctkN64nsk+YRsEvNa/r8j5vqT0Ql6/HI4MGY1ASr6kpIbD7vpi03mKrcHz6E/9vptxLWj+NKjI5zKJOB0lFR+xuAkFqYG92U7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112889; c=relaxed/simple;
	bh=+ke/sdlulmwT2eljjKvKfathajamL2aDsH7OVTZ8zTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnGasiOIxR46vwcfLiOdg6WT/eAlX0uL/PoTJWmwZWIQrpzFoi6arjPofvO2HQFeDsxuWW947XfWnMFLUSwR3c0qt4RQ/9VgtuEf7oX52rJpqkx4vo6GGIZkb6OjVXsuC8RxqaJ3KYBqfD9rm4O7DarAtr3A2qMQ8TG1qJ8LFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pLRsnHvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B8CC4CEE5;
	Tue,  8 Apr 2025 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112889;
	bh=+ke/sdlulmwT2eljjKvKfathajamL2aDsH7OVTZ8zTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLRsnHvFIvGrfpPFyDFvZAgKmAL/+IVKRASow/EcZlctcwMFmKK4P2MbSUUieW2Vl
	 EIO4vJxxtyoWpvguJnwttvzDkfp0w56LgxyhgsOC9DjkUd6b3sLec9CoVhMXt5nSwQ
	 EksRjyLxNW53WYrCVWrxCx1YEpMgnKYwZQFfaPQA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 235/279] spufs: fix a leak on spufs_new_file() failure
Date: Tue,  8 Apr 2025 12:50:18 +0200
Message-ID: <20250408104832.722426068@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit d1ca8698ca1332625d83ea0d753747be66f9906d ]

It's called from spufs_fill_dir(), and caller of that will do
spufs_rmdir() in case of failure.  That does remove everything
we'd managed to create, but... the problem dentry is still
negative.  IOW, it needs to be explicitly dropped.

Fixes: 3f51dd91c807 "[PATCH] spufs: fix spufs_fill_dir error path"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index ed37a93bf858a..1095be5186ebf 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -190,8 +190,10 @@ static int spufs_fill_dir(struct dentry *dir,
 			return -ENOMEM;
 		ret = spufs_new_file(dir->d_sb, dentry, files->ops,
 					files->mode & mode, files->size, ctx);
-		if (ret)
+		if (ret) {
+			dput(dentry);
 			return ret;
+		}
 		files++;
 	}
 	return 0;
-- 
2.39.5




