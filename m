Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A81C7616FB
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjGYLoZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjGYLnw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A1E199D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:43:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33D5961654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F64C433CA;
        Tue, 25 Jul 2023 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285426;
        bh=UhyQDB98Zn9QYjr4U0UgihMWd1dLinu7subL29Nt/Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYr4QUoj1z+6ozKzH18cwbT0VTczMrOZTROJpxlfUt4NYFDruJTU+I3tubBe+OQ40
         MHkqgVV8o5dFQUAIXd70Bn9m2YjVigTzA87B91vBKlK/iokbY7A5PEAgV08gcOHBy9
         LBVbLhw4Uir39XFBQfY7a9Hhk4E6bq1texM4vC2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Klaus Kudielka <klaus.kudielka@gmail.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 201/313] net: mvneta: fix txq_map in case of txq_number==1
Date:   Tue, 25 Jul 2023 12:45:54 +0200
Message-ID: <20230725104529.706359394@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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
index 977c2961aa2c2..110221a16bf6d 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1422,7 +1422,7 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
 			 */
 			if (txq_number == 1)
 				txq_map = (cpu == pp->rxq_def) ?
-					MVNETA_CPU_TXQ_ACCESS(1) : 0;
+					MVNETA_CPU_TXQ_ACCESS(0) : 0;
 
 		} else {
 			txq_map = MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
@@ -3762,7 +3762,7 @@ static void mvneta_percpu_elect(struct mvneta_port *pp)
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



