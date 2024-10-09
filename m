Return-Path: <stable+bounces-83131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B92995EAD
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 06:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CCA1F25D66
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 04:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7451531E8;
	Wed,  9 Oct 2024 04:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b1fAfRoU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179363C24
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 04:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728448931; cv=none; b=TmoLTz3CpLk8Oigbq6GFdV7d5M/8FHqHzxlbsLywwaI3UiAKh1neoFJYGtd+Lj6qotMljVLkRiSBgjCZmATTAFSCg6YY3HlNrzlryvZTMfSpKD3aqk8jyvk8QStd7Z8jrPXWee2gi5nrPdf8eYEJWpMrqGhHqIoEcEM/rCNr17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728448931; c=relaxed/simple;
	bh=pBeUssTQ27Zjp1ibzmROn1YzoH0GVxbFTr+bGRaWSNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIcwdeTW6bSRG12os0doKJciTL111mc98V59PVLFSp7M7xE9PozZ7Vikg62okVZurVsR1C8LWnjBCBATRR6b3c509tF1tsP5LrtZvbdWDAWK+5p01VbDLWrXr7t5aGFcxJ2kNCm40Wd9/ePxjsjbATVkU1oyw+EA0fxfr86wwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b1fAfRoU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db908c9c83so4049031a12.2
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 21:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728448929; x=1729053729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upYuitS7cZOPxZtYqHlHn3WDOGi5+kmSybwmYBzV+cs=;
        b=b1fAfRoUQGPGtpOSLMowAOVFBZUGmob84Fh0zRFeDX9H9tU1HEA9q1qHhf7b7GigZU
         W9eBx8UfVV2s9Wn5iayMEC0G2IW/QA9eSsKLTps1EvD7CtZaS02Ifq4jEp0HCkIFHR6k
         egrqHT9Ciq7mNNGJ2rWN+/RJ2MH9DOkYi9GWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728448929; x=1729053729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upYuitS7cZOPxZtYqHlHn3WDOGi5+kmSybwmYBzV+cs=;
        b=LhtmelYxj+wExZtsK0o+wvS8N2SzjADtRy4FRWpUro0t6iWEXDayL33MZgYcFKPrTS
         xZwdyIF2LOcCE8bcoLZoHaMGsnpg24j3xMx2uMiuA1TlA0hnlHujjoCHa97zv9lSmn3Y
         /Xv/TvLPkJ5m4acvhDOZ9iKOYhigFnIOshPvvfh15A+24heDnxDFVr0oVrEbh4dRfA4r
         qCNg+79VbJ8s5Ov0a8XoTgtr9ehJ2AhHg/kuF/D6UIvMvpu7tzdT/Uz1nLKh4jviLuLL
         WwWiK+SSYvAT80tR3j3fUaz5gPWFSTsXnvxvmnBNOxfMI7iVlwsB/IrMwQjKwKQCRK/F
         Lm7A==
X-Gm-Message-State: AOJu0YwErgDVtrz66gr/bWddzbYlQKIwvXlU+sCyOMzsdMKC99fsqZRo
	iRaoghGK4Hz3tuNByN/kuUwqz+eYCB1pv/ACVQxCyGHwQue+lxNag55Kh8t80wh1vJ8PewouJT/
	KuA==
X-Google-Smtp-Source: AGHT+IEHpwV4G6imNeQ5i/GYr52A4VHd84J1zbRnlaPJYP16JDH6wUH1jNSY7j8egfsNzJNkax3qCw==
X-Received: by 2002:a05:6a21:3944:b0:1d8:a3ab:7212 with SMTP id adf61e73a8af0-1d8a3bca7b3mr2341603637.2.1728448929102;
        Tue, 08 Oct 2024 21:42:09 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7cab:8c3d:935:cbd2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c37515sm6517801a12.75.2024.10.08.21.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 21:42:08 -0700 (PDT)
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
Subject: [PATCH 6.10.y 2/2] zram: don't free statically defined names
Date: Wed,  9 Oct 2024 13:41:57 +0900
Message-ID: <20241009044157.784907-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241009044157.784907-1-senozhatsky@chromium.org>
References: <2024100723-covenant-chef-b766@gregkh>
 <20241009044157.784907-1-senozhatsky@chromium.org>
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
index f66c03ebba74..668db3a995da 100644
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


