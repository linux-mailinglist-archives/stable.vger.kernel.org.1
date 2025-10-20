Return-Path: <stable+bounces-188062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB65ABF157F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F9418A42C0
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4F0313278;
	Mon, 20 Oct 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfym0tuW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE143128BA
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964750; cv=none; b=q0xG0f6FQxfvIjawS821DQusSKBC264m5TrNYFZRxqIPNgt2duQWABTmvd4u6z18tKZabc/CttOcuRPCK+3bydsXl0qY1exxJPhT2KiLNWnY8r+KKgTNZ6hgmQ3/0fs7RQX7BjAIz9KjZKXJd0nkPB9Gku53BrHcFZMWEXLZMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964750; c=relaxed/simple;
	bh=66Z4qU08xe6QVBQtgBHHcMlGC5UjuvK3UTyHU5wAWRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYjpvXap92SuKx2RieNkAwiHhpGAysDkOOd0pVp1sFppQwF/fgvB9/d90bkPDr3QWePTKu0hO12JKr+LHq1w0JW2bgfYo1BvJOYFsINN6qVpGdco4luUKVXfLJrHYHmJ/JIMbjp7VHTYw0o75X97iBeUut7d1XwzJLSRoXD4LSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfym0tuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B715C113D0;
	Mon, 20 Oct 2025 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964750;
	bh=66Z4qU08xe6QVBQtgBHHcMlGC5UjuvK3UTyHU5wAWRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfym0tuWxbP5QOCYoI8u/e9RFSFq00fiHITKEZdJznt76b3Dqy/zez2sJBDROgRXi
	 oSLihbLMCcmGy21QOFTJlqZ6iU8TrVC9hXkoIBd0+nE5BGPVddDyU1wxW+vR8Er1lJ
	 jMOYK5OHd043ENCqpm8bPb3p8xPtpTZyov69eeu5bz2776PMCwQqndf2xOQDlMEEBz
	 tRZOnOv5riac+Xq/reS8ffAQ5pODagiYbbSt1GWKf4tXq5pNJUlnA6ha+4Dbd1SYPZ
	 G8oC9e+RwcWVrqrdMZkain9TIvVOlclW0dBXnT73YbdghtDUrMFex5Aq+8EPgOwF7Q
	 xCEqjlgrTNZLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/4] NFSD: Minor cleanup in layoutcommit processing
Date: Mon, 20 Oct 2025 08:52:23 -0400
Message-ID: <20251020125226.1759978-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125226.1759978-1-sashal@kernel.org>
References: <2025101656-unfrosted-rasping-f7dc@gregkh>
 <20251020125226.1759978-1-sashal@kernel.org>
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
index 75abdd7c6ef84..24f24047d3869 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2521,18 +2521,12 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
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


