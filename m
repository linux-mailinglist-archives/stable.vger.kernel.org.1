Return-Path: <stable+bounces-192379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4727C31107
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 13:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE831423241
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26942EC541;
	Tue,  4 Nov 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1g5b/AV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF382E0B64
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260670; cv=none; b=tE13NOPb8BBK7hvK969xCr4eUTlx79O/Jt8CtEYdHehnLxd4AugiVKtZBqCHooKzjcE9n6hKf+AC8fio4rQsU4gM5pZOSZg/LGmfDO9oYWe0Z2bzHh2eE+6gtVRSUatE/ucjSgUxq0HgfgJ84jIl+b+gnfRoLtscuFcdvyuR5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260670; c=relaxed/simple;
	bh=S3L8yWcPf7Uvvhuw8kb5mV50ABXqzeKjCs/M0blRocI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2AqEXXXoxrNSVSG3BA8VGovuj1Yxs5nTMSzr/er1jkZP05Vclp64iFA/QgYOupY6aG91QrvB8A0Wfur5xRXnSo7UeYlZwSmoecXt0rlAczR4a1/KttyvBnEHcqVQzGf0C2fOt2gBOzWV6oC2muqZReoumJjBMj7IpoMz0oGZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1g5b/AV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34077439166so4805151a91.2
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 04:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260668; x=1762865468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM4LaUJGUQ26yP1YfE9/TUkYoY6eJkQufUALxNmpnUs=;
        b=a1g5b/AVw083mhh/EpgN81CSzncrNP02f45pvke2+H2d1K+ePlVS7/AdsD//K9Xnmm
         qLQtCsFfGFCsnt2Y/LqodDoEmtnTjbsPVRijPGMOzjp0GrT6jJL8sdP48Eoy9tWypLhk
         1YEXzboA7S8rYv5hW9Nmuvn7MaNVAdbpT8fGWCOGm1ABaIlRHVIxd8itcTcCtSMsoJRo
         O++Q3h3FigWAIxt9iAnB5dc4USxmpEj8iMHUnvo9xgf9XB0zI+CrA3rKO0RlNI7DVTi+
         zzTaTGet8CBRG/cJ655hUKqPe3QlZrOvO1Mi2xNKjwg7K97c9O/ir94bdqljjK0esjBv
         wxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260668; x=1762865468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM4LaUJGUQ26yP1YfE9/TUkYoY6eJkQufUALxNmpnUs=;
        b=vsXDaEdWmVU5f+jacGB7zKI9FI0/C9vAnBTOL+crSYtjhbXcKN6plOM+WlyCL2OIzJ
         VwD3Q6ITcBI8KCKtm16kzhzujKBASvd+I3X/T1lqhiSVy43Tf/EHRREwoTvTe/syQ7+7
         yNjiWbqu8p5q1/j0OpDA1YLeL2Wrs7XZZJg5IiuE9lcLlCFCmR+8aeAystkYZ6KAmX1F
         hWmbmm7g9+RyBlqdrtgWU7pt+zDXm72J5rB7kLmrFofG9egnVDFgn/t7gVlO7pB8l9re
         3UIxpLHX0P7QvZFrUTCLs5e5QdIQSwd1y0M9u9XTTCL0OOb8sBdm3ZV153K6sufeBeJ2
         A4SA==
X-Forwarded-Encrypted: i=1; AJvYcCXECCQJfdmtuM8Jg8va2CEwKLWhxlxh6U/YdcWYKMKjy8caJUyJ9iI7Dn/IWv6hn5NvEtC92V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqjK0l76Z5TZRDpEUa4fVaYJx2hf923wbKPpgJ9L1O7Mh7jHH
	cBkWBvOT83SFLrh+H9moIGGUKKQ5QOkXQSi1qS0A5dBbMtsGDEccC1Bx
X-Gm-Gg: ASbGncs7olctCqGiZMHQfaPEmbTh4e0s2mv1wSrKMFAXUnvGaLmirs5krJalaA3hPKo
	hEYfAqmr0x6uW2ra7lDykMGpcj9ohki04omtUS2to+xU14Ebx0612v8QezGB5G+PzB6aHhblEyI
	5mvqVk1e5XHZGUYa1QZ5Tnlii0wkyqoObCBJFc9LzHTKnyEFzo29u3Dh/hlBlZaKXPJceQ5i4ZY
	6XFEiidLBUVjCD4MVPVcx2BVL4x3Rf5wpdh375Pa7suQbD+EwNu9SdGmHezTPDKm+OJmJ37a9OJ
	7INok+bKWEGqca94uDjMV1/l1KvQujlP7nuzgmHouUW2vWqoQwBZ9j75O+vwBJmxZcZGjEJ0gtv
	UhObgimyU1tcOEI520mZ4O8fpd4nCSUW7VntuN5WRKkJciFLzVcjj3ysyHebQV5zcz8by5qq6XO
	iK6XTsw8dJHrXiEZWMcGe9P4QzDQxQ5LtvYigAZWb3pO+1XDI=
X-Google-Smtp-Source: AGHT+IH3JuuEMoP9YT3zyIl/+HUSXK+p3FIZ5E5NT2awhGYYunlZYurin74ce3hTLqp46OSwVZT1sA==
X-Received: by 2002:a17:90b:3946:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-34083074e9bmr20646792a91.19.1762260667843;
        Tue, 04 Nov 2025 04:51:07 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6d026dcsm2860710b3a.70.2025.11.04.04.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:51:07 -0800 (PST)
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
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 4/5] xfs: check the return value of sb_min_blocksize() in xfs_fs_fill_super
Date: Tue,  4 Nov 2025 20:50:09 +0800
Message-ID: <20251104125009.2111925-5-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
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
Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/xfs/xfs_super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index e85a156dc17d..fbb8009f1c0f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1662,7 +1662,10 @@ xfs_fs_fill_super(
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


