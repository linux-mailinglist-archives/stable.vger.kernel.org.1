Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC107DC995
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 10:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbjJaJad (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 05:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343909AbjJaJab (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 05:30:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F13CFA
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 02:30:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C0AC433C9;
        Tue, 31 Oct 2023 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698744627;
        bh=FUlOkdOclIzKk4syI4JF14/A2kjJKQf1CK1kE3ldico=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYES0S8zDwcipYNfG5JjNhk9O9ssrABe0ofNcxbwXbekv/iH5aSGB9RTVWhTTPyu8
         gsroyYNw9XxGOON5G08lglV+6485v86GL8f/Yp3x+ZYFfwIR83C4642JRWF7+weOKI
         uN/Pq06wmus2fcSmUNd0tO8d8z2zOuFFX8beiARp9QXM+7E5GkbDtbqq/M/qA/wnpC
         toGjSXGYa7vVCUiKHp6haw4c8EafeO+OBVomxb+c8HTun7+B92ZhZl5/owJ82IQHDm
         mKniQwueRLIW2Se57B+0nPtN4eptt8eLazmVR1o4AEk+APo4mcZHtqcxUOAP4SMGlS
         1HAoolHi0eTrQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4.19.y 2/6] rpmsg: Constify local variable in field store macro
Date:   Tue, 31 Oct 2023 09:30:11 +0000
Message-ID: <20231031093018.2233640-2-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031093018.2233640-1-lee@kernel.org>
References: <20231031093018.2233640-1-lee@kernel.org>
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
Change-Id: I0dd497d7a6eb51e9d285b4a256a711d7c9627fec
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
2.42.0.820.g83a721a137-goog

