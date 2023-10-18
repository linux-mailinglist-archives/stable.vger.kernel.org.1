Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4104A7CDB35
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjJRMFP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjJRMFO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 08:05:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EDD95
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 05:05:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D055C433C9;
        Wed, 18 Oct 2023 12:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697630712;
        bh=X3w/+tcJbii8Aanj0ihHChUWSRXtwcat67SQS3z29fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nq1x35wOcgM9yj0c4oloacOryMFs83dMsx91Ib5ASG5QWsZ00Y5+df9o9cC1vV8rW
         Mcic/0URlao1tooe+DZe/SMQoqoC0sPlOAkkDXmWIRNWFXP2l/QmcXUx75ziaxUTy9
         c78SZ8vDHUGg70Q58u16REyPz6ronO6GbuBsMMOSbsN3gSP5FOZnZ6/8LGglSklK+T
         GzCRF3uP/yuX5io8nyVTwdncWZWoFgNnnV+JKfQUd+JFT7uyBrnMBq2HcUqCqUkH5A
         t5sYoSu70gbvnmNBlbp2416v22wnQkedxm2DT3xsbT6MQfD93M1vxH1MNi30UOxGUX
         ke0L8DobzuT9A==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5.10.y 2/3] rpmsg: Constify local variable in field store macro
Date:   Wed, 18 Oct 2023 13:04:58 +0100
Message-ID: <20231018120502.2110260-2-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231018120502.2110260-1-lee@kernel.org>
References: <20231018120502.2110260-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit e5f89131a06142e91073b6959d91cea73861d40e upstream.

Memory pointed by variable 'old' in field store macro is not modified,
so it can be made a pointer to const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220419113435.246203-12-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rpmsg/rpmsg_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 028ca5961bc2a..ef32fd66e8c2d 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -332,7 +332,8 @@ field##_store(struct device *dev, struct device_attribute *attr,	\
 	      const char *buf, size_t sz)				\
 {									\
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	char *new, *old;						\
+	const char *old;						\
+	char *new;							\
 									\
 	new = kstrndup(buf, sz, GFP_KERNEL);				\
 	if (!new)							\
-- 
2.42.0.655.g421f12c284-goog

