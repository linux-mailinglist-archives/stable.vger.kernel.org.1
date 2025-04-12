Return-Path: <stable+bounces-132318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D701A86C7D
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 12:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AE27AE2EE
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 10:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522851A83FF;
	Sat, 12 Apr 2025 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3y+UE1B"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103338DE1
	for <stable@vger.kernel.org>; Sat, 12 Apr 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744453471; cv=none; b=ciEes4seuczsDR8UHZZL75yiHlMbolXaiyhHv0xatD4g8T82h4gzuHFfN5aDUAnc6foMakTk8KYsXdV029lDlA+iAPZMDCdYyySqfM8LO7e1QylZcZvARpluAKxJ6xcB5Mvaiyvpzt03/pmOzkLYjHZ5JwE6P7TxfaTuWdS9ZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744453471; c=relaxed/simple;
	bh=zGxP8/J5ZMGlrPsNNvJTPNIrAD1C7brVDquRKFVc/RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aaVTjUBqIjkq+QHkwxX2LYBhsyVhtHs2mSHdxf/dVpCBa5KE2/1Q8ZNCvqLC51oE5+xetV7AUej76mUvhU74GmqIFLNI+jTShm02HsZjy4n39mKRsniUkVQAhOWscTsuLPkFbi48UlwHRng25QTU+w/mtwU0K6dAHFpCMmtoTOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3y+UE1B; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d16a01deaso2744825e9.2
        for <stable@vger.kernel.org>; Sat, 12 Apr 2025 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744453467; x=1745058267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h+d+iPHK3cZsOyFk1upo1QwOO2Nl34rv+3enP6J2puQ=;
        b=c3y+UE1B3V5bfRMxUYzOxkAxdiMVfXvDhW1dKh2hdIHXe3exTiQNhqZ4IpEZw/fC+A
         AD3QAOjHcNEWvwFvynlaOgZEnjO3L/pB+L56g2S4WXpNBo/AzcY4xx96hqq8Tk3JMHuf
         NWV6hgt6utob7no6d/dxmZgNi+F/r6CEJpJhf8t/EiZvi96Dt+lmimvmtEWvu8w+0i9m
         3UjNHgDdIJbDCtH5RQYXrJqHB9PJQALcPhIbXSa2QKXU8yaF3LTtdTcWtWapkTtl1PdO
         0xoZDvZjIvbl9dltF+7/pa7866IXlGdQb8PWsN/s1yo6gz3pBa3LO2xppkPN0/7iVpzL
         DmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744453467; x=1745058267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+d+iPHK3cZsOyFk1upo1QwOO2Nl34rv+3enP6J2puQ=;
        b=QxsrJnDIGxuaS6+u4mQyeLPJts+5QBi98qPFoixZgXqVBN0jxoHiNuR3wrdxy3korc
         2a4girQ1+fYJyCLgYebyPmkfqluE0frtgop2aWqWKSvVe9MEO7oEKbdhgRrKAxTZaqMy
         ipn/wNI979wFyFHdy3w8SvrVhnydunK2iCva+M0mvQTnhQ5sdoE1tSI27I7vXM4wle7D
         PGUVXzxFKYm5ZGbU0nUMP786r2ZyaNJkg5FjeFmgtwtxWg+qpmyq1sKuM2igR4aS3s1r
         UdpIMNhxq4KcD0u0vZeCL5SoiMLHg0Q7WWEUGzDCrj7N7VVNqSsghDz34tOOagICfWQm
         tFKw==
X-Gm-Message-State: AOJu0YyqgVGWABd3PdxkrWxdbOmaHDGe11Eeg7Am5LaMJUOUMk/CLJg6
	dmsWoH/Y4TVmBamO1R4zpJiwYEO+fBP05tb5qSWeCLgApOA7jk/znWdyEqemFws=
X-Gm-Gg: ASbGncu8aUHDLQrvgINCUu/oGXMcrh9jhBSQT6+bVYxR87/fGGSV2XXs0pqMthzol+4
	3BMGchfFfp+1NorXcva0o2siaIKUMqkF7puZePQBDi9IGBhYYedpOdebvXGlt4VJzL4zQQwqcex
	baHRatKtamCQlIdeRcwWxiTbc8rJfPvMcS8Nc7wTrHAsDGeIzWHgeTLYDnyE+JrUe0Jtd99xAQO
	rHry6uVw3HE0fMLnllHXhruPe5ZOm1HqSZ1x/ehaXZVboGMRCssjm6iCNQU7SlmDXcPwUBhCzQU
	ofAm/WzLD9ZP6lZr3cmh32iA6kV8VZXx3KO0dI7hTlTQ7KMWZtqN4D72fuK5yCYRpMcoxJvo481
	Nverk/58acWCFdO81PmQ=
X-Google-Smtp-Source: AGHT+IHzN9oKFzGv9O2OJywLd/UwJEnpovF5g0wmoIWFntPlNASw3Bb5psj6W/5L8d5zyDfsvURE5Q==
X-Received: by 2002:a05:600c:1d08:b0:43d:745a:5a49 with SMTP id 5b1f17b1804b1-43f3a9ab215mr20137365e9.4.1744453466914;
        Sat, 12 Apr 2025 03:24:26 -0700 (PDT)
Received: from pop-os.localdomain (207.41.221.87.dynamic.jazztel.es. [87.221.41.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f208e96dasm82406075e9.0.2025.04.12.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 03:24:26 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Christoph Hellwig <hch@lst.de>,
	syzbot+2aca91e1d3ae43aef10c@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH 6.1.y] block: make bio_check_eod work for zero sized devices
Date: Sat, 12 Apr 2025 12:24:24 +0200
Message-Id: <20250412102424.56383-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

commit 3eb96946f0be6bf447cbdf219aba22bc42672f92 upstream.

This patch is a backport.

Since the dawn of time bio_check_eod has a check for a non-zero size of
the device.  This doesn't really make any sense as we never want to send
I/O to a device that's been set to zero size, or never moved out of that.

I am a bit surprised we haven't caught this for a long time, but the
removal of the extra validation inside of zram caused syzbot to trip
over this issue recently.  I've added a Fixes tag for that commit, but
the issue really goes back way before git history.

Fixes: 9fe95babc742 ("zram: remove valid_io_request")
Reported-by: syzbot+2aca91e1d3ae43aef10c@syzkaller.appspotmail.com
Bug: https://syzkaller.appspot.com/bug?extid=2aca91e1d3ae43aef10c
Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230524060538.1593686-1-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit 3eb96946f0be6bf447cbdf219aba22bc42672f92)
Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 94941e3ce219..6a66f4f6912f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -515,7 +515,7 @@ static inline int bio_check_eod(struct bio *bio)
 	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
 	unsigned int nr_sectors = bio_sectors(bio);
 
-	if (nr_sectors && maxsector &&
+	if (nr_sectors &&
 	    (nr_sectors > maxsector ||
 	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
 		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
-- 
2.34.1


