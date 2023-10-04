Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2FA7B88E0
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbjJDSU0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbjJDSUZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:20:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E826AA7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:20:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3091FC433C7;
        Wed,  4 Oct 2023 18:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443622;
        bh=KOrPUjZFFCNWkmMKtmqUqNRmcWd71nYff24ymxZrHYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XsX47F5vQLcHrCEJzoC57KyjPzuTASbrH+lctZtYRDQV3wrwMXZ9BGD9bEVsC3utq
         G7bDknX2CunUOhTCb4ZKGSge0rQCkkHQCHZOtnt6kHHm+9mXlAPWquWEHRfAfYi5hD
         aASYLjSGJH8GHC62vzrAaGQP/J976KZzgd/irUt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johnathan Mantey <johnathanx.mantey@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 193/259] ncsi: Propagate carrier gain/loss events to the NCSI controller
Date:   Wed,  4 Oct 2023 19:56:06 +0200
Message-ID: <20231004175226.144292242@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johnathan Mantey <johnathanx.mantey@intel.com>

[ Upstream commit 3780bb29311eccb7a1c9641032a112eed237f7e3 ]

Report the carrier/no-carrier state for the network interface
shared between the BMC and the passthrough channel. Without this
functionality the BMC is unable to reconfigure the NIC in the event
of a re-cabling to a different subnet.

Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ncsi/ncsi-aen.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 62fb1031763d1..f8854bff286cb 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -89,6 +89,11 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	if ((had_link == has_link) || chained)
 		return 0;
 
+	if (had_link)
+		netif_carrier_off(ndp->ndev.dev);
+	else
+		netif_carrier_on(ndp->ndev.dev);
+
 	if (!ndp->multi_package && !nc->package->multi_channel) {
 		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
-- 
2.40.1



