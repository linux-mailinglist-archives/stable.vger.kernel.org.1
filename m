Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8EE75CD90
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGUQNE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjGUQMe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F595359F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8195061D32
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936DBC433C8;
        Fri, 21 Jul 2023 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955929;
        bh=1rgrk0atMSjBgI0G4aSAOGxx6F0MGujobWFfH5UHC5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7IDe2VOxWIRgJ4WFcX73JyNWRuhr5yE0NZvT+8JaqHv4MZ1Ozb38zFN9oFbmVf2J
         CRuGafnQhRXYU4C+b3ZtWuBwiWDVEHJxulwd0Ga9iOA4DQ4aCuVw1W1CTRxEuXAw9x
         4rlAO4AOn1oGKXKQ1EyaPtvE45lA33NMDgqxYqD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Klaus Kudielka <klaus.kudielka@gmail.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 042/292] net: mvneta: fix txq_map in case of txq_number==1
Date:   Fri, 21 Jul 2023 18:02:31 +0200
Message-ID: <20230721160530.612527510@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Klaus Kudielka <klaus.kudielka@gmail.com>

[ Upstream commit 21327f81db6337c8843ce755b01523c7d3df715b ]

If we boot with mvneta.txq_number=1, the txq_map is set incorrectly:
MVNETA_CPU_TXQ_ACCESS(1) refers to TX queue 1, but only TX queue 0 is
initialized. Fix this.

Fixes: 50bf8cb6fc9c ("net: mvneta: Configure XPS support")
Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Link: https://lore.kernel.org/r/20230705053712.3914-1-klaus.kudielka@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 2cad76d0a50ef..4401fad31fb98 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1505,7 +1505,7 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
 			 */
 			if (txq_number == 1)
 				txq_map = (cpu == pp->rxq_def) ?
-					MVNETA_CPU_TXQ_ACCESS(1) : 0;
+					MVNETA_CPU_TXQ_ACCESS(0) : 0;
 
 		} else {
 			txq_map = MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
@@ -4295,7 +4295,7 @@ static void mvneta_percpu_elect(struct mvneta_port *pp)
 		 */
 		if (txq_number == 1)
 			txq_map = (cpu == elected_cpu) ?
-				MVNETA_CPU_TXQ_ACCESS(1) : 0;
+				MVNETA_CPU_TXQ_ACCESS(0) : 0;
 		else
 			txq_map = mvreg_read(pp, MVNETA_CPU_MAP(cpu)) &
 				MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
-- 
2.39.2



