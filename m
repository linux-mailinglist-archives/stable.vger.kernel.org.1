Return-Path: <stable+bounces-126743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56723A71B47
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5AE27A815D
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1621F1F8937;
	Wed, 26 Mar 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="T8VWEhwI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A361F790F
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004735; cv=none; b=IZau/CvLXReo6Mveq55rZUbJUgh3e52szvnPk5W9d+S18yl8iMcHO6llxJe0DNQ22YSg+4QMGChwQ6kouFsSM0nfMBSZ3jcvsgfYinK7dKOzFMLbvC2SrJOYEFTWmLGPk1whzFXuCX83HX8BUePg5dj92cvralb8swgx/xGS8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004735; c=relaxed/simple;
	bh=Ko35wHuYTUsyD9pNDD6CddW86SuHmvVF/p8rHOgc5Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osrdr3iN1K8uGvLKpvPEUMZxy+uGz3VslWZeexuvv81BwG2ZBZzI9oodziWXEcEkLuYlNn9+srj6/HS+aEleShSWp0Q0iuOTxV3rAR76t4rYuHwwMwwZG/W6+YCWR96hNBj4lE3+rlNuEJZXRjy2BewvVaka4aVf8hF9vJC0RS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=T8VWEhwI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso1849598a91.0
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1743004733; x=1743609533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vaZQ+2MJDMVjz/9PaIWP0hky9ATIPKX3HyuJU/jmspM=;
        b=T8VWEhwIWdprG7TzGEYgjk8BP/tosxJmDPwv1apaqgnHfMtYfvrE9EfeKFk/WJGTiP
         T4knKjFqT11kDt1yCPC0XVRr2Kdte1to2oNh4c6QneRLhxyYh/RXmCf4oNPIAuAx2xXa
         90KmDNoJ+JQunZJbAulL5f7e+W61mYfNEIJEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743004733; x=1743609533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaZQ+2MJDMVjz/9PaIWP0hky9ATIPKX3HyuJU/jmspM=;
        b=mJ+9Vd6dx9FeXA9GJcgk6bqzyckVkPXSFoR0vJBFhMThajt8qxzy06EgIFZ4OrRaZ5
         z4Uz7se4AQbt5AYC6O9jhMONI80cF9jXortMurSioNmWGvFC5Gq+z5+v/Zf1HBIXzyuU
         OCdXej47Yp32LqkiML4DlOJg6lwktARmIa4uaoIZ/CIeUOznfK7EDmoNpsvTEuCwRSCP
         tJOlLOrqwlg0DNBh/SXbi3vdzUQt0d/JymYaxhhPDJEOUjmJeIwmMjSiH65J/LCKLA5L
         Hh4bpKxuS/3XayIV7BxE2vo1na9uiLHNhaiyKPqExfJF1ihOA7lezpCZP0zQr+p+6LRn
         NVwg==
X-Forwarded-Encrypted: i=1; AJvYcCUqsgrTOEuzprOB1qJd3IjTbcY1wcuMH9Kc0JpgfDRMv3gXqtRZKdb0BTuDk5hzxn/fLNPwK/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8M7/T3K8OjxvYZaxL4iyA0yrO+h69KDnc4urUQ+mOYDtxUC+
	QVQ+jwQ4BZhRt6VzEW0ZCwxRULzJYuOhZMhqMwOuJBoUiF01ELreKC7PbVCh6d0=
X-Gm-Gg: ASbGncvEMSj0/p4jWHnAckff2OULC6Z5GKipH3d9SaE43eeyVzN+sqUyTlS3q0niL9x
	WxiH0zP/TioUUye/qQqnjee5vmnTu05A6PM+As86OUHw+T73D5jlyqYCQv767AbTp4kNdkAOJm7
	sBrBVlwjGUfuIUvuq3NKMKfiQARUwFD1iTfRKHzFVt6i7j4wYlbNSG7Ny4otWhXHiJ05QEkdtOB
	K94M3T4XashLdJKXP6EwH+j9P2YVnhLW9OfJiBaeEu90bfrcBR/gIt+OXxjxbS0dRUKy+ouUuDI
	rMsolLGbXue3m9ykeJ6RiXlU+i/QpHdqnJAv42ogYZxThngSbH2g3Hdf4COqxcqeDRL3sSMlA2a
	ElyxH
X-Google-Smtp-Source: AGHT+IHFgZ5MnxSjZ1MnHHSC8h28hT1dJVRZQpLzJ1vDyTU635J4PM5CGpBG8FJ9Nnh2HGTU+QyICw==
X-Received: by 2002:a17:90b:3e8d:b0:2fc:aaf:74d3 with SMTP id 98e67ed59e1d1-303788c3949mr5434698a91.4.1743004733212;
        Wed, 26 Mar 2025 08:58:53 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab1d1sm12423939b3a.32.2025.03.26.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:58:52 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 6.14] btrfs: ioctl: error on fixed buffer flag for io-uring cmd
Date: Wed, 26 Mar 2025 15:57:36 +0000
Message-ID: <20250326155736.611445-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the io-uring fixed buffer cmd flag is silently dismissed,
even though it does not work. This patch returns an error when the flag
is set, making it clear that operation is not supported.

Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
Cc: stable@vger.kernel.org
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..62bb9e11e8d6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4823,6 +4823,12 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		ret = -EPERM;
 		goto out_acct;
 	}
+
+	if (cmd->flags & IORING_URING_CMD_FIXED) {
+		ret = -EOPNOTSUPP;
+		goto out_acct;
+	}
+
 	file = cmd->file;
 	inode = BTRFS_I(file->f_inode);
 	fs_info = inode->root->fs_info;
@@ -4959,6 +4965,11 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 		goto out_acct;
 	}
 
+	if (cmd->flags & IORING_URING_CMD_FIXED) {
+		ret = -EOPNOTSUPP;
+		goto out_acct;
+	}
+
 	file = cmd->file;
 	sqe_addr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr));
 
-- 
2.43.0


