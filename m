Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BEB75D1F5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjGUSyk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGUSyi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:54:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F2E30DB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2360A61D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A95C433C7;
        Fri, 21 Jul 2023 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965675;
        bh=5dAIn7Nr+d7M9/hyO4N8LiqjnNv8Yzt4wctCtt/euJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEM3yWRhCj+5CxKX4XhFJaibwQAQ81SJclimqu6/PK7SawBk+af28LTvabRo2hwhf
         sFa/b0O2RinON9l2xjKMVCHKBtoY2m23U7tmW+4eSlVfVgHNppSxSR6BjClfBMrpLg
         OTgqvO5gnFOIYFtxjjd2CgRXq8OzdfCrqSbpF34Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com
Subject: [PATCH 5.15 036/532] wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx
Date:   Fri, 21 Jul 2023 17:59:00 +0200
Message-ID: <20230721160616.615620424@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit f24292e827088bba8de7158501ac25a59b064953 ]

For the reasons also described in commit b383e8abed41 ("wifi: ath9k: avoid
uninit memory read in ath9k_htc_rx_msg()"), ath9k_htc_rx_msg() should
validate pkt_len before accessing the SKB.

For example, the obtained SKB may have been badly constructed with
pkt_len = 8. In this case, the SKB can only contain a valid htc_frame_hdr
but after being processed in ath9k_htc_rx_msg() and passed to
ath9k_wmi_ctrl_rx() endpoint RX handler, it is expected to have a WMI
command header which should be located inside its data payload.

Implement sanity checking inside ath9k_wmi_ctrl_rx(). Otherwise, uninit
memory can be referenced.

Tested on Qualcomm Atheros Communications AR9271 802.11n .

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Reported-and-tested-by: syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230424183348.111355-1-pchelkin@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 19345b8f7bfd5..d652c647d56b5 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -221,6 +221,10 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 	if (unlikely(wmi->stopped))
 		goto free_skb;
 
+	/* Validate the obtained SKB. */
+	if (unlikely(skb->len < sizeof(struct wmi_cmd_hdr)))
+		goto free_skb;
+
 	hdr = (struct wmi_cmd_hdr *) skb->data;
 	cmd_id = be16_to_cpu(hdr->command_id);
 
-- 
2.39.2



