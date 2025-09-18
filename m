Return-Path: <stable+bounces-168822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0034B236D9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688181B6629D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99894285043;
	Tue, 12 Aug 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QpneHx0k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D0260583;
	Tue, 12 Aug 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025449; cv=none; b=KP1xR0tJOfom21UiaglrsHoSOuUrV1DXCkfhZiLTcrOh+YXOuAWg+tVmyR0kElQDJY74lBeY+4CNlVBJpe6Ed+E5cFUmSPj4g2G7hXYhTjaZhLDDsJRKJWxBLreqVhQN38USwDZoaexvULFB52fEbhbzA3gJkkU0ZNXDBWTPaA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025449; c=relaxed/simple;
	bh=UGVStGvawt8jdO1BwD0PA7DbLa6kkjFXeNtq3nhVqSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5dwYATxbT7nnuKXUz93nqgUN5ffz6qVrMv8JHgYtkhd1Ww67klqJKSgh0p3F1W/FPlp/t3R29fXALs4A8c9ds0AIC9coC+Qxabt6XQz70e4Y3mRaZTuDAOiNPS7eIZysONF4QLEKPGOf63kqCPaYl/riNaLv5gLu1D4s6OTCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QpneHx0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C62C4CEF0;
	Tue, 12 Aug 2025 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025449;
	bh=UGVStGvawt8jdO1BwD0PA7DbLa6kkjFXeNtq3nhVqSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpneHx0kvenMPL6oOcCdrK8UdYHKS9fM/IEH79T3fIXyHIbL2UXRgtMsZFqGI5yR6
	 6xlqsoAbhqRzrASFHjuO0h1jODwpnCQaTuZq+0nl8NTMLiYqZxs01CoXvEf1AvSfHm
	 6yfrzXgOpsCgkE7qLcsTxIA8+ILywvfdXgyuVr7M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 010/480] [ceph] parse_longname(): strrchr() expects NUL-terminated string
Date: Tue, 12 Aug 2025 19:43:38 +0200
Message-ID: <20250812174357.732153046@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 101841c38346f4ca41dc1802c867da990ffb32eb ]

... and parse_longname() is not guaranteed that.  That's the reason
why it uses kmemdup_nul() to build the argument for kstrtou64();
the problem is, kstrtou64() is not the only thing that need it.

Just get a NUL-terminated copy of the entire thing and be done
with that...

Fixes: dd66df0053ef "ceph: add support for encrypted snapshot names"
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/crypto.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 3b3c4d8d401e..9c7062245880 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -215,35 +215,31 @@ static struct inode *parse_longname(const struct inode *parent,
 	struct ceph_client *cl = ceph_inode_to_client(parent);
 	struct inode *dir = NULL;
 	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
-	char *inode_number;
-	char *name_end;
-	int orig_len = *name_len;
+	char *name_end, *inode_number;
 	int ret = -EIO;
-
+	/* NUL-terminate */
+	char *str __free(kfree) = kmemdup_nul(name, *name_len, GFP_KERNEL);
+	if (!str)
+		return ERR_PTR(-ENOMEM);
 	/* Skip initial '_' */
-	name++;
-	name_end = strrchr(name, '_');
+	str++;
+	name_end = strrchr(str, '_');
 	if (!name_end) {
-		doutc(cl, "failed to parse long snapshot name: %s\n", name);
+		doutc(cl, "failed to parse long snapshot name: %s\n", str);
 		return ERR_PTR(-EIO);
 	}
-	*name_len = (name_end - name);
+	*name_len = (name_end - str);
 	if (*name_len <= 0) {
 		pr_err_client(cl, "failed to parse long snapshot name\n");
 		return ERR_PTR(-EIO);
 	}
 
 	/* Get the inode number */
-	inode_number = kmemdup_nul(name_end + 1,
-				   orig_len - *name_len - 2,
-				   GFP_KERNEL);
-	if (!inode_number)
-		return ERR_PTR(-ENOMEM);
+	inode_number = name_end + 1;
 	ret = kstrtou64(inode_number, 10, &vino.ino);
 	if (ret) {
-		doutc(cl, "failed to parse inode number: %s\n", name);
-		dir = ERR_PTR(ret);
-		goto out;
+		doutc(cl, "failed to parse inode number: %s\n", str);
+		return ERR_PTR(ret);
 	}
 
 	/* And finally the inode */
@@ -254,9 +250,6 @@ static struct inode *parse_longname(const struct inode *parent,
 		if (IS_ERR(dir))
 			doutc(cl, "can't find inode %s (%s)\n", inode_number, name);
 	}
-
-out:
-	kfree(inode_number);
 	return dir;
 }
 
-- 
2.39.5




