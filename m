Return-Path: <stable+bounces-108238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E07A09E26
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 23:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB753AD608
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 22:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0062236FE;
	Fri, 10 Jan 2025 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="OGE+dK/g";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Vvjyu5g6"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53834206F3E
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548435; cv=none; b=iQXr42XdpVRtnJlTHE6vqh6F7zkWu0ysRao4Vt5cl5YYW4EA0MH0mmIy8GxksXT/8Ys25l0DT8KsqiolU4SV+dX5wX/rqt+ROHa2MDgxSEJaZTljr3Y0GVWMw/ezLpeWGqO1tZnBqfZyzVqUkVxX8BYhBmZlQLQgAltriwXCixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548435; c=relaxed/simple;
	bh=LUxzOfye5x4+wKTe4Y5fcv7stlpWOTaOzJfwW5wdOQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttHjt740LdlDQ6Y9DqSvUyJ7SklzBr1A6URidbhDuP7JnQzHsMptK0JqPThzdBycs1IP/M47BGLvRCzGZIZFGQme92e9WokTKAkZ59dE3Qo/rcmUCPcs4Fs+pdt7NAht98Mgd0nRnwoOpAi3ak97HTyS0VC1gUd+FrMrKlSr31M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=OGE+dK/g; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Vvjyu5g6; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1736548432;
	bh=LUxzOfye5x4+wKTe4Y5fcv7stlpWOTaOzJfwW5wdOQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OGE+dK/gLQ8bUYJ6fWxqjyJxNcwPV9wZWYBx6jVLPj+Y1h6xdBqeyWUW/EtX8b3Rz
	 QgF6JpHsr2t4nFQeaydt68aKOFcjbWNFfIr4rL0LfXPFT+S1bPVsSb6qHGl3Xdda5I
	 Xuo7wkSgjl3OqlaO3P+haOeVtL+IQC34QC5Y5/IYOc1zTA5QEpAN0RyZV0wny/1+Yg
	 R+ondOPH0cWw7Fq89wJwudmpD49E/dIRqSXEs7ZGqFi7bO0AhXHiDQEyEBbP8hkOsc
	 ZRT2cSLhi0BXCd0OpdiZ564trxrKNCXjtlB9++xAEY5Y8q1p8bnfMxblnpPKPL19Jd
	 lJ/HKle0gvpLQ==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 2EF8731A
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 07:33:52 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=Vvjyu5g6;
	dkim-atps=neutral
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 0F36431A
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 07:33:52 +0900 (JST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-468f80bc82fso50318741cf.1
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 14:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1736548430; x=1737153230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvgg6kua1P9/v2m+A88TQ+0zCQUUbkXF3mftz77zLjs=;
        b=Vvjyu5g6Ml0+88nEE0WT9M2jP/u6ZsVYhNuQu7tPr/yGlAoDfO9ps1FxZb0fftv9du
         PnqHoUDAeSlde27uMW+g+092SyV0n8WSyJXzmEn9IX8t20NSz2MKeNhf4WCSt0I8G0qV
         PQfAuuviLkUPOguRHw9P13+S2HYjbOwqSC8YCqOFttjOTpvCvCqh30pQBp0D+nXRtEzj
         WrwFOjI2kh+DIQVKLjLT95ZBiyUg8HairWf7VZiPaZt4aA9UiI+6lnvT0PTMkYQuFdcq
         HNU9vcQihDLUCiUthcaEj2IN4bQunrVPFlg4KW4NwA2eLvkzgAzpi3n0ep7KcCDqjKno
         djaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736548430; x=1737153230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvgg6kua1P9/v2m+A88TQ+0zCQUUbkXF3mftz77zLjs=;
        b=oBENV6MbtKLAAprk2ATowaJobeqMFLKrqL+lpUap9IG9CUrcK/ptMrxIKaq2o0AFie
         rEDRlVPinIqMpskAbRGEeuoXF4S+9L3vo4TUo+ghCNCslPWHwfpXrs9degWEE9DnysAO
         nZ/D5ZFTp3OprbSris2qxgv+en7phk2tm4AuR0iLtuVDvZxx/R4uw5r4UkIO2uUxKw46
         fznYVFNyw7E7tgrpb9Emz3LUxjDnHWyDpsRs+vpTEZYgzL7eOYOSbx7wJ8eC66VmUM1z
         hCAeKbjuzR7WeLEdlXkDVX8ZXN2VCOJ7IkOAMcomgkFv7yYcfVe8oTM6uD/wyR9VuvMX
         REmQ==
X-Gm-Message-State: AOJu0Yy7h2DxmdHJXYeySRLq+B3SJtoO/+AXUPm7SR1nEmSbs8PxGFbL
	QnEDEgBBd6QPKcHD358i5dab+V5pgDYxjl6/SAH7jAyoik5dHuVK2zr0k4aQF8+4pKvb9dlwTZY
	n5W3oEj28zQZcOp2ZPMQb8ywwMeui9TpyEyw/nQUV7qClk+e60/0jHZE=
X-Gm-Gg: ASbGncvz/F67BrdIAPqdhH89G1e1DO59MeptdqzgrBuOieRZMD9tNPwigCyIczlOB0C
	6+qC9Zl6nJFbpbUzw/k7qX6NfZLaXazWgbxYm6dwVxNbjhprEPlJi0bbjAmMyqEnf51One6mE/e
	QbqobirOuQI7tNFh8KbOh/In2zikbn4LdjItyygS8bhsJ0lJvOOZsTxPNyMKlR9rEjgz3SUN7QA
	5T2+upKvwKLwTAdwWdDK22rSzFI07yPAMADsUDJe5RVTuYz+Eo+4djJZDYroJWPBrCUcpRpj8hr
	n/des61hLrPe5t+0SVvPNm4fppM/v4vqJ2iHUF48
X-Received: by 2002:a17:903:2451:b0:215:b74c:d7ad with SMTP id d9443c01a7336-21a83fc389cmr162419805ad.36.1736495938927;
        Thu, 09 Jan 2025 23:58:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg7Gtw4+nNFW63rrEUhcY+NXQezUOEG7/RFzXqlN5bHknlqW0CU5RJ/lr3mFFQuF1ETMLkmg==
X-Received: by 2002:a17:903:2451:b0:215:b74c:d7ad with SMTP id d9443c01a7336-21a83fc389cmr162419585ad.36.1736495938615;
        Thu, 09 Jan 2025 23:58:58 -0800 (PST)
Received: from localhost (103.131.189.35.bc.googleusercontent.com. [35.189.131.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219e38sm8884685ad.136.2025.01.09.23.58.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2025 23:58:58 -0800 (PST)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	Desheng Wu <deshengwu@tencent.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 5.15 3/3] zram: fix uninitialized ZRAM not releasing backing device
Date: Fri, 10 Jan 2025 16:58:44 +0900
Message-Id: <20250110075844.1173719-4-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110075844.1173719-1-dominique.martinet@atmark-techno.com>
References: <20250110075844.1173719-1-dominique.martinet@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

[ Upstream commit 74363ec674cb172d8856de25776c8f3103f05e2f ]

Setting backing device is done before ZRAM initialization.  If we set the
backing device, then remove the ZRAM module without initializing the
device, the backing device reference will be leaked and the device will be
hold forever.

Fix this by always reset the ZRAM fully on rmmod or reset store.

Link: https://lkml.kernel.org/r/20241209165717.94215-3-ryncsn@gmail.com
Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
Signed-off-by: Kairui Song <kasong@tencent.com>
Reported-by: Desheng Wu <deshengwu@tencent.com>
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
 drivers/block/zram/zram_drv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e5626303c8ff..4e008cd0ef65 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1150,12 +1150,16 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 	size_t num_pages = disksize >> PAGE_SHIFT;
 	size_t index;
 
+	if (!zram->table)
+		return;
+
 	/* Free all pages that are still in this zram device */
 	for (index = 0; index < num_pages; index++)
 		zram_free_page(zram, index);
 
 	zs_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
+	zram->table = NULL;
 }
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
@@ -1699,11 +1703,6 @@ static void zram_reset_device(struct zram *zram)
 
 	zram->limit_pages = 0;
 
-	if (!init_done(zram)) {
-		up_write(&zram->init_lock);
-		return;
-	}
-
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 
-- 
2.39.5



