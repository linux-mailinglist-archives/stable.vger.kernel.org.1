Return-Path: <stable+bounces-53378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B224290D2E8
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD076B274DB
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C127F1A00F0;
	Tue, 18 Jun 2024 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V4zY9bqf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD01A00F5;
	Tue, 18 Jun 2024 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716147; cv=none; b=s1pIE1prx2IYwe+R0rzIRDabF2PzPc173N9qvv6hq9q6pHjUDMvweOUc0KnfQNKmLBxunqd07mCRr+s/6SvR0jdnMMUifcJIskEh9oPEoebwMXRRI2O7nHGwD8vOicVskBdV80l+SR7qu6imdw9ooJu/TNZoKA/AuagKjmpfJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716147; c=relaxed/simple;
	bh=xWSLPyi7uL695Xl9I5vi/+Z59XjrsLS4D0tzYbvjzjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCwdxDdJjf2HGywEnuc9j6bdsGF4E6Kt/i+9zRmutn2ngLHO9mtOdA5jfimoxYuHjDtn4k75uqr21/GK0YYIrITKkLAzmZwANCrpweBZFdYW3B5bkKmFrwMiA0knLdMGfCQ/uF5u6mFLCrmjiNEKlCt6fL2cTG6BDcbiXHYcYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V4zY9bqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED187C3277B;
	Tue, 18 Jun 2024 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716147;
	bh=xWSLPyi7uL695Xl9I5vi/+Z59XjrsLS4D0tzYbvjzjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4zY9bqfPSGmYUaaNTLUlH3DFJ+U2lisx+wlHOpRFt3Oi/HRiXvC1Aftwkyh/gFE6
	 X3a+eIKMwpH0+4nx1K5v95VFuM8SMEJnkbgWsfj6ySPlEoVhxwQPKpyHTlfmb0slhn
	 a4y6zG566BsZADGCTWzXXStQ4NaEexksA3gCXsDk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 517/770] NFSD: Clean up nfsd3_proc_create()
Date: Tue, 18 Jun 2024 14:36:10 +0200
Message-ID: <20240618123427.270768783@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit e61568599c9ad638fdaba150fee07d7065e31851 ]

As near as I can tell, mode bit masking and setting S_IFREG is
already done by do_nfsd_create() and vfs_create(). The NFSv4 path
(do_open_lookup), for example, does not bother with this special
processing.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs3proc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 936eebd4c56dc..981a2a71c5af7 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -229,8 +229,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 {
 	struct nfsd3_createargs *argp = rqstp->rq_argp;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
-	svc_fh		*dirfhp, *newfhp = NULL;
-	struct iattr	*attr;
+	svc_fh *dirfhp, *newfhp;
 
 	dprintk("nfsd: CREATE(3)   %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -239,20 +238,9 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 
 	dirfhp = fh_copy(&resp->dirfh, &argp->fh);
 	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
-	attr   = &argp->attrs;
-
-	/* Unfudge the mode bits */
-	attr->ia_mode &= ~S_IFMT;
-	if (!(attr->ia_valid & ATTR_MODE)) { 
-		attr->ia_valid |= ATTR_MODE;
-		attr->ia_mode = S_IFREG;
-	} else {
-		attr->ia_mode = (attr->ia_mode & ~S_IFMT) | S_IFREG;
-	}
 
-	/* Now create the file and set attributes */
 	resp->status = do_nfsd_create(rqstp, dirfhp, argp->name, argp->len,
-				      attr, newfhp, argp->createmode,
+				      &argp->attrs, newfhp, argp->createmode,
 				      (u32 *)argp->verf, NULL, NULL);
 	return rpc_success;
 }
-- 
2.43.0




