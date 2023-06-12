Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA972C0C5
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjFLKyg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbjFLKyO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B081FDF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28C6A614F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38875C433D2;
        Mon, 12 Jun 2023 10:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566382;
        bh=ML3KgEYnEnyOd4/iFaMec4F1uu56r2UAsx8G5a2JbfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yTCuAoPZDNOXsYM5f9rNsUX79P4VyOUKWAcFYpLkZiK1F2Je1e3boRuxYoDQI2i7h
         MjDeAbbScIib+Y6OAkE1oIhuGUZLtXdVopy0m3l5Z645jM/+VQ1fRuoUjP3moRrwh1
         yxoI7cpX3gvXARNgv3nwhuW/3puSXWO/Tz/alylU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 011/132] net: dsa: lan9303: allow vid != 0 in port_fdb_{add|del} methods
Date:   Mon, 12 Jun 2023 12:25:45 +0200
Message-ID: <20230612101710.797498520@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

[ Upstream commit 5a59a58ec25d44f853c26bdbfda47d73b3067435 ]

LAN9303 doesn't associate FDB (ALR) entries with VLANs, it has just one
global Address Logic Resolution table [1].

Ignore VID in port_fdb_{add|del} methods, go on with the global table. This
is the same semantics as hellcreek or RZ/N1 implement.

Visible symptoms:
LAN9303_MDIO 5b050000.ethernet-1:00: port 2 failed to delete 00:xx:xx:xx:xx:cf vid 1 from fdb: -2
LAN9303_MDIO 5b050000.ethernet-1:00: port 2 failed to add 00:xx:xx:xx:xx:cf vid 1 to fdb: -95

[1] https://ww1.microchip.com/downloads/en/DeviceDoc/00002308A.pdf

Fixes: 0620427ea0d6 ("net: dsa: lan9303: Add fdb/mdb manipulation")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20230531143826.477267-1-alexander.sverdlin@siemens.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/lan9303-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 2e270b4791432..a08e7cbb23c91 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1199,8 +1199,6 @@ static int lan9303_port_fdb_add(struct dsa_switch *ds, int port,
 	struct lan9303 *chip = ds->priv;
 
 	dev_dbg(chip->dev, "%s(%d, %pM, %d)\n", __func__, port, addr, vid);
-	if (vid)
-		return -EOPNOTSUPP;
 
 	return lan9303_alr_add_port(chip, addr, port, false);
 }
@@ -1212,8 +1210,6 @@ static int lan9303_port_fdb_del(struct dsa_switch *ds, int port,
 	struct lan9303 *chip = ds->priv;
 
 	dev_dbg(chip->dev, "%s(%d, %pM, %d)\n", __func__, port, addr, vid);
-	if (vid)
-		return -EOPNOTSUPP;
 	lan9303_alr_del_port(chip, addr, port);
 
 	return 0;
-- 
2.39.2



