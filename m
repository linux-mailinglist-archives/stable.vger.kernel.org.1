Return-Path: <stable+bounces-87866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ED29ACCB0
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D057F1C216DF
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E091CACDF;
	Wed, 23 Oct 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZO4qj/R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD81C231D;
	Wed, 23 Oct 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693878; cv=none; b=EjGU6n5opAklnqgcFRIWxPk7LB8HlYHSVsoHUQh8sgttzZv2EeUtupyFfP3bMLHbLbXWfCW+db+2dilSjDJ5gFhHUpDThN/1P5Fcj5dOvpZ4YtV0H6SuWL3uoeMUIIFOMqUYraSv7viEenwGSdwc5pYmdVsWbta1q3PgvrBdpmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693878; c=relaxed/simple;
	bh=gGjoSKuMzN38pKeOo57846/tebNCe1RbKVVaSV4fnHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qyAzhi/OT//UB85K66l0On6P9jTds77iOl8oAf/B3ofvDU+5NTVXFdUVCr2SB5S0WY9jR6uWkGKzDtjXI+T8m/3sY0kUw6VectOIAibPg2rERhF+Hmupp8VLptG4V6it/Ayrs19cep2bI+j9rVs1U/tB5y8MKijGPp5BFwPEbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZO4qj/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74E1C4CEC6;
	Wed, 23 Oct 2024 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693878;
	bh=gGjoSKuMzN38pKeOo57846/tebNCe1RbKVVaSV4fnHc=;
	h=From:To:Cc:Subject:Date:From;
	b=HZO4qj/RI/NMbs/6xzixg1RQ2QIXKUx+jWguVm0V1M5qFcIfOkb8UFs6mPpTL2+LV
	 CH0JS7rjyVwpgTwvdEPXYJWlvIk3Vv0ZMPLXXWmR+h+pfS4yqpE6mrxy2472JkVWXb
	 x01KwIuppq0nOHuTk2EDnwdRRziQsCMa3MnC98giRQYio+Tx0B6FALv8yUYJpT/er4
	 LirxA5SOVgmBjWSjNyMYLzKL22D3qHtxaWAbsVnozmPrZUUMe4fcdJaqq/R7UD16gS
	 NpaN2y8qV6z/Yxa0VIdA/ruPp8KF0TPuUP0XGIDqC0GyLD+qa1YA9jOkq2FTAo/C/0
	 FxlPQClAbXt+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Sasha Levin <sashal@kernel.org>,
	ericvh@kernel.org,
	lucho@ionkov.net,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 01/23] 9p: v9fs_fid_find: also lookup by inode if not found dentry
Date: Wed, 23 Oct 2024 10:30:45 -0400
Message-ID: <20241023143116.2981369-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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


