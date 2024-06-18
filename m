Return-Path: <stable+bounces-53462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2D290D1BB
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A791C21E22
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB81A2C00;
	Tue, 18 Jun 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y4ny0p3s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1854513A41E;
	Tue, 18 Jun 2024 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716397; cv=none; b=W4bji7H4Yyo+AGGbT5v4WZeiDgJfDWMLi5rmtl4apg0YYReWMHIk0IE+Yw3FjI5slNCTfNWVa46iqaTYD3s3zyTSwEU3J3FFsoNa6XxxomrXQNdRKbTD4rblNudgiRKbYmiqxi3KBwNAt6SsVLBpba2s5RPUVShHQSo9RHXqpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716397; c=relaxed/simple;
	bh=FNFgHcepOTXql9G+zXM+zHFHWhMbN3s6lrBubeAhPG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJv17gs54WyrQmtTjPisXI7sw3B7Z6dvGXQ1s2RENRxXb/WovSh5GbcJkEaESqWX0TjzWqrtvqiv0xPaZhvpKcYCEkDrC4omjk2hapz2oYC+84l6A565GoFDrJ7/XsRUxaoE/hdBRM/ZIeaqW1wuRYbzjBfPA+oAVkLnGAnsctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y4ny0p3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F6AC3277B;
	Tue, 18 Jun 2024 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716396;
	bh=FNFgHcepOTXql9G+zXM+zHFHWhMbN3s6lrBubeAhPG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4ny0p3sNCuPyWadQ6fTssVdhv1WGasHB30dCl7bb/dOj1QjaKyFuRxLeSu/sfu+o
	 NEDylWcBBURUVPtrlWvlrdzYJpfqHhueDIm7EbKymcPar76qdlOr14XfmYyZqoY/an
	 s/Kbrv+GrJAYJudvKyWwA0UKeCP1STTM9Kw/WFj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 633/770] NFSD: Protect against send buffer overflow in NFSv2 READDIR
Date: Tue, 18 Jun 2024 14:38:06 +0200
Message-ID: <20240618123431.718549671@linuxfoundation.org>
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

[ Upstream commit 00b4492686e0497fdb924a9d4c8f6f99377e176c ]

Restore the previous limit on the @count argument to prevent a
buffer overflow attack.

Fixes: 53b1119a6e50 ("NFSD: Fix READDIR buffer overflow")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsproc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index e533550a26db5..559603a0a5358 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -567,12 +567,11 @@ static void nfsd_init_dirlist_pages(struct svc_rqst *rqstp,
 	struct xdr_buf *buf = &resp->dirlist;
 	struct xdr_stream *xdr = &resp->xdr;
 
-	count = clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
-
 	memset(buf, 0, sizeof(*buf));
 
 	/* Reserve room for the NULL ptr & eof flag (-2 words) */
-	buf->buflen = count - XDR_UNIT * 2;
+	buf->buflen = clamp(count, (u32)(XDR_UNIT * 2), (u32)PAGE_SIZE);
+	buf->buflen -= XDR_UNIT * 2;
 	buf->pages = rqstp->rq_next_page;
 	rqstp->rq_next_page++;
 
-- 
2.43.0




