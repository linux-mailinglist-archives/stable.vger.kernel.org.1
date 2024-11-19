Return-Path: <stable+bounces-93961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9169D25D8
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF73284BEA
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6191CC161;
	Tue, 19 Nov 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHdtr5J1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8861CC157
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019449; cv=none; b=iXJeGmK1FYRmNJk2EI20Etuo2iVUCOV/RHGyU1Nw2txTtUWKjvjFk+QFcI7MzvlcnsM5VGYztjS/eS87aviW3zQyTK13n2X0Yr9Jg6De+ScSGbrFCjGU/tolUcoN2/eSg0RyRyuGSlYL7cv3u8U1RUj7IASr/A45ZTYXU6uGK0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019449; c=relaxed/simple;
	bh=DPEJuJcsATVIDufVoiETH89aE+CRYFVB2aOCyZlNQsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGlRqZA7/TRHaPJmNWHy2232aTNWkeDxiQKiu9Y3kdSSURpoIkDQdZtdvY2b4yGjG2jF8eNu1rxvYINS2d72+Kj0E6Jr7A5vv003QA2UAg7qwuQOarVAHq/OyMp78hHfJ3NwFNtjVmrQSATDSuN3dzrglFkrzidHL7JVaTKTdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHdtr5J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7354C4CED2;
	Tue, 19 Nov 2024 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019449;
	bh=DPEJuJcsATVIDufVoiETH89aE+CRYFVB2aOCyZlNQsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHdtr5J1u3IdPqZBHEFL6rSUe3QFaxBKDaX815B2UGk7x22Mu1kaWGjkOzZ5LYoWl
	 gK+h+95p4U84VOhdti4ajeGEde1mRarQHEoYPvYmL58ShyUhpfHIv4cWUKRU4Kg7kG
	 LPCtRiBE5Vuj0AN33zdeLRPfld6f7KhPn2wiTJDklpe7OHoy70OMRz0NqWgDDLgBVL
	 8y4GlwRS3AFTRzeesSsquMzYoj98/D19fqX9mw+MgFcuY6j1VekdibMZDSBzb/ghUK
	 PnCRLg7cQ3MSMahCS02+GnW1eJ/rnIgyWnGIpwWkBBleVL1H4I+yWGOip9Yl0FAz5j
	 dDDrVwi42wziw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 5/5] NFSD: Never decrement pending_async_copies on error
Date: Tue, 19 Nov 2024 07:30:47 -0500
Message-ID: <20241119004732.4703-6-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119004732.4703-6-cel@kernel.org>
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

The upstream commit SHA1 provided is correct: 8286f8b622990194207df9ab852e0f87c60d35e9

WARNING: Author mismatch between patch and upstream commit:
Backport author: cel@kernel.org
Commit author: Chuck Lever <chuck.lever@oracle.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: 1421883aa30c)      |
| 6.6.y           |  Not found                                   |
| 6.1.y           |  Not found                                   |
| 5.15.y          |  Not found                                   |
| 5.10.y          |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 02:17:05.153083472 -0500
+++ /tmp/tmp.7qxXQiIMTe	2024-11-19 02:17:05.147810577 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 8286f8b622990194207df9ab852e0f87c60d35e9 ]
+
 The error flow in nfsd4_copy() calls cleanup_async_copy(), which
 already decrements nn->pending_async_copies.
 
@@ -9,10 +11,10 @@
  1 file changed, 1 insertion(+), 3 deletions(-)
 
 diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
-index 5fd1ce3fc8fb7..d32f2dfd148fe 100644
+index b439351510d2..237e47896af8 100644
 --- a/fs/nfsd/nfs4proc.c
 +++ b/fs/nfsd/nfs4proc.c
-@@ -1845,10 +1845,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+@@ -1791,10 +1791,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  		refcount_set(&async_copy->refcount, 1);
  		/* Arbitrary cap on number of pending async copy operations */
  		if (atomic_inc_return(&nn->pending_async_copies) >
@@ -24,3 +26,6 @@
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

