Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47098791CF7
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245717AbjIDSde (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjIDSdd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:33:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F220B2
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 71A76CE0D97
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E60C433CB;
        Mon,  4 Sep 2023 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852406;
        bh=fjm6xXFFDPsgsDCDB5jjxKYw0gEgtQZLyUYRLqCJzVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tswar8PvakIMSM1r17HAoGD2XZjK1iHlq3xSwPWq+0HFwtvYgzak/Utig3IpIs56z
         0rDfLi4FkUWllcPsmqIXhVHb0wPHP47v+Fx8FCdIJ5x4gHR7vN8zHFy9/TaeYT7NSI
         5ssmMgi29JiT/2CfN/nHgbj8VwIakjZ7ih9h4U5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ilgaz=20=C3=96cal?= <ilgaz@ilgaz.gen.tr>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.4 20/32] wifi: rtw88: usb: kill and free rx urbs on probe failure
Date:   Mon,  4 Sep 2023 19:30:18 +0100
Message-ID: <20230904182948.836746600@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
References: <20230904182947.899158313@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sascha Hauer <s.hauer@pengutronix.de>

commit 290564367ab7fa7e2048bdc00d9c0ad016b41eea upstream.

After rtw_usb_alloc_rx_bufs() has been called rx urbs have been
allocated and must be freed in the error path. After rtw_usb_init_rx()
has been called they are submitted, so they also must be killed.

Add these forgotten steps to the probe error path.

Besides the lost memory this also fixes a problem when the driver
fails to download the firmware in rtw_chip_info_setup(). In this
case it can happen that the completion of the rx urbs handler runs
at a time when we already freed our data structures resulting in
a kernel crash.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Cc: stable@vger.kernel.org
Reported-by: Ilgaz Öcal <ilgaz@ilgaz.gen.tr>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230823075021.588596-1-s.hauer@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw88/usb.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -837,7 +837,7 @@ int rtw_usb_probe(struct usb_interface *
 
 	ret = rtw_core_init(rtwdev);
 	if (ret)
-		goto err_release_hw;
+		goto err_free_rx_bufs;
 
 	ret = rtw_usb_intf_init(rtwdev, intf);
 	if (ret) {
@@ -883,6 +883,9 @@ err_destroy_usb:
 err_deinit_core:
 	rtw_core_deinit(rtwdev);
 
+err_free_rx_bufs:
+	rtw_usb_free_rx_bufs(rtwusb);
+
 err_release_hw:
 	ieee80211_free_hw(hw);
 


