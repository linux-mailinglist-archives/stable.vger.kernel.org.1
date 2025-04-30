Return-Path: <stable+bounces-139234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB31AA574D
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2CA1B63C27
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA902D1102;
	Wed, 30 Apr 2025 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZUd+9O6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68792D1103
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048440; cv=none; b=lTQNDuMpu3F7qEQ8b4VDL6PZ6qP/m2MvUPQlzVG2JVEEM8DCVMwJbLvJ+TDhrA6DKLFYElcMhYUVqvwoQIe6nGHMvQLBQvU3GuM/BHaQwMkams8frjqg2rM1RYwb6HYvSBi6e9NAmIvsvdzFq9H8pMWzQJfniAtQ3iPgb2VrcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048440; c=relaxed/simple;
	bh=enFh72uiMyk/+U3VW9bhmIZLAc2u4Zlk58bRqnqp+gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jL2VzRl1FD6X/aHZAYp+xmIle9lb9wQ0Qj33Q5Q0Rf29I7OPXwScoJWBMtQ/TbuQYzlngp+Doc4EFEW0IyFf79vGRLK+j3sal+7dRJx3NA+PVcoiGKGzpmA4otZIos5FTo9xpAMZcm+vxvp8nO96krJ30ik8jrwqPo2BW892wxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZUd+9O6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af548cb1f83so317615a12.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048438; x=1746653238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBGSXe+RF1LtvNBYTWzvawytijlOxhrB02aRSrXHEsM=;
        b=hZUd+9O6AHp+4cxMWl+4e41c3BR4bhIJEf3e47GzpL37qoIdFzKYHntq7FwduMSSCn
         Jv6ym3dAvzktwqkXXFltfDhwu8FpEjjUBByAqtVeDF0mt98sYwAzEmF4NbSm78pYZz9V
         3kiA443AFEoij3J3c0TWdlfi+sYen585ytF3DBsVTRnMLjxqrzxKJDxiA0QRF956RpUx
         M2qkKNi6ZLdXSyihVtopnq9kmKTukYrpZTDDv64pgzlH9VpeeodrUeJlXZ8ZycMSYM8y
         9EWk2dsNCidEXxOW0lWLor38vG7MynANQ47p0qUHHTB7JUdls03OXzt2jWUbZVbm8vw/
         qokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048438; x=1746653238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBGSXe+RF1LtvNBYTWzvawytijlOxhrB02aRSrXHEsM=;
        b=iT3W+eM2iUMJNzyAxaoJcw17rLz4aO6UXDWCiYiMypLuw7WOQDh+mhV/4IfNZgFAls
         mQY33kOQDFcv/J9GTREz3ePqb33aSxC6eVA6VJUaf/dFt2iCvUfZfJ6+QR9jS3+hTSs0
         uD6XqHa/a+eGk8FUTxwlcFHoppWhdjTlFXZDoGd7LvLjxWaYkSnlhrdw/GgdXXKJAAS0
         Attv1YZE1/s90T52DNDVyjaQuWsyeU4skHahvxEYgb7AQj5Z8ULVnwkaqjoWsJn5lstC
         iyUGMl6Cx+XgszbQg0mN3sqOZLfCGqHI+M4HS2G/RDBqV43n8UpQERrLO4uP4exvptBh
         h1hw==
X-Gm-Message-State: AOJu0YxNdZz7BmQ5+DWxcmMJNZ3o8Hrzz9jPO7bgnrW74STmBGmKDeO9
	mfkhCoExc1i/voPwgYbXD4FjcZ/5Yxk6jDhr0ASmXcId3qB7ncLRrbnfJQ==
X-Gm-Gg: ASbGncvZbPQvIjUYFTTvdFF0KsN+pBXdwUUJ0q+I6rKMiZiMgZMHr9PsYS6gEbADgQO
	n9390dQPPv80DWKylTlZTHrHPBH9midOcys+rO1yRZsDqB/mjDj8QHwbIZzXX48bhpi+CoaRpN/
	zA6/Qf/jGwQJ71Qucw21Pk8DkVdwhAD/5M0R4aXfIbTkjMLhK/Bdlq7PFhG/tnW22Y0ERlV7ODA
	UyVaroKL4wWVjnn2X+y5OUEKHbsiN/DtmuEwveOMZEGkujBbgsdDPfl5hfl6UJeI0+c64b/9tBW
	7DFYOM/5JktkrwPDWv2KITZIgBRgwxg3DWLv7t8R45GL7+Qw+X/4oF/0DbcdankBkth6
X-Google-Smtp-Source: AGHT+IHP3x6xPbipSSIU20brrAdWDyHMYLjvtpHu+xsQ6xfUwzgErGtkzvTHEJhUjnHAKQ1Uz7bY+g==
X-Received: by 2002:a05:6a20:d526:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-20aa26d41b1mr6192866637.7.1746048438104;
        Wed, 30 Apr 2025 14:27:18 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:17 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 07/16] xfs: revert commit 44af6c7e59b12
Date: Wed, 30 Apr 2025 14:26:54 -0700
Message-ID: <20250430212704.2905795-8-leah.rumancik@gmail.com>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 2a009397eb5ae178670cbd7101e9635cf6412b35 ]

In my haste to fix what I thought was a performance problem in the attr
scrub code, I neglected to notice that the xfs_attr_get_ilocked also had
the effect of checking that attributes can actually be looked up through
the attr dabtree.  Fix this.

Fixes: 44af6c7e59b12 ("xfs: don't load local xattr values during scrub")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/scrub/attr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index b6f0c9f3f124..f51771e5c3fe 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -157,10 +157,15 @@ xchk_xattr_listent(
 	args.hashval = xfs_da_hashname(args.name, args.namelen);
 	args.trans = context->tp;
 	args.value = xchk_xattr_valuebuf(sx->sc);
 	args.valuelen = valuelen;
 
+	/*
+	 * Get the attr value to ensure that lookup can find this attribute
+	 * through the dabtree indexing and that remote value retrieval also
+	 * works correctly.
+	 */
 	error = xfs_attr_get_ilocked(&args);
 	/* ENODATA means the hash lookup failed and the attr is bad */
 	if (error == -ENODATA)
 		error = -EFSCORRUPTED;
 	if (!xchk_fblock_process_error(sx->sc, XFS_ATTR_FORK, args.blkno,
-- 
2.49.0.906.g1f30a19c02-goog


