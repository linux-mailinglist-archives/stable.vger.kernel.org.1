Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF736FA593
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjEHKK5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjEHKK5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A439884
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 267F86222E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4F1C433D2;
        Mon,  8 May 2023 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540655;
        bh=9n4jKf10Y/FkCI3sXlyrVqlIyqulhjmDrYqmY0qXMnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lpg0xkRNYqSb20SeteN5I55l82RPI59+VoS3r1jKKUnQUdmbklyBR8oggt1zIse7n
         wj22CrSNurIkn38R8C4f/whp3Rd17cJwIe7+//kAzWSnbqKj8252KVqwJYXDdRsQiE
         nIzVZNrmxcL8pUn8+wPfAJ7aJFpD3XytZ8SUUaJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dongliang Mu <dzm91@hust.edu.cn>,
        Peter Chen <peter.chen@kernel.org>,
        Yinhao Hu <dddddd@hust.edu.cn>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 446/611] usb: chipidea: fix missing goto in `ci_hdrc_probe`
Date:   Mon,  8 May 2023 11:44:48 +0200
Message-Id: <20230508094436.648899062@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Yinhao Hu <dddddd@hust.edu.cn>

[ Upstream commit d6f712f53b79f5017cdcefafb7a5aea9ec52da5d ]

>From the comment of ci_usb_phy_init, it returns an error code if
usb_phy_init has failed, and it should do some clean up, not just
return directly.

Fix this by goto the error handling.

Fixes: 74475ede784d ("usb: chipidea: move PHY operation to core")
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
Link: https://lore.kernel.org/r/20230412055852.971991-1-dddddd@hust.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 5abdc2b0f506d..71f172ecfaabc 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1101,7 +1101,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	ret = ci_usb_phy_init(ci);
 	if (ret) {
 		dev_err(dev, "unable to init phy: %d\n", ret);
-		return ret;
+		goto ulpi_exit;
 	}
 
 	ci->hw_bank.phys = res->start;
-- 
2.39.2



