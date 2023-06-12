Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A91172C0AA
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjFLKx7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbjFLKxg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:53:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D968ED176
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B916F612E1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8ABC433EF;
        Mon, 12 Jun 2023 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566312;
        bh=9OsA4wiFDR0vEoePViywymDkJFGn8FMf+817mTunXBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqL9bbEMaWRmWuDK+X09bVDHdARFl2VbekU4Y3JDUzvCVBNM7f5NaIXnWWjpetWDj
         iPVXcZQbPI3ceAwH5AruSiWKcArnrs2MKo3U931AI/KSmryOLcsPp9u/YJ1Ko2Z59Y
         CvNsle7I3xOkeNsbcj7AmilNiuiVggjN1dPDdV4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Vladislav Efanov <VEfanov@ispras.ru>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.15 47/91] batman-adv: Broken sync while rescheduling delayed work
Date:   Mon, 12 Jun 2023 12:26:36 +0200
Message-ID: <20230612101704.030177429@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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


