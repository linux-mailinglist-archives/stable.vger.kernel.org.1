Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD075D3F8
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjGUTQa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjGUTQ2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B941FD7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E83F61D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1ECC433C8;
        Fri, 21 Jul 2023 19:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966986;
        bh=ngsIzsPzrzMX6YbLTUvq4x0WrC59CFbmiljbnGdU1TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftZ7Fnr9K7JWjO3Fp3d8OFt8pU68JEEqi2qQVmIEQCfYLGxqqZzTv6I1tutGOYSPE
         I26rnw3JpnLBQiJB+Ges6EKps1hZezkIjz3s6k4uRD8pT764plPELAj4V3u3Yk7TtL
         +0mh1Fpg5C9nEsCh+hlmmiXZFnRfUw+bE1UBnkRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Gorski <jonas.gorski@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.15 508/532] bus: ixp4xx: fix IXP4XX_EXP_T1_MASK
Date:   Fri, 21 Jul 2023 18:06:52 +0200
Message-ID: <20230721160642.196620640@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
 drivers/bus/intel-ixp4xx-eb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/intel-ixp4xx-eb.c b/drivers/bus/intel-ixp4xx-eb.c
index f5ba6bee6fd8..320cf307db05 100644
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
-- 
2.41.0



