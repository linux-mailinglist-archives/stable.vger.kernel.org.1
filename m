Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57E379C05E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245738AbjIKVLd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbjIKOv5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:51:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13CD118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:51:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23386C433C8;
        Mon, 11 Sep 2023 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443912;
        bh=0+0QW1GV19QzsNCzsnGfQhpl697qMKBR0CsPGUcLceY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QgjW3F84f12IGSONlFcZETgbsw1F2lMTlo0r5aJp0pUwB74FWkkcaQUnmCs4Rq35r
         Ricvx+VuvuHqMzi40Dwi5MLdH3jaRNmCwQd/LDs3fA5s9l035wpxsXm8GpUN3xmHnf
         IMmnlkEcBYTk1BzfKlVmFFGc/kHcoAMJZlkmhvSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 544/737] fsi: aspeed: Reset master errors after CFAM reset
Date:   Mon, 11 Sep 2023 15:46:43 +0200
Message-ID: <20230911134705.758054214@linuxfoundation.org>
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

From: Eddie James <eajames@linux.ibm.com>

[ Upstream commit 52300909f4670ac552bfeb33c1355b896eac8c06 ]

It has been observed that sometimes the FSI master will return all 0xffs
after a CFAM has been taken out of reset, without presenting any error.
Resetting the FSI master errors resolves the issue.

Fixes: 4a851d714ead ("fsi: aspeed: Support CFAM reset GPIO")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Link: https://lore.kernel.org/r/20230612195657.245125-8-eajames@linux.ibm.com
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fsi/fsi-master-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 7cec1772820d3..5eccab175e86b 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -454,6 +454,8 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
 	gpiod_set_value(aspeed->cfam_reset_gpio, 1);
 	usleep_range(900, 1000);
 	gpiod_set_value(aspeed->cfam_reset_gpio, 0);
+	usleep_range(900, 1000);
+	opb_writel(aspeed, ctrl_base + FSI_MRESP0, cpu_to_be32(FSI_MRESP_RST_ALL_MASTER));
 	mutex_unlock(&aspeed->lock);
 	trace_fsi_master_aspeed_cfam_reset(false);
 
-- 
2.40.1



