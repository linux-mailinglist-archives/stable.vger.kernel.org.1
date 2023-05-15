Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD66703349
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242752AbjEOQfV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242584AbjEOQfU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2DAA4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5289627CB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB22EC4339B;
        Mon, 15 May 2023 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168518;
        bh=lWvqTOxU1QgW3fIQ7ZpzBHA2YPWpg0MaVGVFKM3GgC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDQL+/m0NQCMn7eQioP6Nye4el9ZhK/GIa1v6rH4h90UQYV0H3uxQuWbP8uLNY345
         ZFqGyT/AgHo2pno19IE6c2nkRq1jeG9ZVq5JVBGRy1COfAAn7MXOh8wdE7e1WS7jPJ
         P7FOm6tL05TxC3fI6mzz+s9ix7BufcBTYzdl4YGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Jes Sorensen <jes@trained-monkey.org>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 4.14 075/116] wifi: rtl8xxxu: RTL8192EU always needs full init
Date:   Mon, 15 May 2023 18:26:12 +0200
Message-Id: <20230515161700.777115270@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
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
@@ -1660,6 +1660,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops =
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
 	.has_s0s1 = 0,
 	.gen2_thermal_meter = 1,
+	.needs_full_init = 1,
 	.adda_1t_init = 0x0fc01616,
 	.adda_1t_path_on = 0x0fc01616,
 	.adda_2t_path_on_a = 0x0fc01616,


