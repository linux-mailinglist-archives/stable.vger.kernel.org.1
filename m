Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA137CAC3F
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjJPOv4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjJPOvz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:51:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B857D9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:51:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C79C433C7;
        Mon, 16 Oct 2023 14:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467913;
        bh=v1GrKwcTF0FEuAFxxhZ1mICGQRGvil6f3sWdDfatucE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xy8Z7wxOAsn9c13pMsUoB84BqdV0EEjyLRSnPwwzQ6urulyUh9EK34C3pPYwxjAcQ
         Gm9MvrmOh7UmC0zQHpKRjR+1yyo9ejBwRqGhfO5JmRiAl7Bhjd3B6WeLmD0uk5yhr5
         rvF+zRhOR4FAHp06hU5b8I61zieTYPq/5HLqXQqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 090/191] rswitch: Fix imbalance phy_power_off() calling
Date:   Mon, 16 Oct 2023 10:41:15 +0200
Message-ID: <20231016084017.496836797@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 053f13f67be6d02781730c9ac71abde6e9140610 ]

The phy_power_off() should not be called if phy_power_on() failed.
So, add a condition .power_count before calls phy_power_off().

Fixes: 5cb630925b49 ("net: renesas: rswitch: Add phy_power_{on,off}() calling")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/rswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 5024ce9587312..fb9a520f42078 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1255,7 +1255,7 @@ static void rswitch_adjust_link(struct net_device *ndev)
 		phy_print_status(phydev);
 		if (phydev->link)
 			phy_power_on(rdev->serdes);
-		else
+		else if (rdev->serdes->power_count)
 			phy_power_off(rdev->serdes);
 
 		rdev->etha->link = phydev->link;
-- 
2.40.1



