Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5D8713FEF
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjE1Tul (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjE1Tuj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:50:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B68C9C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:50:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 206FE6205D
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D740C433D2;
        Sun, 28 May 2023 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303437;
        bh=y3/oTmxZMZyUd9mxFMw5smXixd37XJ8Q1HejfZBBX4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ocCc+waPRHzlzaUib5E5pmCYfm5bZjBQwTmB7qqu2G2FUCtpr3kBZ3IsbrZp+bY+2
         7VxXIZon0WLUCJOqXVkTdM1ZzBpnNYmhZlczQVEH8/twiFpnLKRo170Ug+YRA4dP6m
         DHBgSeR2b5gcaxbG6N5ENEBS0V/GEp1wkaEZ3qm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 68/69] 3c589_cs: Fix an error handling path in tc589_probe()
Date:   Sun, 28 May 2023 20:12:28 +0100
Message-Id: <20230528190830.924513247@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 640bf95b2c7c2981fb471acdafbd3e0458f8390d upstream.

Should tc589_config() fail, some resources need to be released as already
done in the remove function.

Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/d8593ae867b24c79063646e36f9b18b0790107cb.1684575975.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/3com/3c589_cs.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/3com/3c589_cs.c
+++ b/drivers/net/ethernet/3com/3c589_cs.c
@@ -195,6 +195,7 @@ static int tc589_probe(struct pcmcia_dev
 {
 	struct el3_private *lp;
 	struct net_device *dev;
+	int ret;
 
 	dev_dbg(&link->dev, "3c589_attach()\n");
 
@@ -218,7 +219,15 @@ static int tc589_probe(struct pcmcia_dev
 
 	dev->ethtool_ops = &netdev_ethtool_ops;
 
-	return tc589_config(link);
+	ret = tc589_config(link);
+	if (ret)
+		goto err_free_netdev;
+
+	return 0;
+
+err_free_netdev:
+	free_netdev(dev);
+	return ret;
 }
 
 static void tc589_detach(struct pcmcia_device *link)


