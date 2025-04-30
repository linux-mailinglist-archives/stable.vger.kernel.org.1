Return-Path: <stable+bounces-139230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F975AA5779
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ECCC7BFA7F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2B02690C4;
	Wed, 30 Apr 2025 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGczr7O+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E12D0ADA
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048437; cv=none; b=ghQarQbWVuhh8Mn/IZRWO/7+GPHdG6RF9csf+0ekHPs2B5BUQPJrpCLTfPKKq8Re2cPWZC+ahggE2a5Gq0ghzuRpq4W2D1H2raaS5mvQtPnIRIsrQKEFYPNVBFX98EZLTThWCgcbCcrLZAD2dlLBRioXtOJvQfCaGLknuY/v8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048437; c=relaxed/simple;
	bh=8Acc0ccywnDHukwunGRWa7Q8OkhUYefKHbVfNpaFyvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBPSKtTDpva4dmJjB9Jh+Yq1KsvUW1d1tdMYvJsUMTZyhEPAxotqN8iG07yBFrYcx3Yz7KEakpX+VAvvyk0NXYgywcojD5sY12oDhjMoQUnW0kJitsMgUoukggPQAL6jT0iHtFmGKL93N2FPINbOu0ynrtmtCes6wvkm1DZdir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGczr7O+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso410005b3a.2
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048434; x=1746653234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQkc9TT1f/5VSOH2XjwK7L4YV87S4TOAZDr1VroeguQ=;
        b=RGczr7O+bAHt6KJPWBwYuc077CxZSyCp6qYYzUQLOVDzuXVs4VJJWt8m7TX4CKmdIP
         ymQle8KGbzSpZEGfczt4g/RDGqYxz5Vv58ArqZSdcAmPct/WBUh2WK/fu8zL/bR6B5dh
         x6F0/TVMK6rShVnhoQ0ftfxqfxbljkqPWXkXjkGcRDg3LhNXSdjlfNTWrIul2ICF5bQK
         5YhAnb5tpXjh85JRYllIN4n034LGiKRR3IdLvfOLRn4LHalZuZ9t/FeHuQiDE2vHUX7B
         +cQ3wXoT2sB3Txzhp5oaEHnywa78UKyRm8K3MWpb/jhUKwDfEtPeHyxM/xnYq5GVe50e
         GGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048434; x=1746653234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQkc9TT1f/5VSOH2XjwK7L4YV87S4TOAZDr1VroeguQ=;
        b=Onjn7AUyik3TUqeyPw41rf42Sw0UffogyZSM7uGtmRf/NM/LemLBERvT75euQcu+im
         v5MOaFUSatBv1D3BLkOKHkmEThA7VS44x5rTOVawXYEOAmKlEmq6XLyAs7MhrXrMXjlW
         bJu7ENOzgGDNGl9SXkG+H+comNxKP1Kyu/Ultv39RtvtguEsOWbltOLyyHGVir/42lpm
         qBSZFAcEeXQniyfRXJ37a8MKlEITofL2E9nEqlBIoI4aL8CEAnAEpkUYcm2J9X149Lrz
         wnXtzIFBqbqpkOVlzoFODmlpLLxMDN0D0XR2Iqr6TQ6Sv5O15mzGWC6JgUXFU08+pZCX
         wmSg==
X-Gm-Message-State: AOJu0YxDmcZtFWjutDWNxM7wNm20LY7xABo45+nTsoUAAKBh3lgPAP8H
	TiJJoFhng5CbOfAVbnhF3N+NZiZa09qkJJTU3c10fDG+RWt2GZjdzGFkug==
X-Gm-Gg: ASbGncvQ5EqkR/Zw/bdSj7dMeNTm6OlF+hKh8SclwUXmulyiG2Dx8yjJuy2u+6Pw3wP
	rnk/lyvEwEsD9QGkZfC3W3Mev0GV3EaLHlh1NSBCKBUs+7LXK/AZEVfbl/+wqlHpro6djgSfOCI
	xKA0OI5Cp3TnX5tkt7Nul8t5/UjjF/89vPIGy3xNEUpV7OS1xs/iIFjI4gd8HA4C9YwTAKy5XqS
	P7vuECh5FDRn3R5UvRMEMj2qUT1wJls6l4judvBW/PuyjNZUEmLWAgVDk7xEZjSbu5rFyPuBbAN
	2p19dGni6LC+on4qCxEB8zdA7w3XSsGOoBbyZOxpIq1gu6jY8BglZwh8VBTz8/TNvc1U
X-Google-Smtp-Source: AGHT+IHXwCkLm9zUA40sIVHE13uzZC3iwvVOdI5NC6vS2pXGdZdDy7oh9HwMmWK3f5qerhLg1l70dg==
X-Received: by 2002:a05:6a00:3911:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-7403a75b720mr6249194b3a.4.1746048433847;
        Wed, 30 Apr 2025 14:27:13 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:13 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 03/16] xfs: remove a racy if_bytes check in xfs_reflink_end_cow_extent
Date: Wed, 30 Apr 2025 14:26:50 -0700
Message-ID: <20250430212704.2905795-4-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430212704.2905795-1-leah.rumancik@gmail.com>
References: <20250430212704.2905795-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 86de848403abda05bf9c16dcdb6bef65a8d88c41 ]

Accessing if_bytes without the ilock is racy.  Remove the initial
if_bytes == 0 check in xfs_reflink_end_cow_extent and let
ext_iext_lookup_extent fail for this case after we've taken the ilock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_reflink.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 0405226fb74c..d539487eaf1a 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -716,16 +716,10 @@ xfs_reflink_end_cow_extent(
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
 	unsigned int		resblks;
 	int			nmaps;
 	int			error;
 
-	/* No COW extents?  That's easy! */
-	if (ifp->if_bytes == 0) {
-		*offset_fsb = end_fsb;
-		return 0;
-	}
-
 	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
 			XFS_TRANS_RESERVE, &tp);
 	if (error)
 		return error;
-- 
2.49.0.906.g1f30a19c02-goog


