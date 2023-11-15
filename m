Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47E7ECD99
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjKOThW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbjKOThV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:37:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ECF19F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356DCC433C9;
        Wed, 15 Nov 2023 19:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077038;
        bh=IS6/zpZxfW9P679TJNY1NLFvvPfw13mD5OanZyfrUF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4iHCI2wVa4PA+9q8+xcaOWJzRVK4MBb3gDRV6ltYt7+cQnz0wvLDh9oqbRh9Qi68
         FA5sNesxQymnxy/qJqkaBjXUmvDBOG/HiIMetHW7bfwU1Kfuks7cODmTf9c7agHg5z
         FVb4tptu+46kH8vZEQxuIHuEgmnKlMG8VyWKvO7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 105/603] can: etas_es58x: add missing a blank line after declaration
Date:   Wed, 15 Nov 2023 14:10:50 -0500
Message-ID: <20231115191620.474564060@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

[ Upstream commit 4f8005092cafc194ba6a8e5f39626ba0b9f08271 ]

Fix below checkpatch warning:

  WARNING: Missing a blank line after declarations
  #2233: FILE: drivers/net/can/usb/etas_es58x/es58x_core.c:2233:
  +		int ret = es58x_init_netdev(es58x_dev, ch_idx);
  +		if (ret) {

Fixes: d8f26fd689dd ("can: etas_es58x: remove es58x_get_product_info()")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230924110914.183898-3-mailhol.vincent@wanadoo.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 0c7f7505632cd..5e3a72b7c4691 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -2230,6 +2230,7 @@ static int es58x_probe(struct usb_interface *intf,
 
 	for (ch_idx = 0; ch_idx < es58x_dev->num_can_ch; ch_idx++) {
 		int ret = es58x_init_netdev(es58x_dev, ch_idx);
+
 		if (ret) {
 			es58x_free_netdevs(es58x_dev);
 			return ret;
-- 
2.42.0



