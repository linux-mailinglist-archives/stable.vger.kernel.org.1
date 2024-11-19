Return-Path: <stable+bounces-93963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87129D25D9
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DCC1F21F0F
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC76A1CBE95;
	Tue, 19 Nov 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slHUEDIe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1101C4A30
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019453; cv=none; b=SEIhMtkCc7u29eqewhqlWKZCR1jnAG+Cv97EkTkjPL6633d+pBquw6oSK81tpJbEuY5O5YR6M0uprtYJnVFrGvGIEELEj/m3JahXxTzNh8aeX6Q9PYxnmhUxBX63lXE58qeKaYRNVr4zibOG+oNFBG4AtyU6vuhzxVHnBqwJXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019453; c=relaxed/simple;
	bh=Uph/jM/Os4LSyJwdDCyOqTyZQfY1idsaEtl40RfZSc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uiz9Xt2NKwDmN5sZzDLviYEu97RbGF+mRmKxS/L5N/l/GaobvBrQaUQ4FpA8okyO4RYWA8ZNyRUJTb3bdA3brKmLTZkacV39ZlisUjVzSVmQkp/LqnrpIl5zZkt3n3ksVVFhfpmqQ1aKxwX4X08Ie6lBrf7P4uWG7PAh/dvAc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slHUEDIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B000CC4CECF;
	Tue, 19 Nov 2024 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019453;
	bh=Uph/jM/Os4LSyJwdDCyOqTyZQfY1idsaEtl40RfZSc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slHUEDIeJ6FM+R7HBJ2Bb2K8iUHNd1OJRbDzkiXxbqEFEHH8jfL+qq302F2wjX3s8
	 loTPm044BhQjO/7VGgueGq23wI/Q9IC+68oAbCxIi7IZuWcBYwZnjXXtFm4j9VjpMr
	 C0nQTrRrVkEBb0cvYkq4mnM6wNA6TtT80hpePqJUHy+Pd9eJV+BTIDWHykGtFdqJRU
	 fFu9jTilqEQ7nnXw0dinD25Av+Oxf+Z+r+Fpt7OtNRhllZqRYgeDBMBC0pkCEYM6Gz
	 hgqvocJVv0AeDbdUCbFjtOonIDoNn07Ls0IPYHRvmWbxtarno52h1doANcWNxGdw+a
	 iTL1xbzxFfTLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 4/5] NFSD: Initialize struct nfsd4_copy earlier
Date: Tue, 19 Nov 2024 07:30:51 -0500
Message-ID: <20241118212035.3848-8-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118212035.3848-8-cel@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 63fab04cbd0f96191b6e5beedc3b643b01c15889

WARNING: Author mismatch between patch and upstream commit:
Backport author: cel@kernel.org
Commit author: Chuck Lever <chuck.lever@oracle.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: e30a9a2f69c3)      |
| 6.6.y           |  Not found                                   |
| 6.1.y           |  Not found                                   |
| 5.15.y          |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 00:26:09.417432003 -0500
+++ /tmp/tmp.3m7vS1d9H2	2024-11-19 00:26:09.411459259 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 63fab04cbd0f96191b6e5beedc3b643b01c15889 ]
+
 Ensure the refcount and async_copies fields are initialized early.
 cleanup_async_copy() will reference these fields if an error occurs
 in nfsd4_copy(). If they are not correctly initialized, at the very
@@ -13,10 +15,10 @@
  1 file changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index b5a6bf4f459fb..5fd1ce3fc8fb7 100644
+index 54f43501fed9..6267a41092ae 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1841,14 +1841,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1787,14 +1787,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  		if (!async_copy)
  			goto out_err;
  		async_copy->cp_nn = nn;
@@ -33,3 +35,6 @@
  		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
  		if (!async_copy->cp_src)
  			goto out_err;
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

