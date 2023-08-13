Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6779A77ADAA
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjHMVu0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjHMVtW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:49:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74871709
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BD1963E44
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C25BC433C7;
        Sun, 13 Aug 2023 21:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963291;
        bh=cTdeHh848QZnLCcdgDZMlk9AFU1o9ZXAMKFT/vJblzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t41kklezME6tgBUvASPZMJB0wRPgQuYUi+nulLzM5J0RHzmEER7BRNliKVFAxCM6N
         P9lVft/PXQz30GkQZiD2RYD3REYMA6ybr4M2WBPDpRQjxdzxdPDys2mmpItY7c1WhP
         2MpMZ3Gb/ZU9gTn30zCC92v7I1B4ngDYW9oob6zI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>,
        Yiyuan Guo <yguoaz@gmail.com>, Stable@vger.kerenl.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 08/39] iio: cros_ec: Fix the allocation size for cros_ec_command
Date:   Sun, 13 Aug 2023 23:19:59 +0200
Message-ID: <20230813211705.119276228@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
References: <20230813211704.796906808@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Yiyuan Guo <yguoaz@gmail.com>

commit 8a4629055ef55177b5b63dab1ecce676bd8cccdd upstream.

The struct cros_ec_command contains several integer fields and a
trailing array. An allocation size neglecting the integer fields can
lead to buffer overrun.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>
Fixes: 974e6f02e27e ("iio: cros_ec_sensors_core: Add common functions for the ChromeOS EC Sensor Hub.")
Link: https://lore.kernel.org/r/20230630143719.1513906-1-yguoaz@gmail.com
Cc: <Stable@vger.kerenl.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -99,7 +99,7 @@ int cros_ec_sensors_core_init(struct pla
 	platform_set_drvdata(pdev, indio_dev);
 
 	state->ec = ec->ec_dev;
-	state->msg = devm_kzalloc(&pdev->dev,
+	state->msg = devm_kzalloc(&pdev->dev, sizeof(*state->msg) +
 				max((u16)sizeof(struct ec_params_motion_sense),
 				state->ec->max_response), GFP_KERNEL);
 	if (!state->msg)


