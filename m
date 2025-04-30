Return-Path: <stable+bounces-139233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8DAAA575F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1E416E7A4
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC552D2698;
	Wed, 30 Apr 2025 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihF0B/iv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028472D1102
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048439; cv=none; b=r5hmj54AIbrIDj8VrnJIpgcVkzIZhPPffBs44lZjBpXjWLcmQAgzp9STGh/ifV/AINmJgOrEaPCzpmXYHT8Sofdbc6pTykawn1hYUp5inSHbvJm+mh00IOPT6vjjh6neuH5s4ytiijTiuUX+e3R2KUZyWZJdUmBfA1AdB1t34K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048439; c=relaxed/simple;
	bh=p10Q0+9QAZZioZA502xb4z4OhUg8AnTdk4rcc5gX710=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjKKYOJl6FvhdYGoiz1F/FsyOqoweqzcF105Y/XXK/wOa3h6gJTntsi5f7h6CmjmLx82BD0AW+SV0GEBKZCjKUScf3KKU6jQr5h2VdMCPu7uNJ5CmE14xv+2lmLY/Ju4d5nN3m4+J0DL2gDq10k9ublt6rulaYagdrcQTeZTWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihF0B/iv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736e52948ebso465547b3a.1
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048437; x=1746653237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVPyHIH7ZRjOIO8JHArk3NWp5tc+4Nu3ZkczSBo6XLs=;
        b=ihF0B/ivlFj3CpsAqPLbhYn4PE+5yqb9Rg6MfPvdXDc28msSwHplZVerbg50YR3NkG
         VwL8m+LcGwLkg+g9WBrv16iv18BAvZHqJvkP2+yDATq6e3ZO1VMKzXFgyzI6kE3tc/Ti
         o7JLKmcWrkOhS05dwuCpfOxo+q7Gr1Z7AE4XZ0mvaxjMlm/2yLSTHpj/NtzVjgk5K68R
         Xlba9IXdizYSUl7CPDx+qHsAUGwHPyiW/038n9Fg80Fal19807Fl/o08MH6QdfuLrM0r
         ZUBQfFdhfROhTX7EIR510+DcjR8QDejAy4RiGqgKN7JdeWDNit+4nSOGa9Oa8dpIvBP+
         N3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048437; x=1746653237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVPyHIH7ZRjOIO8JHArk3NWp5tc+4Nu3ZkczSBo6XLs=;
        b=n6BtA4SuOptcS1RvPBkufSwjqb/iRQEIMfDKLIQU9BUPEkYwtKJhxrII7/1LZdMWUH
         4GTu1PwBT58++U3N3y4fJJgDrAF4Pv/CKSdsW3KWcfYY38fUkh55c9xMw51NxIc9nx1s
         bOfxQ81H8KaHVVAiwh7D/BDbyhR9UiuA8bDa3LPov0vy2Jg3QmG7oc/GiIxOIvehI2NE
         CGfdyEKs4loUsynAY5SgV6rwihZANkTmkZ2iFr2Ec0r5cPD3Gq9jvlw5GzebCMV2yBMU
         rvjKFBVEOXMyBASOiYXgUqnHQRM1HiYTQSbvoET1sjnGNYfHCUwooHWCNFS2c5EuD2mI
         3TKg==
X-Gm-Message-State: AOJu0YxOeWj/ksa7NwbxamhTS4TiUEwHgyZNTqxbwEPhYemYkcHs2lzA
	5QWrkxAXf/Fr0Rxr19f0fQel1FedatXFH1bTFxibr0Wb6fERZg4HuP3K8Q==
X-Gm-Gg: ASbGncswoo58Of/rBP/oKxsNGtRsBJcJO4yoRVUEkajA5mOKH/wJaLTISyxxEXNlbZS
	il62lHxlC0pdLlxpqHx/9OKAGOr0xzdnl/UqlSQa5qCPgp36aL4q75XuGjPTtUoFY+qUcgMGt2v
	NsutaTKyA8IcRb+JNjNc3QyNN4cN1l5lKjfQqw83zRQNrivkPKW80Qg/j2fUXea32dzrEJDZbe+
	UeBevUH6/+cg5LCn4LhafzJPJi4CuPxx+g51tchHM818fr9KubM9dcsiHdfQ7dwT+xgNH2Mcyl9
	sJIN+RSL8zFhg0I3nrIVlavEe038YUtlonwIMnnXF/c5d6m/0UgXSXcn0HUZgeYq9PvZ
X-Google-Smtp-Source: AGHT+IE9EWvOmMxMTa7iwN44Rzh2wWHQ6bH0Mvxo4lU84ML2fmgcdfzybdFQ+9JKSZm4ifjFQhx1wg==
X-Received: by 2002:a05:6a00:3d46:b0:73f:eeb:84bb with SMTP id d2e1a72fcca58-7404924efdemr27379b3a.19.1746048437165;
        Wed, 30 Apr 2025 14:27:17 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:16 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 06/16] xfs: validate recovered name buffers when recovering xattr items
