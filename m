Return-Path: <stable+bounces-87836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF09ACC4C
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C1F28220B
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067F21C3024;
	Wed, 23 Oct 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDafyW0W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A6B1B6556;
	Wed, 23 Oct 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693815; cv=none; b=bV1xPqtR5qIwM/J9hsz0hdX4xvpBpyMqmt2DtjGjmqt8QonENdSdWjcTTtd0iP7v2ewU/CuABc6FqR7RJrHRx5dyEMe3ajHnPv8B+fEHDua/dScs7ujDjBF9sFhM8LhgvTW9Ommtxf99cO7FVv2dndimB+asdCIhplme2BJbTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693815; c=relaxed/simple;
	bh=gGjoSKuMzN38pKeOo57846/tebNCe1RbKVVaSV4fnHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVuT6zh8ra7YChfdcoZbhe+IWFL/BoW7tXUg5c3j+X9Tm2Ml/PvuYJGNFF0Sb4s7iZq8LEhfNaAULhiyi9ka4gNITmExPRuHSp0YZwNxplADduo6RZV+pWy8o8cCrgZNTNpzsL833KqOahGd7viy34CkCLwRoAkNu/QjpXgdJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDafyW0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5357BC4CEC6;
	Wed, 23 Oct 2024 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693815;
	bh=gGjoSKuMzN38pKeOo57846/tebNCe1RbKVVaSV4fnHc=;
	h=From:To:Cc:Subject:Date:From;
	b=cDafyW0WXk6+PyCR3XViCtQ/xe9/ywTUSPstmYeRVhZJpgNt0A5ptnfnErJORf3mN
	 wSdifE8yC2u72WugeHEL90LDUUjw1kWsnvDD2Vlzx3MQPiJP4ZSWum5HMqf9ScdT4O
	 ELS11uQ/BU6CFBUPOhJhPbUDQItezKWRNeARREdK/oCrhaH0mBmXDfb6qatjfJgAMT
	 gupU4q71InIfUkebBTbFMgCr0/DGoHp2F3IOP6Qu5n940Jl3L8OHQLh0svb7EP3dgi
	 ZfZWPQZOukzAI47dwP1WVVug9a25gwVg/AFRBazy7Zoyqr+5aFsE8IQga3hL/PxUSF
	 LpuQosYemXOkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Sasha Levin <sashal@kernel.org>,
	ericvh@kernel.org,
	lucho@ionkov.net,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 01/30] 9p: v9fs_fid_find: also lookup by inode if not found dentry
Date: Wed, 23 Oct 2024 10:29:26 -0400
Message-ID: <20241023143012.2980728-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Dominique Martinet <asmadeus@codewreck.org>

[ Upstream commit 38d222b3163f7b7d737e5d999ffc890a12870e36 ]

It's possible for v9fs_fid_find "find by dentry" branch to not turn up
anything despite having an entry set (because e.g. uid doesn't match),
in which case the calling code will generally make an extra lookup
to the server.

In this case we might have had better luck looking by inode, so fall
back to look up by inode if we have one and the lookup by dentry failed.

Message-Id: <20240523210024.1214386-1-asmadeus@codewreck.org>
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/fid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e26..f84412290a30c 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -131,10 +131,9 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 			}
 		}
 		spin_unlock(&dentry->d_lock);
-	} else {
-		if (dentry->d_inode)
-			ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
 	}
+	if (!ret && dentry->d_inode)
+		ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
 
 	return ret;
 }
-- 
2.43.0


