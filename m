Return-Path: <stable+bounces-204345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60C0CEC091
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96156301224B
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6F6322DD0;
	Wed, 31 Dec 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeL9zH+6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE43112B2
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767188777; cv=none; b=nuaJ/qZ4MlTlIpjEy4SsY7EWxH6HHU1Xi2SRuh00eGvb3Tep7e4vugUwhA3GpE6jsSmKzrqNqeP+chQZCS9fJQz8CZ1NWywEkHvL094+Hk/dd3xhQ3jgiY4ja5LIECZuKMRWkXKLH2uilFv5rziDTMJT1BWpgeBYnCsIJe+K/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767188777; c=relaxed/simple;
	bh=lxAYFDZ6cCo2o620qp9VubxpBk0L/r+ftLgPKq+EesY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYJmrKDenUo//+DD560K5LVVZhMLSwvgqHOpuoPDNS0iD2ajrCqAO91zKFomzzGBBEZKFT0hhsFknFpEIlmi4mOZIO1wWb73DRJASNNZPZJN0gYfpA2ifE6+eJuumFHo/6O9Faje7vvisbRtwZbARbHmFQ9d38NnT1ndZjT3bp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeL9zH+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01BEC113D0;
	Wed, 31 Dec 2025 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767188777;
	bh=lxAYFDZ6cCo2o620qp9VubxpBk0L/r+ftLgPKq+EesY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HeL9zH+62bul8nDtae974Rg9Nw5Xyc3A/v+ohRvZBTF8d+29TZbMFIWmhZlsrCKIL
	 M7ZSIJHDOQbToLcTMj2q5Ad1BcD18QafKk/EM5CSXC3fw1Kh6wU7ESblnaHoU67BaJ
	 uvkP+Bb2Ownqk2ZIA+9AW1VzRbKCHu/o+xSQgah5NI6h5gVpC74FPb2zpIlPXvXju1
	 v+drM/iBSnlwAXUvhkXieC+wioB6wL9uhVp760oOLTqfF39F5JkLWSOtZbfhVRSnCr
	 j53jZr4eQsH13mu3OCCBMq6pzGHZQvMslC9/XihGyTe1/AheDuy8sbwEZfWwWduVIk
	 AgefK6wRo2NOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
Date: Wed, 31 Dec 2025 08:46:15 -0500
Message-ID: <20251231134615.2899300-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122921-startle-proximity-8c22@gregkh>
References: <2025122921-startle-proximity-8c22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 27d17641cacfedd816789b75d342430f6b912bd2 ]

>From RFC 8881:

5.8.1.14. Attribute 75: suppattr_exclcreat

> The bit vector that would set all REQUIRED and RECOMMENDED
> attributes that are supported by the EXCLUSIVE4_1 method of file
> creation via the OPEN operation. The scope of this attribute
> applies to all objects with a matching fsid.

There's nothing in RFC 8881 that states that suppattr_exclcreat is
or is not allowed to contain bits for attributes that are clear in
the reported supported_attrs bitmask. But it doesn't make sense for
an NFS server to indicate that it /doesn't/ implement an attribute,
but then also indicate that clients /are/ allowed to set that
attribute using OPEN(create) with EXCLUSIVE4_1.

Ensure that the SECURITY_LABEL and ACL bits are not set in the
suppattr_exclcreat bitmask when they are also not set in the
supported_attrs bitmask.

Fixes: 8c18f2052e75 ("nfsd41: SUPPATTR_EXCLCREAT attribute")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3a9f929cdb31..9e2507980473 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3409,6 +3409,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		u32 supp[3];
 
 		memcpy(supp, nfsd_suppattrs[minorversion], sizeof(supp));
+		if (!IS_POSIXACL(d_inode(dentry)))
+			supp[0] &= ~FATTR4_WORD0_ACL;
+		if (!contextsupport)
+			supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+
 		supp[0] &= NFSD_SUPPATTR_EXCLCREAT_WORD0;
 		supp[1] &= NFSD_SUPPATTR_EXCLCREAT_WORD1;
 		supp[2] &= NFSD_SUPPATTR_EXCLCREAT_WORD2;
-- 
2.51.0


