Return-Path: <stable+bounces-188079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 828E7BF15DF
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AD984EE5CE
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C730FC08;
	Mon, 20 Oct 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl0ZUIIW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408471624E9
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964967; cv=none; b=m3LArSbuZOMYSk/JE2G1zJC2L/iJzD2FILBdbTzR6GO2bw3OqFV2U1qwd+ok2Vzk8rFzTXGiVBBSs5j+S0a/chCdL/TEvbkY+6dwtOxwyDcFuYgUGkOXCb7ATNNCNuF1ikMqyW4xxaOVprHRNc49thYpe/LFv3H9WS4iH4k73zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964967; c=relaxed/simple;
	bh=P3Xtc37YHjEYiL7ewNWp5qpVFdjy3fHshXty4ZCGTHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4k5t3e682arUslQZvdF0drnjzbOf0/VaXJh7iKDeU0k6100a3104Ff8/npZ7uV7OGxb4DoCd+uatdwAbHh0cFapCflEMLp0VNckx1BxufeZWwFE9I24TjF8TBu0Ks6tyHCneIA/o6DUYH5bDArXErE8jR2Wgw8n43XoX4l3g3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl0ZUIIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442FFC113D0;
	Mon, 20 Oct 2025 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964966;
	bh=P3Xtc37YHjEYiL7ewNWp5qpVFdjy3fHshXty4ZCGTHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dl0ZUIIWQ5CDf+cGlykg9pEQTbL1DS9Fjsx4drXa3bAesdWS2xRKKj90hmoYJiSWq
	 jJ5Y8LmNmqf7DRfUN5RL9aaYhDuXruwUAysU5dSYw90fOOaOEIafZPU3vk8wnG2CHD
	 EGzxe9HMzt/KTU9pqCbo8ONMk1WpAyX8N0WHhc6RoS9NQD0naZ/oXge9dhXRPx0VER
	 ZFuPTssdhYBMtcioAqmiqEbANE+z813YeKnWz4L/Vd/Y9ugXv/eExAvHen/FNRLbda
	 9cOsaLG6LGyrTewJQKTAcuUu+OzXpoEOirndmbz/7aKn7rpXmFGKWUjBOHm+0upT6Q
	 JMILiFRy6/gGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] NFSD: Minor cleanup in layoutcommit processing
Date: Mon, 20 Oct 2025 08:56:01 -0400
Message-ID: <20251020125602.1761375-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125602.1761375-1-sashal@kernel.org>
References: <2025101659-tightly-grandma-7323@gregkh>
 <20251020125602.1761375-1-sashal@kernel.org>
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
index a976f67194e8a..35b9888aee51a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2278,18 +2278,12 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
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


