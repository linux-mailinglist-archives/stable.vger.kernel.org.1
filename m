Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8423572C1EC
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbjFLLB2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbjFLLBE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:01:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FA910CC
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2336E624B0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D3FC433EF;
        Mon, 12 Jun 2023 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566890;
        bh=9OsA4wiFDR0vEoePViywymDkJFGn8FMf+817mTunXBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnmJO/DiTT2V/eSVxWcLEkr68KE5RP1VlnbCKLFQeCLnUBv90pLIXBkyIw0BZAufy
         pw1TxasPZZR6RbFOB7btzdkd1kuAPZKREpiKh8Z+ueJDaNv0shvh5PnykClMYo1vYM
         zIK8SUInR69PhJjb6lZ58zGklciHfTn++u88skgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Vladislav Efanov <VEfanov@ispras.ru>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 6.3 070/160] batman-adv: Broken sync while rescheduling delayed work
Date:   Mon, 12 Jun 2023 12:26:42 +0200
Message-ID: <20230612101718.221292012@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Vladislav Efanov <VEfanov@ispras.ru>

commit abac3ac97fe8734b620e7322a116450d7f90aa43 upstream.

Syzkaller got a lot of crashes like:
KASAN: use-after-free Write in *_timers*

All of these crashes point to the same memory area:

The buggy address belongs to the object at ffff88801f870000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 5320 bytes inside of
 8192-byte region [ffff88801f870000, ffff88801f872000)

This area belongs to :
        batadv_priv->batadv_priv_dat->delayed_work->timer_list

The reason for these issues is the lack of synchronization. Delayed
work (batadv_dat_purge) schedules new timer/work while the device
is being deleted. As the result new timer/delayed work is set after
cancel_delayed_work_sync() was called. So after the device is freed
the timer list contains pointer to already freed memory.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Cc: stable@kernel.org
Fixes: 2f1dfbe18507 ("batman-adv: Distributed ARP Table - implement local storage")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/distributed-arp-table.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -101,7 +101,6 @@ static void batadv_dat_purge(struct work
  */
 static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 {
-	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->dat.work,
 			   msecs_to_jiffies(10000));
 }
@@ -819,6 +818,7 @@ int batadv_dat_init(struct batadv_priv *
 	if (!bat_priv->dat.hash)
 		return -ENOMEM;
 
+	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	batadv_dat_start_timer(bat_priv);
 
 	batadv_tvlv_handler_register(bat_priv, batadv_dat_tvlv_ogm_handler_v1,


