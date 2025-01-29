Return-Path: <stable+bounces-111224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA87A2243A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7651887E13
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3271E2613;
	Wed, 29 Jan 2025 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUjP/uow"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC41DFE3D
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176466; cv=none; b=nmthAjwOzlY86jowH8uj5e4Yw3LvTPPcWOqYyGFejaI67Y8K7Y3ovCJOh4QR0Xt51kFQHM61R2Clcbn5MYwZHgCGF49WpIairhmjsKx9ZFYt1sCWekYbtVG7dI9yDWcMheKSeVB/V0P+a6VyRNY9T1HNh8R8uEUX6FLLjY4wjY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176466; c=relaxed/simple;
	bh=slkEpwoU/ktL+cjx4jamtTSpJdx8n0/t1eqx3+sOnYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZ8a9adYpBw9AyAD+CWOrNOhtoCfgt4wD/gGcpDENKWOJpEH+VPwzpJy32b5FRzZ1IMcYgJqCx/qHlm3CVWj2MH/EtUqCl64Ho/bwM79aNcwYcCrVGKcmPVzTmrKseNaGCofpKlHXLUo6hW0GoGhstWNjsfiGrtngZdDSN8sjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUjP/uow; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2161eb94cceso87825335ad.2
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176464; x=1738781264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSvy2yWsNTK+725cX8bWl4GEAkf56PRv0DomIO7AH8w=;
        b=ZUjP/uowjPAneC8ST+PuFBYgObeniLON90rzgsIoxp4roNUGMUeq2Ensa5FDguUfBY
         Rdyvgw5iNHrCIHppP57OJnZLe8HkvCshRhnp3rXjHwg5CU7x6pxXaunQm4yDzWfU5MNr
         FVelaClnwfiG9DKlgalnnmi6X8FsgZS+eGDBKH7qKqZsAqulB+kDwBs429sMOnozlgLf
         unPhyW8vqWsrBvmBFf7JUTDJsCB7ZfEo4B8oUV0ou3UZpm0gLok8prnWoT65q6mbTX/2
         CcwRlIwmCavb9DW3VCNOJzyB00V2BGT0LiqZhL5X06sWASERRcVODu3xCdQxzHFzB2d7
         /wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176464; x=1738781264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSvy2yWsNTK+725cX8bWl4GEAkf56PRv0DomIO7AH8w=;
        b=TOTw9Ol9Mctdda2AMFnS258I6ZWQgzXB9EW5J3PkBj1QRxWc9JC2Kj4rxj9mImuXQm
         T5NsYoOvfTfqqQLNzbgUrp9MAm/dFjKE+9xZX5PLDdXR2qGrGnHQ6YQwB9pD5jMBylWw
         g5eJuJOl5L8+ApFj7RuDfGWcsEs6d9/EHOc0/dG5kz9sHJAJHLHnQs/So2I56XefO39P
         0j/6UvytMeB10OXzuWwqzjhIcbFi2SHcHzTp7Dw7Mi90oyUIVth6/7cW9f1pZsWA8ji7
         c220V0vEEFE6LglLoXAIYUjS2S8TiZNJPVUwPT6ZOpnKaM1J3zpziLJ5PJb+sQIsi79n
         4kKQ==
X-Gm-Message-State: AOJu0YxCVVLzfS9zKp+xsVVW6+3JzIEdM7gcsAG7LdcMVz5+zPTse9CK
	9dx4ELfPzXA57DRDGpS74x5pvx2//OTmFFxd4kFIlL1PHUBoYOUbwQ/K0OBw
X-Gm-Gg: ASbGncti329lzUdi6TjEAjqA3oia6CMLFa9XqeI1ldfjBd+SH6LBnMODV4yEdGkaXnd
	gGpxwa8P1xfQO8XuTsuumzKQYL5mjwIsLpWTuIhRg/ibWVH4o90VZYCU0WG5N25AKfHdiyK5AkO
	a9RLUcXkFWzY5GOcD2m1A+AE+4/ChhnoNCMLEHDMVBkztOLSNCo7XZKa+Jj6qWJQPldQyQI0yow
	pkAWbHiDrOr0sxzGXGhNc9ziXyrKpl3SG5Vt3S0cXZp8ZjKxq2yonIxDuPDzhEAEKmkg1OcBdgb
	7KjjAILmgZ9JjvZRQwr4fGvaVGHPITGN0gChzaj+aDk=
X-Google-Smtp-Source: AGHT+IEIzOMlO8sa2RGZpPLPmKZrw5u0aHNCjfDuoHxNBtE330uxnmXA/7TuaBOB5vQT1LhZdWZ/wQ==
X-Received: by 2002:a17:903:240b:b0:216:7761:cc49 with SMTP id d9443c01a7336-21dd7e070d5mr60382345ad.47.1738176463118;
        Wed, 29 Jan 2025 10:47:43 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:42 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 12/19] xfs: only remap the written blocks in xfs_reflink_end_cow_extent
Date: Wed, 29 Jan 2025 10:47:10 -0800
Message-ID: <20250129184717.80816-13-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
In-Reply-To: <20250129184717.80816-1-leah.rumancik@gmail.com>
References: <20250129184717.80816-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 55f669f34184ecb25b8353f29c7f6f1ae5b313d1 ]

xfs_reflink_end_cow_extent looks up the COW extent and the data fork
extent at offset_fsb, and then proceeds to remap the common subset
between the two.

It does however not limit the remapped extent to the passed in
[*offset_fsbm end_fsb] range and thus potentially remaps more blocks than
the one handled by the current I/O completion.  This means that with
sufficiently large data and COW extents we could be remapping COW fork
mappings that have not been written to, leading to a stale data exposure
on a powerfail event.

We use to have a xfs_trim_range to make the remap fit the I/O completion
range, but that got (apparently accidentally) removed in commit
df2fd88f8ac7 ("xfs: rewrite xfs_reflink_end_cow to use intents").

Note that I've only found this by code inspection, and a test case would
probably require very specific delay and error injection.

Fixes: df2fd88f8ac7 ("xfs: rewrite xfs_reflink_end_cow to use intents")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/xfs_reflink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 004f5a0444be..cbdc23217a42 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -781,10 +781,11 @@ xfs_reflink_end_cow_extent(
 			*offset_fsb = end_fsb;
 			goto out_cancel;
 		}
 	}
 	del = got;
+	xfs_trim_extent(&del, *offset_fsb, end_fsb - *offset_fsb);
 
 	/* Grab the corresponding mapping in the data fork. */
 	nmaps = 1;
 	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
 			&nmaps, 0);
-- 
2.48.1.362.g079036d154-goog


