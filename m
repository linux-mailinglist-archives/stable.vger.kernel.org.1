Return-Path: <stable+bounces-204318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD3CEB35C
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 04:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ECEA300D4B0
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 03:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7622030BF60;
	Wed, 31 Dec 2025 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYxN8HAl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2A30BBB8
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767153340; cv=none; b=ZYr2+ePZp1wDMvItL7lY52o9bPx76IMFBtBQhCGkJghj0rO/1Vy9g1O6ECOmmCGHHXE4QZqOaysO592SFNFb9VMGzifZ1aq5VefodSGuXDbQHfB61SBX8AwqQVZ+AIQ6+ng9gUqZfQjsyW726BM5h4PgKamV+HW7dYJnlITOf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767153340; c=relaxed/simple;
	bh=Ur3VWvGk+aOCEL7QSQ/hup5wPpGbhmOHJGJOPFvN0PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stACsyGY/DSKw275mocykFDsAZfGqQMSNaERlzkr1yMXzKXkcNZO71/jttrn/IC191JZW08vqb2a9kBluar3HMw9Jh53wPIwD7fXzK8w5BogvbVc7QHEkxII1Jl0mgTlNgSaVIjBQ9bk9zbAZMG1PiphtYxCDz4MDenEdVXYcj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYxN8HAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F6FC116B1;
	Wed, 31 Dec 2025 03:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767153339;
	bh=Ur3VWvGk+aOCEL7QSQ/hup5wPpGbhmOHJGJOPFvN0PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYxN8HAlgs2H4lhjqL4txQrivm2qaCepd2tOYA42FJB3YyV2N7Md06Sel7UFtAa/m
	 cjCZpM6f2bQVRP7SRGUNNrmBNBb3cM0bbv3itefvAl9Noac11I4fRhAMiDcrYJrzlu
	 ojrYkrJbPz8+9+rI3t8jcHGpN/ZWBB/clLDt/foXzMeXMZbdDI6pYdr+wu2Cokph8t
	 Zod/oiuY64/rmCBjHILuXpB9nOxN9WA++sKnragdX/VjltWH+A+/8OpIn9zzlXJMGl
	 sAL+PW+L11HS3no30Zcs751w0tZlNvAx/2wVVfL4NbhS2nJ0s3ve4aNKlEW5jEE9q5
	 Iyi4hZZt1AV+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
Date: Tue, 30 Dec 2025 22:55:37 -0500
Message-ID: <20251231035537.2722284-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122920-sequence-vixen-bb32@gregkh>
References: <2025122920-sequence-vixen-bb32@gregkh>
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
index 5073fa77cd76..8ef533b2dc35 100644
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


