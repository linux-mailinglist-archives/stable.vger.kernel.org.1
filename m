Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DC7703835
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbjEOR3i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbjEOR3M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:29:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448DC120A3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C9262CB3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB45C4339B;
        Mon, 15 May 2023 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171616;
        bh=LLezx0IRucv1RV+3noGzzS8zmfu+BNHnm6724uHKmY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RaMrPKYxJ2PWy3P1ASOpKyV6uHNuO6Noz4fKirFLUsdd8ozaUuWJ5sK/zRlIM0ntU
         MamGFZQ3x+0eTvRfTFaRgLIyVy2HIuJiVAJ/Nk43Vqy+6ifGvY0RMI57YxsytXVgLJ
         2oGCob/tiJOrzmyNiC2lNQxow6VrMVs8g3//xk6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 024/134] net: dsa: mv88e6xxx: add mv88e6321 rsvd2cpu
Date:   Mon, 15 May 2023 18:28:21 +0200
Message-Id: <20230515161703.820875491@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Angelo Dureghello <angelo.dureghello@timesys.com>

[ Upstream commit 6686317855c6997671982d4489ccdd946f644957 ]

Add rsvd2cpu capability for mv88e6321 model, to allow proper bpdu
processing.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Fixes: 51c901a775621 ("net: dsa: mv88e6xxx: distinguish Global 2 Rsvd2CPU")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index bc363fca2895f..b33aee4404de2 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4575,6 +4575,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
+	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
-- 
2.39.2



