Return-Path: <stable+bounces-192232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94988C2D2EC
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B621898E5C
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C283191D2;
	Mon,  3 Nov 2025 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZQUmVUb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F43191C0
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187855; cv=none; b=LjzHABRubOdpHhokboqxWT1IaLtK1vPEcGrf2vO3dPLOsyJOqz3/htTcOvR064PpOByAiErnWUbf4oMnMnC/J5HT7VzAataWczRlU5nWbTxxnayEURqJ+/ioFn58kpLKpNX/QPunf0mTHUW/F22bojyIoipMoyjKPU0vR4R9YX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187855; c=relaxed/simple;
	bh=nWCX9Xn/+IKfnehkSs57lbJDTkS9u5nAvInJtc9YeA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+lpLjSiT63W7uKYlS7TUCwaNj6G4a6PaL/6QxjJCDpi6QrWqOJyPje2APBaG+FDjRgwFvToOto7B8qIeyLBO895C/YpRa+n/cGscRzNTezGVid19RcpnYNo0AOGZWz8E38Fg7v94qOLm1+qU6VbReryYmkSlbHeobtvfZ+/WBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZQUmVUb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33255011eafso3878054a91.1
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 08:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187853; x=1762792653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UbgPj8GVBWuehInulfgB6O/0NvS5woL/wIoY+Rh1do=;
        b=VZQUmVUbFLd8tjP14YlfkEj+BnVA0HkZGG1iVrcvoAVDds/l82FT4TOF95wMpFst0e
         /g6xGi6MxUMmJz5h/bI23XRQ86NmhJ3qEuOxDODdvzg6AXg6ZoJaM4oxszUScRTVWrsz
         e9bkzUs/18yEut2/k5hfEsP6233MTakx9aAkCovRdMWVDmqh4kUDgRHDiC2CHoKPr9fT
         VeuqTRbh0IzebF+QI2dMfZj6pO9xKOFJwVy5IbQeDtTitIm2GN3MoidrFpft8Vrfolcw
         oIacMBKWdqJzpgAYJVrRZZXdDjMhNSc41ZViFRnk8FFQGPmekmuam6WtA1UskCcR8DDb
         ACzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187853; x=1762792653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UbgPj8GVBWuehInulfgB6O/0NvS5woL/wIoY+Rh1do=;
        b=qhrZxlEJktCl+ghHNms7rn20kFzVftXml9pltZTSIApmgeRk5P6/CNA+MaB/Jqczs1
         PK2//TwEeTt6jZ7OPy+zE8WueuZ+8kWM0BDXyG8TGmhJk1DxQ4lEvToNXRA1cje9ij1u
         P1Rc1qnPbb3GocLqmiSZl+0U5c8oDhVb5CTsukEU6wZ5ZFjbSj2z2owOqyZXH28hK45E
         0t/Ogwo+3VHXY0PEWpAQvmmu/wMy37KgP/TaroVHWQ9UTmKFQksJsEXlAqT9zaNI+O72
         uF0Peh/jQpmX6yX4ij5BPZaihIfW1f/CiPRzcF9nkc0twjLqVmb9thH25mYrBqoxDq6m
         3lHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUScCKpV9jqU6NUiKeSPvLgW+dbuO6r8E15tZsP3bDw2nV5yIlI6M6TSu09sqVKDqVQUFaju8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZRT7JPES3dwmmwMpR6AwBouZj2OE3Duhcb7gcgpHrRlIi9tE
	N4EEcXZpf7PhfkjbuFYaCPVIO/W5zXsMnWkeoxP+i1b6LpX5q/hhAySz
X-Gm-Gg: ASbGncvs6oyIKsYA/wBlUxVIP4PWk3/pipPQkuT3labtSVCIdSVlSgcusAoPyzKUh6a
	bQ6FfS9QhrBK4HbqfRS1MeX27rPbaI1QX7g70igEVmiP5wCGgNwcxhseD2KmXGEtptZHL03qjN/
	A9vXuxAkgTEhWcGfIz1MDMaVcCvc9WSCqTDoichLOTOc/ICWjC6x8N+YuvENl1d3oxB3Ym4op8n
	wWr8No1vmT4pcfeFr2oI2bnjiDxnx/k31MGuXd/S+L6FPEB7f2dn/VIPpuV2hJHr9jJIpSrKs+U
	X5cRPzEHTbIwqY25ynty5g/oMspRDJR/+DxUXdaApSD8t64yGHdYhqUdnSmwWImTClnm4qxY48H
	We1Md6P/ZMhoY4baGJhzIZRKdtm2R/c48Vnj75oP1GdK/8Y9Hs7/YjfXePTl7g1KR2LIRvGqXdw
	P5O1awg79De+3TeypRBRfTyPqqjNc=
X-Google-Smtp-Source: AGHT+IEASkA8V+7jhpM5M1UBN9y/LaIZ3ZfddiwA+afwhpAeDYCIo8Ch8f4X0rxhFH+DrE1jj0TzUw==
X-Received: by 2002:a17:90b:48c1:b0:340:c060:4d44 with SMTP id 98e67ed59e1d1-340c0604eccmr10391621a91.14.1762187853008;
        Mon, 03 Nov 2025 08:37:33 -0800 (PST)
Received: from monty-pavel.. ([120.245.115.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6853704a91.2.2025.11.03.08.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:37:32 -0800 (PST)
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
Subject: [PATCH v4 3/5] isofs: check the return value of sb_min_blocksize() in isofs_fill_super
Date: Tue,  4 Nov 2025 00:36:16 +0800
Message-ID: <20251103163617.151045-4-yangyongpeng.storage@gmail.com>
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

sb_min_blocksize() may return 0. Check its return value to avoid
opt->blocksize and sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
Reviewed-by: Jan Kara <jack@suse.cz>
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


