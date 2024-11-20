Return-Path: <stable+bounces-94344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351629D3C55
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61ACB257F3
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA621BD516;
	Wed, 20 Nov 2024 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G5cItoZx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2E1BD513;
	Wed, 20 Nov 2024 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107683; cv=none; b=nbyEgTkTWlESsRwLaTalRf6NOIqg8dlr9uotjcrqa9cc1FukGHNtyKYeXsC+nCzb8tXyiQ8Kn2HtZRV07Ij46ZJ2UFLPxfPnFoxLc4rqVZEj26RHdFMDj6Ce+C7Ir3N2AeIxfCjjWQxxEz/6vr4+uKY1H+dptzxcmiROhQ8hMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107683; c=relaxed/simple;
	bh=zDPPWbU6ys60K2pz2T0QCbMo7fJbT4C4rGopTloGckg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C79LkQrCutHdjBP4rlRFzCbJ5HJ751vsbXk8Cvzz+X8EYlg6ghr98l91CSbyzovICxoTnYRl8CnFVK44Y0kNx/GMpT7Vuh7H4PvbSaVI84oF7cbzEvdM/Xa/p35ozN1lrjscJ/5QrWLer9ZJ/NuvepvB/jdrGPmyDYS87ARRK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G5cItoZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EA1C4CECD;
	Wed, 20 Nov 2024 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107683;
	bh=zDPPWbU6ys60K2pz2T0QCbMo7fJbT4C4rGopTloGckg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5cItoZxfDM2rqutQv7e+v7SyI/EQ2uadPOXZ8VGFuWwaD67SkGnRUHBsEDc4N3zT
	 5+KfhSjFn0xTUByMAQH1OWxaME/8z11QwBtz443QgQ8+NW/+imXhB74E8hK9LhwebL
	 MmvWS0pjdyq50xZdxgRfJ5Kq6ZnNSfxgn4NIIKQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dai Ngo <dai.ngo@oracle.com>,
	Chen Hanxiao <chenhx.fnst@fujitsu.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 41/73] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Wed, 20 Nov 2024 13:58:27 +0100
Message-ID: <20241120125810.596732074@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
References: <20241120125809.623237564@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 15d1975b7279693d6f09398e0e2e31aca2310275 ]

Prepare for adding server copy trace points.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Tested-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Stable-dep-of: 9ed666eba4e0 ("NFSD: Async COPY result needs to return a write verifier")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1768,6 +1768,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struc
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
 
+	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
 		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
 			status = nfserr_notsupp;
@@ -1782,7 +1783,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struc
 			return status;
 	}
 
-	copy->cp_clp = cstate->clp;
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {



