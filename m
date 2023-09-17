Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBB37A380F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbjIQTal (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbjIQTaa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:30:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FC9119
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:30:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DD2C433C9;
        Sun, 17 Sep 2023 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979024;
        bh=siv6BfS3vbLbukNSvZBUzC7iL1IEdS9fSevnFRzjjRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZvTrrziQzXADK+1oH5OPhcdQEqG0j+/Ef805LjgmitjGN1q5QaHfapiW3McX4TQf
         N6+bNvrfvLEwqZpgyXnua0rdbgpitUS5jDcWFu9+pHIdTpR6CO5xYBMWeQV4uQ6Mhw
         LHYBEYoSt274CfjSlyBaMV7vRBEbfbUjCT9Rtfac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 167/406] of: unittest: Fix overlay type in apply/revert check
Date:   Sun, 17 Sep 2023 21:10:21 +0200
Message-ID: <20230917191105.592698107@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 1058e23eca7d2..412d7ddb3b8b2 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2067,7 +2067,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 	of_unittest_untrack_overlay(save_id);
 
 	/* unittest device must be again in before state */
-	if (of_unittest_device_exists(unittest_nr, PDEV_OVERLAY) != before) {
+	if (of_unittest_device_exists(unittest_nr, ovtype) != before) {
 		unittest(0, "%s with device @\"%s\" %s\n",
 				overlay_name_from_nr(overlay_nr),
 				unittest_path(unittest_nr, ovtype),
-- 
2.40.1



