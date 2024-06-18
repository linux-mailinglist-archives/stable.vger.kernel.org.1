Return-Path: <stable+bounces-53422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5891E90D18D
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE671C23318
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B51A254E;
	Tue, 18 Jun 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NjICWXGo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590F1586DB;
	Tue, 18 Jun 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716279; cv=none; b=qMeefu9zC968jLvzauITS3V4tUOa/+qYWGN59G/SsfriqcpED097HCXSJQC4gowcEm953giUd/9zdh/FO9952mWy+rI5IxoVSIpO41NF5savsfw2pH/R8qHJbMDhePw1kejwK6ol7TCPni9kElERnQ3mBFNEB4XodbsNXl8AOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716279; c=relaxed/simple;
	bh=ALWlAHYFcpytN0Tp2L0tMex8pyHfsA5GRLJ4nk7Csco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VikrlvT0MzWoW7xruy7lN+GXCmlndXG1j8uzUyLS1kxBhh7DMQ2ob4r2/b8kAbepEWevmhHxOy3tNehUZh1q4cWoQOTcwdFyjD0InruB/fa0V2u3zVdBmQRMSbWD3xXPuNJs84p7HSoQL5R5BJrmvTNQCEtLmhqtfugIGXff29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NjICWXGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54174C3277B;
	Tue, 18 Jun 2024 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716278;
	bh=ALWlAHYFcpytN0Tp2L0tMex8pyHfsA5GRLJ4nk7Csco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjICWXGox+5czrzarwhDzMvzbIM8bgzN6OnG9mZy8BAWOSneDVV5omwYLZKlOx8Q8
	 obVXqCmWX5cpaWKicdVO2Kr+se8bFTVbtNFJk8E+jPcwcxw7YLrC3FOzmAlwKTzJSO
	 pMVobmVaVGMxYOG7I0mpgWQ35fjgpQNDAFw846bo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 593/770] NFSD: Optimize nfsd4_encode_readv()
Date: Tue, 18 Jun 2024 14:37:26 +0200
Message-ID: <20240618123430.183896772@linuxfoundation.org>
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

[ Upstream commit 28d5bc468efe74b790e052f758ce083a5015c665 ]

write_bytes_to_xdr_buf() is pretty expensive to use for inserting
an XDR data item that is always 1 XDR_UNIT at an address that is
always XDR word-aligned.

Since both the readv and splice read paths encode EOF and maxcount
values, move both to a common code path.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8437a390480df..36f0f06714dec 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3891,7 +3891,6 @@ static __be32 nfsd4_encode_splice_read(
 	struct xdr_buf *buf = xdr->buf;
 	int status, space_left;
 	__be32 nfserr;
-	__be32 *p = xdr->p - 2;
 
 	/* Make sure there will be room for padding if needed */
 	if (xdr->end - xdr->p < 1)
@@ -3910,9 +3909,6 @@ static __be32 nfsd4_encode_splice_read(
 		goto out_err;
 	}
 
-	*(p++) = htonl(read->rd_eof);
-	*(p++) = htonl(maxcount);
-
 	buf->page_len = maxcount;
 	buf->len += maxcount;
 	xdr->page_ptr += (buf->page_base + maxcount + PAGE_SIZE - 1)
@@ -3973,11 +3969,6 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 		return nfserr_io;
 	xdr_truncate_encode(xdr, starting_len + 8 + xdr_align_size(maxcount));
 
-	tmp = htonl(read->rd_eof);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
-	tmp = htonl(maxcount);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
-
 	tmp = xdr_zero;
 	pad = (maxcount&3) ? 4 - (maxcount&3) : 0;
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + maxcount,
@@ -4019,11 +4010,14 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
 		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
-
-	if (nfserr)
+	if (nfserr) {
 		xdr_truncate_encode(xdr, starting_len);
+		return nfserr;
+	}
 
-	return nfserr;
+	p = xdr_encode_bool(p, read->rd_eof);
+	*p = cpu_to_be32(read->rd_length);
+	return nfs_ok;
 }
 
 static __be32
-- 
2.43.0




