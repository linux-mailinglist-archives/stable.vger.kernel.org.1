Return-Path: <stable+bounces-204347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97211CEC0AF
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A4A03007CA6
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E616C30FC3D;
	Wed, 31 Dec 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtCzz3b2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A071C84D0
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767189010; cv=none; b=c7P2FZDI+NKsHjDPLGLInt4+WdHxkmo7cRkCXtybdAYE8ksWtA40Ptm9/llcmNY+LD6Yf6JlgtGb72/L2zX2epjoVVS+kxiHvSU1pn4V8om7Xu4QM1mT+5YtT5OtskzKGOg2Xa28/omrKHH39hnKVAkCq/p5CbNsoXS2VUXFtYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767189010; c=relaxed/simple;
	bh=vKT2CT2k/JlnKp2cy2iWaGkG+w+SJOm5Mv768b7pjjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCytwBr9OyKruPhMgmW735BQsoU1yufI/mlZeU1AAFduCFEf5Enb+v7HVMCA6eeSDEs2yxjO3hH2w4ZpplRsjRno3Xy/oZd0ONQRJzfdf6G/IUwfTgm745AraxGvytKYUsNWwq0tmLG0fUqdUed+d3U74mdJHfBBvFJmWTwuo9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtCzz3b2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0653C113D0;
	Wed, 31 Dec 2025 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767189010;
	bh=vKT2CT2k/JlnKp2cy2iWaGkG+w+SJOm5Mv768b7pjjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JtCzz3b2OJBetuQQmCCGiigDIvo9REpDQQ8vmr7TyW87eX9AFU1itq66XNxyddUFW
	 C++elzFZ0UvRFC90Jckdzbrww07zJUNCdJtZl8n8wUbNAGnpqGl9/e8F3mScDQXGz8
	 I/emE4HRgZqVLrFKfrD6uB4+Ay2Vpa78S6jdOURXJQekSkAq+/7GNOQA3XuMi1dgfz
	 7aFtQR3kX+3bkosQrN16+ByWykBNxBcZjF4dQLfOW2efeaN9WsipwjF1BFabu6nVIg
	 YCmp1BbAYCiPkW5vN69DMAbADnSjP12vohB8MIHWBmrcbhp9Eaz367YMxAZ01oLRXr
	 NpXbFdrQwbq+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
Date: Wed, 31 Dec 2025 08:50:07 -0500
Message-ID: <20251231135007.2902697-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122921-wanting-sixfold-db66@gregkh>
References: <2025122921-wanting-sixfold-db66@gregkh>
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
index 57dc5493c860..4253778a9747 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3408,6 +3408,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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


