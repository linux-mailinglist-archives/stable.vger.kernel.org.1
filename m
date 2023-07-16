Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BBE7554DB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGPUew (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjGPUev (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEE0E40
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC6F460DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0094C433C8;
        Sun, 16 Jul 2023 20:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539689;
        bh=HFRw48G4DtXnPqIuIC57uDqU175yi+0rBLI+YnZvbfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXiNSfcSwGSQdQuKPEa+QfruobwZBEl+MozAyjyai2DsIREDGxHrW9TbKaLeDpCpQ
         bSpVWfNFJ6sTGyXLII6xK+FUSxp1byY9e8U7bWB+DqGxK7ppFBfIB+I0nYAsnNKZxi
         eo3EvG81yxZJJLODvrpRKjBpXLiygWbXZtslAhi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 096/591] wifi: rsi: Do not configure WoWlan in shutdown hook if not enabled
Date:   Sun, 16 Jul 2023 21:43:55 +0200
Message-ID: <20230716194926.362037009@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit b241e260820b68c09586e8a0ae0fc23c0e3215bd ]

In case WoWlan was never configured during the operation of the system,
the hw->wiphy->wowlan_config will be NULL. rsi_config_wowlan() checks
whether wowlan_config is non-NULL and if it is not, then WARNs about it.
The warning is valid, as during normal operation the rsi_config_wowlan()
should only ever be called with non-NULL wowlan_config. In shutdown this
rsi_config_wowlan() should only ever be called if WoWlan was configured
before by the user.

Add checks for non-NULL wowlan_config into the shutdown hook. While at it,
check whether the wiphy is also non-NULL before accessing wowlan_config .
Drop the single-use wowlan_config variable, just inline it into function
call.

Fixes: 16bbc3eb8372 ("rsi: fix null pointer dereference during rsi_shutdown()")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230527222833.273741-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index d09998796ac08..6e33a2563fdbd 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1463,10 +1463,8 @@ static void rsi_shutdown(struct device *dev)
 
 	rsi_dbg(ERR_ZONE, "SDIO Bus shutdown =====>\n");
 
-	if (hw) {
-		struct cfg80211_wowlan *wowlan = hw->wiphy->wowlan_config;
-
-		if (rsi_config_wowlan(adapter, wowlan))
+	if (hw && hw->wiphy && hw->wiphy->wowlan_config) {
+		if (rsi_config_wowlan(adapter, hw->wiphy->wowlan_config))
 			rsi_dbg(ERR_ZONE, "Failed to configure WoWLAN\n");
 	}
 
-- 
2.39.2



