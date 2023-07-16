Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C097553C5
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjGPUWp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjGPUWo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343EABC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7C9260EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64B1C433C8;
        Sun, 16 Jul 2023 20:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538963;
        bh=FUuAnzOv50s8PZIxEX+8QPPRrmavaKFDTWKqABI7x5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NySUcWeg4e42yLoz0G20q6dj/BebuII/CMxJSkRMI4XdANsaKzeELN6WKe1+Y1hId
         m6BFwnIwUuPBWg5CRknf6WqRatAX7Brw7IzM9jQpm+BF5xgk2TDRBaKxXkGuvGV16f
         Lh365XBwyTCYjPAEyKq9D4cyRlvF1YzxAkSt1KKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 639/800] misc: fastrpc: check return value of devm_kasprintf()
Date:   Sun, 16 Jul 2023 21:48:12 +0200
Message-ID: <20230716195003.955948935@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit af2e19d82a116bc622eea84c9faadd5f7e20bec4 ]

devm_kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: 3abe3ab3cdab ("misc: fastrpc: add secure domain support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230615102546.581899-1-claudiu.beznea@microchip.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 30d4d0476248f..9051551d99373 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2225,6 +2225,9 @@ static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ct
 	fdev->miscdev.fops = &fastrpc_fops;
 	fdev->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "fastrpc-%s%s",
 					    domain, is_secured ? "-secure" : "");
+	if (!fdev->miscdev.name)
+		return -ENOMEM;
+
 	err = misc_register(&fdev->miscdev);
 	if (!err) {
 		if (is_secured)
-- 
2.39.2



