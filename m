Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE617554C8
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjGPUeY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjGPUeX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503BF9F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA05460EBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FA9C433C8;
        Sun, 16 Jul 2023 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539661;
        bh=795XjNeKTIUuV2hjpNON2NWXeeZ7ellz9oGaPgUy2ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1GiBh1aYcxblZHdW5AhJ7QAJijvsq2nCDoUGyDN+QbcIr/aCFeL2J+V9W4lBsq3jv
         /K+lvgb6msDCohHqgLrCTEyAAAfFnHMBXaqh5UcHUQUTRRYIKyUh2rm44RR4UEe51c
         KUuEbqXepbGJoEXEM8vuzh7GZXyG6OcQgxdA08DQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 087/591] wifi: orinoco: Fix an error handling path in orinoco_cs_probe()
Date:   Sun, 16 Jul 2023 21:43:46 +0200
Message-ID: <20230716194926.132494263@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 67a81d911c01225f426cc6bee2373df044c1a9b7 ]

Should orinoco_cs_config() fail, some resources need to be released as
already done in the remove function.

While at it, remove a useless and erroneous comment. The probe is
orinoco_cs_probe(), not orinoco_cs_attach().

Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/e24735ce4d82901d5f7ea08419eea53bfdde3d65.1684568286.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_cs.c b/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
index a956f965a1e5e..03bfd2482656c 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
@@ -96,6 +96,7 @@ orinoco_cs_probe(struct pcmcia_device *link)
 {
 	struct orinoco_private *priv;
 	struct orinoco_pccard *card;
+	int ret;
 
 	priv = alloc_orinocodev(sizeof(*card), &link->dev,
 				orinoco_cs_hard_reset, NULL);
@@ -107,8 +108,16 @@ orinoco_cs_probe(struct pcmcia_device *link)
 	card->p_dev = link;
 	link->priv = priv;
 
-	return orinoco_cs_config(link);
-}				/* orinoco_cs_attach */
+	ret = orinoco_cs_config(link);
+	if (ret)
+		goto err_free_orinocodev;
+
+	return 0;
+
+err_free_orinocodev:
+	free_orinocodev(priv);
+	return ret;
+}
 
 static void orinoco_cs_detach(struct pcmcia_device *link)
 {
-- 
2.39.2



