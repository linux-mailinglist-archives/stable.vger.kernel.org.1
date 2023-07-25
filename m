Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69060761621
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjGYLgm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjGYLg0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:36:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D897C1BF6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA0B961600
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CF4C433CD;
        Tue, 25 Jul 2023 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284980;
        bh=ry/yoa4ge2tw6XcEMV2M9mMlgluVEOFdhrP51A8ozVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwzH7NUtdD1Tnbq1K2rcjusXUMIDZ/hUmY4K0cP3iEjXSV6ns+wY/7gWtJXyWyUed
         PXLVzN5oYC+DJBrdS+8yrAL0lVT7kbuVky0tvbhVrWbIydvKOq3arwkC8WmvBzM97B
         45nGEoEPBBzJpRim4G4t8OWZgt3AUhUiNlYOmRbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Dewar <alex.dewar90@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 041/313] wl3501_cs: Remove unnecessary NULL check
Date:   Tue, 25 Jul 2023 12:43:14 +0200
Message-ID: <20230725104522.851710014@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alex Dewar <alex.dewar90@gmail.com>

[ Upstream commit 1d2a85382282e7c77cbde5650335c3ffc6073fa1 ]

In wl3501_detach(), link->priv is checked for a NULL value before being
passed to free_netdev(). However, it cannot be NULL at this point as it
has already been passed to other functions, so just remove the check.

Addresses-Coverity: CID 710499: Null pointer dereferences (REVERSE_INULL)
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200926174558.9436-1-alex.dewar90@gmail.com
Stable-dep-of: 391af06a02e7 ("wifi: wl3501_cs: Fix an error handling path in wl3501_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/wl3501_cs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index b66c7d4798977..cf67ea13dd8dc 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -1437,9 +1437,7 @@ static void wl3501_detach(struct pcmcia_device *link)
 	wl3501_release(link);
 
 	unregister_netdev(dev);
-
-	if (link->priv)
-		free_netdev(link->priv);
+	free_netdev(dev);
 }
 
 static int wl3501_get_name(struct net_device *dev, struct iw_request_info *info,
-- 
2.39.2



