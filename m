Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379487CDB38
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjJRMFg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjJRMFf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 08:05:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49133BA
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 05:05:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FF9C433C9;
        Wed, 18 Oct 2023 12:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697630733;
        bh=6fOioNis1dNNYoFYh3Req6O/SZIUp3GUJaDj45GqNpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUIQAgV4NGl4+bZN4EmL8lfj1C07ai+43tvTni/Agg1XaIndvCZ4mq247pD7MYSEE
         sfNEFcYglKWXvwNIvQXvTTpUpxSYcirX/6kcDKweLAzNJ1bCfzZFtueIWW6kzfDqID
         CqXJ4cEJXhEIwOTlPMw3PU5Y1DSPzuN+p76SxQuOOPUAV4Db8Tjn/Sg7/nKhDTS09W
         r1PO7oFB091NIVgXw/YgT6GlgGd5n+/cNqLj3UdBYAoLH5VSPU8GIvzAHc0rT4ywS0
         Bi8q2WxxV90XV8wh+AoN9Q1V21f0VPYJVwuSZ0lv58VzQlMSm9aBxHc/CqKXJwT2ST
         9nrA0/51Sd7Jw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5.4.y 1/2] rpmsg: Constify local variable in field store macro
Date:   Wed, 18 Oct 2023 13:05:17 +0100
Message-ID: <20231018120527.2110438-2-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231018120527.2110438-1-lee@kernel.org>
References: <20231018120527.2110438-1-lee@kernel.org>
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
index c1d4990beab02..458ddfc09120b 100644
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

