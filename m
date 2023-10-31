Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15EE7DC975
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 10:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjJaJ1F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343861AbjJaJ1E (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 05:27:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA9DE
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 02:26:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C837C433C8;
        Tue, 31 Oct 2023 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698744416;
        bh=Y25zfaRU3JoUwctVBP6Q4YHTLAb6E0JWEwLFU1ySvhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3QP6oCVkHTZidX3eK3pIv0SEekUoc3amdQWkI7kzfZPNXg5i+THAHKnPiXW4QXWe
         lSF+TWZCPvUGEcNC1Ri3QF124qej78v6/P7KShF6HAq4U17Tuu0kGcqF0l3qDAKmVo
         utMYsIhKeYx9XI/aDEARQpoz7Je/sfHA7TLzSzi2Ww1V18UzXJWZFxYzBgExfZ2mEi
         iQcJhLmxVaZPIZqt0J5cHevTCraP/Sm/3CHcaOEfybyAm1F+bvhVn79MkFdMKwYLP7
         S5VacOpawVIMW8+98ClGXIL/FfVl2z5c4Qsk5RGdMUQbeyvNv/2UlaIskDahMHl6j2
         DXhZ14whSAUPg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5.4.y 2/6] rpmsg: Constify local variable in field store macro
Date:   Tue, 31 Oct 2023 09:26:36 +0000
Message-ID: <20231031092645.2230861-2-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031092645.2230861-1-lee@kernel.org>
References: <20231031092645.2230861-1-lee@kernel.org>
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
Change-Id: If9f1f25e2f09bcbf137c9adc55357c5a73b0571f
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
2.42.0.820.g83a721a137-goog

