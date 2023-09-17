Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00777A3BD9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbjIQUXb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbjIQUXD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:23:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF1310A
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:22:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF4DC433CB;
        Sun, 17 Sep 2023 20:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982178;
        bh=dryLdZsjr9zvMo+KQpWWFnWAx8sIsoR9f4yWvonCFaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvHs4hC7LvknVsZxDbLmABFM+1DDY8Fvos6ZMk//YCQE2P15zVjyWD/1M6E1soFN5
         76APo0yA/tIBd6inHm+NsrnYuBrTHtNmy8Ew1jIDFWuDn95h1NdIg9W1QIebr8qX9J
         06gDgv0zcieIkNXGABpr+FyFDmXP6hZNnN5ER32s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 174/511] firmware: meson_sm: fix to avoid potential NULL pointer dereference
Date:   Sun, 17 Sep 2023 21:10:01 +0200
Message-ID: <20230917191118.035815382@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 77aa5c6398aa6..d081a6312627b 100644
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



