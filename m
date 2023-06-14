Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320C0726DDC
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjFGUqZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjFGUqI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:46:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23722D40
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AC406467D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389A4C433EF;
        Wed,  7 Jun 2023 20:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170747;
        bh=lPkjKh3VSeD7zFOib0sRqqqhSihnZ3Mqhs4DaI2r1xU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAyk3qlW4muu56q4tNpJuWpuxmEEdpvYM0svwJqXv6H8fha3wcgHiaqKWF38o27Uo
         NRIRafAe1QnfnkmSokG4XFn7TCJ3k0RKrI+RFgRth3/ZXqLNIXSTePdNoevONdIprp
         1dz7Y5OgG8tpSQ6IeU5pybyh3hB+tA26UtMW61VA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herve Codina <herve.codina@bootlin.com>,
        kernel test robot <lkp@intel.com>, stable <stable@kernel.org>
Subject: [PATCH 6.1 202/225] serial: cpm_uart: Fix a COMPILE_TEST dependency
Date:   Wed,  7 Jun 2023 22:16:35 +0200
Message-ID: <20230607200920.973708695@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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

From: Herve Codina <herve.codina@bootlin.com>

commit 7183c37fd53eee1e795206e625da12a5d7ec1e1a upstream.

In a COMPILE_TEST configuration, the cpm_uart driver uses symbols from
the cpm_uart_cpm2.c file. This file is compiled only when CONFIG_CPM2 is
set.

Without this dependency, the linker fails with some missing symbols for
COMPILE_TEST configuration that needs SERIAL_CPM without enabling CPM2.

This lead to:
  depends on CPM2 || CPM1 || (PPC32 && CPM2 && COMPILE_TEST)

This dependency does not make sense anymore and can be simplified
removing all the COMPILE_TEST part.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/
Fixes: e3e7b13bffae ("serial: allow COMPILE_TEST for some drivers")
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20230523085902.75837-3-herve.codina@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/Kconfig             |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -769,7 +769,7 @@ config SERIAL_PMACZILOG_CONSOLE
 
 config SERIAL_CPM
 	tristate "CPM SCC/SMC serial port support"
-	depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)
+	depends on CPM2 || CPM1
 	select SERIAL_CORE
 	help
 	  This driver supports the SCC and SMC serial ports on Motorola 
--- a/drivers/tty/serial/cpm_uart/cpm_uart.h
+++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
@@ -19,8 +19,6 @@ struct gpio_desc;
 #include "cpm_uart_cpm2.h"
 #elif defined(CONFIG_CPM1)
 #include "cpm_uart_cpm1.h"
-#elif defined(CONFIG_COMPILE_TEST)
-#include "cpm_uart_cpm2.h"
 #endif
 
 #define SERIAL_CPM_MAJOR	204


