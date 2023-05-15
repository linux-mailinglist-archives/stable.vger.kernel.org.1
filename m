Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC070376B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbjEORVG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbjEORUx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:20:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D812E89
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 452EF62C42
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB09C433EF;
        Mon, 15 May 2023 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171115;
        bh=Z/gDJJJKMVNdVuRO3qUjS8ELSXpCSLM7BwbRrtdpN58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v/XoujKZkkgfUHtpAsDrV30d4SkfO2rXGB6vNj4wmDFCpW5+fJQ0TikjC8xLtSGTt
         O1YBATcDEEm6jmBJPTJ/ATVpODyYeztn+yY9Eh3vYgwrhtikLX0Zqb8FU51C9lNVCE
         vUnkhB/hjmUBNZMOjKw4Seyk/INj2feLHVT8F23o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shannon Nelson <shannon.nelson@amd.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 077/242] ionic: remove noise from ethtool rxnfc error msg
Date:   Mon, 15 May 2023 18:26:43 +0200
Message-Id: <20230515161724.208989962@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit 3711d44fac1f80ea69ecb7315fed05b3812a7401 ]

It seems that ethtool is calling into .get_rxnfc more often with
ETHTOOL_GRXCLSRLCNT which ionic doesn't know about.  We don't
need to log a message about it, just return not supported.

Fixes: aa3198819bea6 ("ionic: Add RSS support")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 01c22701482d9..d7370fb60a168 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -691,7 +691,7 @@ static int ionic_get_rxnfc(struct net_device *netdev,
 		info->data = lif->nxqs;
 		break;
 	default:
-		netdev_err(netdev, "Command parameter %d is not supported\n",
+		netdev_dbg(netdev, "Command parameter %d is not supported\n",
 			   info->cmd);
 		err = -EOPNOTSUPP;
 	}
-- 
2.39.2



