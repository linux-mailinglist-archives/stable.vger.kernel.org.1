Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FE07315FB
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 13:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjFOLBr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 07:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbjFOLBi (ORCPT
        <rfc822;Stable@vger.kernel.org>); Thu, 15 Jun 2023 07:01:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B321FE5
        for <Stable@vger.kernel.org>; Thu, 15 Jun 2023 04:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EA59629DD
        for <Stable@vger.kernel.org>; Thu, 15 Jun 2023 11:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32744C433C8;
        Thu, 15 Jun 2023 11:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686826896;
        bh=bzmv3vo6wXDTdOd/zL9VsATz/j8OQWAiXUEQ0vNC+Zo=;
        h=Subject:To:From:Date:From;
        b=by25+YKSXwgic0JTQnt7n9KX/pJNGRnZQmVGn+9XXrlfkg82Vv+eMSfbMBarQExQC
         AjtpfBd5FGwZL/5IpvLPdWuih2Opvbs+Yp11hTxG8NkHSh0yFyBRrb4UUNRNc9S14f
         VX6BjDYJKgFdt6SopUBXRjqKzqMtrrYl0R5JTQQs=
Subject: patch "iio: addac: ad74413: don't set DIN_SINK for functions other than" added to char-misc-testing
To:     linux@rasmusvillemoes.dk, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 15 Jun 2023 13:01:24 +0200
Message-ID: <2023061524-yarn-defeat-752d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: addac: ad74413: don't set DIN_SINK for functions other than

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From a4cba07e64e6ec22d9504a1a45d29afa863dc19c Mon Sep 17 00:00:00 2001
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Wed, 3 May 2023 12:50:41 +0200
Subject: iio: addac: ad74413: don't set DIN_SINK for functions other than
 digital input

Apparently, despite the name Digital Input Configuration Register, the
settings in the DIN_CONFIGx registers also affect other channel
functions. In particular, setting a non-zero value in the DIN_SINK
field breaks the resistance measurement function.

Now, one can of course argue that specifying a drive-strength-microamp
property along with a adi,ch-func which is not one of the digital
input functions is a bug in the device tree. However, we have a rather
complicated setup with instances of ad74412r on external hardware
modules, and have set a default drive-strength-microamp in our DT
fragments describing those, merely modifying the adi,ch-func settings
to reflect however the modules have been wired up. And restricting
this setting to just being done for digital input doesn't make the
driver any more complex.

Fixes: 504eb485589d1 (iio: ad74413r: wire up support for drive-strength-microamp property)
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Link: https://lore.kernel.org/r/20230503105042.453755-1-linux@rasmusvillemoes.dk
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/addac/ad74413r.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index e3366cf5eb31..6b0e8218f150 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1317,13 +1317,14 @@ static int ad74413r_setup_gpios(struct ad74413r_state *st)
 		}
 
 		if (config->func == CH_FUNC_DIGITAL_INPUT_LOGIC ||
-		    config->func == CH_FUNC_DIGITAL_INPUT_LOOP_POWER)
+		    config->func == CH_FUNC_DIGITAL_INPUT_LOOP_POWER) {
 			st->comp_gpio_offsets[comp_gpio_i++] = i;
 
-		strength = config->drive_strength;
-		ret = ad74413r_set_comp_drive_strength(st, i, strength);
-		if (ret)
-			return ret;
+			strength = config->drive_strength;
+			ret = ad74413r_set_comp_drive_strength(st, i, strength);
+			if (ret)
+				return ret;
+		}
 
 		ret = ad74413r_set_gpo_config(st, i, gpo_config);
 		if (ret)
-- 
2.41.0


