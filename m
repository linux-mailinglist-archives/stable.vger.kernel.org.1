Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB675D2ED
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjGUTFV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjGUTFU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8012F2D4A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1584261D8E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232D1C433C7;
        Fri, 21 Jul 2023 19:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966318;
        bh=ds2pkiK9ioYtLMnF1E+bHeq+zdya3OIjPr/fc76HNNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rtf5lr/YGXD6hT/TdlzM6WgxL7yZb/jYdIyQM9LJzxUzlhVG46vnbADmlQch4vBK6
         NOKfK6L1UedD7ZrtHSB/STioSK7GAeThEiSuatDA+MjvtDi8rab3ZyNmY+0qrxyYFA
         qygSDrAW2PF7vgAVfRE/fhSCno9hyT3MNzc4eHD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 302/532] mfd: stmfx: Fix error path in stmfx_chip_init
Date:   Fri, 21 Jul 2023 18:03:26 +0200
Message-ID: <20230721160630.777884375@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

[ Upstream commit f592cf624531286f8b52e40dcfc157a5a7fb115c ]

In error path, disable vdd regulator if it exists, but don't overload ret.
Because if regulator_disable() is successful, stmfx_chip_init will exit
successfully while chip init failed.

Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Link: https://lore.kernel.org/r/20230609092804.793100-1-amelie.delaunay@foss.st.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index e095a39301423..6e1629beb8094 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -387,7 +387,7 @@ static int stmfx_chip_init(struct i2c_client *client)
 
 err:
 	if (stmfx->vdd)
-		return regulator_disable(stmfx->vdd);
+		regulator_disable(stmfx->vdd);
 
 	return ret;
 }
-- 
2.39.2



