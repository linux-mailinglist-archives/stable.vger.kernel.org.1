Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8189D7ECC4B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjKOT17 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjKOT16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:27:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AE41A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:27:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B253C433CC;
        Wed, 15 Nov 2023 19:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076474;
        bh=aaC7MY2A6kTS5Uw1jLlzZESxr8Fj0P51DYsf662xBOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jE65xFEr8aspnnp2s1RkFUQiQqffelMTTXpwxvck1q31+ZnXVq7YGgOU1WeaAifrH
         i7/dcL1RUrhcBQDHfK5sQNmaCtRlMqBFe6ggP0FQnxgBZ8nGw4mUcGNta5J80NFHoj
         xXmRQpXx5zbKQKG40I/D2Iku1A9PEeCp+w7I5icM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 312/550] crypto: hisilicon/hpre - Fix a erroneous check after snprintf()
Date:   Wed, 15 Nov 2023 14:14:56 -0500
Message-ID: <20231115191622.467728734@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit c977950146720abff14e46d8c53f5638b06a9182 ]

This error handling looks really strange.
Check if the string has been truncated instead.

Fixes: 02ab994635eb ("crypto: hisilicon - Fixed some tiny bugs of HPRE")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 5d0adfb54a34b..655138d21e71f 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -1030,7 +1030,7 @@ static int hpre_cluster_debugfs_init(struct hisi_qm *qm)
 
 	for (i = 0; i < clusters_num; i++) {
 		ret = snprintf(buf, HPRE_DBGFS_VAL_MAX_LEN, "cluster%d", i);
-		if (ret < 0)
+		if (ret >= HPRE_DBGFS_VAL_MAX_LEN)
 			return -EINVAL;
 		tmp_d = debugfs_create_dir(buf, qm->debug.debug_root);
 
-- 
2.42.0



