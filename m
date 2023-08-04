Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971E2770164
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 15:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjHDNYH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 09:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjHDNXX (ORCPT
        <rfc822;Stable@vger.kernel.org>); Fri, 4 Aug 2023 09:23:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC48C526A
        for <Stable@vger.kernel.org>; Fri,  4 Aug 2023 06:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9F7361FBB
        for <Stable@vger.kernel.org>; Fri,  4 Aug 2023 13:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6237C433C8;
        Fri,  4 Aug 2023 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691155229;
        bh=BxZPkIl93oJZVkmXVLp3sFf4VHVev49yl0qc+FUoAwE=;
        h=Subject:To:From:Date:From;
        b=UBWswkhoBLgWw5fSsXKh7i63oRtyKki3hLn8BTOdP7ZRx7ulZyCFFrnfaNx+y6uXN
         k4hwqbmy+OQSeNZ/RHH+RdTOt5SMXLutQEyoavfjtvMNIIVEuEPohMQwkNy7ahM3Ba
         oJ5G4lLdVg66UTXqzb3Il3J3Z7329u6W8yFxCS2M=
Subject: patch "iio: frequency: admv1013: propagate errors from" added to char-misc-linus
To:     dan.carpenter@linaro.org, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 04 Aug 2023 15:20:15 +0200
Message-ID: <2023080415-armed-refocus-d895@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


This is a note to let you know that I've just added the patch titled

    iio: frequency: admv1013: propagate errors from

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 507397d19b5a296aa339f7a1bd16284f668a1906 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Tue, 18 Jul 2023 10:02:18 +0300
Subject: iio: frequency: admv1013: propagate errors from
 regulator_get_voltage()

The regulator_get_voltage() function returns negative error codes.
This function saves it to an unsigned int and then does some range
checking and, since the error code falls outside the correct range,
it returns -EINVAL.

Beyond the messiness, this is bad because the regulator_get_voltage()
function can return -EPROBE_DEFER and it's important to propagate that
back properly so it can be handled.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/ce75aac3-2aba-4435-8419-02e59fdd862b@moroto.mountain
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/frequency/admv1013.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 9bf8337806fc..8c8e0bbfc99f 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -344,9 +344,12 @@ static int admv1013_update_quad_filters(struct admv1013_state *st)
 
 static int admv1013_update_mixer_vgate(struct admv1013_state *st)
 {
-	unsigned int vcm, mixer_vgate;
+	unsigned int mixer_vgate;
+	int vcm;
 
 	vcm = regulator_get_voltage(st->reg);
+	if (vcm < 0)
+		return vcm;
 
 	if (vcm < 1800000)
 		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;
-- 
2.41.0


