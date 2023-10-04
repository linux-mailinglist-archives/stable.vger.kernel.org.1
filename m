Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017AD7B89AE
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbjJDS2I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbjJDS2H (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:28:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A24D7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:28:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25615C433C8;
        Wed,  4 Oct 2023 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444083;
        bh=v4OiZQFpgpE864WAHpvizxgC8UwdO5mX6XHyLLBR8Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NtF2N5bqK3lZlqiFRigPP0rXF876KfoqL2SdTsLHa8SAYYdVMS5g4g5EHQBRo4EP3
         SoLgdqnI/TL/qR/9mKVNW9jTbtS1Wund4ucQQwX8W5KJ0qLoxC5EGWTj4mCLv4R5M0
         IX2wDZbszvqgUJYBldM/9uoZMLeGiuE6nQ15cVc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 125/321] power: supply: mt6370: Fix missing error code in mt6370_chg_toggle_cfo()
Date:   Wed,  4 Oct 2023 19:54:30 +0200
Message-ID: <20231004175235.032609882@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit 779873ec81306d2c40c459fa7c91a5d40655510d ]

When mt6370_chg_field_get() suceeds, ret is set to zero and returning
zero when flash led is still in strobe mode looks incorrect.

Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger driver")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: ChiaEn Wu <chiaen_wu@richtek.com>
Link: https://lore.kernel.org/r/20230906084815.2827930-1-harshit.m.mogalapalli@oracle.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/mt6370-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index f27dae5043f5b..a9641bd3d8cf8 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -324,7 +324,7 @@ static int mt6370_chg_toggle_cfo(struct mt6370_priv *priv)
 
 	if (fl_strobe) {
 		dev_err(priv->dev, "Flash led is still in strobe mode\n");
-		return ret;
+		return -EINVAL;
 	}
 
 	/* cfo off */
-- 
2.40.1



