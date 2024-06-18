Return-Path: <stable+bounces-52976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D1B90CF9A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F81A1C232DF
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66CE15EFD2;
	Tue, 18 Jun 2024 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rdVITIIS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6315EFCF;
	Tue, 18 Jun 2024 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714964; cv=none; b=jW5FRcTh3CUTtUXdoXfP7SWks/Aoc2t8qTejOvyRuaG8ViloG1KdUifdJ/BiPWHgH4T+wmqTcvFotp9J1Dz+eBjNuIepczTKOwG7sBXMoxIIOzjDoVey6UiKf3v6WG3ylONxCL6Jgs7LCcEBpF+MwajM4R4sHvV8YqpOxCO28xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714964; c=relaxed/simple;
	bh=iW/RmruWaNbDQaY5s2bSAzYLx1gvaMXJ0bD63vbZMSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkleDyGzyy0NIkvWo878C3BMl0nJobNhYXr+koOIblood1evhJThwFtxFB89lntTfmQSaox1DfnLSFoIE7sRk+DH9h9sniMUiOmIiwojb6RCiYVEeezK24EkEybvNHa8u5NUHLoVrXiBaDaPKDENbUUdpRH+LiYogzvOxHEYKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rdVITIIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261F7C3277B;
	Tue, 18 Jun 2024 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718714964;
	bh=iW/RmruWaNbDQaY5s2bSAzYLx1gvaMXJ0bD63vbZMSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdVITIIShW7L+wgglJXbMa/uiTMYC9Z9nPLfdky6rC+0844wXM0a0RspX6RaKcwG6
	 q52X/3aZC++slJYnu+a42wj6pV5iJq4Q6o1x6g2mysbuBO2tGUQFm6NOsjh8GyUVNs
	 QJGqBED+886QNH/1LMYuS/RpVDXy8ZXDccJmBVjQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 149/770] NFSD: Update the CREATE3args decoder to use struct xdr_stream
Date: Tue, 18 Jun 2024 14:30:02 +0200
Message-ID: <20240618123413.024521817@linuxfoundation.org>
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

[ Upstream commit 6b3a11960d898b25a30103cc6a2ff0b24b90a83b ]

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs3xdr.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 6a6bf8e34d82b..24db3725a070b 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -580,26 +580,26 @@ nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_createargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh))
-	 || !(p = decode_filename(p, &args->name, &args->len)))
+	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
 		return 0;
-
-	switch (args->createmode = ntohl(*p++)) {
+	if (xdr_stream_decode_u32(xdr, &args->createmode) < 0)
+		return 0;
+	switch (args->createmode) {
 	case NFS3_CREATE_UNCHECKED:
 	case NFS3_CREATE_GUARDED:
-		p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
-		break;
+		return svcxdr_decode_sattr3(rqstp, xdr, &args->attrs);
 	case NFS3_CREATE_EXCLUSIVE:
-		args->verf = p;
-		p += 2;
+		args->verf = xdr_inline_decode(xdr, NFS3_CREATEVERFSIZE);
+		if (!args->verf)
+			return 0;
 		break;
 	default:
 		return 0;
 	}
-
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
 int
-- 
2.43.0




