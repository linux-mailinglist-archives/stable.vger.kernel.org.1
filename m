Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B8376AE6A
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjHAJid (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjHAJiB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E062736
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:36:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91D0B61507
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE2FC433C9;
        Tue,  1 Aug 2023 09:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882575;
        bh=fOkkrAkZBlriAJNrBQVZNSWli/C37UZRFIbFxhLbJMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kfv+9azXfZNMmcYvwg6H1bBcjezBa1gW9FXPniv4/VZIOCNKdY93Ji7lPOmd/eFCn
         Ko8oC/QcSeK8xzWdxw4Q/HQyHLX3QbDfCq1kMEmapTmt6o1m53bSbvPU+qbCI95FEe
         J1sYrG1icoEFBX6DszllpukJ9lpQoOftnD4cet68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 6.1 155/228] serial: sifive: Fix sifive_serial_console_setup() section
Date:   Tue,  1 Aug 2023 11:20:13 +0200
Message-ID: <20230801091928.500436277@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

From: Samuel Holland <samuel.holland@sifive.com>

commit 9b8fef6345d5487137d4193bb0a0eae2203c284e upstream.

This function is called indirectly from the platform driver probe
function. Even if the driver is built in, it may be probed after
free_initmem() due to deferral or unbinding/binding via sysfs.
Thus the function cannot be marked as __init.

Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
Cc: stable <stable@kernel.org>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Link: https://lore.kernel.org/r/20230624060159.3401369-1-samuel.holland@sifive.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sifive.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -832,7 +832,7 @@ static void sifive_serial_console_write(
 	local_irq_restore(flags);
 }
 
-static int __init sifive_serial_console_setup(struct console *co, char *options)
+static int sifive_serial_console_setup(struct console *co, char *options)
 {
 	struct sifive_serial_port *ssp;
 	int baud = SIFIVE_DEFAULT_BAUD_RATE;


