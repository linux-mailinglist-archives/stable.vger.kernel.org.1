Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ADA791CF1
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245165AbjIDSdV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjIDSdT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:33:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7761BB2
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DAA16198C
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B95C433C8;
        Mon,  4 Sep 2023 18:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852395;
        bh=UobcOCVL1N1YccmQE7b18r9BeI/VLVHxGl6GpXdCa/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SoFc0azIK/cs5z86IKsQFloixZtpGx9L/2cAiMkwbn6p7cGArrGUJUPSgvRKxRsZX
         H6l0XmaE0BTKJM1CkLAfM2QHx47CVgJFiK3zsk+y3GYLhb/GmmGWWcdvceTJY55kI8
         aYxNPGrHc5yFalwuTsA6o8sfTNmLczJ33Tj3iikQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+b08315e8cf5a78eed03c@syzkaller.appspotmail.com,
        stable <stable@kernel.org>, Nam Cao <namcaov@gmail.com>
Subject: [PATCH 6.4 17/32] staging: rtl8712: fix race condition
Date:   Mon,  4 Sep 2023 19:30:15 +0100
Message-ID: <20230904182948.691497293@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
References: <20230904182947.899158313@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nam Cao <namcaov@gmail.com>

commit 1422b526fba994cf05fd288a152106563b875fce upstream.

In probe function, request_firmware_nowait() is called to load firmware
asynchronously. At completion of firmware loading, register_netdev() is
called. However, a mutex needed by netdev is initialized after the call
to request_firmware_nowait(). Consequently, it can happen that
register_netdev() is called before the driver is ready.

Move the mutex initialization into r8712_init_drv_sw(), which is called
before request_firmware_nowait().

Reported-by: syzbot+b08315e8cf5a78eed03c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-staging/000000000000d9d4560601b8e0d7@google.com/T/#u
Fixes: 8c213fa59199 ("staging: r8712u: Use asynchronous firmware loading")
Cc: stable <stable@kernel.org>
Signed-off-by: Nam Cao <namcaov@gmail.com>
Link: https://lore.kernel.org/r/20230731110620.116562-1-namcaov@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8712/os_intfs.c |    1 +
 drivers/staging/rtl8712/usb_intf.c |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -327,6 +327,7 @@ int r8712_init_drv_sw(struct _adapter *p
 	mp871xinit(padapter);
 	init_default_value(padapter);
 	r8712_InitSwLeds(padapter);
+	mutex_init(&padapter->mutex_start);
 
 	return 0;
 
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -567,7 +567,6 @@ static int r871xu_drv_init(struct usb_in
 	if (rtl871x_load_fw(padapter))
 		goto deinit_drv_sw;
 	init_completion(&padapter->rx_filter_ready);
-	mutex_init(&padapter->mutex_start);
 	return 0;
 
 deinit_drv_sw:


