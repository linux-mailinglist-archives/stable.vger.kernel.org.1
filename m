Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2524C703996
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244628AbjEORoD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244614AbjEORnl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:43:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC06816EB7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8163462E54
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AF4C433EF;
        Mon, 15 May 2023 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172472;
        bh=bVRFA+3lK9mnwHwTl25DW8xoZ7QDfzX9Or5NnrxqsZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCXHP1P7asPYfRk7eN5rpdw05W+n7mRvkFp3WrIASXkN5kLK/n+CRAicQa90VlJCn
         riIGNFVtmUs/gHcDkEYZKPs0k6uXbST+p8iQuww8kc0m2ZPJIAx5wzhtknHZPoMgLA
         xdmYXr1hsPYJ16xO3RtBW17oSwU1FXHJ2OlvJTjk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 136/381] wifi: rtw88: mac: Return the original error from rtw_mac_power_switch()
Date:   Mon, 15 May 2023 18:26:27 +0200
Message-Id: <20230515161742.977016099@linuxfoundation.org>
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 15c8e267dfa62f207ee1db666c822324e3362b84 ]

rtw_mac_power_switch() calls rtw_pwr_seq_parser() which can return
-EINVAL, -EBUSY or 0. Propagate the original error code instead of
unconditionally returning -EINVAL in case of an error.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230226221004.138331-3-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index fd427c606fa2d..a6d554a9dd995 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -247,6 +247,7 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	const struct rtw_pwr_seq_cmd **pwr_seq;
 	u8 rpwm;
 	bool cur_pwr;
+	int ret;
 
 	if (rtw_chip_wcpu_11ac(rtwdev)) {
 		rpwm = rtw_read8(rtwdev, rtwdev->hci.rpwm_addr);
@@ -270,8 +271,9 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 		return -EALREADY;
 
 	pwr_seq = pwr_on ? chip->pwr_on_seq : chip->pwr_off_seq;
-	if (rtw_pwr_seq_parser(rtwdev, pwr_seq))
-		return -EINVAL;
+	ret = rtw_pwr_seq_parser(rtwdev, pwr_seq);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.39.2



