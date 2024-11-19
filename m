Return-Path: <stable+bounces-93962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D979D25DA
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B77FB2959E
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE01CC157;
	Tue, 19 Nov 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaRBQLju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2641CC151
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019451; cv=none; b=azAVn49T9W23k38u9KTd386hH7pjZHDfg7y4+o81kjmuVX6OcSBHYTIYfcm2Yd8Na63f5pPasfkOLq+RzPXSZcd8zrA6MyQBoB9bR2bTfYi9wlHXeTIwO5vjlt/+yL0kH29+g4lencEaUmR1+cJcjBlN97KR8eCUv/+twViuIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019451; c=relaxed/simple;
	bh=SSaGwON3yZjsUqU5YkBnjfoCGF2OVMw+mFtRFRrzB5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMVSDj7BDoEupAaCslO462WjDUGPLeM9eWRXEvpwYdRUetNL9O1cGKJABSWL8aSiy+4b1kiWPVeGpzmxowXTgKVe7VRvUWSOi5rqeUF9/bWlQLKrSbKuWVQh3SD/qxrPGo9yQB9qfd3/3y2SQvFr3w4N/yUI/u4ycXyw536yV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaRBQLju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB335C4CECF;
	Tue, 19 Nov 2024 12:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019451;
	bh=SSaGwON3yZjsUqU5YkBnjfoCGF2OVMw+mFtRFRrzB5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uaRBQLjusalQFDpFqQjYxL/8eNx9uY+4ESoLnYJWEevn6Es1K54rMuNNKkk2tenY+
	 fMOIQZHpFkpWA+IEL0nFPyFGxSprEEM4UtguFwt+BoT2T5Y67Kle7dH07gKy0No50V
	 e/vaQ74MkpY0f0fQjl+aakhWwx51jM6zWBJmpd//ptoVXTRRBTM6xiCAgCib0cFKLd
	 TSecfL+WiVZfXZbX9orfU1Z9vssIGsiN4+Kc9MuqQyANkZHnzQgBDf6sqXgtSClNTK
	 bpFqGmsM7IqrJ8gViElW7gUuFm4sUYJEPtUaHIXpeC+1Y2yakYL0DbCyoGn4/cPmwx
	 yylakSuE1lVsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/5] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Tue, 19 Nov 2024 07:30:49 -0500
Message-ID: <20241118211413.3756-2-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118211413.3756-2-cel@kernel.org>
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

The upstream commit SHA1 provided is correct: 15d1975b7279693d6f09398e0e2e31aca2310275

WARNING: Author mismatch between patch and upstream commit:
Backport author: cel@kernel.org
Commit author: Dai Ngo <dai.ngo@oracle.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 23:33:58.560704409 -0500
+++ /tmp/tmp.HmIWEAEtyu	2024-11-18 23:33:58.554913089 -0500
@@ -1,14 +1,17 @@
+[ Upstream commit 15d1975b7279693d6f09398e0e2e31aca2310275 ]
+
 Prepare for adding server copy trace points.
 
 Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
 Tested-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
+Stable-dep-of: 9ed666eba4e0 ("NFSD: Async COPY result needs to return a write verifier")
 Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
 ---
  fs/nfsd/nfs4proc.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index 4199ede0583c7..c27f2fdcea32c 100644
+index ae0057c54ef4..a378dcb2ceb2 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
 @@ -1798,6 +1798,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
@@ -27,3 +30,6 @@
  	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
  		sizeof(struct knfsd_fh));
  	if (nfsd4_copy_is_async(copy)) {
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

