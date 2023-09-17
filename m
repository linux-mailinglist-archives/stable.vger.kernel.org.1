Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454A97A3C07
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbjIQUZk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbjIQUZa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:25:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A530101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:25:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8EBC433C8;
        Sun, 17 Sep 2023 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982325;
        bh=+A6Z4vbACVKzaFuj2JSoNd0H31aL1M3/2TwgW+IWf+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsTsCT8x2E/sTxOv+AOLKY4b4CA7X1y0ri7yt4b2GMnOEq17su4tofGHDqzWNxS+Q
         zQNP3Ykp6cjKQED77a9QbjP+Jj8kAx5NuMoLpWo0TmPuV4sX7APpwg1WXfNNalNjNf
         PzZQIrTDJUZGTKnGQPIIAhpNaMm5mUH09nbNP/sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 191/511] of: unittest: Fix overlay type in apply/revert check
Date:   Sun, 17 Sep 2023 21:10:18 +0200
Message-ID: <20230917191118.435297312@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 6becf8f845ae1f0b1cfed395bbeccbd23654162d ]

The removal check in of_unittest_apply_revert_overlay_check()
always uses the platform device overlay type, while it should use the
actual overlay type, as passed as a parameter to the function.

This has no impact on any current test, as all tests calling
of_unittest_apply_revert_overlay_check() use the platform device overlay
type.

Fixes: d5e75500ca401d31 ("of: unitest: Add I2C overlay unit tests.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/ba0234c41ba808f10112094f88792beeb6dbaedf.1690533838.git.geert+renesas@glider.be
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/unittest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 19d3b136aed79..073a3f44c4049 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2073,7 +2073,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 	of_unittest_untrack_overlay(save_id);
 
 	/* unittest device must be again in before state */
-	if (of_unittest_device_exists(unittest_nr, PDEV_OVERLAY) != before) {
+	if (of_unittest_device_exists(unittest_nr, ovtype) != before) {
 		unittest(0, "%s with device @\"%s\" %s\n",
 				overlay_name_from_nr(overlay_nr),
 				unittest_path(unittest_nr, ovtype),
-- 
2.40.1



