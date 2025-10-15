Return-Path: <stable+bounces-185863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B32BE0E76
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 00:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC0C1A21061
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 22:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5A305079;
	Wed, 15 Oct 2025 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYjD/ygT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6AF2652A4
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566131; cv=none; b=qPsM6mCjkdhIBryxMsWjcHYpq7dVVUIQcU4fZVN9BabNqpRf128z8FTSPRWlb5Qy2CdR97625NoEmuJG09PQXto+b6iLN+VXnz96/IxTUy/bevAMENl9J1spIfqcbsQPKL1nde2RiOJTU1dccifeY6Z8CXUZuXdbfZpOghZm0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566131; c=relaxed/simple;
	bh=P3jVgtui9oH2tr3o/Vnstegi650jwiIgQRQZ+beDdAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtuaIofBFxEYJ8lblIZgxlR6IimrrnxcpKXc37ETJpZr6svshA35MpfJjMhUZuI/EQRPAcTfHZCvHxFWoowYCL8WssUuEYNs5ufrw+zNhTbRYi3B9PetHcEV4gK5BLU3ovIAhI49h4Tsjc7+AHr45rFRkjHmrq9T78z7JPokcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYjD/ygT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F38C4CEF8;
	Wed, 15 Oct 2025 22:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760566130;
	bh=P3jVgtui9oH2tr3o/Vnstegi650jwiIgQRQZ+beDdAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYjD/ygTavMg8dbjOIOGIngoSITM40EwcopM40td0UyHC4ikVjjyCAYTqh8G/Gazk
	 mCQhKhBOgnWR7X9nHFWxLJ+X0/RBzHRBy3lQfGpN3MhUifYt4d0X2s0vTRWZqJvvvz
	 8w5mM3FaIHOsYaDShNDNSS9xop7ZYU9tTs51PPD0POuuyFccqzbN+EmB1ZQp4mnnCo
	 xmXvFvZJ8LdMukZnMbw2CBcq1hTrEMtDYqrNWJ5IqBjdo5NWf/sj///nH4rVKS2fFc
	 1iCPchX060PVXYTTGPMzNuLBhBh1mNeJLOcOz4hGX7qBiGoWVsqxTrCkJCXGplFYzN
	 8a6nqNSOdq1ZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neilb@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] NFSD: Replace use of NFSD_MAY_LOCK in nfsd4_lock()
Date: Wed, 15 Oct 2025 18:08:43 -0400
Message-ID: <20251015220846.1531878-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015220846.1531878-1-sashal@kernel.org>
References: <2025101547-demeanor-rectify-27be@gregkh>
 <20251015220846.1531878-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 6640556b0c80edc66d6f50abe53f00311a873536 ]

NFSv4 LOCK operations should not avoid the set of authorization
checks that apply to all other NFSv4 operations. Also, the
"no_auth_nlm" export option should apply only to NLM LOCK requests.
It's not necessary or sensible to apply it to NFSv4 LOCK operations.

Instead, set no permission bits when calling fh_verify(). Subsequent
stateid processing handles authorization checks.

Reported-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 898374fdd7f0 ("nfsd: unregister with rpcbind when deleting a transport")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bcb44400e2439..7b0fabf8c657a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7998,11 +7998,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (check_lock_length(lock->lk_offset, lock->lk_length))
 		 return nfserr_inval;
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh,
-				S_IFREG, NFSD_MAY_LOCK))) {
-		dprintk("NFSD: nfsd4_lock: permission denied!\n");
+	status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0);
+	if (status != nfs_ok)
 		return status;
-	}
 	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
-- 
2.51.0


