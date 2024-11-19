Return-Path: <stable+bounces-93958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0E49D25D5
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10E2B29492
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554C13B780;
	Tue, 19 Nov 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2dR0+kb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28F1C4A30
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019443; cv=none; b=B7H3s6kMd3z6C9cQRp7Ir2RGrZfOpA6jxLttQ/YNz4pdOB9x+3Mex0ADtsiFO7TuGiTLGmeKoWQc89zHQg6BK5bvZUlI61M6nRIBbzWtebW4QUc+iupM8Yr35T3SHItSp4irrf4VH4xEjyWppSBDSW8l6i9Uon6/ftrrOaMdx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019443; c=relaxed/simple;
	bh=Z/RvCczrrzz62AKBAsyt6surUy9nahS6ChJzG+qtBjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLmBFg4yiHiyahgQVK7yQVTYkIWr3/ybdnil1rGeQD3Qeg8vTBPcGBKYLfoOucwCMWbhEgUIXiUcsFSe4n2EvwC9KrN76T07yKT8qL4+lrcuRjg2ENLKaC3M7eLhTEIlqO6MyfZdDYwe/yqEUISqezIjMaBdk3q75vUgHHhV7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2dR0+kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95C5C4CECF;
	Tue, 19 Nov 2024 12:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019443;
	bh=Z/RvCczrrzz62AKBAsyt6surUy9nahS6ChJzG+qtBjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2dR0+kb8ulSgx7aSxkGxjj9kVCBU8Qg0icLFGvf349ORssg0GqAYek/JUyH8rU49
	 QJsLavY/W5JbPUWchZQv+1vI9A50bG6xvfMvbpyYiM5V2nMQtyAE2ZOuuAKUUkrTAl
	 0AeL9OU4cxazlZPJ6NXFO1Yk7NlvFja+/Z9xwFZkyJ8GAwSE9+l7xtnbpF/kh9FGwV
	 GufBcrp8uZS98YR4RDGRmy/wAVjDPditY3tpxXJmnqTWy2gAHyBsmDRQGKpfOPRicj
	 cxJ/XOYwuXGpjk+YFXHMz1tKPQUJ9nLNYgYBHZqCxKnrkCuy9DB+OgbqXITzgvWf3X
	 QVoaFNb/4oV0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 4/5] NFSD: Initialize struct nfsd4_copy earlier
Date: Tue, 19 Nov 2024 07:30:41 -0500
Message-ID: <20241119004732.4703-5-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119004732.4703-5-cel@kernel.org>
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
| 5.10.y          |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 02:13:01.627307685 -0500
+++ /tmp/tmp.c6ujDBJvwx	2024-11-19 02:13:01.623397728 -0500
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
+index 9718af3c2611..b439351510d2 100644
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
| stable/linux-5.10.y       |  Success    |  Success   |

