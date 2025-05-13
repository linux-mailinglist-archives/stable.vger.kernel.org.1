Return-Path: <stable+bounces-144157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AAAAB53D5
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 13:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E53B3A7372
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636D28CF53;
	Tue, 13 May 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hKHiASAC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7719E975
	for <stable@vger.kernel.org>; Tue, 13 May 2025 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747135727; cv=none; b=TXRHfVo2G/Ea2DH7BUZUNbNXWbRU9NjfePk5+2fnBpXFcBDP3RQZLf8e+F7NRXP7Cms36x1n0oBpkfYXY9pJR8Zgen/Wu4PdC0fsSqBO0BjIfY8Ig5NqNk5V/B2mx3wpK6gUP3+YBK93DfJcDFUddpLfqQ1UCeQpIWlCkX+O++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747135727; c=relaxed/simple;
	bh=fwhaCgrqKUhtb9uLx2REYodOJyWmMw3CCs2oamNmdiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s8IfJ1uRcYXiZu4Fx84RTnB151WdKCJ0botDoKL05STsW92PkVuGoQqK3wHK//sWc/p/ID5vpH8a4QDcMI37VQrMT4DVVS5NBf/11hYwt7D/eIE09d9CY8T2adGFQqcPH5wJgUWu99wiq9Cm3J0N13EfJoRMXj4p8vc+bi9wSIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hKHiASAC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e730c05ddso49922615ad.2
        for <stable@vger.kernel.org>; Tue, 13 May 2025 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747135723; x=1747740523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YnfYQE3Zzkmn4cLFYP4S5QOVLqzofVO4Vkea4CiOMSk=;
        b=hKHiASACFxoqlJcLqHoHQsgvOtlXWf4PtHSF8skkPbP21RcLYLAmTzU5tldQjTYZNh
         tOGMaS5V3/McDt1gG8tUpYadJchF2j2tupgESgiA6+MLD+9bcLEESuHVnXKORqhFjXcL
         oOjE/n0Q/kfVcdO/8k5cfnEn9LhMJA4eAANdClRjkR2f8aQtq/g1LSK/PaXRdvfdQU86
         yLv3OvUUST/ix9rFxmZAeaDXFWCXdi191Y5sIu9dtAHS2UOw0VSPXYkh7DYc+a8GleP3
         Z8lh9kaJG8caCcG8qke56vr6Rv1dzT2zD83E/GE+tnc3VfrFlXhBr8aPZGRwd5evCyYD
         1QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747135723; x=1747740523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnfYQE3Zzkmn4cLFYP4S5QOVLqzofVO4Vkea4CiOMSk=;
        b=LuiWA7yy8xx+AWONUxcAMzU2YgE9jQxQHHofgcppSU4dNThKdpepZzyyxWp/RsNObY
         jVoBdEaot6Ua9zYHXLNlpA2VekMbqppY0tl7BtHlnUZOW7TnX/XJWahYFM0FVtQKnhSj
         8ebmcWl10wamTs2fu7vbA6acqtiH/TKPydBzXgNOYgvDt3Ng84GajDmv3oLXktiG6/p2
         Qc0EyfUShVBxA60zP7yblrLaM/ERV+fgaDVO1VHSuigegRoJEIg0Yb4sXVtZZUufWdO6
         AfeefbEBT7SBV3q3JfJ/5Cu4zRCO6Pv8ZgTNHBew6JOE4TbWlCauvhy93mVVv1JjtHWS
         Gh3g==
X-Gm-Message-State: AOJu0YwnjVNxmfXlagtUN/g+jJdfbGovlUxs/nFdMbwIhc3BDZNZznL8
	fGZORIKqYRDw6KVI4KSPBokomif8zVi+sg9BfZh1s/ehJ7FbKgoZySJk446Q3A8=
X-Gm-Gg: ASbGnctzm5lAx1l3u/7tAft3DRPdRDpu9FvCH4YlA2qS5uJcC4AVsaeKYyYSPNnIHhl
	FSNGX7JMXPUB+p5J5TOyqtsoQYsEj5YzmpE2CWblH/OQgLRS4G6ZxCGZ/QCx3obY3KtAfMXpAKC
	6DMoWUtVnkGV6IhLk2T9O9JzeHyluDmz0ftAgO22f+yneRinEO4YIMkPGvP02BioQ4NKyOBwjdN
	G4n1P7Kq9ETuWKyfD6nf7fRCqXwmpusw5gmnLVUcmEeHTHW6GaQAWbNz7ogqSej6gU858DvTYUU
	Z9Pl1+xnhK5s3vJKJM2B8xOJY5A1BhAHpChTzlRFc2iDeLwgsy8zZhnPVCLVpN6N+312caNnq7d
	ufuh2hLafHFM7XlaedrTbvuzV
X-Google-Smtp-Source: AGHT+IE+mQWQ0lt6ZzvshF7Ud3J+CerFVDqOVkcgOj7M0UpHYjaNwfC5nt7wxFukG/1qalTGjR2wFQ==
X-Received: by 2002:a17:902:dacd:b0:220:bcc5:2845 with SMTP id d9443c01a7336-22fc8b0cc67mr218590605ad.7.1747135723582;
        Tue, 13 May 2025 04:28:43 -0700 (PDT)
Received: from HTW5T2C6VL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7742fedsm78665945ad.91.2025.05.13.04.28.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 May 2025 04:28:43 -0700 (PDT)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH 5.15.y] block: fix direct io NOWAIT flag not work
Date: Tue, 13 May 2025 19:28:04 +0800
Message-Id: <20250513112804.18731-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8b44b4d81598 ("block: don't allow multiple bios for IOCB_NOWAIT
issue") backport a upstream fix, but miss commit b77c88c2100c ("block:
pass a block_device and opf to bio_alloc_kiocb"), and introduce this bug.
commit b77c88c2100c ("block: pass a block_device and opf to
bio_alloc_kiocb") have other depend patch, so just fix it.

Fixes: 8b44b4d81598 ("block: don't allow multiple bios for IOCB_NOWAIT issue")
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/fops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 4c8948979921..72da501542f1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -259,7 +259,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				blk_finish_plug(&plug);
 				return -EAGAIN;
 			}
-			bio->bi_opf |= REQ_NOWAIT;
 		}
 
 		if (is_read) {
@@ -270,6 +269,10 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			bio->bi_opf = dio_bio_write_op(iocb);
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
+
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			bio->bi_opf |= REQ_NOWAIT;
+
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
-- 
2.39.2 (Apple Git-143)


