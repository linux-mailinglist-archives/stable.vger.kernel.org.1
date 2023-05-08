Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C56FA522
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjEHKGT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjEHKGT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A1730460
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F7762345
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4C7C4339B;
        Mon,  8 May 2023 10:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540377;
        bh=n+MyhvLQuaL6P+rcPk0Nqm7xeI6e3h1ejyiTDBOpUtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ei0RMXOkUWll8l9SbrDvgdIHHJzi1F+qnYXVYr793ySCu5B2jc2ks5a3pb3jm8zp3
         KfOKNG9FaKPnOGyYnDv3fBbQgm9KqXWkJ96coom+zDjItHppMtLbRyOrhNZOrsc/at
         +jvQVg+xllaaRJ8pacpDmLveBREz+cQyOvAAwrZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        Simon Horman <simon.horman@corigine.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 314/611] wifi: rt2x00: Fix memory leak when handling surveys
Date:   Mon,  8 May 2023 11:42:36 +0200
Message-Id: <20230508094432.646457276@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit cbef9a83c51dfcb07f77cfa6ac26f53a1ea86f49 ]

When removing a rt2x00 device, its associated channel surveys
are not freed, causing a memory leak observable with kmemleak:

unreferenced object 0xffff9620f0881a00 (size 512):
  comm "systemd-udevd", pid 2290, jiffies 4294906974 (age 33.768s)
  hex dump (first 32 bytes):
    70 44 12 00 00 00 00 00 92 8a 00 00 00 00 00 00  pD..............
    00 00 00 00 00 00 00 00 ab 87 01 00 00 00 00 00  ................
  backtrace:
    [<ffffffffb0ed858b>] __kmalloc+0x4b/0x130
    [<ffffffffc1b0f29b>] rt2800_probe_hw+0xc2b/0x1380 [rt2800lib]
    [<ffffffffc1a9496e>] rt2800usb_probe_hw+0xe/0x60 [rt2800usb]
    [<ffffffffc1ae491a>] rt2x00lib_probe_dev+0x21a/0x7d0 [rt2x00lib]
    [<ffffffffc1b3b83e>] rt2x00usb_probe+0x1be/0x980 [rt2x00usb]
    [<ffffffffc05981e2>] usb_probe_interface+0xe2/0x310 [usbcore]
    [<ffffffffb13be2d5>] really_probe+0x1a5/0x410
    [<ffffffffb13be5c8>] __driver_probe_device+0x78/0x180
    [<ffffffffb13be6fe>] driver_probe_device+0x1e/0x90
    [<ffffffffb13be972>] __driver_attach+0xd2/0x1c0
    [<ffffffffb13bbc57>] bus_for_each_dev+0x77/0xd0
    [<ffffffffb13bd2a2>] bus_add_driver+0x112/0x210
    [<ffffffffb13bfc6c>] driver_register+0x5c/0x120
    [<ffffffffc0596ae8>] usb_register_driver+0x88/0x150 [usbcore]
    [<ffffffffb0c011c4>] do_one_initcall+0x44/0x220
    [<ffffffffb0d6134c>] do_init_module+0x4c/0x220

Fix this by freeing the channel surveys on device removal.

Tested with a RT3070 based USB wireless adapter.

Fixes: 5447626910f5 ("rt2x00: save survey for every channel visited")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230330215637.4332-1-W_Armin@gmx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 3a035afcf7f99..9a9cfd0ce402d 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1091,6 +1091,7 @@ static void rt2x00lib_remove_hw(struct rt2x00_dev *rt2x00dev)
 	}
 
 	kfree(rt2x00dev->spec.channels_info);
+	kfree(rt2x00dev->chan_survey);
 }
 
 static const struct ieee80211_tpt_blink rt2x00_tpt_blink[] = {
-- 
2.39.2



