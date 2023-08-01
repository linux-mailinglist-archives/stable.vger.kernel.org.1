Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102AE76AF20
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjHAJpS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjHAJpB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F220D10D4
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:43:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AD326150E
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5E5C433C8;
        Tue,  1 Aug 2023 09:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882985;
        bh=MeO4VOxWkoKF+a1dMi/IpGydodY8BNRvcxWDvkhcdO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3xT+/GSUi5OIJt945Pz1HmB7ctob6jF6iMkbs5YOtMT/otM8+MrqNuNbjQ8h7NKb
         /YTDIvbYBWp4LtNaDooxSGw2hZJYzqotgKU15lsEQDZsN/qVP9Q19NtVnfHrWi+4a2
         JzSvLVFTbZK9XRLROLt3EMD2OkoBmujD4BjxdymI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 074/239] atheros: fix return value check in atl1_tso()
Date:   Tue,  1 Aug 2023 11:18:58 +0200
Message-ID: <20230801091928.367695596@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yuanjun Gong <ruc_gongyuanjun@163.com>

[ Upstream commit ed96824b71ed67664390890441b229423a25317f ]

in atl1_tso(), it should check the return value of pskb_trim(),
and return an error code if an unexpected value is returned
by pskb_trim().

Fixes: 401c0aabec4b ("atl1: simplify tx packet descriptor")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
Link: https://lore.kernel.org/r/20230722142511.12448-1-ruc_gongyuanjun@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index c8444bcdf5270..02aa6fd8ebc2d 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -2113,8 +2113,11 @@ static int atl1_tso(struct atl1_adapter *adapter, struct sk_buff *skb,
 
 			real_len = (((unsigned char *)iph - skb->data) +
 				ntohs(iph->tot_len));
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 			hdr_len = skb_tcp_all_headers(skb);
 			if (skb->len == hdr_len) {
 				iph->check = 0;
-- 
2.39.2



