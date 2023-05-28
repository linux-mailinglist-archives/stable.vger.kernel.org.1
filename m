Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB9B713C1B
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjE1TEq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjE1TEn (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 28 May 2023 15:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2238C4
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 12:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E5560F7E
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 19:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94546C433D2;
        Sun, 28 May 2023 19:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300681;
        bh=MMLFx6Ea5VLVavqczOH5el9rjkzBQp70cCXDk8k8TR0=;
        h=Subject:To:From:Date:From;
        b=HimTOVb9/RFCNSjpzGPjzCCWkWVAlFtAdNRiKygfOwOKXRG82Wi7afCZaA+/3Ia1R
         rXTTiSc8tM7loo3YWfwEfC2HNMliCS7IDJUI0j4qRV+OBASb5NsY9HlwtuWbPC3hrg
         NqpGma5El2gTiwp1ebTKNZgYIRz9NFPMfTqKp4jA=
Subject: patch "iio: tmag5273: Fix runtime PM leak on measurement error" added to char-misc-linus
To:     lars@metafoo.de, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, gerald.loacker@wolfvision.net,
        nuno.sa@analog.com
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:32 +0100
Message-ID: <2023052832-pants-ramrod-323f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: tmag5273: Fix runtime PM leak on measurement error

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 265c82ea8b172129cb6d4eff41af856c3aff6168 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 13 Apr 2023 18:37:52 -0700
Subject: iio: tmag5273: Fix runtime PM leak on measurement error

The tmag5273 gets a runtime PM reference before reading a measurement and
releases it when done. But if the measurement fails the tmag5273_read_raw()
function exits before releasing the reference.

Make sure that this error path also releases the runtime PM reference.

Fixes: 866a1389174b ("iio: magnetometer: add ti tmag5273 driver")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Gerald Loacker <gerald.loacker@wolfvision.net>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20230414013752.498767-1-lars@metafoo.de
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/tmag5273.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index 28bb7efe8df8..e155a75b3cd2 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -296,12 +296,13 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = tmag5273_get_measure(data, &t, &x, &y, &z, &angle, &magnitude);
-		if (ret)
-			return ret;
 
 		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
 
+		if (ret)
+			return ret;
+
 		switch (chan->address) {
 		case TEMPERATURE:
 			*val = t;
-- 
2.40.1


