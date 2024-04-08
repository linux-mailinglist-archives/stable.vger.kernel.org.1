Return-Path: <stable+bounces-37479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7BF89C509
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195AA1C21F7B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A14A74BE5;
	Mon,  8 Apr 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NOdq0Uch"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282BD524AF;
	Mon,  8 Apr 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584354; cv=none; b=NU5e6bKbwTbjxcLpb64JyaGWOOtHrreWijRn1y8vEXAxhsV1OucLH58F+l8zQ77OKKbSdsERc72loF+DIC9nqTAIYjLPyGo8CY1EJpnuFHyYqU6joGOtF0cu+1hUbmOjRyEIbzvCRo3Gr8dz5JR/3g/3sCB+O7DaYcHE57MLWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584354; c=relaxed/simple;
	bh=I8/JxMhAKhHO+rjFLLfipu/FNpQaXqIYcm9r0btz0RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8mVUy5WJ3sjytDEM5tDrKuGKrz+i6P1ajIhsbtTfsS0RZs8vaRAYe6fJ+ih70XqlBqd++OP5AzNF1Qzu9tNxzfwdhtQrFk4UpO8Hugvug4W0h9H/VbkLmIiuZu12uTxmW1UAcom5dZFWNVaawxeJD4B1Ge7TNOhWv4XFhqN+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NOdq0Uch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DBBC433C7;
	Mon,  8 Apr 2024 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584354;
	bh=I8/JxMhAKhHO+rjFLLfipu/FNpQaXqIYcm9r0btz0RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOdq0Uchh+PaDpQNBq6cClZ0VuVDO6zKxH9bibk1LvtW5Mpc4LV5p+q+eZq1LqMoj
	 Oio0DC7pCSaGECLCX7jlH+OKzz90sv9LNn0y2yZFWYW/IEGOOHr5VZ/IMvJ6wxo7J5
	 CoQmYVaLdFJPJEpuz5rGlgJHq1S1ZAhQxXuSpW6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 409/690] NFSD: only call fh_unlock() once in nfsd_link()
Date: Mon,  8 Apr 2024 14:54:35 +0200
Message-ID: <20240408125414.401830890@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

From: NeilBrown <neilb@suse.de>

[ Upstream commit e18bcb33bc5b69bccc2b532075aa00bb49cc01c5 ]

On non-error paths, nfsd_link() calls fh_unlock() twice.  This is safe
because fh_unlock() records that the unlock has been done and doesn't
repeat it.
However it makes the code a little confusing and interferes with changes
that are planned for directory locking.

So rearrange the code to ensure fh_unlock() is called exactly once if
fh_lock() was called.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4b1304fe718fd..ac716ced1fd5f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1542,9 +1542,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	dirp = d_inode(ddir);
 
 	dnew = lookup_one_len(name, ddir, len);
-	host_err = PTR_ERR(dnew);
-	if (IS_ERR(dnew))
-		goto out_nfserr;
+	if (IS_ERR(dnew)) {
+		err = nfserrno(PTR_ERR(dnew));
+		goto out_unlock;
+	}
 
 	dold = tfhp->fh_dentry;
 
@@ -1563,17 +1564,17 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 		else
 			err = nfserrno(host_err);
 	}
-out_dput:
 	dput(dnew);
-out_unlock:
-	fh_unlock(ffhp);
+out_drop_write:
 	fh_drop_write(tfhp);
 out:
 	return err;
 
-out_nfserr:
-	err = nfserrno(host_err);
-	goto out_unlock;
+out_dput:
+	dput(dnew);
+out_unlock:
+	fh_unlock(ffhp);
+	goto out_drop_write;
 }
 
 static void
-- 
2.43.0




