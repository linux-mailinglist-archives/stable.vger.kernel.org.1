Return-Path: <stable+bounces-102569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7929EF340
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8627189268E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4964225A21;
	Thu, 12 Dec 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ym75PPzF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209A2210DA;
	Thu, 12 Dec 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021702; cv=none; b=RHc8Z9997vdklSVOZXyPY8GcZ8ouUf12zKm6qgbKiD3GvsZM4lxuPN/ZwQYzGbI8F+UahAOn0dBq3NUg41B7izvI5syz2jgp58v+Rb0yvrwKNFov3hUEfgaJjpYEnyql/Z2kFYo77ECdlAcnu9uQJbC8gHQY3HFwgVuTo39XNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021702; c=relaxed/simple;
	bh=jyl0CJj+ZMheTed/tHosHoxCvAssiAt6uFgflkSGAdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbxG1Qcrvm+M2/Mdsf44U4a5N1oAV+79tCYExhkKIKIFfDz8P+TKZvixYPuZzcmZrev8amkrBLwlxvORMj/h89RcOGvwYQiqhe0JzQZKWR+evZ7f329i0DMNRO9YDIg8gmCPhjGj41ESs5JpmTCzZK5yQC3RYg4JTVgyL5WnmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ym75PPzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7581C4CECE;
	Thu, 12 Dec 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021702;
	bh=jyl0CJj+ZMheTed/tHosHoxCvAssiAt6uFgflkSGAdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ym75PPzFYGuhMn1IkKQKIuoh+R39lsa3Xn0o3GQsGI/wiMj68iAAK5BVpwvO2xYjl
	 TW/QuaQQigPOPJDWI/K43/o3cEizVWQautDJmxaM6XUvpNMf9PkFOTRKM6ZGE8sQcq
	 NrJiEd6nlMqVSCsWJE2sDkdCTwWrfE6peV1KNhXw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dai Ngo <dai.ngo@oracle.com>,
	Chen Hanxiao <chenhx.fnst@fujitsu.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 039/565] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Thu, 12 Dec 2024 15:53:54 +0100
Message-ID: <20241212144313.005370341@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 15d1975b7279693d6f09398e0e2e31aca2310275 ]

Prepare for adding server copy trace points.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Tested-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Stable-dep-of: 9ed666eba4e0 ("NFSD: Async COPY result needs to return a write verifier")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1769,6 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struc
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
 
+	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
 		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
 			status = nfserr_notsupp;
@@ -1783,7 +1784,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struc
 			return status;
 	}
 
-	copy->cp_clp = cstate->clp;
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {



