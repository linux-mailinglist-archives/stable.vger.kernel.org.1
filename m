Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD57176AFAB
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjHAJtt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjHAJt2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69D3C3C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DCBC61509
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEB0C433C9;
        Tue,  1 Aug 2023 09:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883285;
        bh=RbuvKrTO/lvaDb9dGFSCkw2dQ23aIzios9ci2FOF2HM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2mq5Yq0zVkR2eQA65qT/MEO+WNJ5D/cL0FKRiEzkhwcEvtHuzhZ7w1QNtugNWcBPn
         QrZlltlci9k0MnjZdmMvWncAhLiyfWODMn6BZGrCOl2sKmBYnXGA5XbzjFouXN5bJ8
         qiyrrvXfeeCGElwSiOKQvMPfupkWALyzEGHP6HQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksa Savic <savicaleksa83@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.4 181/239] hwmon: (aquacomputer_d5next) Fix incorrect PWM value readout
Date:   Tue,  1 Aug 2023 11:20:45 +0200
Message-ID: <20230801091932.190096545@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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

From: Aleksa Savic <savicaleksa83@gmail.com>

commit a746b3689546da27125da9ccaea62b1dbaaf927c upstream.

Commit 662d20b3a5af ("hwmon: (aquacomputer_d5next) Add support for
temperature sensor offsets") changed aqc_get_ctrl_val() to return
the value through a parameter instead of through the return value,
but didn't fix up a case that relied on the old behavior. Fix it
to use the proper received value and not the return code.

Fixes: 662d20b3a5af ("hwmon: (aquacomputer_d5next) Add support for temperature sensor offsets")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
Link: https://lore.kernel.org/r/20230714120712.16721-1-savicaleksa83@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/aquacomputer_d5next.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -969,7 +969,7 @@ static int aqc_read(struct device *dev,
 			if (ret < 0)
 				return ret;
 
-			*val = aqc_percent_to_pwm(ret);
+			*val = aqc_percent_to_pwm(*val);
 			break;
 		}
 		break;


