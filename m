Return-Path: <stable+bounces-94471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE089D4404
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 23:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84BF282D1C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272CB1AAE00;
	Wed, 20 Nov 2024 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG+T1rTz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28A155A34
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732142488; cv=none; b=ndAw1ogxZjrWVqAUPa/4s3lCI6OIeuKqIs3rnf2+1L6agAY0jvuR+pvihAF5h49rOFWDwiHrLI2wx6BMRuGg8aiZpFYAuBsLZ0FNUYrj5/27NEy/n8jS9sIm7GspiqfQm9Hrzae1qEAaq3N1uay1J5dWYRrYVbpoPPyulx+/HJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732142488; c=relaxed/simple;
	bh=rhe1nocJ5vnC2eO4igZA3YRpvGxfMh7+CcE0cy0JrF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Agm1UPV92tHscGgK4qGouNbddwTRThmGTxO/XV370efLT5CCHLZVmfS3LLXJALmlH/WDtXusXaECB0IhnyZklnnXgk2scvYVTA3sTSuri/15MGexmzhY2tgSxTf3R/fFSE1PdxfHM+lpS9MQcGg01BjWZq4IP2eJBITG4ptm3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG+T1rTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59CDC4CECD;
	Wed, 20 Nov 2024 22:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732142488;
	bh=rhe1nocJ5vnC2eO4igZA3YRpvGxfMh7+CcE0cy0JrF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LG+T1rTzwIaH9Zm6rhdhkXl5wjf8xuWlOVWf1LzSX6kQ928tP5zjvSpwVRo8oZbO3
	 n8tuXx7USpO1zEA3NBE8UpGkzoHOihLNhNehPmoN5uADzOQc4Dgh5s47zrMHfNgZps
	 t49IcC7y6pIXrYyY0fmSldANnFjHGgPX/bKwugGbcQ2wCPQdGti6UFj1Ev15/7NRUT
	 Z6EL0YUuBX07yuf8Eh3Rhm2q4i3hckOZYqKfqpDNtGMAzAaDbnIr5dsZx9jZWabWlR
	 ltpakyPnUqpVSONtMY9tj7n5NAiWZelvgSoaW8QGLFJSxIkJ46N655t0rdqwf7pCOc
	 QE92aDkokPe/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4] NFSD: Force all NFSv4.2 COPY requests to be synchronous
Date: Wed, 20 Nov 2024 17:07:53 -0500
Message-ID: <20241120154356-25780d81bae31e10@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241120191315.6907-2-cel@kernel.org>
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

The upstream commit SHA1 provided is correct: 8d915bbf39266bb66082c1e4980e123883f19830

WARNING: Author mismatch between patch and upstream commit:
Backport author: cel@kernel.org
Commit author: Chuck Lever <chuck.lever@oracle.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-20 15:40:02.161540833 -0500
+++ /tmp/tmp.PdmCvDR3aZ	2024-11-20 15:40:02.153931894 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 8d915bbf39266bb66082c1e4980e123883f19830 ]
+
 We've discovered that delivering a CB_OFFLOAD operation can be
 unreliable in some pretty unremarkable situations. Examples
 include:
@@ -28,16 +30,18 @@
 COPY result is returned in that case, and the client can present
 a fresh COPY request for the remainder.
 
+Link: https://nvd.nist.gov/vuln/detail/CVE-2024-49974
+[ cel: adjusted to apply to origin/linux-5.4.y ]
 Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
 ---
  fs/nfsd/nfs4proc.c | 7 +++++++
  1 file changed, 7 insertions(+)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index ea3cc3e870a7f..46bd20fe5c0f4 100644
+index e38f873f98a7..27e9754ad3b9 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1807,6 +1807,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1262,6 +1262,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  	__be32 status;
  	struct nfsd4_copy *async_copy = NULL;
  
@@ -46,8 +50,11 @@
 +	 * requests to be synchronous to avoid client application
 +	 * hangs waiting for COPY completion.
 +	 */
-+	nfsd4_copy_set_sync(copy, true);
++	copy->cp_synchronous = 1;
 +
- 	copy->cp_clp = cstate->clp;
- 	if (nfsd4_ssc_is_inter(copy)) {
- 		trace_nfsd_copy_inter(copy);
+ 	status = nfsd4_verify_copy(rqstp, cstate, &copy->cp_src_stateid,
+ 				   &copy->nf_src, &copy->cp_dst_stateid,
+ 				   &copy->nf_dst);
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

