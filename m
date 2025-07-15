Return-Path: <stable+bounces-162744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A22B05F24
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D27BB57A
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C110219D8A7;
	Tue, 15 Jul 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yHOqTdxj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7752EA728;
	Tue, 15 Jul 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587363; cv=none; b=Xj8s9PfRVos9I0uYvOuO78JZzHNu843/TRLbMMpv6sRvtXGMTX3BxXXHPqyzQOvZzCwv7mqpIExTU+S9yZSGERZd5S2fnE0387QFBh1Ae3tY1f8Z9FzcIzuAPc8BIQPo0o53u6Ra3IO9dSI/3OGV1jB+IhCVxWgt6n1iWlMEs/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587363; c=relaxed/simple;
	bh=m/ZPPuDq7BrhmqGrqmcjy+cZyx0ZBXF/SuIIdQjVcyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cciHWMC8yzU4cHRbj42n9IieXe/5gCdVEBNMnGQbMwhu1GBGYigQVygQTIqc8qwr75j/xRaWMRLB3ddP0sVs+zO81siplkb5zN1fnHwMAv1kgjbgUGcFY6OdR8UdNx9uNNdUZ94Cxbm2sEqKI0N25um6dFdSgNepcLZ5qRnB9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yHOqTdxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12956C4CEE3;
	Tue, 15 Jul 2025 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587363;
	bh=m/ZPPuDq7BrhmqGrqmcjy+cZyx0ZBXF/SuIIdQjVcyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yHOqTdxjCvOS513g9QO6/zGbBs3PsM1OVtrjvWUOG/RnQlGNGEHl3QZswip1+y5Kh
	 CC4DU7IlB3lCrQoJQEHiuKwCFRMfmLnRgb3afw78CRJefp5WnKCTuKaqMObCnK9t/j
	 6Q/odS4J6E7frTBRCIBTE9UEynSHBi2TZodpbKH8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 41/88] ksmbd: fix a mount write count leak in ksmbd_vfs_kern_path_locked()
Date: Tue, 15 Jul 2025 15:14:17 +0200
Message-ID: <20250715130756.174593383@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130754.497128560@linuxfoundation.org>
References: <20250715130754.497128560@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 277627b431a0a6401635c416a21b2a0f77a77347 upstream.

If the call of ksmbd_vfs_lock_parent() fails, we drop the parent_path
references and return an error.  We need to drop the write access we
just got on parent_path->mnt before we drop the mount reference - callers
assume that ksmbd_vfs_kern_path_locked() returns with mount write
access grabbed if and only if it has returned 0.

Fixes: 864fb5d37163 ("ksmbd: fix possible deadlock in smb2_open")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/vfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1283,6 +1283,7 @@ out1:
 
 		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
 		if (err) {
+			mnt_drop_write(parent_path->mnt);
 			path_put(path);
 			path_put(parent_path);
 		}



