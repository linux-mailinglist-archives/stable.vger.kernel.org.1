Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100B6775AB8
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjHILLB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjHILLA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:11:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAB21724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EDC2630F0
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851C6C433C7;
        Wed,  9 Aug 2023 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579458;
        bh=m9VBjD3Z7qdh+iqBDlEIqV3q/m93UW91yy+tKPkNG/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ub+k1OBGh/nZ2gGvfUHV6itNcMSwj1PkPi7Z2bhMoyrT/1P7rYq9UzoxYzee9fcB7
         INOEDIVeJJR5U1jAKqugGzS64F5sdAvJ+kplDoVwjaPSrpk+BY+xEFEuHwzjZoCi9A
         ysadnvrYngoEUIwmKHdaARc6Kg1rQZcoBXFko1bw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 174/204] s390/dasd: fix hanging device after quiesce/resume
Date:   Wed,  9 Aug 2023 12:41:52 +0200
Message-ID: <20230809103648.340945719@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stefan Haberland <sth@linux.ibm.com>

commit 05f1d8ed03f547054efbc4d29bb7991c958ede95 upstream.

Quiesce and resume are functions that tell the DASD driver to stop/resume
issuing I/Os to a specific DASD.

On resume dasd_schedule_block_bh() is called to kick handling of IO
requests again. This does unfortunately not cover internal requests which
are used for path verification for example.

This could lead to a hanging device when a path event or anything else
that triggers internal requests occurs on a quiesced device.

Fix by also calling dasd_schedule_device_bh() which triggers handling of
internal requests on resume.

Fixes: 8e09f21574ea ("[S390] dasd: add hyper PAV support to DASD device driver, part 1")

Cc: stable@vger.kernel.org
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Link: https://lore.kernel.org/r/20230721193647.3889634-2-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_ioctl.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -138,6 +138,7 @@ static int dasd_ioctl_resume(struct dasd
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 	dasd_schedule_block_bh(block);
+	dasd_schedule_device_bh(base);
 	return 0;
 }
 


