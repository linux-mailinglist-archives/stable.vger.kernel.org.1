Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713CC6FA9C4
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjEHKz3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjEHKys (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC46930AEE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:54:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34A1F6297D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4083DC433D2;
        Mon,  8 May 2023 10:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543244;
        bh=GRAUdwK3g0uB6qbs4mc8HpcNgecEEAsCozKvvrhm46g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uufdom9bfeAhHDYxAWHAjYaAH5VYSdAUTGryx+CJRsjlupFeI3cmTTuu6j3X8a8FN
         pFnFmCV+bJhrprecC509az4DruL3dgyOXYadOokzBqXVGEuRm7KJByiM738zrftBPs
         ezCRFoKsVrBosT1nTRJvuvKFcxHVDmMmQoDBrPRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.3 029/694] serial: fix TIOCSRS485 locking
Date:   Mon,  8 May 2023 11:37:44 +0200
Message-Id: <20230508094433.591864458@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>

commit 9e4f2a8004213339e9d837d891a59cc80e082966 upstream.

The RS485 multipoint addressing support for some reason added a new
ADDRB termios cflag which is (only!) updated from one of the RS485
ioctls.

Make sure to take the termios rw semaphore for the right ioctl (i.e.
set, not get).

Fixes: ae50bb275283 ("serial: take termios_rwsem for ->rs485_config() & pass termios as param")
Cc: stable@vger.kernel.org	# 6.0
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20230412124811.11217-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1552,7 +1552,7 @@ uart_ioctl(struct tty_struct *tty, unsig
 		goto out;
 
 	/* rs485_config requires more locking than others */
-	if (cmd == TIOCGRS485)
+	if (cmd == TIOCSRS485)
 		down_write(&tty->termios_rwsem);
 
 	mutex_lock(&port->mutex);
@@ -1595,7 +1595,7 @@ uart_ioctl(struct tty_struct *tty, unsig
 	}
 out_up:
 	mutex_unlock(&port->mutex);
-	if (cmd == TIOCGRS485)
+	if (cmd == TIOCSRS485)
 		up_write(&tty->termios_rwsem);
 out:
 	return ret;


