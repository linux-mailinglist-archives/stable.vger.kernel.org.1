Return-Path: <stable+bounces-124370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F61A60294
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7090619C5806
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681941F3FED;
	Thu, 13 Mar 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSNEQdiI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539B1F3FEE
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897578; cv=none; b=Evipslv9+pWAdyn+Vr1V00z7QkHKJiGRbRa5ZfZrwvMD9Twb6zt8Ntoz82GwQPNBkYKiOTrGBh842cinznT7qIICbw3gn6g5xSQO/a/tdGxe6ELSdGuYaIgswe14N+Hi9tfUlyynaxeD+IU9OZ7rBNtl96gswkpC+XBSCY9UtkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897578; c=relaxed/simple;
	bh=TwUeTIRHKScjU6mQok03tILvIrfVy/neM/PD/4IG3i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJvaCH/nfmFjOT7DRgnEXch+lyMVsZ9BQQis/RWQ+L1c3QVG7izsXAGmYNddWbYbo8RRu/SciUeJUWzd1ds1UEWde5Iyll/tt5MWqetnCKcQhUhtHWu76X/FCIjch0zMPzlO+k0+h5epaNUzav6EgfnGSuiJo8Ad8pPUYfpFGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSNEQdiI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224341bbc1dso29982585ad.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897576; x=1742502376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNsuG8Kz4PlZy+yaxsiLa9dGxfRU4N28aINgwyt+fCk=;
        b=FSNEQdiIeYcIDWn+PU+L7lqFgoYYnecaoZeGEZYZ2fnyb5Qw9ZzNMjgRyIkEhs6nPY
         SxW+gRCW5sQn6p6kZR1iN1jkN/QzZWSndYNW32DgIHtfFeJXG1z1Gy5wtySR7ahqcz9z
         jGslihtO+amg9TK+lqqDts3VeoFLCrYpYumoZLZnaTMeEAPkzxF1X+WLBFs2r/VvpPN0
         jFZc+R/paAlRCWRFVS10Tsg5Ej7RAboktW8S8CDmYxGIB8gftrXeor2t0QnXSEejSsdn
         6o87dYKWgOkBoV8h2JTIGnP3KYcgUS73a6oI3A4JdtyY/Rk6MlmTvSOuCFwfu23FWPeL
         kTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897576; x=1742502376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNsuG8Kz4PlZy+yaxsiLa9dGxfRU4N28aINgwyt+fCk=;
        b=dLXCBHZkT6rz3r3Fm93XNAI2XD0BuV4uHBQdYuSPvjHY91mLB0cIlkO9d/FFNYI9bZ
         Ag5HXYbv+wiCQOn0rkw1pVJsCM1Rg4M718yJ3bf6fW+0MIk/OldViidLnJYsyHF9oA6c
         +qctSqJ4h2lyFFkSSSf4GEB9NODnihAuDQVenq//ypkQjY/BbFK5wDrIf3CouOfj5xvR
         3DzQ+O4GHYPBhGhBdFIuogDHKRI8H5ZjcVpT/n1eD9ZhZG1gCZrJhUCqMLCsGYTePwzg
         H7bVYGw3E05QniDiD2Xcuy7aL4e5Dy7eig1K8ugpZ0toFXLDqAc7ylRoODGY/KfXEANI
         G8SQ==
X-Gm-Message-State: AOJu0YzxOYWSnUQWdVz9FTqeXzYOnKdCpYPVksXIV72H8LjV9FhZL6j0
	5Wd9p6pJ5gDDTjSqxHigs7pbyuCbNATuzshia9xLd7gTW2WkisHxjMk0rUH0
X-Gm-Gg: ASbGncsxtz+sHlOJ0Sf1QxrXi9uVPZwi6TceHXG/zMYMS0mxOc4+KZF+jQSYZ5nwi/P
	NV+D6rtvOp3TSxGXS8E4/FXUTShWU9e3Y7u+Y8HIeuKPcgv9XdP5lbQ4gJuCMTMldZvNItAb7bV
	8Hf0riQqCpAw6GarikvzOhV+ixXSRu8fqM/HIDz5HQgVRvjvRB8epWxsnKIFqbqGRwfTfKxLjqz
	EzLXgjKfRgv9yH9r7p5tdl54aGbUKORhNFfxHJ6iO4vLFMAMnVSunWS/+afMF3h42DHWKJfKKn0
	tJX27WKJEbr0ej05mZSwfM1UmlqkjBV8JU0DkaRhdkIw5V9nZ9zjecx9LyyzN01+q1uRTGQ7kzZ
	Lge5txg==
X-Google-Smtp-Source: AGHT+IHfZ/44dfav0INPJnYsuEjDI12napzUBvVv36qbDKMP58ZG+SHweqvsaTfY5cgsm4VbNBzZxQ==
X-Received: by 2002:a05:6a21:a43:b0:1f5:8c05:e8f8 with SMTP id adf61e73a8af0-1f5c1219153mr64419637.25.1741897575917;
        Thu, 13 Mar 2025 13:26:15 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:15 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 13/29] xfs: don't leak recovered attri intent items
Date: Thu, 13 Mar 2025 13:25:33 -0700
Message-ID: <20250313202550.2257219-14-leah.rumancik@gmail.com>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 07bcbdf020c9fd3c14bec51c50225a2a02707b94 ]

If recovery finds an xattr log intent item calling for the removal of an
attribute and the file doesn't even have an attr fork, we know that the
removal is trivially complete.  However, we can't just exit the recovery
function without doing something about the recovered log intent item --
it's still on the AIL, and not logging an attrd item means it stays
there forever.

This has likely not been seen in practice because few people use LARP
and the runtime code won't log the attri for a no-attrfork removexattr
operation.  But let's fix this anyway.

Also we shouldn't really be testing the attr fork presence until we've
taken the ILOCK, though this doesn't matter much in recovery, which is
single threaded.

Fixes: fdaf1bb3cafc ("xfs: ATTR_REPLACE algorithm with LARP enabled needs rework")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_attr_item.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 36fe2abb16e6..11e88a76a33c 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -327,10 +327,17 @@ xfs_xattri_finish_update(
 	if (XFS_TEST_ERROR(false, args->dp->i_mount, XFS_ERRTAG_LARP)) {
 		error = -EIO;
 		goto out;
 	}
 
+	/* If an attr removal is trivially complete, we're done. */
+	if (attr->xattri_op_flags == XFS_ATTRI_OP_FLAGS_REMOVE &&
+	    !xfs_inode_hasattr(args->dp)) {
+		error = 0;
+		goto out;
+	}
+
 	error = xfs_attr_set_iter(attr);
 	if (!error && attr->xattri_dela_state != XFS_DAS_DONE)
 		error = -EAGAIN;
 out:
 	/*
@@ -606,12 +613,10 @@ xfs_attri_item_recover(
 			attr->xattri_dela_state = xfs_attr_init_replace_state(args);
 		else
 			attr->xattri_dela_state = xfs_attr_init_add_state(args);
 		break;
 	case XFS_ATTRI_OP_FLAGS_REMOVE:
-		if (!xfs_inode_hasattr(args->dp))
-			goto out;
 		attr->xattri_dela_state = xfs_attr_init_remove_state(args);
 		break;
 	default:
 		ASSERT(0);
 		error = -EFSCORRUPTED;
-- 
2.49.0.rc1.451.g8f38331e32-goog


