Return-Path: <stable+bounces-52977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8CE90CF9B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD47E1C230E1
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB5E15EFD5;
	Tue, 18 Jun 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YRcmTzB+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948B15EFCB;
	Tue, 18 Jun 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714967; cv=none; b=e48CGm7r+O1E5TQp5tzZch4WxkMi/xrWbzyILXIDy60umoczILMvs6iZ1a8UPrYTkNbk7fqbSAvCO3wdU9lx3AB7Z5+x0lXOiHq8CwpggpvOtqpbWrjuNvNTVX8ZQl7suYpbNjmBOcL/mPmBm+tnQ4+/OsInxEoamNuUo8ZpnSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714967; c=relaxed/simple;
	bh=t+x7k4vWqAThZRQOdLtaCy6hXNBhrTMbGisPTte3WVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7y8upsoZ9cbPQUkGXPB1yhllkzR0EQ9Cg/+7jbWwumN/Bm1HwOTk1e4AE+dPSqLnsrT2wnoMOuPFqd6lZMZnhDxt+HfCXdT/pkByBdqBo4J5CHcexTw4dxshrQkjqUUJXeUYU3cy8f7UhfmqbeifCBnaVzvCEjRcOf3Xq2lBT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YRcmTzB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B117C4AF1D;
	Tue, 18 Jun 2024 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718714967;
	bh=t+x7k4vWqAThZRQOdLtaCy6hXNBhrTMbGisPTte3WVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRcmTzB+Sc52jEvATZK+L6jzFAXtOR+N170iWR8gm6yCUq2zFrBZDB2yX2rcastRp
	 7pG/UeKMz6OtcoQNMIlDZZChERh6a8XybAenyZNaS9/Vl9f/vl1xh3vPoNa9FyTXqK
	 dYZPLoS0F2guOlQpGnGn7p2BZS0wVKF3Mw3910bc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 150/770] NFSD: Update the MKDIR3args decoder to use struct xdr_stream
Date: Tue, 18 Jun 2024 14:30:03 +0200
Message-ID: <20240618123413.064043713@linuxfoundation.org>
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

[ Upstream commit 83374c278db193f3e8b2608b45da1132b867a760 ]

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs3xdr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 24db3725a070b..b4071cda1d652 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -605,14 +605,12 @@ nfs3svc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_createargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh)) ||
-	    !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-	p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_diropargs3(xdr, &args->fh,
+					&args->name, &args->len) &&
+		svcxdr_decode_sattr3(rqstp, xdr, &args->attrs);
 }
 
 int
-- 
2.43.0




