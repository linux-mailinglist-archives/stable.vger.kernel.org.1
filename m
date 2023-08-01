Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C1976AED1
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjHAJmQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjHAJmA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D538459DE
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D76261507
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5E1C433C7;
        Tue,  1 Aug 2023 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882774;
        bh=T0PPXgufBph/UaoXC+Qp51QV/sijMBGbEccxd9zQBng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKGAry6X106buxVDjTf6NACezIMA6xMb8yleqQO5CDm3CNqpOXi/uJmubGxE/jsR8
         k6M8TPgLoWqXVXQOdPzgCUwRV+Hf+RmVC6XF8iwce2hPNOd/vbQu3LPcQe/XEtca4F
         +XxQFLUJjFLfdOoiKPo7QMPyS3e9upx3imDj4jn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
        Scott Branden <sbranden@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Brian Norris <briannorris@chromium.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 6.1 226/228] test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation
Date:   Tue,  1 Aug 2023 11:21:24 +0200
Message-ID: <20230801091931.014786810@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

commit 7dae593cd226a0bca61201cf85ceb9335cf63682 upstream.

In a couple of situations like

	name = kstrndup(buf, count, GFP_KERNEL);
	if (!name)
		return -ENOSPC;

the error is not actually "No space left on device", but "Out of memory".

It is semantically correct to return -ENOMEM in all failed kstrndup()
and kzalloc() cases in this driver, as it is not a problem with disk
space, but with kernel memory allocator failing allocation.

The semantically correct should be:

        name = kstrndup(buf, count, GFP_KERNEL);
        if (!name)
                return -ENOMEM;

Cc: Dan Carpenter <error27@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Brian Norris <briannorris@chromium.org>
Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
Fixes: 0a8adf584759c ("test: add firmware_class loader test")
Fixes: 548193cba2a7d ("test_firmware: add support for firmware_request_platform")
Fixes: eb910947c82f9 ("test: firmware_class: add asynchronous request trigger")
Fixes: 061132d2b9c95 ("test_firmware: add test custom fallback trigger")
Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <20230606070808.9300-1-mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_firmware.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -214,7 +214,7 @@ static int __kstrncpy(char **dst, const
 {
 	*dst = kstrndup(name, count, gfp);
 	if (!*dst)
-		return -ENOSPC;
+		return -ENOMEM;
 	return count;
 }
 
@@ -671,7 +671,7 @@ static ssize_t trigger_request_store(str
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -719,7 +719,7 @@ static ssize_t trigger_request_platform_
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("inserting test platform fw '%s'\n", name);
 	efi_embedded_fw.name = name;
@@ -772,7 +772,7 @@ static ssize_t trigger_async_request_sto
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -817,7 +817,7 @@ static ssize_t trigger_custom_fallback_s
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s' using custom fallback mechanism\n", name);
 
@@ -868,7 +868,7 @@ static int test_fw_run_batch_request(voi
 
 		test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
 		if (!test_buf)
-			return -ENOSPC;
+			return -ENOMEM;
 
 		if (test_fw_config->partial)
 			req->rc = request_partial_firmware_into_buf


