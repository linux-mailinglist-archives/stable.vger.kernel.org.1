Return-Path: <stable+bounces-246072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHVeLOtsA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:09:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF677526EBE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 814F330B381E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9F3EDE75;
	Tue, 12 May 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J8y8z4jf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93C3EDE7B;
	Tue, 12 May 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608286; cv=none; b=pBQjc4XX6I4oUOCFzUmiMUGFXda+qn1hb1q33icGIrhkADXTVGALsokgqLePrhpYAuziEdkCetqV0pJTkPik9+wGG7yBougJGGqhLdFmVF2UihpEKlJq/DTONzE8Le12ktV1oDzf17GtoPwkgM41a5EyKEbC+WN9XJtoik6ru9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608286; c=relaxed/simple;
	bh=+bb8TxnSxIhe6iqSt/n07ufhMbZn0/7krSTTLIvhOSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jxkxp8FzNA4MPY7mIw12UP/Z9OuUE3Tue+xB24pHd5Nx6f7ZVhoLAHQP43N6fUcpFvucSNDM3gCm8Nb2MayKBsvY77DYCoEi7ljpxAXZ2GlfRS8l/o0o/65rJCB/2QPzphls44ZXJaUWvTLGngiArncuc1GvvXfvh3Su76BuuAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J8y8z4jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90B7C2BCB0;
	Tue, 12 May 2026 17:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608286;
	bh=+bb8TxnSxIhe6iqSt/n07ufhMbZn0/7krSTTLIvhOSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8y8z4jfVwyfNra8zy14eL/Ej5oKgjHJloX3aaUrMVcgeod6Gk0UCMsq/Rq+CQqBj
	 5Wq1WooG3uxk616gbPym8o4qMUbZ4LDAhSeod0WMVIqxcsj6Hfe7G5zJt0pjAo7eWT
	 jXcgM6fwFb5hLR761xkCxCR3lqmvfn+syUxxKwvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Metzmacher <metze@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Yi Kuo <yi@yikuo.dev>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 020/270] smb: client/smbdirect: fix MR registration for coalesced SG lists
Date: Tue, 12 May 2026 19:37:01 +0200
Message-ID: <20260512173938.883135006@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF677526EBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246072-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,yikuo.dev:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yi Kuo <yi@yikuo.dev>

commit 9900b9fee5a0e0f72d7c744b37c7c851d5785ac6 upstream.
The stable backport to < 7.1 patches a different file. Also
the Fixes tag below is adjusted for the old code path.

ib_dma_map_sg() modifies the provided scatterlist and returns the
number of mapped entries, which can be fewer than the requested
mr->sgt.nents if the DMA controller coalesces contiguous memory
segments. Passing the original, uncoalesced count to ib_map_mr_sg()
causes memory registration failures if coalescing actually occurs.

Capture the actual mapped count returned by ib_dma_map_sg() and pass it
to ib_map_mr_sg() to ensure correct MR registration.

Also update the ib_dma_map_sg() error logging to drop the error
pointer formatting, since the return value is an integer count
rather than an error code.

Ensure a proper error code (-EIO) is assigned when DMA mapping or
MR registration fails.

Fixes: c7398583340a ("CIFS: SMBD: Implement RDMA memory registration")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221408
Reviewed-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yi Kuo <yi@yikuo.dev>
Signed-off-by: Steve French <stfrench@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smbdirect.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index ff44a2dc49938..e2b20219ba2c7 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -2895,7 +2895,7 @@ struct smbdirect_mr_io *smbd_register_mr(struct smbd_connection *info,
 	struct smbdirect_socket *sc = &info->socket;
 	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct smbdirect_mr_io *mr;
-	int rc, num_pages;
+	int rc, num_pages, num_mapped;
 	struct ib_reg_wr *reg_wr;
 
 	num_pages = iov_iter_npages(iter, sp->max_frmr_depth + 1);
@@ -2923,18 +2923,21 @@ struct smbdirect_mr_io *smbd_register_mr(struct smbd_connection *info,
 		    num_pages, iov_iter_count(iter), sp->max_frmr_depth);
 	smbd_iter_to_mr(iter, &mr->sgt, sp->max_frmr_depth);
 
-	rc = ib_dma_map_sg(sc->ib.dev, mr->sgt.sgl, mr->sgt.nents, mr->dir);
-	if (!rc) {
-		log_rdma_mr(ERR, "ib_dma_map_sg num_pages=%x dir=%x rc=%x\n",
-			    num_pages, mr->dir, rc);
+	num_mapped = ib_dma_map_sg(sc->ib.dev, mr->sgt.sgl, mr->sgt.nents, mr->dir);
+	if (!num_mapped) {
+		log_rdma_mr(ERR, "ib_dma_map_sg num_pages=%x dir=%x num_mapped=%x\n",
+			    num_pages, mr->dir, num_mapped);
+		rc = -EIO;
 		goto dma_map_error;
 	}
 
-	rc = ib_map_mr_sg(mr->mr, mr->sgt.sgl, mr->sgt.nents, NULL, PAGE_SIZE);
-	if (rc != mr->sgt.nents) {
+	rc = ib_map_mr_sg(mr->mr, mr->sgt.sgl, num_mapped, NULL, PAGE_SIZE);
+	if (rc != num_mapped) {
 		log_rdma_mr(ERR,
-			    "ib_map_mr_sg failed rc = %d nents = %x\n",
-			    rc, mr->sgt.nents);
+			    "ib_map_mr_sg failed rc = %d num_mapped = %x\n",
+			    rc, num_mapped);
+		if (rc >= 0)
+			rc = -EIO;
 		goto map_mr_error;
 	}
 
-- 
2.53.0




