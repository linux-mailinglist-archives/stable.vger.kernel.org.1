Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415E07BBB10
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 17:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjJFPBK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjJFPBJ (ORCPT
        <rfc822;Stable@vger.kernel.org>); Fri, 6 Oct 2023 11:01:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9349CA6
        for <Stable@vger.kernel.org>; Fri,  6 Oct 2023 08:01:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73BBC433C8;
        Fri,  6 Oct 2023 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696604468;
        bh=2440xQKK3Lk9C3zaG1o0mKj9+uHLZiPPy8OJdgawbM8=;
        h=Subject:To:From:Date:From;
        b=LmAyYcANpsc1niRN2lGlDj9O3kSw8VwGwlesnnfpaK5uKwVjE5pJFg3ykLh/xeNiW
         07bCyFDcXEDhP0kq79ASC94MdR5r/+VvCTH2GaH8NlZTJ6x2yvIHaQ+3pV3WHfTQVh
         hQ/8KNcvJpoASOFIvtOipOA30OybmcAt+rc+QA7E=
Subject: patch "iio: admv1013: add mixer_vgate corner cases" added to char-misc-linus
To:     antoniu.miclaus@analog.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, nuno.sa@analog.com
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 06 Oct 2023 17:01:00 +0200
Message-ID: <2023100600-eastbound-morbidly-3775@gregkh>
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

    iio: admv1013: add mixer_vgate corner cases

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 287d998af24326b009ae0956820a3188501b34a0 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Mon, 7 Aug 2023 17:38:05 +0300
Subject: iio: admv1013: add mixer_vgate corner cases

Include the corner cases in the computation of the MIXER_VGATE register
value.

According to the datasheet: The MIXER_VGATE values follows the VCM such
as, that for a 0V to 1.8V VCM, MIXER_VGATE = 23.89 VCM + 81, and for a >
1.8V to 2.6V VCM, MIXER_VGATE = 23.75 VCM + 1.25.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20230807143806.6954-1-antoniu.miclaus@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/frequency/admv1013.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 6355c1f28423..92923074f930 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -351,9 +351,9 @@ static int admv1013_update_mixer_vgate(struct admv1013_state *st)
 	if (vcm < 0)
 		return vcm;
 
-	if (vcm < 1800000)
+	if (vcm <= 1800000)
 		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;
-	else if (vcm > 1800000 && vcm < 2600000)
+	else if (vcm > 1800000 && vcm <= 2600000)
 		mixer_vgate = (2375 * vcm / 1000000 + 125) / 100;
 	else
 		return -EINVAL;
-- 
2.42.0


