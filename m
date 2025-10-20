Return-Path: <stable+bounces-188068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F53BF1597
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BF818A5C87
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E03128BA;
	Mon, 20 Oct 2025 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSL40Tvj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499331280D
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964791; cv=none; b=eC9b+Hvz9cYtvne26n7yW6w7gH5M8r2jOYg9Y38N0jCNVEX5NjdN91VF6o96KZ0fm7aj4k0+9czNN2vYhVi+yIQE5V4MRKLUweKI40gy3OMq1TlweHzLkS1pvgiqafMOE2soZY92sUp2OUvMFZIF6D+iSmunDnjcAs9NKEvNvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964791; c=relaxed/simple;
	bh=CNzr+Kq+Wu8aMiB+ISGTBdP8pdEPe2LXbYnQf8FkUyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmElkUjQVWGF70Sy+VBPDjTVGGmt0mibdgghNxYnAXIA9tM0dNpfxmpj2WhaXNVQQ7ZUOuIyA+go5UT9DC4Iu3yak+20GX9RRfeu8X4bo1vHAGadyD/sbQFKHhhMFIqojgFJCnaTsFh8SOBbnr+36O6YwuDy0FwJ5IIzyyRCwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSL40Tvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF9DC116B1;
	Mon, 20 Oct 2025 12:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964791;
	bh=CNzr+Kq+Wu8aMiB+ISGTBdP8pdEPe2LXbYnQf8FkUyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSL40TvjY3angDgu52wOFQS46sejkdTJ6wMSMcI6M03ecgTvTOrI0Q+Ug9mLYh8Dw
	 8jJQqX6AllDQghQxRN8Vqs8szQnh0OwIiHxM1nN+JeRYsCJ5U1veDO1U+pEBlcNGiE
	 Y7by9S573X6eS2FUdYHzZ+UWAt4WZz5CppXyR4qK3urZ9A4WxhP6anBaevFFeC37jY
	 iPoq9XDTwDrgAt5AdecMj6r1N0yVzh1W3NbcqAtQYDsva4UL//sT06usoZgvY9tvbt
	 IIvIkUP/VTDqFLqjdjjXDNkzRFnYa0Uni62JzMzAIHCIlehvkrEpa08gD4jBdPirzg
	 POQfWpb6Vf60g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/7] NFSD: Minor cleanup in layoutcommit processing
Date: Mon, 20 Oct 2025 08:53:02 -0400
Message-ID: <20251020125305.1760219-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125305.1760219-1-sashal@kernel.org>
References: <2025101657-preseason-garnish-c1e0@gregkh>
 <20251020125305.1760219-1-sashal@kernel.org>
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
index 8f2dc7eb4fc45..c01183ddc93f2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2379,18 +2379,12 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
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


