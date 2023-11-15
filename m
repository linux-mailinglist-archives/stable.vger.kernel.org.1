Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9197ECD5E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjKOTgM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbjKOTgH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4FAD42
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C0BC433C8;
        Wed, 15 Nov 2023 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076963;
        bh=e0seoj7LTsnn1L6AY6pD90UrieCXGqQDd8Ra2LUyiUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hu0RL/TPD99OtUAHE8Ax1O+6kYB/QeO248RZ+Xfnr4Z6q/INYp76iZ/Q1oJGI5xKI
         ykW840A0E53s6IAyHB+L1OFIBS5yPCy9k1O2P+vlRFhLy8+gXu1SCQPEupXLn0yLvR
         VSsZtfASe9Ug/fun7LF/8SgbuYRY/P45VPXwC32U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 477/550] media: bttv: fix use after free error due to btv->timeout timer
Date:   Wed, 15 Nov 2023 14:17:41 -0500
Message-ID: <20231115191633.933186961@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit bd5b50b329e850d467e7bcc07b2b6bde3752fbda ]

There may be some a race condition between timer function
bttv_irq_timeout and bttv_remove. The timer is setup in
probe and there is no timer_delete operation in remove
function. When it hit kfree btv, the function might still be
invoked, which will cause use after free bug.

This bug is found by static analysis, it may be false positive.

Fix it by adding del_timer_sync invoking to the remove function.

cpu0                cpu1
                  bttv_probe
                    ->timer_setup
                      ->bttv_set_dma
                        ->mod_timer;
bttv_remove
  ->kfree(btv);
                  ->bttv_irq_timeout
                    ->USE btv

Fixes: 162e6376ac58 ("media: pci: Convert timers to use timer_setup()")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/bt8xx/bttv-driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 734f02b91aa31..a50cae25b5463 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -3830,6 +3830,7 @@ static void bttv_remove(struct pci_dev *pci_dev)
 
 	/* free resources */
 	free_irq(btv->c.pci->irq,btv);
+	del_timer_sync(&btv->timeout);
 	iounmap(btv->bt848_mmio);
 	release_mem_region(pci_resource_start(btv->c.pci,0),
 			   pci_resource_len(btv->c.pci,0));
-- 
2.42.0



