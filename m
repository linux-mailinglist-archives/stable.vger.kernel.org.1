Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6AD74C283
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjGILV1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjGILV0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:21:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E780A186
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A19D60BD6
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAA1C433C7;
        Sun,  9 Jul 2023 11:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901683;
        bh=HFRw48G4DtXnPqIuIC57uDqU175yi+0rBLI+YnZvbfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ocf8PinoAbQMDM9Vci7xC5Fr2eysSUPWDDSGzBjmX3VonjJmvQ2bdtCqGPNPMMuht
         xHbXPk8FVhQgrJrNETcAq8Ou77K6xiLQA8X4H/NI+uoQ+VOsJ+c9OzjusTy271lAej
         Y76MHKU51cycYmNSk4YSxwf3K9BohJVBUmDuQwjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 108/431] wifi: rsi: Do not configure WoWlan in shutdown hook if not enabled
Date:   Sun,  9 Jul 2023 13:10:56 +0200
Message-ID: <20230709111453.686012647@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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



