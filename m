Return-Path: <stable+bounces-52992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7FB90CFAD
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D4A1F21448
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5A15F410;
	Tue, 18 Jun 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q9f9kIlB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3412614F118;
	Tue, 18 Jun 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715010; cv=none; b=qfEFLqbEdhfNyOuukhL6Hk0zKjEJij9aW40+XxPP2wXkkRWXJbKFTPKfRy+nZMuKoQPF8CP3MWEfTVVrEzHP6ESweFxy9pTgrgZCVg09/K5FhU8NMYCvNvySaPebqmyyUt2hGn19/p8tqsjU32GrKpUdkjk5D6sZp9jL/e1fJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715010; c=relaxed/simple;
	bh=Wjs5Lqho8fYt9QtLMn6nP18lEe54FkPHSQGL8d3Mkzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEWlGrX/cy4uc/YbXS/MHNYrprkEZWtc/LdsP0H3mJ7jHVSXkqs2kYLW3DdHNe3jCQFWOQJbFcy7bShx6eBB8lXRKmSMLzIV80Us3+N5dtBlqGGAJinlCPxI0IVMUH1ZJtYLHtkkj+IJJkYjUkk8suour+Wa1FNq5cwECmyf2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q9f9kIlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D12FC3277B;
	Tue, 18 Jun 2024 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715008;
	bh=Wjs5Lqho8fYt9QtLMn6nP18lEe54FkPHSQGL8d3Mkzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9f9kIlBwvqjARyujggJjRd0WrBPmFBwNs6j4G+sDd4isN8pPbI4cY++/t2+uHWOz
	 /fsPFryMBzMg+1EFhpvnGT9FnWyjwrv/6hzUwknyO+YX0748BOl0zW4iU9uXrGHtPY
	 vfl0ECe/9AAITcNPMZmyaak/91hcqZSQiteCupJk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 163/770] NFSD: Update the NFSv2 CREATE argument decoder to use struct xdr_stream
Date: Tue, 18 Jun 2024 14:30:16 +0200
Message-ID: <20240618123413.567780352@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 7dcf65b91ecaf60ce593e7859ae2b29b7c46ccbd ]

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsxdr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 6c87ea8f38769..2e2806cbe7b88 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -401,14 +401,12 @@ nfssvc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_createargs *args = rqstp->rq_argp;
 
-	if (   !(p = decode_fh(p, &args->fh))
-	    || !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-	p = decode_sattr(p, &args->attrs, nfsd_user_namespace(rqstp));
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_diropargs(xdr, &args->fh,
+				       &args->name, &args->len) &&
+		svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
 int
-- 
2.43.0




