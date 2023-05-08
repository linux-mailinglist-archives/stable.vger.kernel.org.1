Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2BA6FAB9A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjEHLPQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjEHLPP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:15:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A136CCB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 404E862BB7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF80C433EF;
        Mon,  8 May 2023 11:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544513;
        bh=CqdxlRARtYRWkig4nDgeWSsNt9j2F+l3MZQ9Ubx3IXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JwQQXCM6DAyW3X+BJDxppl/wIJ03Co3D2KG/AkXnVO87tHA6YLIPDqxFGyNTUalAj
         qPLBTz1sVr0HELLPv7Pw2AWFyYX9+SbAFN16GKxu48lxvgLpDeOib9iWrBtCk5dUVr
         Egnz3V7FvwvxZTc4gO5BrVduu6OAoTxat3/0pBbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 434/694] wifi: mt76: mt7915: unlock on error in mt7915_thermal_temp_store()
Date:   Mon,  8 May 2023 11:44:29 +0200
Message-Id: <20230508094447.482356835@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Dan Carpenter <error27@gmail.com>

[ Upstream commit cdc215c2c8d74b3c8886650e979b47f16c1f7f92 ]

Drop the lock before returning -EINVAL.

Fixes: ecaccdae7a7e ("wifi: mt76: mt7915: rework mt7915_thermal_temp_store()")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 5e288116b1b01..4f3efc942a4d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -89,6 +89,7 @@ static ssize_t mt7915_thermal_temp_store(struct device *dev,
 	     val < phy->throttle_temp[MT7915_CRIT_TEMP_IDX])) {
 		dev_err(phy->dev->mt76.dev,
 			"temp1_max shall be greater than temp1_crit.");
+		mutex_unlock(&phy->dev->mt76.mutex);
 		return -EINVAL;
 	}
 
-- 
2.39.2



