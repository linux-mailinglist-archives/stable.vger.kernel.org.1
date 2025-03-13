Return-Path: <stable+bounces-124369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5457EA60293
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C0719C5906
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869A91F4614;
	Thu, 13 Mar 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFPbbaLe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ACD1F4618
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897577; cv=none; b=nWmE1+gHtiMUxGwC8rnwrm35yCP6PUFXXjfTCoKaKc2OSq8/FxP2ZMU5T6PaFOUwtD9Hf9svRPgSgTFEnZ1A35RFVGLZ2NmCQOx0Dq7FoRakjQHPNr1dRtXbvocwS0sxv4yP7nUFm7efSu1ph7wM3lRw2aOJkcw33Rft2mKPuvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897577; c=relaxed/simple;
	bh=BbWkOzPeKDIJBgec6dWg7cJIMR26gcECoHi4o6/NVns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPmBt390mjBmobZUxE0Jd6yxKVMbi9yaKsR3/CBQyIgdmKA6FihFk1zU62dnwcje19ksMZSCBvqY5HI+qGhjWwDXN/DhZF7j+UwJaACv5yGyoSwNEEyIw4OENO68Dew4jBawcFMH7wCuqVlzQmBQZyt2AQZf3if3BSesXqVedDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFPbbaLe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225a28a511eso26701435ad.1
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897575; x=1742502375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/3x2+jQC++c1ZD7wWYSfUrh/SLnUlNVKpaWCNjcVIc=;
        b=ZFPbbaLeBcKZd9M9Enw9bDGTP9rB5pyIr2Bf+T2M6cZFodOGRB3SU0YuJ1wrX8CjYj
         G9gPul3I2aXQkS4DIsc6hqvyYSvMKs+Zru9Qwz24Ed4xB8dGesMmi/JesId9YaiDeUB8
         b+RXs5VWz+KOZ5i/uq6Mc3ffQnUjo5lWUTi2rTvljpuTr/KTFkgDMpU6zI2/n14cuKbe
         yeolUWuZJzI7PBGHUmqMGmqoETtnHeQm7J1yCEjMvz9ypCn+WvTkzYzfyFDDNIGKNoGP
         P3dfS8uuVZYRT1X/RXzn6eWVHFlL88I/CPMl/usQtWXEj2/dvjTolIwvw022iVXMyD6E
         C4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897575; x=1742502375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/3x2+jQC++c1ZD7wWYSfUrh/SLnUlNVKpaWCNjcVIc=;
        b=LRXBj2jCRpSLd5Po0KTsH1LIqzXI9JfFODxPhsm7/ENrJl1z8H0fWg6Su+oVSC/WEe
         QjwonP7tqgrzyn29E15ZDznilUqDnUBJ21kTINNHF6agcgP2iHrJiggMIozg4BUmfB+Q
         xlu/iw0q4E2p1V3dIiwdOOocXgRmesbMpkmIJKcN6OatGRI/yCwh8/YPXHFZl7LW4X4L
         vESY6EVu4rexVVw1N8QRFE7+5BnrNXqrSqtxrQRtmmCUXrm9p8DcOX9hVm8X44ycwe4C
         d5Hf9hnPeqiFNapQaSamC/YP2Fx1I9eoT4CVnNF8prHcB7VzFRR3KHUXuGGxkBV9vfLu
         3sWQ==
X-Gm-Message-State: AOJu0Yx4JuUugkGjwqiuZrh8rqhmCwk7taQJgVPVnpc/Z3oyuesepAo0
	laMOfuq0Rs1Y+z7V/1EDvgbsNamv9mfA6B0++BRWfSiGWa4rFeoZBvZWO+Ak
X-Gm-Gg: ASbGncuaFWyS7L9X0+34J/S3SEILS4rTK43TS1CNkmIaTtqjWjTBPN821ePSPiF5MIA
	8ELMdffloPUcW6acTicJ/ee64DjGN/Y/yOGVU+saCrTLUE++C/ZJZ9SMHNrM1+7peqQVVbxmjlt
	joMURynT2qNRSpaw3yfFnCP7mp+KaPn+ftpEgmUGz8rTr2Jj1T0J2QN/bdx0OaNB9LwFi/olZE2
	+9grI7Tdo87clabAJtBZjUAlytdM6Ogk61EMsDwoPHbNPg/HUK/1WzHCQrMoyz76bAr9bwzmHKB
	aokSIsuqVbgiVSPJE4PmFwAENjZ86xvX2XDe2Tm2zg3ViTvSbgHBQoUzd7ntq7XkDK6fCsU=
X-Google-Smtp-Source: AGHT+IEYYY4iNRZgxPNNGWniagJsj39Rq47RR0dHiVjSVLbm+EVE8a0YeWJypkihuDU1pxlgcdP7fg==
X-Received: by 2002:a05:6a20:9c8e:b0:1f5:79c4:5da0 with SMTP id adf61e73a8af0-1f5c12d76c2mr87880637.31.1741897575004;
        Thu, 13 Mar 2025 13:26:15 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:14 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 12/29] xfs: consider minlen sized extents in xfs_rtallocate_extent_block
Date: Thu, 13 Mar 2025 13:25:32 -0700
Message-ID: <20250313202550.2257219-13-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To: <20250313202550.2257219-1-leah.rumancik@gmail.com>
References: <20250313202550.2257219-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 944df75958807d56f2db9fdc769eb15dd9f0366a ]

minlen is the lower bound on the extent length that the caller can
accept, and maxlen is at this point the maximal available length.
This means a minlen extent is perfectly fine to use, so do it.  This
matches the equivalent logic in xfs_rtallocate_extent_exact that also
accepts a minlen sized extent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_rtalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 7ce122da43fe..2f2280f4e7fa 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -316,11 +316,11 @@ xfs_rtallocate_extent_block(
 			break;
 	}
 	/*
 	 * Searched the whole thing & didn't find a maxlen free extent.
 	 */
-	if (minlen < maxlen && besti != -1) {
+	if (minlen <= maxlen && besti != -1) {
 		xfs_extlen_t	p;	/* amount to trim length by */
 
 		/*
 		 * If size should be a multiple of prod, make that so.
 		 */
-- 
2.49.0.rc1.451.g8f38331e32-goog