Date: Wed, 30 Apr 2025 14:26:53 -0700
Message-ID: <20250430212704.2905795-7-leah.rumancik@gmail.com>
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

[ Upstream commit 1c7f09d210aba2f2bb206e2e8c97c9f11a3fd880 ]

Strengthen the xattri log item recovery code by checking that we
actually have the required name and newname buffers for whatever
operation we're replaying.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_attr_item.c | 58 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index a8e09ea2622d..4a712f1565c1 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -715,26 +715,24 @@ xlog_recover_attri_commit_pass2(
 	struct xfs_attri_log_format     *attri_formatp;
 	struct xfs_attri_log_nameval	*nv;
 	const void			*attr_value = NULL;
 	const void			*attr_name;
 	size_t				len;
-	unsigned int			op;
-
-	attri_formatp = item->ri_buf[0].i_addr;
-	attr_name = item->ri_buf[1].i_addr;
+	unsigned int			op, i = 0;
 
 	/* Validate xfs_attri_log_format before the large memory allocation */
 	len = sizeof(struct xfs_attri_log_format);
-	if (item->ri_buf[0].i_len != len) {
+	if (item->ri_buf[i].i_len != len) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				item->ri_buf[0].i_addr, item->ri_buf[0].i_len);
 		return -EFSCORRUPTED;
 	}
 
+	attri_formatp = item->ri_buf[i].i_addr;
 	if (!xfs_attri_validate(mp, attri_formatp)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-				item->ri_buf[0].i_addr, item->ri_buf[0].i_len);
+				attri_formatp, len);
 		return -EFSCORRUPTED;
 	}
 
 	/* Check the number of log iovecs makes sense for the op code. */
 	op = attri_formatp->alfi_op_flags & XFS_ATTRI_OP_FLAGS_TYPE_MASK;
@@ -759,35 +757,73 @@ xlog_recover_attri_commit_pass2(
 	default:
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				     attri_formatp, len);
 		return -EFSCORRUPTED;
 	}
+	i++;
 
 	/* Validate the attr name */
-	if (item->ri_buf[1].i_len !=
+	if (item->ri_buf[i].i_len !=
 			xlog_calc_iovec_len(attri_formatp->alfi_name_len)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-				item->ri_buf[0].i_addr, item->ri_buf[0].i_len);
+				attri_formatp, len);
 		return -EFSCORRUPTED;
 	}
 
+	attr_name = item->ri_buf[i].i_addr;
 	if (!xfs_attr_namecheck(attr_name, attri_formatp->alfi_name_len)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-				item->ri_buf[1].i_addr, item->ri_buf[1].i_len);
+				attri_formatp, len);
 		return -EFSCORRUPTED;
 	}
+	i++;
 
 	/* Validate the attr value, if present */
 	if (attri_formatp->alfi_value_len != 0) {
-		if (item->ri_buf[2].i_len != xlog_calc_iovec_len(attri_formatp->alfi_value_len)) {
+		if (item->ri_buf[i].i_len != xlog_calc_iovec_len(attri_formatp->alfi_value_len)) {
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 					item->ri_buf[0].i_addr,
 					item->ri_buf[0].i_len);
 			return -EFSCORRUPTED;
 		}
 
-		attr_value = item->ri_buf[2].i_addr;
+		attr_value = item->ri_buf[i].i_addr;
+		i++;
+	}
+
+	/*
+	 * Make sure we got the correct number of buffers for the operation
+	 * that we just loaded.
+	 */
+	if (i != item->ri_total) {
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				attri_formatp, len);
+		return -EFSCORRUPTED;
+	}
+
+	switch (op) {
+	case XFS_ATTRI_OP_FLAGS_REMOVE:
+		/* Regular remove operations operate only on names. */
+		if (attr_value != NULL || attri_formatp->alfi_value_len != 0) {
+			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+					     attri_formatp, len);
+			return -EFSCORRUPTED;
+		}
+		fallthrough;
+	case XFS_ATTRI_OP_FLAGS_SET:
+	case XFS_ATTRI_OP_FLAGS_REPLACE:
+		/*
+		 * Regular xattr set/remove/replace operations require a name
+		 * and do not take a newname.  Values are optional for set and
+		 * replace.
+		 */
+		if (attr_name == NULL || attri_formatp->alfi_name_len == 0) {
+			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+					     attri_formatp, len);
+			return -EFSCORRUPTED;
+		}
+		break;
 	}
 
 	/*
 	 * Memory alloc failure will cause replay to abort.  We attach the
 	 * name/value buffer to the recovered incore log item and drop our
-- 
2.49.0.906.g1f30a19c02-goog


