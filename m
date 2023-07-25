Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C376140A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjGYLQD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjGYLPu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515F81BE3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E427461683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB2BC433C7;
        Tue, 25 Jul 2023 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283710;
        bh=JjH1o7vXcnPx4jxPljo2uQ3pa+zew3WkmOp1B7oNTYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rrs6/1Q/SdGk4rjcicDV8mBzjExOOY6CMK/6Eaer7BR7Mov/Wc6vxzeDSnUF9gSNK
         mpwjOpKnGXGTf4KF0lrK08p/edKTVcnJvUFbjMR96iIUYB7O/cKQIGmdyXfHoE2s0Y
         /uEuBpLquvMOet/TqqMbXshFdYIpZAJHyYq16d6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 056/509] wifi: orinoco: Fix an error handling path in spectrum_cs_probe()
Date:   Tue, 25 Jul 2023 12:39:55 +0200
Message-ID: <20230725104556.243837496@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 925244325159824385209e3e0e3f91fa6bf0646c ]

Should spectrum_cs_config() fail, some resources need to be released as
already done in the remove function.

While at it, remove a useless and erroneous comment. The probe is
spectrum_cs_probe(), not spectrum_cs_attach().

Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/c0bc0c21c58ca477fc5521607615bafbf2aef8eb.1684567733.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intersil/orinoco/spectrum_cs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/spectrum_cs.c b/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
index 291ef97ed45ec..841d623c621ac 100644
--- a/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
+++ b/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
@@ -157,6 +157,7 @@ spectrum_cs_probe(struct pcmcia_device *link)
 {
 	struct orinoco_private *priv;
 	struct orinoco_pccard *card;
+	int ret;
 
 	priv = alloc_orinocodev(sizeof(*card), &link->dev,
 				spectrum_cs_hard_reset,
@@ -169,8 +170,16 @@ spectrum_cs_probe(struct pcmcia_device *link)
 	card->p_dev = link;
 	link->priv = priv;
 
-	return spectrum_cs_config(link);
-}				/* spectrum_cs_attach */
+	ret = spectrum_cs_config(link);
+	if (ret)
+		goto err_free_orinocodev;
+
+	return 0;
+
+err_free_orinocodev:
+	free_orinocodev(priv);
+	return ret;
+}
 
 static void spectrum_cs_detach(struct pcmcia_device *link)
 {
-- 
2.39.2



