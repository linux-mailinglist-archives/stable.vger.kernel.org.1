Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0C4703A70
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbjEORvI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244903AbjEORum (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898471B75C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6122262F21
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573FAC433D2;
        Mon, 15 May 2023 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172928;
        bh=jMuUOgIu8Yv/QEghRySHjIYMRgs8xq45SiW/u5cuJLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKXnS96+IsdbXD91kS4lVf5vDS4w5LxkXrKqSUNZWWSNcddbIEXxcHRtB8+ifo+rU
         KiBdaRlpgglogTQG5w5L/w/nWUlXWD1PhP4YqFfxHZEaZVDcEOG8Ru2vOxRaBacqNt
         FiQ0R782oeZzmATZO5l1s8xWUO6Uy/spHyabtHu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 312/381] net: dsa: mv88e6xxx: add mv88e6321 rsvd2cpu
Date:   Mon, 15 May 2023 18:29:23 +0200
Message-Id: <20230515161750.928104459@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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
index 0b104a90c0d80..321c821876f65 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4182,6 +4182,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
+	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
-- 
2.39.2



