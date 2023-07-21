Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19F375D2EE
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGUTFV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjGUTFU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4FC30CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:05:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51AAE61D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BB7C433CA;
        Fri, 21 Jul 2023 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966315;
        bh=J2lDcGqvpfLrSAW3RkTH9qO3IByZ+BTwfVAiaR7rBE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2vqfqCxTxDvvwLGEL2eDaii8+8f+0kYrvGZkahKoGMWQGVwjvfuaGcA/BQ9o6l1k
         kezmmIU73GBUuXPgYSIknVdwVS7eilPlj+llhDyAh0sCsZQhH2+RqHXqsDtT8dY5PX
         6RyDgSKvi/QkIhIcfTas4u3rtD04E7PeN1prnQTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Phil Elwell <phil@raspberrypi.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 301/532] nvmem: rmem: Use NVMEM_DEVID_AUTO
Date:   Fri, 21 Jul 2023 18:03:25 +0200
Message-ID: <20230721160630.724973843@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.com>

[ Upstream commit 09dd7b993eddb3b48634fd5ddf27aa799785a9ee ]

It is reasonable to declare multiple nvmem blocks. Unless a unique 'id'
is passed in for each block there may be name clashes.

Avoid this by using the magic token NVMEM_DEVID_AUTO.

Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20230611140330.154222-6-srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/rmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index 80cb187f14817..752d0bf4445ee 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -71,6 +71,7 @@ static int rmem_probe(struct platform_device *pdev)
 	config.dev = dev;
 	config.priv = priv;
 	config.name = "rmem";
+	config.id = NVMEM_DEVID_AUTO;
 	config.size = mem->size;
 	config.reg_read = rmem_read;
 
-- 
2.39.2



