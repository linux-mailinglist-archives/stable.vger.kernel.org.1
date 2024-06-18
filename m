Return-Path: <stable+bounces-53049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA7290CFF3
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96811F23CD1
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A2A152E15;
	Tue, 18 Jun 2024 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SgTxwE99"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8C13D8BC;
	Tue, 18 Jun 2024 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715177; cv=none; b=LnQPCC/ryqosiM4usomlSRINEJe5x7jAP2HVcqHMOXtTk4+3mH9QWMgs0J/VWRVYn9Gomoewedg9UlJZOgS94GQhfk49NCikrY4GnOXyoJ7QuZR3+IyjfnYpxdt7bfJJoI1Jp79jTHNX9tBeLlf0vW0vgTI3H68xe9TAo8VKsSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715177; c=relaxed/simple;
	bh=FV2C54oqnEyMg/e8wzsqQKB/zA2pGzfOke15jprO6d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGzYKwkKaLwO1aQYenmFie8mcZ244Yuz2kfUZBlkcATLNkwdsWPfNuOJuiFFUyM2yfQ7lpe/yHrubbu0pImHxjx1R0TUAjwlkRQdL1r+VVTUuM0QxXO1i8GjESiP6fXP/6FW8tvxO+VTg08qk3QUtfd693CFCHWHWfrpPB/xb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SgTxwE99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A747C3277B;
	Tue, 18 Jun 2024 12:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715177;
	bh=FV2C54oqnEyMg/e8wzsqQKB/zA2pGzfOke15jprO6d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgTxwE99wta9nSwclXJOsaV7+jIu7rEtXYcTJZ16MR9M8Rlm3gL0WPev7AGluvffI
	 CDgPctQ7nLsaNmaCH1MsBddVYId+CmHYYSa+y8ayjZ8WiORNk5lil1GNFlnsDiZZCw
	 l1oYJzGedKn1tYWqi3sv6kP55ySRgBhTM+kuKkOc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 221/770] NFSD: Update the NFSv2 READLINK result encoder to use struct xdr_stream
Date: Tue, 18 Jun 2024 14:31:14 +0200
Message-ID: <20240618123415.812594803@linuxfoundation.org>
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

[ Upstream commit d9014b0f8fae11f22a3d356553844e06ddcdce4a ]

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsproc.c |  5 +++--
 fs/nfsd/nfsxdr.c  | 26 ++++++++++++--------------
 fs/nfsd/xdr.h     |  1 +
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 2a30b27c9d9be..fa9a18897bc29 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -151,13 +151,14 @@ nfsd_proc_readlink(struct svc_rqst *rqstp)
 {
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
-	char *buffer = page_address(*(rqstp->rq_next_page++));
 
 	dprintk("nfsd: READLINK %s\n", SVCFH_fmt(&argp->fh));
 
 	/* Read the symlink. */
 	resp->len = NFS_MAXPATHLEN;
-	resp->status = nfsd_readlink(rqstp, &argp->fh, buffer, &resp->len);
+	resp->page = *(rqstp->rq_next_page++);
+	resp->status = nfsd_readlink(rqstp, &argp->fh,
+				     page_address(resp->page), &resp->len);
 
 	fh_put(&argp->fh);
 	return rpc_success;
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 989144b0d5be2..74d9d11949c6c 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -527,24 +527,22 @@ nfssvc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
-	*p++ = resp->status;
-	if (resp->status != nfs_ok)
-		return xdr_ressize_check(rqstp, p);
-
-	*p++ = htonl(resp->len);
-	xdr_ressize_check(rqstp, p);
-	rqstp->rq_res.page_len = resp->len;
-	if (resp->len & 3) {
-		/* need to pad the tail */
-		rqstp->rq_res.tail[0].iov_base = p;
-		*p = 0;
-		rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
-	}
-	if (svc_encode_result_payload(rqstp, head->iov_len, resp->len))
+	if (!svcxdr_encode_stat(xdr, resp->status))
 		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
+			return 0;
+		xdr_write_pages(xdr, &resp->page, 0, resp->len);
+		if (svc_encode_result_payload(rqstp, head->iov_len, resp->len) < 0)
+			return 0;
+		break;
+	}
+
 	return 1;
 }
 
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 45aa6b75a5f87..b17fd72c69a6a 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -94,6 +94,7 @@ struct nfsd_diropres  {
 struct nfsd_readlinkres {
 	__be32			status;
 	int			len;
+	struct page		*page;
 };
 
 struct nfsd_readres {
-- 
2.43.0




