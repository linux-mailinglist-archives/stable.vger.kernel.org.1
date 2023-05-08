Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41C46FAA3C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbjEHLA5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjEHLAW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348CF2B428
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD20262A0A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD677C433D2;
        Mon,  8 May 2023 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543545;
        bh=sVrm4fFIR40TPvE566MrX757Ru1LLIfkpqSQNuQ7DTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXb8Q4r5QUHAgpsL5RJlad7O0uL0OSWYAUWCIxcuPZA0+LjU/ObGDVZjKK/51Hc2F
         r5an4zE+CC5QXKnPTFOjf/4ui48nqkTGM+vekroVF06QDqOSHwR2TbWv9BqUOsDFkv
         cIb73lMZhAysytKsP3f9eLCy0sYPNpOLbM1t3C4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Jes Sorensen <jes@trained-monkey.org>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.3 125/694] wifi: rtl8xxxu: RTL8192EU always needs full init
Date:   Mon,  8 May 2023 11:39:20 +0200
Message-Id: <20230508094436.523947581@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

commit d46e04ccd40457a0119b76e11ab64a2ad403e138 upstream.

Always run the entire init sequence (rtl8xxxu_init_device()) for
RTL8192EU. It's what the vendor driver does too.

This fixes a bug where the device is unable to connect after
rebooting:

wlp3s0f3u2: send auth to ... (try 1/3)
wlp3s0f3u2: send auth to ... (try 2/3)
wlp3s0f3u2: send auth to ... (try 3/3)
wlp3s0f3u2: authentication with ... timed out

Rebooting leaves the device powered on (partially? at least the
firmware is still running), but not really in a working state.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Jes Sorensen <jes@trained-monkey.org>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/4eb111a9-d4c4-37d0-b376-4e202de7153c@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1817,6 +1817,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops =
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
 	.has_s0s1 = 0,
 	.gen2_thermal_meter = 1,
+	.needs_full_init = 1,
 	.adda_1t_init = 0x0fc01616,
 	.adda_1t_path_on = 0x0fc01616,
 	.adda_2t_path_on_a = 0x0fc01616,


