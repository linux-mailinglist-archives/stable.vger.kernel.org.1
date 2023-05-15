Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DFC703B39
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbjEOSA4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243726AbjEOSAa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3DC18AA2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 107C362F5E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BDAC433EF;
        Mon, 15 May 2023 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173469;
        bh=jn/KJPtko9C4vM80ZJrD0xZOWj4M0n48uYm3g9CACgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQzt8zM0UeICA2Y3B8qaNyzde6PNf5zlWJ2jub2SK7uWhtyiWpZbXnsb+5kPZwFyL
         R2SR46/Y6HWCX58hNqbukNjXplPhOXS1TeUCj4J00h8eMe1FzrZ6Lf+J8qZwsGMjr1
         tm4nsmRqXGvE+fqLl/yUDmsOad2oLBVNOwl5OPRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 076/282] wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()
Date:   Mon, 15 May 2023 18:27:34 +0200
Message-Id: <20230515161724.520119785@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

[ Upstream commit 4c856ee12df85aabd437c3836ed9f68d94268358 ]

This loop checks that i < max at the start of loop but then it does
i++ which could put it past the end of the array.  It's harmless to
check again and prevent a potential out of bounds.

Fixes: 1048643ea94d ("ath5k: Clean up eeprom parsing and add missing calibration data")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/Y+D9hPQrHfWBJhXz@kili
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath5k/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/eeprom.c b/drivers/net/wireless/ath/ath5k/eeprom.c
index 01163b3339451..92f5c8e830901 100644
--- a/drivers/net/wireless/ath/ath5k/eeprom.c
+++ b/drivers/net/wireless/ath/ath5k/eeprom.c
@@ -529,7 +529,7 @@ ath5k_eeprom_read_freq_list(struct ath5k_hw *ah, int *offset, int max,
 		ee->ee_n_piers[mode]++;
 
 		freq2 = (val >> 8) & 0xff;
-		if (!freq2)
+		if (!freq2 || i >= max)
 			break;
 
 		pc[i++].freq = ath5k_eeprom_bin2freq(ee,
-- 
2.39.2



