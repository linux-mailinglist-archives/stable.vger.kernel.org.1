Return-Path: <stable+bounces-204317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC5CEB350
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 04:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85BE73009F32
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 03:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2D02FE592;
	Wed, 31 Dec 2025 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+iRhVA2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C42FF154
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767152770; cv=none; b=ae5ZWe/ZaEy7TnBziIB2WQuwlH3lxBKAnXNANbz04qYEtlhFCI4EhH5OygsFCgrqAwiSYM36ZEL1ltyF4OU+YjwEmIwHEZg6QJp/NnGsYznhVH+ZVTH+6E77qRwDYkxgYXWuzV0FCe9EbNFLXmmfILZCMA9DiqIz35FHU6BG3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767152770; c=relaxed/simple;
	bh=UAL4Nik3YhcQg9fUjywZJ/a6biQZdUu6xgSfEK91uUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWNY1bJefbo/DLzTnB1LsVbaojv1gL/Vu53GtVi/HXKZosFAjp2/NuYGo0YYlzK4KjySZc9QRtgu1kmTx0jnfxS6qP2rZERRZlFbaDRMLH0n76BxBvfW8fTc4D+d+2+A+gQkAuokpv8hH6bYxVK5jyU17u+npeQ7TtDTlBPKNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+iRhVA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74272C116B1;
	Wed, 31 Dec 2025 03:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767152770;
	bh=UAL4Nik3YhcQg9fUjywZJ/a6biQZdUu6xgSfEK91uUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+iRhVA21MiGKxyC78FpzAFP0EsmpEU5GlhpQkhT0l25mwnddhGo0O2OF4SMp5Xu8
	 vYWlceJm1MHMXzTFeGYVnTux2b6YgCyS1mbKKA05cqEHB5T0v9bVEx7NLdu6O5bKtD
	 9HcyMiWza8KujbmcBti/uN70QW/vRazlkGEHF1pa3XdpGdVeaFLkWPpMCkmbqtodNV
	 /6itHovvMHe49mBsjda3xMajQ6mLcODia1cSLOSeY3tdkxubEcPgQ+FpOoA70WzJ8Z
	 c4qQ8hMCev0DMbG3FVOGM3aJWdtUGK5UtH9B3jw13iZGf7D3hdCk7XdKJH13hEofDw
	 MToRFLZaOmxcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
Date: Tue, 30 Dec 2025 22:46:07 -0500
Message-ID: <20251231034607.2717171-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122919-carried-livestock-9465@gregkh>
References: <2025122919-carried-livestock-9465@gregkh>
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
index 3eff780fd8da..15189e683e83 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3419,6 +3419,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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


