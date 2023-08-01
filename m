Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733D476AED4
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjHAJmY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjHAJmG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4638B55A6
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA303614FF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DD3C433C7;
        Tue,  1 Aug 2023 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882782;
        bh=sOhTtpSTGO4zvMRThBKUmr/OrBRzO1KuEy8ktvG9A5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryE0XmuyNZGq1BxUip7BuOc2GVl88HNRd9ZkkLdAvHYCYPJUIca+1fN02UbRxyMmr
         wVU1MEv6trt+vjrLDb46YY7EBSdl1o4b0hSE5G2rkUEhd2S4bcogjxN48TbHDFlRzi
         tEBWlPaE7aYo3IhY6lbcUb0vqa8fe011t7FHP6xE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 207/228] s390/dasd: print copy pair message only for the correct error
Date:   Tue,  1 Aug 2023 11:21:05 +0200
Message-ID: <20230801091930.345676883@linuxfoundation.org>
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

From: Stefan Haberland <sth@linux.ibm.com>

commit 856d8e3c633b183df23549ce760ae84478a7098d upstream.

The DASD driver has certain types of requests that might be rejected by
the storage server or z/VM because they are not supported. Since the
missing support of the command is not a real issue there is no user
visible kernel error message for this.

For copy pair setups  there is a specific error that IO is not allowed on
secondary devices. This error case is explicitly handled and an error
message is printed.

The code checking for the error did use a bitwise 'and' that is used to
check for specific bits. But in this case the whole sense byte has to
match.

This leads to the problem that the copy pair related error message is
erroneously printed for other error cases that are usually not reported.
This might heavily confuse users and lead to follow on actions that might
disrupt application processing.

Fix by checking the sense byte for the exact value and not single bits.

Cc: stable@vger.kernel.org # 6.1+
Fixes: 1fca631a1185 ("s390/dasd: suppress generic error messages for PPRC secondary devices")
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Link: https://lore.kernel.org/r/20230721193647.3889634-5-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_3990_erp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 91e9a17b848e..89957bb7244d 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -1050,7 +1050,7 @@ dasd_3990_erp_com_rej(struct dasd_ccw_req * erp, char *sense)
 		dev_err(&device->cdev->dev, "An I/O request was rejected"
 			" because writing is inhibited\n");
 		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
-	} else if (sense[7] & SNS7_INVALID_ON_SEC) {
+	} else if (sense[7] == SNS7_INVALID_ON_SEC) {
 		dev_err(&device->cdev->dev, "An I/O request was rejected on a copy pair secondary device\n");
 		/* suppress dump of sense data for this error */
 		set_bit(DASD_CQR_SUPPRESS_CR, &erp->refers->flags);
-- 
2.41.0



