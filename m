Return-Path: <stable+bounces-53450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFA890D2C4
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624D2B2A5D8
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095D61A2C22;
	Tue, 18 Jun 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KZUay1aH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CE1A2C14;
	Tue, 18 Jun 2024 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716361; cv=none; b=aVN4fZib5NPSwtsP7eXYNSe6lBFhZotfxyKQdxbLGASlhpyndDmLSNGzXzoUZ/3/JHl12sVijhZIlqgvFVgLltulv+GqOqlhWnxxCLlz3GaOq2FS9qTOdDxCyEWeJhEIMw6TRPxqANEUVmgnqT8BrHiI0QRWV443ce/AEF7KvCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716361; c=relaxed/simple;
	bh=981CRhA1GhJh/iWMbUwBb6QeD3eUmhAzPyAZaa7E5P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6Y5O1KJMUVczIfzgIRt60S5ZbqvTqhyCetzL5tXSt3bmmHK4UV+kTwKa+oOaUubRcCRz556veRxVF+UqfN6lfwD91JA4T4GBK5IrFrRcrPqsHN2MG5Go42vxqAaGWf8a+fVsDWc3kWRN6fcgXDdzGkolZjS58XqQLhRpVgzH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KZUay1aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0382DC3277B;
	Tue, 18 Jun 2024 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716361;
	bh=981CRhA1GhJh/iWMbUwBb6QeD3eUmhAzPyAZaa7E5P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZUay1aH6uu74FK7Jnf4kN1rqR2hhr4KrRiJt5jZF6UPEjYq+Kaj8/OW3al+GAmWA
	 lbg3p2sTDiU2LpuWh5zU/pcNfC54IpCggFufIuv0PXf7Ur0kgzzD2ZdbjTAgsxX/Sk
	 YUxgKCotye1iew8ls3S1mXkI92/HDGj/8Rxtfn3k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 589/770] NFSD: Optimize nfsd4_encode_operation()
Date: Tue, 18 Jun 2024 14:37:22 +0200
Message-ID: <20240618123430.032105097@linuxfoundation.org>
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

[ Upstream commit 095a764b7afb06c9499b798c04eaa3cbf70ebe2d ]

write_bytes_to_xdr_buf() is a generic way to place a variable-length
data item in an already-reserved spot in the encoding buffer.
However, it is costly, and here, it is unnecessary because the
data item is fixed in size, the buffer destination address is
always word-aligned, and the destination location is already in
@p.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b98a24c2a753c..14e8e37550609 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5381,8 +5381,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 						so->so_replay.rp_buf, len);
 	}
 status:
-	/* Note that op->status is already in network byte order: */
-	write_bytes_to_xdr_buf(xdr->buf, post_err_offset - 4, &op->status, 4);
+	*p = op->status;
 }
 
 /* 
-- 
2.43.0




