Return-Path: <stable+bounces-188076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C907BF15CD
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD5F18A5E3C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097652FB621;
	Mon, 20 Oct 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5uqyFg7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0663FFD
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964907; cv=none; b=BHLurFGe9JJ+3XH4jutCYqXG8hBICojthYGBCD3sQWpmJCQqXcJrjWk0UlXpN02UdEefFJlxOiwfKjVGz5mFCNgz/5mL1QyI22RrCTHysQMaTPR4+Q4bu7oQczViajHmNKhNmWzD/h7JFaVOLebBBjJmjvakNu6FNC1rP55CuMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964907; c=relaxed/simple;
	bh=1Ms71/T9xw5qcYuh95pnGqk9Bb70S4o3kEe0OsZ+fF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1WJdkFOoEwhaesR3yXTQXEBDnMLePRvRRMtiD2saHXz7hatA/riM/lJauWLiRH+yOa6SQugZtjmTunLfj57S0vw8KhRHCC1P9I64AUlJn3jcsQYiqyf0tGg6av08kaq+70zs+qNrflpUqq0BpN9y4rGgGs0THSCWU+Vt+fRINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5uqyFg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7273C113D0;
	Mon, 20 Oct 2025 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964907;
	bh=1Ms71/T9xw5qcYuh95pnGqk9Bb70S4o3kEe0OsZ+fF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5uqyFg78rTd0AgBj4Rs1e8vxulU6N2tbdd4bdPdZYDCDOBY+ogG8AsJlXL2/uGDU
	 U1UMjZLYI8M4ILDYpIukDLbgl/Aj6ZUwegA1q7ZYRtX5Ki4gjyCHsov8XTMwjrgE5M
	 ChrpTiJ2mMlvPbn9iuKzaXltQeW8+PDM5/87TWslsMKYo7N3GJdZXf4P9Vc/+kgvgA
	 c1+FAUGCOTAEaq69w6d3zCuVnfgAH6j9RgzjOatRE7PmnF950Ht74r9IKSAILtBjmy
	 j3MQ4ysvelwFzs2GI1SxgmnYA2e4/bwZdgTa/+K8bgudybtPVXUgOFu2rBScJRP/KY
	 DyEeWChOsdr4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] NFSD: Minor cleanup in layoutcommit processing
Date: Mon, 20 Oct 2025 08:55:02 -0400
Message-ID: <20251020125503.1760951-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125503.1760951-1-sashal@kernel.org>
References: <2025101658-county-probation-13a9@gregkh>
 <20251020125503.1760951-1-sashal@kernel.org>
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
index f9354c3713ac1..d83637af1c4ea 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2277,18 +2277,12 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
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


