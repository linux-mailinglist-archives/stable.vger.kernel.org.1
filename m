Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F317DD3FE
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbjJaRGj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbjJaRGX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7B7D73
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:04:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F93C433C7;
        Tue, 31 Oct 2023 17:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771857;
        bh=GRSws6JG/6XaGWpNEPruK4gcfGFTDlu8JNBc4lMrsXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AtHIZVZhAIdAohT6l1QxzzdlXas351y9S5OCuvJuye0i/76aKur05tKw1sAa2V7UA
         WcHbcQ03pyoiEeUIzc4GDBy1OKm3/jjeHofnMc9fC4YFLy7QDfB3Cbnfr5MwJfdVB5
         xSCU45mkXLfAhp+z1oklnSENDvH/x7zmGEJ4pEA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 44/86] net: ieee802154: adf7242: Fix some potential buffer overflow in adf7242_stats_show()
Date:   Tue, 31 Oct 2023 18:01:09 +0100
Message-ID: <20231031165919.980101035@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ca082f019d8fbb983f03080487946da714154bae ]

strncat() usage in adf7242_debugfs_init() is wrong.
The size given to strncat() is the maximum number of bytes that can be
written, excluding the trailing NULL.

Here, the size that is passed, DNAME_INLINE_LEN, does not take into account
the size of "adf7242-" that is already in the array.

In order to fix it, use snprintf() instead.

Fixes: 7302b9d90117 ("ieee802154/adf7242: Driver for ADF7242 MAC IEEE802154")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/adf7242.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 5cf218c674a5a..32d92bdabd234 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1162,9 +1162,10 @@ static int adf7242_stats_show(struct seq_file *file, void *offset)
 
 static void adf7242_debugfs_init(struct adf7242_local *lp)
 {
-	char debugfs_dir_name[DNAME_INLINE_LEN + 1] = "adf7242-";
+	char debugfs_dir_name[DNAME_INLINE_LEN + 1];
 
-	strncat(debugfs_dir_name, dev_name(&lp->spi->dev), DNAME_INLINE_LEN);
+	snprintf(debugfs_dir_name, sizeof(debugfs_dir_name),
+		 "adf7242-%s", dev_name(&lp->spi->dev));
 
 	lp->debugfs_root = debugfs_create_dir(debugfs_dir_name, NULL);
 
-- 
2.42.0



