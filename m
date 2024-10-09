Return-Path: <stable+bounces-83135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35402995EBE
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 06:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01F01F25790
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 04:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC2A1547D7;
	Wed,  9 Oct 2024 04:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lHQn7gpz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A338DD3
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 04:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728449512; cv=none; b=t1kuf9PvDfhmjYPygfrxhDBRwe02HBc4NgGtrwejR/h59icj6mCH6aQdi/vLFeVspOoN8zQ0yDMbbhh+nIMY63H0ym6jWvqiaSOl+WNUPGGeYi9sQSn/rnYGV/yEDqLte1SBk/6qis4qYFuBbw4oAm8fBFGGqEhiwlKmMJNe5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728449512; c=relaxed/simple;
	bh=teltDqujW+3qHjfFE3DtofGiqCjnPIk9gncYNTvQdqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B36uRLqUkFUW09sj+C+GvfIl+sORH6MdSLb55nT8D/9At0PSg94tVXPAx0HZUcEWgaFhxtGPCMo1/H0BSRJvVNS+vW6uhanEEn1Y9EMMIFrvo1SLvIEbQ9CH2UDzyEgG4wLQebmLVa5ZAFreaYPr5DHZs7Gb6YXgeVD1ijxuAjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lHQn7gpz; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-710daaadd9bso3558029a34.2
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 21:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728449509; x=1729054309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJKEXKH5TAcRJpR+aDvOxAmg6X7WyjnAGUbW1+jsH78=;
        b=lHQn7gpzAobWby+dnUnyuH3km95QE2WFHWly032P4BQWKP4KtzWnRtRzsTIsvNf2Gr
         7VVObmW0NNcWeKD8+f5m2H1lpsav7CZwxnJv0Y7sA8YA9BNMlx2v7lvzEYvZFqpETRQI
         4KxDYWG5x7lNTqkRQ/UjvA7EjjcmbK5OSP69M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728449509; x=1729054309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJKEXKH5TAcRJpR+aDvOxAmg6X7WyjnAGUbW1+jsH78=;
        b=qXb+1ZIXlk9kohf9Y3SqfibDTDeaAbYZj17HeqV1YjZ8BTA2l3lLNclQU+Iecmfhc8
         yEjMcVoiRZUaKFSfpR1WHCnjfcj1XIB5Spiezd7HGZ1UmTVeY/qferyBQrq8tReiPIYR
         VbA5I0N0qJNsH00ab3+nfSv2aZITS8WpQ59FhcbrtSYQVllGXvjDxRxEbq86xrbCQwwL
         +HtzbSuKCGHYB93Q9mrr+aIusgt16G9LyaVUu53zwnsYxB8rOknkGH5jaDs4Fml2DuQE
         JzGFB8p+eO23zFQt84JYsdUdnoWYPGOtat6JkutImJJqRtJ5dzJs4VqVGqdhEmg8aVik
         TRNQ==
X-Gm-Message-State: AOJu0Yxz6nUzTgg89Zuh/tQ08YY7lL17+vRV1OuaC0wPXFP8NIA13Yig
	Hk42hsv4bnbmMiILieCAC2Zu2C44mOfAviHi6CvfBtJy+D9BvfQk+bswdX02r0oy1NSbpscn+Nc
	xQA==
X-Google-Smtp-Source: AGHT+IFFtxTZNarRAiQ7yj6Y9o7VRH+9nWVLkX1NwT4JJTh+P3IAMhr6EqBG9L8+tE/+k4GWSew/sQ==
X-Received: by 2002:a05:6830:d17:b0:710:f375:a6c9 with SMTP id 46e09a7af769-716a41c0672mr1105710a34.7.1728449509433;
        Tue, 08 Oct 2024 21:51:49 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7cab:8c3d:935:cbd2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c49803sm7667123a12.79.2024.10.08.21.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 21:51:49 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y 2/2] zram: don't free statically defined names
Date: Wed,  9 Oct 2024 13:51:40 +0900
Message-ID: <20241009045140.840702-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241009045140.840702-1-senozhatsky@chromium.org>
References: <2024100724-used-ventricle-7559@gregkh>
 <20241009045140.840702-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrey Skvortsov <andrej.skvortzov@gmail.com>

When CONFIG_ZRAM_MULTI_COMP isn't set ZRAM_SECONDARY_COMP can hold
default_compressor, because it's the same offset as ZRAM_PRIMARY_COMP, so
we need to make sure that we don't attempt to kfree() the statically
defined compressor name.

This is detected by KASAN.

==================================================================
  Call trace:
   kfree+0x60/0x3a0
   zram_destroy_comps+0x98/0x198 [zram]
   zram_reset_device+0x22c/0x4a8 [zram]
   reset_store+0x1bc/0x2d8 [zram]
   dev_attr_store+0x44/0x80
   sysfs_kf_write+0xfc/0x188
   kernfs_fop_write_iter+0x28c/0x428
   vfs_write+0x4dc/0x9b8
   ksys_write+0x100/0x1f8
   __arm64_sys_write+0x74/0xb8
   invoke_syscall+0xd8/0x260
   el0_svc_common.constprop.0+0xb4/0x240
   do_el0_svc+0x48/0x68
   el0_svc+0x40/0xc8
   el0t_64_sync_handler+0x120/0x130
   el0t_64_sync+0x190/0x198
==================================================================

Link: https://lkml.kernel.org/r/20240923164843.1117010-1-andrej.skvortzov@gmail.com
Fixes: 684826f8271a ("zram: free secondary algorithms names")
Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Closes: https://lore.kernel.org/lkml/57130e48-dbb6-4047-a8c7-ebf5aaea93f4@linux.vnet.ibm.com/
Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Chris Li <chrisl@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 486fd58af7ac1098b68370b1d4d9f94a2a1c7124)
---
 drivers/block/zram/zram_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index db729035fd6b..606f388c7a57 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1984,8 +1984,10 @@ static void zram_destroy_comps(struct zram *zram)
 		zram->num_active_comps--;
 	}
 
-	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
-		kfree(zram->comp_algs[prio]);
+	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
+		/* Do not free statically defined compression algorithms */
+		if (zram->comp_algs[prio] != default_compressor)
+			kfree(zram->comp_algs[prio]);
 		zram->comp_algs[prio] = NULL;
 	}
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog


