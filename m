Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65304703B55
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbjEOSB5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbjEOSBX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29515EE3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:58:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CCB562FFA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865C8C433EF;
        Mon, 15 May 2023 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173479;
        bh=bBdUAVV0RYC/YpqvXMiO4l5a8MmvdmknqI3y8HEjviM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kr/yI+RsUirrWyz30+p+qnrImHMXGFVXMpbtOFmVQzO+xDrqkt/n/Ei2RySJNxznf
         /Zg2TtPRNN5dfP+UddoM/bflnizhyTepGiQ1aomI7JS/bnrm8y0fkPpLB/kmgHbwKw
         i7joDyTY40EKH+0xkves2P7+GGvOV5R7XZUBWZkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 079/282] wifi: rtw88: mac: Return the original error from rtw_pwr_seq_parser()
Date:   Mon, 15 May 2023 18:27:37 +0200
Message-Id: <20230515161724.606089440@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit b7ed9fa2cb76ca7a3c3cd4a6d35748fe1fbda9f6 ]

rtw_pwr_seq_parser() calls rtw_sub_pwr_seq_parser() which can either
return -EBUSY, -EINVAL or 0. Propagate the original error code instead
of unconditionally returning -EBUSY in case of an error.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230226221004.138331-2-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index b61b073031e57..9a50984fa06c9 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -210,7 +210,7 @@ static int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
 
 		ret = rtw_sub_pwr_seq_parser(rtwdev, intf_mask, cut_mask, cmd);
 		if (ret)
-			return -EBUSY;
+			return ret;
 
 		idx++;
 	} while (1);
-- 
2.39.2



