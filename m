Return-Path: <stable+bounces-83133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7095A995EB3
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 06:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3010285A4F
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 04:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB50114D6F9;
	Wed,  9 Oct 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OpLl5kU+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69238DD3
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728449210; cv=none; b=q7dsi3Z/zE73cn8kXbzNDxPFY6WvnbVo6JoUTmR06YXm1qKZIf0Wl1EFz5oD2dQOY8hskeJAzIpCBbvXDhWY1OuPypI+3tgqu7pOsRosG56cZxoVaRiljHLlWVxH/D+FgkH05EUvC1oEsyFAtJUoShCsL1ozRZ61+usCKaxweak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728449210; c=relaxed/simple;
	bh=w+U0/fG2B2gTpDuF8Q179wN3q3l52ihkXoISQspFpW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7QBv9rV+fwW62p3dMKx4aksDGJAhmBji0mDVLsEFZ6wqiGiiaPRygwJuFfcMvCjPIKDVYdaV4sYNW+nIOxUu7NTaTXKvx5yePJJiUpxuplcNygn2xxioevLnDm6ZwS6jdHmBGBqpzF+d6/BigcjP3+0VPT/oPDJlkLhN7AlyoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OpLl5kU+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so1839951a12.3
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 21:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728449208; x=1729054008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y75CHsS4MU3JtnQdqV4HkUdftUiCQLlkXKpQIaSQFCA=;
        b=OpLl5kU+Yd4/QBI1nA+tXZ+1kAauv1DwVJey44NAh9vNDSkZX2pQlxNUR9b0NdZxut
         EjYSlXrQoII4SODZeCKHqm9UxnOP15yBvxyKbAK5sqMJPqUDCZX9eeqzP8aEAn3ADC+T
         pxzRAjNVtnhVHEdEkFKasRnodRzfAXeDUasYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728449208; x=1729054008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y75CHsS4MU3JtnQdqV4HkUdftUiCQLlkXKpQIaSQFCA=;
        b=a+xCk5HZiOLKsvzrn4OAkC5YLKna9emMfE31I3D69hH9tXojcghZxNdT81VxrRsHaR
         e4JZVBG2kRrVM6Rwm4uwk7UU7V6xGhio37At+WnjqrH+N3Y+dx5RAClOdGEOXRMT3DUG
         cXlz9yp/XHkJVGn0Z6dplGdk0Lz95GRk6HvDNwY76FxnWfBmwqaxu8XcRKBoyamxEppe
         Q1EVIZJkOlnnDD+4fDiOnysebKckc6ct9NhQ5rRrdmIv59/JVL7R55UjcnMPQHaWDRDY
         NlBvS+qZavJZM3209Ihw7awSSgj/R+lke1+p6ff7pIjBaW4G1P77p35pnEQIKxgAFo81
         oNvw==
X-Gm-Message-State: AOJu0Yz+f6xOPemUJWCZtKGpDzfm0khK8rOhWeMR8gV5NRsozopBT8jS
	AZ6+PLdwFPrjP9DOVTpxzSzEt+6n0cJDOkLEHnDZVvebhP6osStdLok+WxT+f+Ws7xWHOPb6WPA
	L+g==
X-Google-Smtp-Source: AGHT+IFz/ebEvYvUCaualmlbsV9cKaUoaNXrP8hrsDcwP08k7Kfr43G4kUGt+PEVEWs2Wb5/FS+4tg==
X-Received: by 2002:a17:90a:688f:b0:2e2:66ac:43f0 with SMTP id 98e67ed59e1d1-2e2a2471f7cmr1477756a91.19.1728449208123;
        Tue, 08 Oct 2024 21:46:48 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7cab:8c3d:935:cbd2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5aaad8bsm529187a91.38.2024.10.08.21.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 21:46:47 -0700 (PDT)
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
Subject: [PATCH 6.11.y 2/2] zram: don't free statically defined names
Date: Wed,  9 Oct 2024 13:46:39 +0900
Message-ID: <20241009044639.812634-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241009044639.812634-1-senozhatsky@chromium.org>
References: <2024100723-syndrome-yeast-a812@gregkh>
 <20241009044639.812634-1-senozhatsky@chromium.org>
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
index 1a875ac43d56..f25b1670e91c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1990,8 +1990,10 @@ static void zram_destroy_comps(struct zram *zram)
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


