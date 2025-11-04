Return-Path: <stable+bounces-192378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E04C31104
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 13:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CBA84EDB8F
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705452EBDD9;
	Tue,  4 Nov 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5hbyQCf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDD2D94A2
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260661; cv=none; b=UuBmacJoycqc+lBLDI0KVHESvB6rrq/Z8kWW3g3F/GSkAlpviVvEPAQnmOnyxJdhMWpAVunFULfnPtGmytzqMm1T+gXzjpbbnVhFM3NcbbmStkL4WHOe038ISQ8vj2GXb5XB6dNdMlxb985z2ByZBYIf1FREa7wi/7aNpREapUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260661; c=relaxed/simple;
	bh=Zc/y7/iyuhzo73FcQYuGWiCMqi/pQGpHb9Cqw0BNl8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSlfhvTqOE6s80tMrefYl1btAlARAbjlXBNP7A0GllXGb9KpqHzqrZgeLh19rviYRHyMBly2lM3jYIP1pGMN3Wl/72ivrjNqFDjEqEk8QnGAshV5+wULuHVyQwJGeyruuLv7TxIA+p/o8Sih/MAFxzlCsSUGvCPpV+XsKcvhbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5hbyQCf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781206cce18so5848198b3a.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 04:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260659; x=1762865459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8asDZdZ/5ha36TqW9viVaU035nISljT2hMRnvK4GxFQ=;
        b=N5hbyQCfZj1/OGGI72+GgKXdJ08+1645rRmavy4TlrZ2aP3Rlsohnd6HUAPJeV2/s8
         huUzE/fcj7DETBzdWOTAXqAdzp+rAOIAeluflpmfy2Gicx1lLMqmNheoEioy/GYaYx6u
         DpRK4O9nnXzCvXmOn3AI6pvQ3MbmbF0ONYLiM559v5eiNlnhKPmApca2A7MMPsO/abCf
         pDe7+v8QvbGsSuhhBFIMpreLlmHZZAed15xwJTRQLONTuArUROzG1cH+l0IGOo64Y5fw
         US4ppbUNpttTtn5/j04LmI/UHogRXNbcRaG1ZvP/127r3viM9WVnX/o/BsldFmnN98ha
         6RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260659; x=1762865459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8asDZdZ/5ha36TqW9viVaU035nISljT2hMRnvK4GxFQ=;
        b=IcuzX6jN3LeXhX51ywEGHZXkcLZIKZuIbWePXuzxsGSQoVBz/CwoxF8Jh7GzZjnYxJ
         SVhh/+pjLJzv9591PjYBZV6kyYqsxQ/yi7J/PlBVpRSVg5/zjKfVIy8Xk68InwYhCDCj
         rdyr+0vldrwrLvJPQ+SVRUyDAOfVpeTOjmGv66Ff74PCK1J2yex+4cKIWF5cvaUuIh2n
         CHiQREqWcfDB3uxLqLacj0w+stQGmV7jKQMExX91UjMNU+BPMiatWF1XFDRqzJ5u+G57
         Kpe9efWmNIbJeWKlJRX8rRvKvuQh3FEb6KM+Oyw9pnl7aUgsGXAxWQdCYq7CPCfPtQzm
         V6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxN3MbRhWn3AboK200znR95xKG5LIsvzUrQ/O3rff+FmiHeJqSsZJqC0RrBrmDJVbDw2vxtPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyclGWPn7ctEpCU875CSRsvmZrN/v/15igPEpZtjYmf8uthLQl/
	TuuJc7raHljfDa4rZGPw5JiEof4NgWfM8nQLBIhJU8JE7z7GoICCeem9
X-Gm-Gg: ASbGncv8ETMNaTLi1rcb8Z7KoOGD9DCVwH3SnYpw541UXev4q65IjZBIQoh2+4peutN
	AL1dWVo+0ymAYMaPD7chPWtM5SBGCR6YwPjuYL52IKVXYjSEvcYaWCj2mRJlkc/odt+5KMN7ozd
	D4uHSWykIUQj6fRJGORCtUiMbqLJXvuddmamcIPzziHMC1GW+pHuIsIpV2PdACJHYjmusoko7Su
	IaSKE++BCMWrduOqLSZaUW6ytCEvf20stEkGF8WOCbyFXnzImriCunFNd6IyH3o3Bvktp1m0VPJ
	BGbOFhk8z8WUxCWprSGWluBCV1SKtNly7JBlP5WhuJSTzuMgtAE5S3BBcB+53GN3Y7cw2HewZd3
	iSwB9BdsJSIZaJ5E1zyfcw2b13GP1F74MwSblTbPTOjOemV3mgOb81zlJnb/w9mN0rdlNiJ3qAl
	WUNJqBdjw5lqybSoFXwPZkC2EC+WKLtA3yVFfMoaEb9bSHjPzAP4S2HbxDsg==
X-Google-Smtp-Source: AGHT+IFSneBnWTt2VQT9MEymny53bGd7ZCTNmsINIZkl0njlmgUgoGuMpFK6R9EKutPwtc1t3a4fcQ==
X-Received: by 2002:a05:6a00:1988:b0:7a9:7887:f0fa with SMTP id d2e1a72fcca58-7acbf0b9e3amr3856752b3a.1.1762260658993;
        Tue, 04 Nov 2025 04:50:58 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6d026dcsm2860710b3a.70.2025.11.04.04.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:50:58 -0800 (PST)
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
Subject: [PATCH v6 3/5] isofs: check the return value of sb_min_blocksize() in isofs_fill_super
Date: Tue,  4 Nov 2025 20:50:08 +0800
Message-ID: <20251104125009.2111925-4-yangyongpeng.storage@gmail.com>
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

sb_min_blocksize() may return 0. Check its return value to avoid
opt->blocksize and sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/isofs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..ad3143d4066b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 		goto out_freesbi;
 	}
 	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
+	if (!opt->blocksize) {
+		printk(KERN_ERR
+		       "ISOFS: unable to set blocksize\n");
+		goto out_freesbi;
+	}
 
 	sbi->s_high_sierra = 0; /* default is iso9660 */
 	sbi->s_session = opt->session;
-- 
2.43.0


