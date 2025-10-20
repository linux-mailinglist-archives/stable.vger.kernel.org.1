Return-Path: <stable+bounces-188084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDE1BF1606
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF42E18A5F68
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BE7313539;
	Mon, 20 Oct 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3EqOLuK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B11303A0D
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965063; cv=none; b=Ra4MOrBY9W2m5Eh8f7mKKmZtPH448Q5iC3NQiFAjfII7xwi7xTOewbX9G+G+NGQDGouijkxdeiSU5Xo7FgyGUrxVGYrKA2N8Vh2JEjLOSxDNTgbbAtx+qXXb+f30nFNZl25s13Nbdz05hAgrXvYW3ke1Gh5oq1H9MTijxueXN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965063; c=relaxed/simple;
	bh=yBKQ9WRTeSz0pTu49aTCHTBkXn3jvNadJsku6cDDug8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq8M5e77uV95Ty8fm4FlxzggynotZCvhg1WHbO3G9nsO8e1OHxNSMEJcuFiAo5sm6otzy+qRr9RnQd2VS2oXUVjsUAyE8URuX91J7V8F13rolLVYjhGgZz325Z9tYnVLNyZa1aSyTzPWJPG2msyQvg9SPkqmZP8P7WVE8TPlLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3EqOLuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846A7C116B1;
	Mon, 20 Oct 2025 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965063;
	bh=yBKQ9WRTeSz0pTu49aTCHTBkXn3jvNadJsku6cDDug8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3EqOLuKjXvAhz9p8nt4nCWnxCLH5oqrfn5aQ+odaV9TB0u2kRRtWkfoRecdYL5GQ
	 4S+d3RaavwmdsJvTTiGcPqI4jNtseOVFzJEl7yyvIzgCpW3GtoQGaWBPsXxzMnNj8Q
	 PFCEe3dK9NvaUbnZVa6COEhs0j5JLcV2F+lE2gWFTt6ua80p93QiW9bQ1s7ckHI3As
	 H5cNIvjNk0XzagkCGO78ae5AOIlW7Siruw+dglnH0Cf+gVPpyzB1m8PEziiqtWiZ03
	 jEZlrSORsJ6Wbqgu9peywV9rfmJDcGvYxykIQH9BZtPZopNXnngujdq8IatSxLEBKW
	 Uu1fFjHZSf4uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] NFSD: Minor cleanup in layoutcommit processing
Date: Mon, 20 Oct 2025 08:57:39 -0400
Message-ID: <20251020125740.1762043-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101600-daintily-walk-9f1a@gregkh>
References: <2025101600-daintily-walk-9f1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Bashirov <sergeybashirov@gmail.com>

[ Upstream commit 274365a51d88658fb51cca637ba579034e90a799 ]

Remove dprintk in nfsd4_layoutcommit. These are not needed
in day to day usage, and the information is also available
in Wireshark when capturing NFS traffic.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: d68886bae76a ("NFSD: Fix last write offset handling in layoutcommit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 527d6b29dffb6..5600fdfa189b8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1717,18 +1717,12 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	inode = d_inode(current_fh->fh_dentry);
 
 	nfserr = nfserr_inval;
-	if (new_size <= seg->offset) {
-		dprintk("pnfsd: last write before layout segment\n");
+	if (new_size <= seg->offset)
 		goto out;
-	}
-	if (new_size > seg->offset + seg->length) {
-		dprintk("pnfsd: last write beyond layout segment\n");
+	if (new_size > seg->offset + seg->length)
 		goto out;
-	}
-	if (!lcp->lc_newoffset && new_size > i_size_read(inode)) {
-		dprintk("pnfsd: layoutcommit beyond EOF\n");
+	if (!lcp->lc_newoffset && new_size > i_size_read(inode))
 		goto out;
-	}
 
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
 						false, lcp->lc_layout_type,
-- 
2.51.0


