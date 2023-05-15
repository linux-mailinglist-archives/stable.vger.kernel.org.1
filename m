Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077B8703742
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243836AbjEORTB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbjEORSP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:18:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DA110A05
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B585662C07
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA735C433EF;
        Mon, 15 May 2023 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171003;
        bh=rCR/umXWjr3fBettugLtcE2iJQTWkq6+wtzDClOh1uI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aaWYJQ4lIBTio43/6rY4lU53JqEl3EJ9alJhviDu4OxDWluM2OaQObB8ePSRuvX8k
         hP+rta7bi+pplpnKOAkWgS/OVSRaJn1EzZy76o5B1ln5NCcMG25Lgq4Kg7BD7To9g5
         gI0Yz11LcwrcpMAlfbp/Eb6yrB39shnOnQ4Zlv54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cosmo Chou <chou.cosmo@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 042/242] net/ncsi: clear Tx enable mode when handling a Config required AEN
Date:   Mon, 15 May 2023 18:26:08 +0200
Message-Id: <20230515161723.179660116@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Cosmo Chou <chou.cosmo@gmail.com>

[ Upstream commit 6f75cd166a5a3c0bc50441faa8b8304f60522fdd ]

ncsi_channel_is_tx() determines whether a given channel should be
used for Tx or not. However, when reconfiguring the channel by
handling a Configuration Required AEN, there is a misjudgment that
the channel Tx has already been enabled, which results in the Enable
Channel Network Tx command not being sent.

Clear the channel Tx enable flag before reconfiguring the channel to
avoid the misjudgment.

Fixes: 8d951a75d022 ("net/ncsi: Configure multi-package, multi-channel modes with failover")
Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ncsi/ncsi-aen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index b635c194f0a85..62fb1031763d1 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -165,6 +165,7 @@ static int ncsi_aen_handler_cr(struct ncsi_dev_priv *ndp,
 	nc->state = NCSI_CHANNEL_INACTIVE;
 	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
 	spin_unlock_irqrestore(&ndp->lock, flags);
+	nc->modes[NCSI_MODE_TX_ENABLE].enable = 0;
 
 	return ncsi_process_next_channel(ndp);
 }
-- 
2.39.2



