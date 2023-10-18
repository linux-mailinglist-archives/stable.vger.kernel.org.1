Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350D07CDB3F
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 14:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjJRMGD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 08:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjJRMGC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 08:06:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D22F119
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 05:06:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC356C433CD;
        Wed, 18 Oct 2023 12:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697630761;
        bh=Zb0hUBtnmBORBHpEzi/tzPH9SflcoNgxaOq8nK3iEMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZmJW7MEWF/OpRECdfErbhUeVkohURn1RQTvYUFpffRucHr3qGuGh+U/vOfVgvAp4
         XNguktT6tMOtkvcroCn2DB22X7NEUi21SlIr8tT2RigiEhwHUBIQuAddENeKVKFtdR
         2UpcNElYaJhhb9CqVZSOghc38QAAzq9DOS8/LRAuYDydBRJr78KU3JeTweYk1khKFH
         +k2i5bZ5hbSn+TV0Ya0RN1h1gXfUjUw8s0/SnOH/2uyhsdGwi4MIU4QYyUow9S0viR
         28VzyERidGlngNwDEItETEhsfsfGYUj5Z1zICIxcGMjrLKOpJI2/1i4Vt66DoFFHrH
         rv2qyRpU14SHA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4.19.y 2/3] rpmsg: Constify local variable in field store macro
Date:   Wed, 18 Oct 2023 13:05:47 +0100
Message-ID: <20231018120552.2110677-2-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231018120552.2110677-1-lee@kernel.org>
References: <20231018120552.2110677-1-lee@kernel.org>
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
index 65834153ba977..19c7df92c63e0 100644
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

