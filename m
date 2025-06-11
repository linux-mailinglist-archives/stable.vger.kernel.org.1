Return-Path: <stable+bounces-152473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44886AD609A
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274703AAFFE
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FFE2BDC25;
	Wed, 11 Jun 2025 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUzhBiC2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3219A
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675715; cv=none; b=qCkvMZw/zWEj9+3QKpA8livvkAESlQMz19EA6PrhJvz/rQbqQN8ypS2Kuc+gfvtWupCGgJfvNH89exrD55KtXObCCTjuZ52/fyG0b5vpxfx3/ntgDVGMQdzh2JTdthBoQFVrWnVi1lBk4CW6tGMPx8581+UgavDPM9GmcL19YWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675715; c=relaxed/simple;
	bh=dsz9Sq44ZroBqquHq9O2e2IsLVaxUPk1ogs6Q1QLUjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AULH9kkPW6LGnB9GllX12Zq5JBa8Pht0t240iw5E8ltz9C3lIdKZf6MF4Mg4Ibj3DMttMnXksACJy8iT8c4jfRWWF9Jf5N6G8d65VqhVa+U+3XSCM0zNv3nwIxYib3ES4A+InVKliu03FWEdRmTZ7HVcYeYP9VRppp6CVhtBkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUzhBiC2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234fcadde3eso3587715ad.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675713; x=1750280513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/yIp4Qx/k+sMmlbJ6t33SMeO5wpOqaP8BgaUBK+/0Q=;
        b=XUzhBiC293HwB7OQ7oOSr1Igr4YFo6LOcDP1o8ETX/4zKl2Nu4V0G0XhYPth4yP7Uq
         tkLlNsjsAUNxIUQ3Y+cSroYGEXmyEFOW/K6biRZYwWJsRnL+8XVGK2vk7fwSsFeyVRsU
         uOvX2nKf/ylKImRDmCTDsGkvHAMln61ibyu072uj4xju+CvgOCg/rPMqfikQ3GOz0byZ
         FuFluqlkzDH4WB7CIF+lTYKWyZ7xb5+SaVbIvZ0VvdJmiEPQ8OTASs6A9ApCrX56uZN4
         ewPCx4P4S0ncYhXB1q7O2pQKPyVpIu0NuGVCYm2mVubMD20+zZa84Hp4rVnpuZh9EEpZ
         iy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675713; x=1750280513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/yIp4Qx/k+sMmlbJ6t33SMeO5wpOqaP8BgaUBK+/0Q=;
        b=fzHdBHj3oSXO6pQGzoYWQeIjumDTTIibL7XiaN0PLyE4oOpLM5fczamgjhz014Xfm0
         vK4wdNa1OgHpDt9x0+ZepdLLl2aCqJxmw1eMAGnQNqxeGgZH5MOtoJs73DXmwG2pYH9v
         jwUw3XRsp+iVHJTLens4IjxmyO1pu0dTPJE4TBYreDNPPugYypHW5DWWCIxp5dl8hSs2
         vunfy7Jb9eTirBTWfFc3UPMcWKy8LYnIRb1c22Q6fJHB5AtGWtZpDOdRtmE80icFgK8H
         u54OJ6jpHftM7+J1+tzlZDDiFsc1oTd/4mBnZUvPNHQls2uvgzVxcnT+0wxrRP+sECeT
         CtjQ==
X-Gm-Message-State: AOJu0YzzXv1IFVa6c7wv4rHKyIAJfEupvuJq+5jrt92VE4kZHxgxoy1L
	r7KY15pUsqfZAsnaP/JGs3Y32+mb+oqbHwAQ0LDrit2kQW/ZsRbeBlQRudmse6w7
X-Gm-Gg: ASbGncsCGAWV9kXjAxytoI9G0PXVIWY8Ga+27STo2sHtFfdZIuLXKttv0QsNmLyu9fv
	9VZY1QDdxByk/JR4//ZQCd0Gnswq9Z6WN2KTA+5RRTU9UPrVZFQpUClpGeESrohTY4IEHaegrqe
	/WfWS3KpN9Y6Yuh+02ZoArJ30M068P7RJnzY0xNT7iqco2yFvduEP56NeUG/AVZNWp6yWLosPhx
	EKoU3qh/zFX2IE3LVjgezZQ3WrV2cNTmwuMbOhPv7umA0sD33I8VLJi2Mw0xCdpyA/uW1zEZ8KN
	fLoQJVB1hSm43CBGve4SZGhYpNfDyHeXByJ/BPulJ5paxJI290Fx9taLSRhwSESeqdTuBID4mjm
	1X5Dlt8woxvXTkXB88hA79w==
X-Google-Smtp-Source: AGHT+IF2bVIywweE2h12IVEi7Gs/TIBD0E8UEcG4T4I/rlU0oIzDKm9+n2ER5ru4Rdh2ljP0/62Ftg==
X-Received: by 2002:a17:902:d58f:b0:234:8f5d:e3bd with SMTP id d9443c01a7336-2364d8cc7aamr7914505ad.39.1749675713021;
        Wed, 11 Jun 2025 14:01:53 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:52 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 19/23] xfs: conditionally allow FS_XFLAG_REALTIME changes if S_DAX is set
Date: Wed, 11 Jun 2025 14:01:23 -0700
Message-ID: <20250611210128.67687-20-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 8d16762047c627073955b7ed171a36addaf7b1ff ]

If a file has the S_DAX flag (aka fsdax access mode) set, we cannot
allow users to change the realtime flag unless the datadev and rtdev
both support fsdax access modes.  Even if there are no extents allocated
to the file, the setattr thread could be racing with another thread
that has already started down the write code paths.

Fixes: ba23cba9b3bdc ("fs: allow per-device dax status checking for filesystems")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 1afb1b1b831e..ef3dc0778566 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1126,10 +1126,21 @@ xfs_ioctl_setattr_xflags(
 
 	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
 		/* Can't change realtime flag if any extents are allocated. */
 		if (ip->i_df.if_nextents || ip->i_delayed_blks)
 			return -EINVAL;
+
+		/*
+		 * If S_DAX is enabled on this file, we can only switch the
+		 * device if both support fsdax.  We can't update S_DAX because
+		 * there might be other threads walking down the access paths.
+		 */
+		if (IS_DAX(VFS_I(ip)) &&
+		    (mp->m_ddev_targp->bt_daxdev == NULL ||
+		     (mp->m_rtdev_targp &&
+		      mp->m_rtdev_targp->bt_daxdev == NULL)))
+			return -EINVAL;
 	}
 
 	if (rtflag) {
 		/* If realtime flag is set then must have realtime device */
 		if (mp->m_sb.sb_rblocks == 0 || mp->m_sb.sb_rextsize == 0 ||
-- 
2.50.0.rc1.591.g9c95f17f64-goog


