Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA68C713DC2
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjE1T2l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjE1T2k (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:28:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3BFB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C092361D03
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3FBC433D2;
        Sun, 28 May 2023 19:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302119;
        bh=I2WkgRbjDBEh9lthIZ2qZW4kaYRRT0PVuCOHSVQXA7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2BIIMzScDZE7uculSb2dJ6s0xBAURKYxGeZb/bU2quyomSAbXXYoD4Q/iW5IdDvy
         4APS2vA1/SW1/lFjWc7CVY+kFc/FVJny3maSmFrqhsIz41hkiEXv6g7sYFPHbuZ5sX
         qnMulA6X2QSRhtWz9Gl6QevvyqLBXcUSSbk0pRVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 161/161] 3c589_cs: Fix an error handling path in tc589_probe()
Date:   Sun, 28 May 2023 20:11:25 +0100
Message-Id: <20230528190841.919997669@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
@@ -196,6 +196,7 @@ static int tc589_probe(struct pcmcia_dev
 {
 	struct el3_private *lp;
 	struct net_device *dev;
+	int ret;
 
 	dev_dbg(&link->dev, "3c589_attach()\n");
 
@@ -219,7 +220,15 @@ static int tc589_probe(struct pcmcia_dev
 
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


