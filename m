Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82B8703A09
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbjEORro (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbjEORra (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D72818AB7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E77F862ECC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1430C433D2;
        Mon, 15 May 2023 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172765;
        bh=wbsX+qMnS9ESfZt5QWNQfcB3hfhlmXDxQvIK+sRzuSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMLZFraiov9wMxcrE4yiDJ2W7y909XOLDCs4JyCZ5a6F4ZG40uJodYQHOMeh12G2Z
         BV9gMjHoK57sGZvzFUV5aWo7iGzIJrkMrEOnTi2AV+jPjpDoBKSkwnxZvxymmSoldh
         obYv9/xxxUfyjuPQ7lq9C5QPwjivjwopBTF2U75o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dongliang Mu <dzm91@hust.edu.cn>,
        Peter Chen <peter.chen@kernel.org>,
        Yinhao Hu <dddddd@hust.edu.cn>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 221/381] usb: chipidea: fix missing goto in `ci_hdrc_probe`
Date:   Mon, 15 May 2023 18:27:52 +0200
Message-Id: <20230515161746.722579931@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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
index f26dd1f054f21..3d18599c5b9e4 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1090,7 +1090,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	ret = ci_usb_phy_init(ci);
 	if (ret) {
 		dev_err(dev, "unable to init phy: %d\n", ret);
-		return ret;
+		goto ulpi_exit;
 	}
 
 	ci->hw_bank.phys = res->start;
-- 
2.39.2



