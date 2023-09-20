Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79C27A7D8A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjITMK0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjITMJ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:09:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E732C6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:09:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9882C433C8;
        Wed, 20 Sep 2023 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211791;
        bh=7tIBM9wjq/paXlRCv2rgin6RuFVQB3XnMey3i6wwshA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3KeL3KxidmqwXAMKhDdiKoN8w2SPyf3Z4mYP0jKy+FT9kbwvmJ/Y6BoIAprGUk96
         jgpxyK2xTIGZCCadOhoKMk4tzvmvbsVm6oZaLWGUwAlYm4aAHwBJ1klt68hCIn/3t3
         4PP3Kpb5D4xwn8tolysMfTV6mYLIwYKHfuI6DVHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Subject: [PATCH 4.19 010/273] serial: sc16is7xx: fix bug when first setting GPIO direction
Date:   Wed, 20 Sep 2023 13:27:30 +0200
Message-ID: <20230920112846.749680257@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

commit 9baeea723c0fb9c3ba9a336369f758ed9bc6831d upstream.

When configuring a pin as an output pin with a value of logic 0, we
end up as having a value of logic 1 on the output pin. Setting a
logic 0 a second time (or more) after that will correctly output a
logic 0 on the output pin.

By default, all GPIO pins are configured as inputs. When we enter
sc16is7xx_gpio_direction_output() for the first time, we first set the
desired value in IOSTATE, and then we configure the pin as an output.
The datasheet states that writing to IOSTATE register will trigger a
transfer of the value to the I/O pin configured as output, so if the
pin is configured as an input, nothing will be transferred.

Therefore, set the direction first in IODIR, and then set the desired
value in IOSTATE.

This is what is done in NXP application note AN10587.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
Link: https://lore.kernel.org/r/20230807214556.540627-6-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1166,9 +1166,18 @@ static int sc16is7xx_gpio_direction_outp
 		state |= BIT(offset);
 	else
 		state &= ~BIT(offset);
-	sc16is7xx_port_write(port, SC16IS7XX_IOSTATE_REG, state);
+
+	/*
+	 * If we write IOSTATE first, and then IODIR, the output value is not
+	 * transferred to the corresponding I/O pin.
+	 * The datasheet states that each register bit will be transferred to
+	 * the corresponding I/O pin programmed as output when writing to
+	 * IOSTATE. Therefore, configure direction first with IODIR, and then
+	 * set value after with IOSTATE.
+	 */
 	sc16is7xx_port_update(port, SC16IS7XX_IODIR_REG, BIT(offset),
 			      BIT(offset));
+	sc16is7xx_port_write(port, SC16IS7XX_IOSTATE_REG, state);
 
 	return 0;
 }


