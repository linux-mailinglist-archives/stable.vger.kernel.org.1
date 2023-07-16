Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE87551C6
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjGPUAA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGPT75 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774181BE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC4FE60EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0404BC433C8;
        Sun, 16 Jul 2023 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537594;
        bh=MadIgmNYIgoiNF38A9g8sWRuWgD1M5IN5qDNF2STTOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTgio9jF1tzj9QNB8vOQknaODxHtEiRnnlqmIS6X7I9sqaa2VUuXg5AYIZIV8rlWi
         3l4kx2ZAra9uPRRUX9uBxkl3IE9droTzDS9/MJ8ACPyh2S53fsoGVicKxBRMkqIF5w
         54z/1BgUblxfj7bDQTr8Z1l/KR9RCz/52XsSLSq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 112/800] wifi: rtw89: fix rtw89_read_chip_ver() for RTL8852B and RTL8851B
Date:   Sun, 16 Jul 2023 21:39:25 +0200
Message-ID: <20230716194951.712514935@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 9d4f491b860ea6d04471c3342093b86a46eee63e ]

The if statement is reversed so it will not record the chip version.
This was detected using Smatch:

    drivers/net/wireless/realtek/rtw89/core.c:3593 rtw89_read_chip_ver()
    error: uninitialized symbol 'val'.

Fixes: a6fb2bb84654 ("wifi: rtw89: read version of analog hardware")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/e4d912a2-37f8-4068-8861-7b9494ae731b@kili.mountain
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index bad864d56bd5c..5423f8ae187f1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3584,7 +3584,7 @@ static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
 
 	if (chip->chip_id == RTL8852B || chip->chip_id == RTL8851B) {
 		ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_CV, &val);
-		if (!ret)
+		if (ret)
 			return;
 
 		rtwdev->hal.acv = u8_get_bits(val, XTAL_SI_ACV_MASK);
-- 
2.39.2



