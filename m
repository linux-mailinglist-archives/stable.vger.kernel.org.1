Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D007DC936
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 10:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbjJaJPd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 05:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343785AbjJaJPc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 05:15:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0954C1
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 02:15:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65411C433C9;
        Tue, 31 Oct 2023 09:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698743729;
        bh=K3+TSiH/E92Q4vety1ZNZyKLBMn5sMI87ytwAXOB028=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UcdSZG9S5yju0SUpPfPU/hn513WFgwZwJYIGK8mmaNw7nyukGgr2So/kybjNr4EnB
         flKp7bybT3b0tr9RXYCMRUjlw2ymf5ajF4kn9Abrf2/77u7BG1/PTeCVzWePFVGxOv
         j5ObYtOJFb9wtvpM+Rm63xn17e38w6JdygIEJncElCRIm8IzcfuoqE1skLvNKuwo9w
         pYEFr3Gd4Xn1pd/XMtbyNBjltc/Ecxfw3ITmho+xnYzwKVl5xZ3P572iaeo6oAIUyE
         kxyKN/8S8xN5SvjRRpccMN8xVSTy4V5x7/zce6Hb2DJkSSfIQUdDMsZ2NpckQDH0cK
         c0ukf6/bbxUrQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/6] rpmsg: Constify local variable in field store macro
Date:   Tue, 31 Oct 2023 09:15:13 +0000
Message-ID: <20231031091521.2223075-2-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031091521.2223075-1-lee@kernel.org>
References: <20231031091521.2223075-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Change-Id: Idb5da2db59b6abbd666ec30372049cdc66014a2f
---
 drivers/rpmsg/rpmsg_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index a71de08acc7b9..c544dee0b5dd9 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -376,7 +376,8 @@ field##_store(struct device *dev, struct device_attribute *attr,	\
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
2.42.0.820.g83a721a137-goog

