Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802A377AB98
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjHMVXh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjHMVXg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A611110E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45172628A6
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58733C433C8;
        Sun, 13 Aug 2023 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961817;
        bh=xxKfQWsqnILrqaaNrVkxhRX6dIs193bUgRXg6XZDEsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mrmP2+dK1+jCq9dXH8OklgeeZHRE5OvXHjxpFhVldsmCkDrYMYJikJik+tj4wsppA
         pHPgUwFOfTllVfvsfQkuJlhdYaHWCatvMCL2FwVu6vU3xfUvwEiFQhHdX8V2AMr2JC
         D/BD15sl0s27dWqX6VErJHmeG7JZsQ8SbDMo9MeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damian B <bronecki.damian@gmail.com>,
        Stable@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.4 010/206] wifi: rtw89: fix 8852AE disconnection caused by RX full flags
Date:   Sun, 13 Aug 2023 23:16:20 +0200
Message-ID: <20230813211725.270005969@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

commit b74bb07cdab6859e1a3fc9fe7351052176322ddf upstream.

RX full flags are raised if certain types of RX FIFO are full, and then
drop all following MPDU of AMPDU. In order to resume to receive MPDU
when RX FIFO becomes available, we clear the register bits by the
commit a0d99ebb3ecd ("wifi: rtw89: initialize DMA of CMAC"). But, 8852AE
needs more settings to support this. To quickly fix disconnection problem,
revert the behavior as before.

Fixes: a0d99ebb3ecd ("wifi: rtw89: initialize DMA of CMAC")
Reported-by: Damian B <bronecki.damian@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217710
Cc: <Stable@vger.kernel.org>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Damian B <bronecki.damian@gmail.com>
Link: https://lore.kernel.org/r/20230808005426.5327-1-pkshih@realtek.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw89/mac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2484,7 +2484,7 @@ static int cmac_dma_init(struct rtw89_de
 	u32 reg;
 	int ret;
 
-	if (chip_id != RTL8852A && chip_id != RTL8852B)
+	if (chip_id != RTL8852B)
 		return 0;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);


