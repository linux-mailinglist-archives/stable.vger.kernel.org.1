Return-Path: <stable+bounces-15513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E0A838DAF
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193EA28A7D6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AEF5A114;
	Tue, 23 Jan 2024 11:42:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582C4BAA8
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010171; cv=none; b=hLU0dDAEQKSWBd5t0cwPijrXheYU+spD6TewC9YWH5pr3RXDYNJoMhlmqnVieUvPoazJXKRg1PWDSIDJbSmmHFVeGiimdWGyh0AK3sOX39gWETWfDkLivjkyRJhzVD+5JGMGgRRSzVR6VXu1qXjY/uUgT8yQG+BkaQRFfYRAnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010171; c=relaxed/simple;
	bh=KN7PDGJcgFQTXxLPW1IR/weDAYk5goYZBzjDxAhJULM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9ev7E62L3hGIhejilazcUYFpGQybkWz9TySte27EdVblsihTeuiFkO2f5WNeWICGmV/O1seyAZ3eeEbyp++Gt/wwmcYe/I++EnksApxLnPzPP3FhEnFXAboIeyRLDo/Pr4PBUOBinXbdPp7YP+9ZpxyeNRGtLYLp5+Kn/jlbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bba50cd318so4284200b6e.0
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010169; x=1706614969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxf6+tHlAVbbaOPT/+raKtwYOjTzH2trQdAOpOzNZwc=;
        b=RT0ct0VJognafArQ9qr2MNEGxn58+kyFyWzlBS6IwwMI2CrC58V30bNd1kT9K4kvEW
         oUTMUhCzZB7EPAmYvur5ZiLYJVFTcyp1d+9OIwvSa/1siwDofnNCRfN1xdPeRpq3U6w1
         UzhViyyRZc/3ldasSPCdw8FZp2UNocZ1bqfhuSqKF3bFg7IErRLnIooaOV70wF/AG5i1
         Ut3qU1Tk5zJpwKg8/fZ5CpLJnSef3dSy1dr3r0MTMbWozR48is7AyNW6UfSIawcfDEar
         bxZoLth7PV90hDx9d3po6mw7XFdW67Hvnvifgl8p4D5rtlVEmpjz2JZQyPoRY6IbPW7p
         xHng==
X-Gm-Message-State: AOJu0YzjN44ypz1JijU4RSk85zsQxQ/iCS7eGZO5Jd4nc83PfO4woK2F
	xflZa+sGAyHgQ042sotMXm/+bwb+CR4EKxN9E+8BtMd6Dcdh68eg
X-Google-Smtp-Source: AGHT+IHO/CxowgnjaWDhR7QtCtgJD3Ru9CGgwEvH0d2ZwA8NcnMK3X7CWyoRsTn9W5xidRTeykMzLg==
X-Received: by 2002:a05:6808:10c3:b0:3bd:9dc0:d39e with SMTP id s3-20020a05680810c300b003bd9dc0d39emr8307321ois.97.1706010169205;
        Tue, 23 Jan 2024 03:42:49 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id c20-20020aa781d4000000b006d9a6a9992dsm11405182pfn.123.2024.01.23.03.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:42:48 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.7.y 3/5] ksmbd: don't increment epoch if current state and request state are same
Date: Tue, 23 Jan 2024 20:42:26 +0900
Message-Id: <20240123114228.205260-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123114228.205260-1-linkinjeon@kernel.org>
References: <20240123114228.205260-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit b6e9a44e99603fe10e1d78901fdd97681a539612 ]

If existing lease state and request state are same, don't increment
epoch in create context.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/oplock.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index c58ff61cf7fd..3209ace41ab4 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -105,7 +105,7 @@ static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
 	lease->is_dir = lctx->is_dir;
 	memcpy(lease->parent_lease_key, lctx->parent_lease_key, SMB2_LEASE_KEY_SIZE);
 	lease->version = lctx->version;
-	lease->epoch = le16_to_cpu(lctx->epoch);
+	lease->epoch = le16_to_cpu(lctx->epoch) + 1;
 	INIT_LIST_HEAD(&opinfo->lease_entry);
 	opinfo->o_lease = lease;
 
@@ -541,6 +541,9 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 				continue;
 			}
 
+			if (lctx->req_state != lease->state)
+				lease->epoch++;
+
 			/* upgrading lease */
 			if ((atomic_read(&ci->op_count) +
 			     atomic_read(&ci->sop_count)) == 1) {
@@ -1035,7 +1038,7 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	       SMB2_LEASE_KEY_SIZE);
 	lease2->duration = lease1->duration;
 	lease2->flags = lease1->flags;
-	lease2->epoch = lease1->epoch++;
+	lease2->epoch = lease1->epoch;
 	lease2->version = lease1->version;
 }
 
@@ -1454,7 +1457,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 		memcpy(buf->lcontext.LeaseKey, lease->lease_key,
 		       SMB2_LEASE_KEY_SIZE);
 		buf->lcontext.LeaseFlags = lease->flags;
-		buf->lcontext.Epoch = cpu_to_le16(++lease->epoch);
+		buf->lcontext.Epoch = cpu_to_le16(lease->epoch);
 		buf->lcontext.LeaseState = lease->state;
 		memcpy(buf->lcontext.ParentLeaseKey, lease->parent_lease_key,
 		       SMB2_LEASE_KEY_SIZE);
-- 
2.25.1


