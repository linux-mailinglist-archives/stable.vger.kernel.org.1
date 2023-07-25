Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208B5761614
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjGYLg1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjGYLgX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5524518F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36543616A3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418A8C433C9;
        Tue, 25 Jul 2023 11:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284974;
        bh=yEl9qgBktJrd/5roW7PC8Zb9Uw6dBFZE8tJFHoAQaM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DT4CBy1jN4SHLwRo8QI9KV9nqEn2kWQyD/8IgEAfuPf03j9+n8RQmoXWHsAMj/zET
         D5BDyOa2yVaClwuXPbwEFyOKb+SoHT8y0ZM/IAmkXZQxaAwqagR7WT1DZsnswzKbFw
         tLnZbcdaA6zXe+skzK3qWR0Ud9uoBAt7AA0FkXtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 039/313] wifi: atmel: Fix an error handling path in atmel_probe()
Date:   Tue, 25 Jul 2023 12:43:12 +0200
Message-ID: <20230725104522.758011792@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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

[ Upstream commit 6b92e4351a29af52c285fe235e6e4d1a75de04b2 ]

Should atmel_config() fail, some resources need to be released as already
done in the remove function.

While at it, remove a useless and erroneous comment. The probe is
atmel_probe(), not atmel_attach().

Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/1e65f174607a83348034197fa7d603bab10ba4a9.1684569156.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/atmel/atmel_cs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/atmel/atmel_cs.c b/drivers/net/wireless/atmel/atmel_cs.c
index 7afc9c5329fb1..f5fa1a95b0c15 100644
--- a/drivers/net/wireless/atmel/atmel_cs.c
+++ b/drivers/net/wireless/atmel/atmel_cs.c
@@ -73,6 +73,7 @@ struct local_info {
 static int atmel_probe(struct pcmcia_device *p_dev)
 {
 	struct local_info *local;
+	int ret;
 
 	dev_dbg(&p_dev->dev, "atmel_attach()\n");
 
@@ -83,8 +84,16 @@ static int atmel_probe(struct pcmcia_device *p_dev)
 
 	p_dev->priv = local;
 
-	return atmel_config(p_dev);
-} /* atmel_attach */
+	ret = atmel_config(p_dev);
+	if (ret)
+		goto err_free_priv;
+
+	return 0;
+
+err_free_priv:
+	kfree(p_dev->priv);
+	return ret;
+}
 
 static void atmel_detach(struct pcmcia_device *link)
 {
-- 
2.39.2



