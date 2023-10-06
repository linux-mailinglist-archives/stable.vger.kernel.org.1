Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E050D7BBB14
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjJFPBe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 11:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjJFPBc (ORCPT
        <rfc822;Stable@vger.kernel.org>); Fri, 6 Oct 2023 11:01:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C273DB
        for <Stable@vger.kernel.org>; Fri,  6 Oct 2023 08:01:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257A7C433C7;
        Fri,  6 Oct 2023 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696604489;
        bh=770lKBY1vQMjE1CYzgnje2rddkVvqTiRBR3r8iFQKPU=;
        h=Subject:To:From:Date:From;
        b=Jg52Mhhqz0+wqzYNVUfuoVqMqEcvd66PFHtq/MOVT2qAn7X9UhsSzj0smXtCi2DTh
         bcovu3Mtpiq2l+S1r0kmmu7lxBGLmh6iRyCVGH4reme/Va7Q1f86l8oJBXZ3oIrB1J
         N5pS6qSIm3hltcqXWKDve2KvLIdVK7HzAe+oD+Kc=
Subject: patch "iio: addac: Kconfig: update ad74413r selections" added to char-misc-linus
To:     antoniu.miclaus@analog.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 06 Oct 2023 17:01:07 +0200
Message-ID: <2023100607-deputy-lure-d702@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: addac: Kconfig: update ad74413r selections

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From b120dd3a15582fb7a959cecb05e4d9814fcba386 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Tue, 12 Sep 2023 11:54:21 +0300
Subject: iio: addac: Kconfig: update ad74413r selections

Building ad74413r without selecting IIO_BUFFER and
IIO_TRIGGERED_BUFFER generates error with respect to the iio trigger
functions that are used within the driver.
Update the Kconfig accordingly.

Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Link: https://lore.kernel.org/r/20230912085421.51102-1-antoniu.miclaus@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/addac/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
index 877f9124803c..397544f23b85 100644
--- a/drivers/iio/addac/Kconfig
+++ b/drivers/iio/addac/Kconfig
@@ -24,6 +24,8 @@ config AD74413R
 	depends on GPIOLIB && SPI
 	select REGMAP_SPI
 	select CRC8
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD74412R/AD74413R
 	  quad-channel software configurable input/output solution.
-- 
2.42.0


