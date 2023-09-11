Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A109279AD27
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351075AbjIKVmf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbjIKPIG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:08:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EACFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:08:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18A2C433C8;
        Mon, 11 Sep 2023 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444881;
        bh=jVx8E95FvZZlMeTI410ElanCHiYnGyPeiQIzxicxbEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceKhS2XTJxpr7RsLFcpE3Xg21A2iWHrcxfBLaD41CdP7/XwwLu5BdmTLcYeOXubLI
         gNHsmE7tzWS3zwGmlafrLxmSLeMYVQYTs+BrxanJ51VkpVaUi0xgFAYZBNZssnMoEV
         Kt3SZvQg4ooMm3rsUo18mQsDF+8zcRNJe5LjuhlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 149/600] wifi: rtw89: debug: Fix error handling in rtw89_debug_priv_btc_manual_set()
Date:   Mon, 11 Sep 2023 15:43:02 +0200
Message-ID: <20230911134638.009878988@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 59b4cc439f184c5eaa34161ec67af1e16ffabed4 ]

If there is a failure during kstrtobool_from_user()
rtw89_debug_priv_btc_manual_set should return a negative error code
instead of returning the count directly.

Fix this bug by returning an error code instead of a count after
a failed call of the function "kstrtobool_from_user". Moreover
I omitted the label "out" with this source code correction.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/tencent_1C09B99BD7DA9CAD18B00C8F0F050F540607@qq.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index ec0af903961f0..3a8fe60d0bb7b 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2302,12 +2302,14 @@ static ssize_t rtw89_debug_priv_btc_manual_set(struct file *filp,
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	bool btc_manual;
+	int ret;
 
-	if (kstrtobool_from_user(user_buf, count, &btc_manual))
-		goto out;
+	ret = kstrtobool_from_user(user_buf, count, &btc_manual);
+	if (ret)
+		return ret;
 
 	btc->ctrl.manual = btc_manual;
-out:
+
 	return count;
 }
 
-- 
2.40.1



