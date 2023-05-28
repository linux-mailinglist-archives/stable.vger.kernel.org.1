Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB20713FF0
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjE1Tum (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjE1Tul (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BEC9B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7581E62063
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955C9C433EF;
        Sun, 28 May 2023 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303439;
        bh=xGQU3UP9u9rVob5UcnYZp6dVySPSgld0am8ChfGc3XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Goop9pAIzsWSgKqRrgi1wAdOqQmvdJ4WbyhmhFrf0IX55dft3xstUa9LHhATtQxL0
         iVwH1rRME0bhaLdKZ3I63x4vsaEAI5zyCs0zF5O2eGowJx0230RLcfCqF81Y4sfc/5
         FVDON0bfB75oDuc4nVBxetssdqYhnXkMSaYD7w88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 69/69] net: phy: mscc: add VSC8502 to MODULE_DEVICE_TABLE
Date:   Sun, 28 May 2023 20:12:29 +0100
Message-Id: <20230528190830.970826369@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: David Epping <david.epping@missinglinkelectronics.com>

commit 57fb54ab9f6945e204740b696bd4cee61ee04e5e upstream.

The mscc driver implements support for VSC8502, so its ID should be in
the MODULE_DEVICE_TABLE for automatic loading.

Signed-off-by: David Epping <david.epping@missinglinkelectronics.com>
Fixes: d3169863310d ("net: phy: mscc: add support for VSC8502")
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mscc/mscc_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2664,6 +2664,7 @@ static struct phy_driver vsc85xx_driver[
 module_phy_driver(vsc85xx_driver);
 
 static struct mdio_device_id __maybe_unused vsc85xx_tbl[] = {
+	{ PHY_ID_VSC8502, 0xfffffff0, },
 	{ PHY_ID_VSC8504, 0xfffffff0, },
 	{ PHY_ID_VSC8514, 0xfffffff0, },
 	{ PHY_ID_VSC8530, 0xfffffff0, },


