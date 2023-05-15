Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567FA7037EB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbjEORZN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244271AbjEORYx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F7D9016
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E09EB62C99
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D252AC4339B;
        Mon, 15 May 2023 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171432;
        bh=TXKItwxrTfBoYe0oOuo94XUFSly+tpmtflGT5Hiac+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phWteSYhvCFts+RnKdMrZPYoqY/bGkGCZAmUEd3XyNvjGTW7JRQh8lyYRSvyejo9q
         h01AshVUkl46JhqSjBL9MPu6JM86j+uhEavLpM72OPlR6UNukDIL+FUtbcIWEnx9/e
         /flBsrumShZlG0m0Msi06/C95JhcUj6FqpDmlb6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zev Weiss <zev@bewilderbeest.net>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH 6.2 167/242] ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED
Date:   Mon, 15 May 2023 18:28:13 +0200
Message-Id: <20230515161726.890305419@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Zev Weiss <zev@bewilderbeest.net>

commit a3fd10732d276d7cf372c6746a78a1c8b6aa7541 upstream.

Turns out it's in fact not the same as the heartbeat LED.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Cc: stable@vger.kernel.org # v5.18+
Fixes: a9a3d60b937a ("ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC")
Link: https://lore.kernel.org/r/20230224000400.12226-2-zev@bewilderbeest.net
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
@@ -31,7 +31,7 @@
 		};
 
 		system-fault {
-			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
 			panic-indicator;
 		};
 	};


