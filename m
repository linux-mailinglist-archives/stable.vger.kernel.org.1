Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7A79B9A7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbjIKWJp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbjIKOnb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:43:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6463ECF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:43:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796D4C433C8;
        Mon, 11 Sep 2023 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443407;
        bh=e+Lky8KTRwoSDt6DEuudvpHwEa3NxqKBE7S6Z/i7Sfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WnAlkxJjbHzXim+pbly85+ZOas9t08lA6UlRiK/bkjgKi/Xf/k98snVUwtRxhK8w9
         t/wMlCjBGLOdLFK2wVLQfCl6ZK0Ku7I/LGwUkH+XcPNum/+gFXRRgAfbIgRDma10zH
         7F6oTUVzr/i/DNuUqSgL4VLV0YtI4WwjR8wqnXDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 359/737] firmware: meson_sm: fix to avoid potential NULL pointer dereference
Date:   Mon, 11 Sep 2023 15:43:38 +0200
Message-ID: <20230911134700.556008402@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit f2ed165619c16577c02b703a114a1f6b52026df4 ]

of_match_device() may fail and returns a NULL pointer.

Fix this by checking the return value of of_match_device.

Fixes: 8cde3c2153e8 ("firmware: meson_sm: Rework driver as a proper platform driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/tencent_AA08AAA6C4F34D53ADCE962E188A879B8206@qq.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/meson/meson_sm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 798bcdb05d84e..9a2656d73600b 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -292,6 +292,8 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	chip = of_match_device(meson_sm_ids, dev)->data;
+	if (!chip)
+		return -EINVAL;
 
 	if (chip->cmd_shmem_in_base) {
 		fw->sm_shmem_in_base = meson_sm_map_shmem(chip->cmd_shmem_in_base,
-- 
2.40.1



