Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226207ED6C9
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbjKOWDc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344127AbjKOWDb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:03:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF706193
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:03:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FABC433CA;
        Wed, 15 Nov 2023 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085808;
        bh=TytBF2pntKlJxupEBzIIFklgBc1SrRTztEPuACO7ho8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dshtwfQ0JGUBazickxJxWkKooT3YmVo6a8rAjRhY1p2Fpt1mm5IiUWER6PhoqlrCI
         ESxvhlgb/4aMTFf66LxKdkc56Bm9QhL8cOePAomxpmFY0jWuKuZ8YC+zkWRBd8lwxL
         qLZQcfSxG8Pmdied6mQknczuQNaOvRmz1mOJiRsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 066/119] mfd: dln2: Fix double put in dln2_probe
Date:   Wed, 15 Nov 2023 17:00:56 -0500
Message-ID: <20231115220134.680082963@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 759c409bc5fc496cbc22cd0b392d3cbb0c0e23eb ]

The dln2_free() already contains usb_put_dev(). Therefore,
the redundant usb_put_dev() before dln2_free() may lead to
a double free.

Fixes: 96da8f148396 ("mfd: dln2: Fix memory leak in dln2_probe()")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Link: https://lore.kernel.org/r/20230925024134.9683-1-dinghao.liu@zju.edu.cn
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/dln2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 80952237e4b43..707f4287ab4a0 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -797,7 +797,6 @@ static int dln2_probe(struct usb_interface *interface,
 	dln2_stop_rx_urbs(dln2);
 
 out_free:
-	usb_put_dev(dln2->usb_dev);
 	dln2_free(dln2);
 
 	return ret;
-- 
2.42.0



