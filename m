Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56363775DD7
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjHILlu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjHILlu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95722173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D9B4636B0
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F43FC433C8;
        Wed,  9 Aug 2023 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581308;
        bh=NEg8pEhxd/L1+ip7iUiqcLlCZ1lqXiZngdtTCajiRPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fogRiGfyDvswd/Nm5AekECzCESnL+btdkZABjCG+8iQvbQSJ3+zzkXj2Kg6maPmhw
         +LudedUDLNTaDzqxGs+8Iy2EpjsxWHDcdJpsM2h5O3WVwNW8mUkWTXK9YnimnHYKax
         TurZFrU6xjnxW7PajfWzIQuIQJJN1IUCWLzC7tvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 151/201] s390/qeth: Dont call dev_close/dev_open (DOWN/UP)
Date:   Wed,  9 Aug 2023 12:42:33 +0200
Message-ID: <20230809103648.763419784@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

[ Upstream commit 1cfef80d4c2b2c599189f36f36320b205d9447d9 ]

dev_close() and dev_open() are issued to change the interface state to DOWN
or UP (dev->flags IFF_UP). When the netdev is set DOWN it loses e.g its
Ipv6 addresses and routes. We don't want this in cases of device recovery
(triggered by hardware or software) or when the qeth device is set
offline.

Setting a qeth device offline or online and device recovery actions call
netif_device_detach() and/or netif_device_attach(). That will reset or
set the LOWER_UP indication i.e. change the dev->state Bit
__LINK_STATE_PRESENT. That is enough to e.g. cause bond failovers, and
still preserves the interface settings that are handled by the network
stack.

Don't call dev_open() nor dev_close() from the qeth device driver. Let the
network stack handle this.

Fixes: d4560150cb47 ("s390/qeth: call dev_close() during recovery")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h      | 1 -
 drivers/s390/net/qeth_core_main.c | 2 --
 drivers/s390/net/qeth_l2_main.c   | 9 ++++++---
 drivers/s390/net/qeth_l3_main.c   | 8 +++++---
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index bf8404b0e74ff..2544edd4d2b56 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -719,7 +719,6 @@ struct qeth_card_info {
 	u16 chid;
 	u8 ids_valid:1; /* cssid,iid,chid */
 	u8 dev_addr_is_registered:1;
-	u8 open_when_online:1;
 	u8 promisc_mode:1;
 	u8 use_v1_blkt:1;
 	u8 is_vm_nic:1;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 7b0155b0e99ee..73d564906d043 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5351,8 +5351,6 @@ int qeth_set_offline(struct qeth_card *card, const struct qeth_discipline *disc,
 	qeth_clear_ipacmd_list(card);
 
 	rtnl_lock();
-	card->info.open_when_online = card->dev->flags & IFF_UP;
-	dev_close(card->dev);
 	netif_device_detach(card->dev);
 	netif_carrier_off(card->dev);
 	rtnl_unlock();
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index cfc931f2b7e2c..1797addf69b63 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2270,9 +2270,12 @@ static int qeth_l2_set_online(struct qeth_card *card, bool carrier_ok)
 		qeth_enable_hw_features(dev);
 		qeth_l2_enable_brport_features(card);
 
-		if (card->info.open_when_online) {
-			card->info.open_when_online = 0;
-			dev_open(dev, NULL);
+		if (netif_running(dev)) {
+			local_bh_disable();
+			napi_schedule(&card->napi);
+			/* kick-start the NAPI softirq: */
+			local_bh_enable();
+			qeth_l2_set_rx_mode(dev);
 		}
 		rtnl_unlock();
 	}
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 291861c9b9569..d8cdf90241268 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2037,9 +2037,11 @@ static int qeth_l3_set_online(struct qeth_card *card, bool carrier_ok)
 		netif_device_attach(dev);
 		qeth_enable_hw_features(dev);
 
-		if (card->info.open_when_online) {
-			card->info.open_when_online = 0;
-			dev_open(dev, NULL);
+		if (netif_running(dev)) {
+			local_bh_disable();
+			napi_schedule(&card->napi);
+			/* kick-start the NAPI softirq: */
+			local_bh_enable();
 		}
 		rtnl_unlock();
 	}
-- 
2.40.1



