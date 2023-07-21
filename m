Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE9675D4C9
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjGUTZD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjGUTY7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:24:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF703A98
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49CFC61D54
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304E7C433C8;
        Fri, 21 Jul 2023 19:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967489;
        bh=kfIlJwZe38+0rz4TlZ9MscRtJZ2Qt4rWqoFtHY2jWXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elgsBmpl25kCMde6MhS17aS9PZpKJtluPvy7kk7HXmdD3c8mLqI/QD/I78l2aA8B5
         AjuLHv8x6Ip4EPDcMBAG6OVEt1qRX6qt3k/k4kJiixOzPePBVeP2dAYDgPJWRoHF06
         EMxGA9ShrkfPHbHU1iUZe9LpNMrAZl7AID6aIpJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <jstultz@google.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 181/223] regmap-irq: Fix out-of-bounds access when allocating config buffers
Date:   Fri, 21 Jul 2023 18:07:14 +0200
Message-ID: <20230721160528.596627491@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
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

From: Isaac J. Manjarres <isaacmanjarres@google.com>

commit 963b54df82b6d6206d7def273390bf3f7af558e1 upstream.

When allocating the 2D array for handling IRQ type registers in
regmap_add_irq_chip_fwnode(), the intent is to allocate a matrix
with num_config_bases rows and num_config_regs columns.

This is currently handled by allocating a buffer to hold a pointer for
each row (i.e. num_config_bases). After that, the logic attempts to
allocate the memory required to hold the register configuration for
each row. However, instead of doing this allocation for each row
(i.e. num_config_bases allocations), the logic erroneously does this
allocation num_config_regs number of times.

This scenario can lead to out-of-bounds accesses when num_config_regs
is greater than num_config_bases. Fix this by updating the terminating
condition of the loop that allocates the memory for holding the register
configuration to allocate memory only for each row in the matrix.

Amit Pundir reported a crash that was occurring on his db845c device
due to memory corruption (see "Closes" tag for Amit's report). The KASAN
report below helped narrow it down to this issue:

[   14.033877][    T1] ==================================================================
[   14.042507][    T1] BUG: KASAN: invalid-access in regmap_add_irq_chip_fwnode+0x594/0x1364
[   14.050796][    T1] Write of size 8 at addr 06ffff8081021850 by task init/1

[   14.242004][    T1] The buggy address belongs to the object at ffffff8081021850
[   14.242004][    T1]  which belongs to the cache kmalloc-8 of size 8
[   14.255669][    T1] The buggy address is located 0 bytes inside of
[   14.255669][    T1]  8-byte region [ffffff8081021850, ffffff8081021858)

Fixes: faa87ce9196d ("regmap-irq: Introduce config registers for irq types")
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Closes: https://lore.kernel.org/all/CAMi1Hd04mu6JojT3y6wyN2YeVkPR5R3qnkKJ8iR8if_YByCn4w@mail.gmail.com/
Tested-by: John Stultz <jstultz@google.com>
Tested-by: Amit Pundir <amit.pundir@linaro.org> # tested on Dragonboard 845c
Cc: stable@vger.kernel.org # v6.0+
Cc: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Link: https://lore.kernel.org/r/20230711193059.2480971-1-isaacmanjarres@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/regmap/regmap-irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -843,7 +843,7 @@ int regmap_add_irq_chip_fwnode(struct fw
 		if (!d->config_buf)
 			goto err_alloc;
 
-		for (i = 0; i < chip->num_config_regs; i++) {
+		for (i = 0; i < chip->num_config_bases; i++) {
 			d->config_buf[i] = kcalloc(chip->num_config_regs,
 						   sizeof(**d->config_buf),
 						   GFP_KERNEL);


