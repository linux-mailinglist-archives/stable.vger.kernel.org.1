Return-Path: <stable+bounces-192233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1CCC2D39A
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A10D420E8C
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFE13191C7;
	Mon,  3 Nov 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH7pNW8S"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B10318155
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187864; cv=none; b=BFkdaktfBxow+SDpGOofSAejhwHm8zKq/jjFxKjTSsm3JtqxNHwBMVB23ZN+lc8AV+FyjZbXho1UoPL4fRZIaYkyu/d5w5BrZDtha7EoDhw9E6V3NnvDpc0dnXWmu3/02EwRNIn4G7TN3aZkOW3RUXaLuvOwktKldSeFt4rG134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187864; c=relaxed/simple;
	bh=QVjhfMLQHjrgRMPIbt314bhjxXbir3hpnY4sM9EUf7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdwlTRyFQW1T7uJfUFe7AJjU1GOyyjh+R9cO82T5m2V5vRVYGIDWccZe64t+kVWfeX1yWJ4a63E33xcf72LCavT9vbrSFdq8wRMUf1sH1m0Np6RIH4FV1O5MGdIIWoF68hATRKUNqNsVzQurjbJvSqHxq52ZJ+9TyAfwEJ7Re7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH7pNW8S; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so4398413a91.3
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187863; x=1762792663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZeg8I26rc6UbearIJ6Ec2S3DjEynyvxSgAdjW2/ZNw=;
        b=QH7pNW8SAuWCcpu2daZV09uu+CFTRMkLcdcWJAW0UeJSEuSJlwaRBYt/YgLI5NmcQH
         kfPkY6/8Tgqa5/gZy58iyZod+5CPh5mX1jpJ7e9ylPRyfYjwrdL/S472T8m29GaCNx0W
         k4plbKu6hIAwj/w2hEred51nHm+zlexs9EawH0YlRwENsADxYnkQj9spOcWNo1nQ57qY
         8qRbxK/BF/QHtievxBYdW3FKAb7d+gWQp8WzaY9m5Tespp77O3yO6/itim3nz8iBwScj
         jcjKgzr94GDHDK4UTXOdlg5HPMI/CMNZkrYrtp49wf+Cqwpt/2+Ne2rapmDeNey5J9Mx
         jojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187863; x=1762792663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZeg8I26rc6UbearIJ6Ec2S3DjEynyvxSgAdjW2/ZNw=;
        b=UG1NMjYp+XlEplqCMxhtxoa/IluOaF01v6LosRCNdylWEBVEMFsllxA1XCQCZdv8fq
         rQtyP6PlfJ0EH0CWxEPJ6lDTnt9iFSX7VYsk/WD/SJ9E+WLF9NNa0tfjdGLfRZKdHinQ
         H/QlWHyuXQxWRkV++MvzmIRNygFf67RsyZ3PUhhl12uK8eBy+fYs/nExLszlsWU21Bis
         kgbE2G6UaHRtd1dM3/2xWRaRnirth3XCJ9YIloOTQFbAbqopACPOzcEVWGOD904L5F15
         7KIoEphQk/wzQMCeq7ax+2Q7hOY8pmN4yrNci+s6HU0sErzQtRUcOSNNc1lsrg99bNEB
         m2pA==
X-Forwarded-Encrypted: i=1; AJvYcCUKt6WasetpZA3TViqJF9CXcSFZpoqMb8PVVtgAgLcjYqw1t621LEflf9ZJFBfB+x9oHnK9sGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLq33Z909A793/d1yeeHE0Ab61WHBEv8HqtrlaLfh3wl7dOP1
	mjMqDFA2X9vrBJvmwb3/5QfmsijCuWBavIeIuIkK3vv4ghQ5xAMYw1Ux
X-Gm-Gg: ASbGnctsWfs5jY9Lk4r8PE9RzaXF6brrmXlbmZvscQgpLsemm6938zv/y99F8j+ny02
	oIZnqe0+vF8n4ywirYIP5xvjB1deghhf9Iu2VA+cSgg0J1ukED7hv6V4Y9+zR0nZlAcQCqmfOL7
	sNRWXN4Cl7waCpOPY4hRPb4+lUFsfIijWlyqUzU9MH6ax2Ghm/Kz44Fo8dTlok+qEEjM3hVyOuX
	qfNXg2VLksVuoyaWic1k4W76jZaTYJHn6SOyyzCd2SA4NuGGB4UyBxFEGKF6IrKQ4db/tpTUXMi
	OhbaV+Hcsk3XoI+LRIgijLra7cdAUFWRoilfLO2XIoe8jIN6CRcKFiY8EL68sXXUoIxfzcDOdxu
	KAdScdeHsQC4/CGgrl3/VEVfHRBmmYqT/BZBR8aqJRmEACGTbJ6X8nbHU4aAEDH0y5M871FkdMB
	cP+OAmeZVvtSkwaUUe
X-Google-Smtp-Source: AGHT+IECJxJ0Plit+Zuu+BbgH2tIvI3CBKHwwvZNXR/2OazArhNb7Gq0ds9hJPADl9dr5Rkhlt0Zdw==
X-Received: by 2002:a17:90b:5150:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-3408307ea84mr15540031a91.21.1762187862734;
        Mon, 03 Nov 2025 08:37:42 -0800 (PST)
Received: from monty-pavel.. ([120.245.115.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6853704a91.2.2025.11.03.08.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:37:42 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v4 4/5] xfs: check the return value of sb_min_blocksize() in xfs_fs_fill_super
Date: Tue,  4 Nov 2025 00:36:17 +0800
Message-ID: <20251103163617.151045-5-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid the
filesystem super block when sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
for sb_set_blocksize()")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/xfs/xfs_super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 1067ebb3b001..bc71aa9dcee8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1693,7 +1693,10 @@ xfs_fs_fill_super(
 	if (error)
 		return error;
 
-	sb_min_blocksize(sb, BBSIZE);
+	if (!sb_min_blocksize(sb, BBSIZE)) {
+		xfs_err(mp, "unable to set blocksize");
+		return -EINVAL;
+	}
 	sb->s_xattr = xfs_xattr_handlers;
 	sb->s_export_op = &xfs_export_operations;
 #ifdef CONFIG_XFS_QUOTA
-- 
2.43.0


