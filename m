Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EA0703976
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjEORmr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbjEORmZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:42:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14013C20
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1E8C62E2A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E370BC433EF;
        Mon, 15 May 2023 17:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172399;
        bh=X/9fnB4izwPUdqzXOGHr1R4lEriUUz/nq6EkeeejuQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTcJ58YBH1XTPh8DIgVDK1no7cls/ybgoOIGS0YlmNTF6HXAlzlDuyDpRJ79vSf4B
         1JTDJLxeUmnmmY4YCKVR5YMb+mY9BEtdMRyjcbnvCa8IZdCZLoCdW1JfbttCZW2wIH
         kRe95Yu4BGNFTOYlfT1CATPSW1SNrNkbHzxWPEG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 141/381] vlan: partially enable SIOCSHWTSTAMP in container
Date:   Mon, 15 May 2023 18:26:32 +0200
Message-Id: <20230515161743.214776528@linuxfoundation.org>
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

From: Vadim Fedorenko <vadim.fedorenko@linux.dev>

[ Upstream commit 731b73dba359e3ff00517c13aa0daa82b34ff466 ]

Setting timestamp filter was explicitly disabled on vlan devices in
containers because it might affect other processes on the host. But it's
absolutely legit in case when real device is in the same namespace.

Fixes: 873017af7784 ("vlan: disable SIOCSHWTSTAMP in container")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/8021q/vlan_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 86a1c99025ea0..929f85c6cf112 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -365,7 +365,7 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 
 	switch (cmd) {
 	case SIOCSHWTSTAMP:
-		if (!net_eq(dev_net(dev), &init_net))
+		if (!net_eq(dev_net(dev), dev_net(real_dev)))
 			break;
 		fallthrough;
 	case SIOCGMIIPHY:
-- 
2.39.2



