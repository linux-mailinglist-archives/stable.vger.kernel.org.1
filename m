Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA7275CF27
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjGUQ1v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjGUQ1g (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:27:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF70E4C29
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5DEB61D34
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8533C433C8;
        Fri, 21 Jul 2023 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956601;
        bh=WHKpEHO3pGTM8hBvykkXGqWRseUZVZwmxk/uprVTlN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zXUlAVy67BLSoMOngSAyT/CSqUdJ1m37DjQqL6HzIBxYQWL7oqtK8LTwHTJd+MFgI
         t0yqC75Ryt3VMJGwxJ8li5dUTALYlSNxw1WkYImaot3IFSJ6dRhB5c4aKrLXP9Bvzo
         hja+j+hlNAeCNY5r8xkosRbcYWq06LmaP4ImF2Ok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Gorski <jonas.gorski@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6.4 234/292] bus: ixp4xx: fix IXP4XX_EXP_T1_MASK
Date:   Fri, 21 Jul 2023 18:05:43 +0200
Message-ID: <20230721160538.913974286@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jonas Gorski <jonas.gorski@gmail.com>

commit 6722e46513e0af8e2fff4698f7cb78bc50a9f13f upstream.

The IXP4XX_EXP_T1_MASK was shifted one bit to the right, overlapping
IXP4XX_EXP_T2_MASK and leaving bit 29 unused. The offset being wrong is
also confirmed at least by the datasheet of IXP45X/46X [1].

Fix this by aligning it to IXP4XX_EXP_T1_SHIFT.

[1] https://www.intel.com/content/dam/www/public/us/en/documents/manuals/ixp45x-ixp46x-developers-manual.pdf

Cc: stable@vger.kernel.org
Fixes: 1c953bda90ca ("bus: ixp4xx: Add a driver for IXP4xx expansion bus")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Link: https://lore.kernel.org/r/20230624112958.27727-1-jonas.gorski@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20230624122139.3229642-1-linus.walleij@linaro.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/intel-ixp4xx-eb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/bus/intel-ixp4xx-eb.c
+++ b/drivers/bus/intel-ixp4xx-eb.c
@@ -33,7 +33,7 @@
 #define IXP4XX_EXP_TIMING_STRIDE	0x04
 #define IXP4XX_EXP_CS_EN		BIT(31)
 #define IXP456_EXP_PAR_EN		BIT(30) /* Only on IXP45x and IXP46x */
-#define IXP4XX_EXP_T1_MASK		GENMASK(28, 27)
+#define IXP4XX_EXP_T1_MASK		GENMASK(29, 28)
 #define IXP4XX_EXP_T1_SHIFT		28
 #define IXP4XX_EXP_T2_MASK		GENMASK(27, 26)
 #define IXP4XX_EXP_T2_SHIFT		26


