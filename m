Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AC479074D
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 12:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351966AbjIBKWm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKWm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 06:22:42 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF8F10FA
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 03:22:39 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-401b5516104so26800025e9.2
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 03:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693650157; x=1694254957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvgTrek8o6c39JOMk/it1QOlaUNhXa2qIFx7TRqmowA=;
        b=La8a9Qc7egMDy6PBum1cPpG64m3QCI5uX7VzsGyNPCjBZX7kjUjCY47LMNiJYAtkjh
         HJ1Kdi65xR6EP0C1o0PqHlnJZ7vJMWXWGDRvdPrB2PMDb4PfsjWEVgNlshjjLkWjO/O8
         fa/OD2PdGSBwOQNIfq4Duz6tkw4PnTrz/RNgL1zCaje421HIU6F9aa0P1jgKOh6WKnE9
         n7X59FQPaDCDIpT3JToXKmWknpquVkSrmTD4DezQDpuVTVsiOLc5k7sT/J1366QI4wsK
         XpzmOAljx7DhnOtejuEm9yD9YIChcjzNaKkynBzcXTyhQ3bJuf9UwhzmkfHoJ2I8pCc2
         0Yjw==
X-Gm-Message-State: AOJu0Yx0AhlDbF6akaYqge6EncXKbVzEjik3GyxK8y7s/Rh8nszL1gm5
        nQdRrPfmlUOHFfWxfg+5Lg/7OAL/hOZRtg==
X-Google-Smtp-Source: AGHT+IHX0yFeJcCilwoYtLdIUOroxaO4DLwZIhMKKXDxp9fyCLXloAJCbckOYv+Ixga8Np43RPEBUQ==
X-Received: by 2002:a05:600c:243:b0:401:4542:5ed8 with SMTP id 3-20020a05600c024300b0040145425ed8mr3788724wmj.0.1693650157157;
        Sat, 02 Sep 2023 03:22:37 -0700 (PDT)
Received: from white.. ([94.204.198.68])
        by smtp.googlemail.com with ESMTPSA id n18-20020a1c7212000000b003fefaf299b6sm7437513wmc.38.2023.09.02.03.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 03:22:36 -0700 (PDT)
From:   "Denis Efremov (Oracle)" <efremov@linux.com>
To:     stable@vger.kernel.org
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
Date:   Sat,  2 Sep 2023 14:21:56 +0400
Message-ID: <20230902102200.24474-1-efremov@linux.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]

In btsdio_probe, the data->work is bound with btsdio_work. It will be
started in btsdio_send_frame.

If the btsdio_remove runs with a unfinished work, there may be a race
condition that hdev is freed but used in btsdio_work. Fix it by
canceling the work before do cleanup in btsdio_remove.

Fixes: CVE-2023-1989
Fixes: ddbaf13e3609 ("[Bluetooth] Add generic driver for Bluetooth SDIO devices")
Cc: stable@vger.kernel.org
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Denis: Added CVE-2023-1989 and fixes tags. ]
Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---

CVE-2023-1989 is 1e9ac114c4428fdb7ff4635b45d4f46017e8916f.
However, the fix was reverted and replaced with 73f7b171b7.
In stable branches we've got only the original fix and its
revert. I'm sending the replacement fix. One can find a
reference to the new fix 73f7b171b7 in the revert commit
db2bf510bd5d.

 drivers/bluetooth/btsdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 795be33f2892..f19d31ee37ea 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -357,6 +357,7 @@ static void btsdio_remove(struct sdio_func *func)
 	if (!data)
 		return;
 
+	cancel_work_sync(&data->work);
 	hdev = data->hdev;
 
 	sdio_set_drvdata(func, NULL);
-- 
2.42.0

