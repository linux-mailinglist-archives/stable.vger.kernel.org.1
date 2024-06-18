Return-Path: <stable+bounces-53005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D19590CFBC
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42719281944
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6918F14F9D0;
	Tue, 18 Jun 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qFN058pu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2F14F13D;
	Tue, 18 Jun 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715047; cv=none; b=hIpraIOVn0lCtTuHIWufWN8lB31EKz4LqL+odGS4OfCPCiYOhtEeZk1VG2BpDIH84f4i5SBNiVQIZmgExig0mLucf8ZSU2NgcmwHEh5zBWS4Z4v/mdXOcBB0I988+lPLeeVtlD3JqCtjdOrm+YH4FWAyhTB3XX4mXqVp/VuCQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715047; c=relaxed/simple;
	bh=F61ccwz6BaCJw2kd7bff6kPQLSc0F62gyDVmcFb8l6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGZtdVVTplp29qI1zKgSBMHLHdQDlT59VP9pYMMPEqhKV6jVijYkYXZsZJWCNX04BJr/Li3v2zO9F2WQJ1aadeIXDzY+w9IyWgjpmSmKxn41s68g2Jr39goYgFuJPsdQFVXEuVRzoSff+C7xWVReT/zUAaXD/PMQor5r80az2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qFN058pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44F9C3277B;
	Tue, 18 Jun 2024 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715047;
	bh=F61ccwz6BaCJw2kd7bff6kPQLSc0F62gyDVmcFb8l6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFN058puAeHSg2jsiMjBS07GAtTLckL4+j7hpAnsNbUl/4MmkDWSyNBT8lv+26FKO
	 1C0l9bfBqJBLA0xpBLI6MSFBOAZmi8DS4ou3cStEpZ1xlEeMxyKZiziJ2+5CPZ+uCl
	 qpv0U15LmdV4XK3oGSA1zQOMAtPOzvOCSf0n/oWA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 144/770] NFSD: Update COMMIT3arg decoder to use struct xdr_stream
Date: Tue, 18 Jun 2024 14:29:57 +0200
Message-ID: <20240618123412.835485351@linuxfoundation.org>
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

[ Upstream commit c8d26a0acfe77f0880e0acfe77e4209cf8f3a38b ]

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs3xdr.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index eb55be106a04e..bafb84c978616 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -601,14 +601,17 @@ nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_commitargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_commitargs *args = rqstp->rq_argp;
-	p = decode_fh(p, &args->fh);
-	if (!p)
+
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return 0;
+	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
 		return 0;
-	p = xdr_decode_hyper(p, &args->offset);
-	args->count = ntohl(*p++);
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
 /*
-- 
2.43.0




