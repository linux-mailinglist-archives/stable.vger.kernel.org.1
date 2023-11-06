Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9C07E2378
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjKFNMH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjKFNME (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:12:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E3F191
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:12:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77F7C433C8;
        Mon,  6 Nov 2023 13:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276320;
        bh=OaP+Rr2aMTgc7jl2ixRIRPDcIHiV3joADqAi59aFtRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bueL5oeuiub0npzkG8B7S9BG66jqfvbS8ZxBDQ1oAowsMkDGGpiSJGv/wVLxwYPjO
         zboyyLCNE+ljM5bv/fEOv62fPvJM9cX9sA3A9MZOAZf61A7xBdrvI1+6nOq+PoEq38
         XoDCwMBua4l1Wva5xhiucCcJNh/DbYW4o9krFISk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, lee@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4.19 35/61] rpmsg: Constify local variable in field store macro
Date:   Mon,  6 Nov 2023 14:03:31 +0100
Message-ID: <20231106130300.820808995@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
References: <20231106130259.573843228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit e5f89131a06142e91073b6959d91cea73861d40e upstream.

Memory pointed by variable 'old' in field store macro is not modified,
so it can be made a pointer to const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220419113435.246203-12-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rpmsg/rpmsg_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -332,7 +332,8 @@ field##_store(struct device *dev, struct
 	      const char *buf, size_t sz)				\
 {									\
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	char *new, *old;						\
+	const char *old;						\
+	char *new;							\
 									\
 	new = kstrndup(buf, sz, GFP_KERNEL);				\
 	if (!new)							\


