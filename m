Return-Path: <stable+bounces-90562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891079BE8F8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E503284ED4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD2D1DE4EA;
	Wed,  6 Nov 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cgngmUx2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A818C00E;
	Wed,  6 Nov 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896141; cv=none; b=iogv0vaeP6ONQIJ5btZQ8IziTZX4cCRu3IXIFM6sgI/UO1Sd1vU4be2aX5XKYHsS+dIkTaVz1kQj53byUheEN6Rz6kfiRSfJZE+WYJE+4Rorx37p9DkZodrRELBQI84mxBFE86rRWNYIayO9hWpVqFO2ytUVkHrhrU2IVvm9/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896141; c=relaxed/simple;
	bh=yAdDY4AptvFIBCEyk5xQ26SeyI+a891UHVyVB9gm8ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jt0SziLfX9bkXkM10v75LV83zq2OQqYSfKSK1j8c4v9lo3rOBN9hEu/Nw3oe9fxG1S/GGGHPQbtsbGWw5I+0k8hsWIOd2GT5KOEJ/Cil18MvDiORfOjh3D9jiibtHW8x3UEcWYDRwoGqUrwgOxtoa3HU3amAI9mOucE8JEznUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cgngmUx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05640C4CECD;
	Wed,  6 Nov 2024 12:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896141;
	bh=yAdDY4AptvFIBCEyk5xQ26SeyI+a891UHVyVB9gm8ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cgngmUx22mV1/VCLmC3EleqfY/z8CMklC1syVS9X32FAAeW7I/0G7NckB4gJCzh+d
	 kFiRoVbd1ThSp9s6naG79OspQYbSrChLLZBu/sGkcp1ha9+dIFmWfd+z0HmMq0iGpY
	 o2TRq28aEgRTvE9/E/85+QV0EHg3Dp2CzxFy1v/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 103/245] NFSD: Never decrement pending_async_copies on error
Date: Wed,  6 Nov 2024 13:02:36 +0100
Message-ID: <20241106120321.752292023@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 8286f8b622990194207df9ab852e0f87c60d35e9 ]

The error flow in nfsd4_copy() calls cleanup_async_copy(), which
already decrements nn->pending_async_copies.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY operations")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 81a1e3bf06b97..8b78d493e301f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1842,10 +1842,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		refcount_set(&async_copy->refcount, 1);
 		/* Arbitrary cap on number of pending async copy operations */
 		if (atomic_inc_return(&nn->pending_async_copies) >
-				(int)rqstp->rq_pool->sp_nrthreads) {
-			atomic_dec(&nn->pending_async_copies);
+				(int)rqstp->rq_pool->sp_nrthreads)
 			goto out_err;
-		}
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
 			goto out_err;
-- 
2.43.0




