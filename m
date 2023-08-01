Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0222676AE3F
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjHAJhP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjHAJg6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E714EEA
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B739614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F689C433C8;
        Tue,  1 Aug 2023 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882505;
        bh=A6+Al5i39VM4XIx65EAS8+h+NSAGGCHmal1OJ1Q5NLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEQjVD7s82BuoXKMDJUrrrva7Vm6JN3P9wmGiNLRw/Yd+KPW3ucZrV837vWmBu7/W
         IiS87Q0ireavvMpwPBmGYLNEjYhD2VJwdTHCwRxDDdcWLCpv/L7qlNurU96pdlXQId
         bxeWIyFJVx9m9ckvgu98HcGdChKdgzJrSLe+Wmn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stefano Stabellini <stefano.stabellini@amd.com>,
        Petr Mladek <pmladek@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/228] xenbus: check xen_domain in xenbus_probe_initcall
Date:   Tue,  1 Aug 2023 11:19:48 +0200
Message-ID: <20230801091927.441709632@linuxfoundation.org>
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

From: Stefano Stabellini <sstabellini@kernel.org>

[ Upstream commit 0d8f7cc8057890db08c54fe610d8a94af59da082 ]

The same way we already do in xenbus_init.
Fixes the following warning:

[  352.175563] Trying to free already-free IRQ 0
[  352.177355] WARNING: CPU: 1 PID: 88 at kernel/irq/manage.c:1893 free_irq+0xbf/0x350
[...]
[  352.213951] Call Trace:
[  352.214390]  <TASK>
[  352.214717]  ? __warn+0x81/0x170
[  352.215436]  ? free_irq+0xbf/0x350
[  352.215906]  ? report_bug+0x10b/0x200
[  352.216408]  ? prb_read_valid+0x17/0x20
[  352.216926]  ? handle_bug+0x44/0x80
[  352.217409]  ? exc_invalid_op+0x13/0x60
[  352.217932]  ? asm_exc_invalid_op+0x16/0x20
[  352.218497]  ? free_irq+0xbf/0x350
[  352.218979]  ? __pfx_xenbus_probe_thread+0x10/0x10
[  352.219600]  xenbus_probe+0x7a/0x80
[  352.221030]  xenbus_probe_thread+0x76/0xc0

Fixes: 5b3353949e89 ("xen: add support for initializing xenstore later as HVM domain")
Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Link: https://lore.kernel.org/r/alpine.DEB.2.22.394.2307211609140.3118466@ubuntu-linux-20-04-desktop
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xenbus/xenbus_probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 58b732dcbfb83..639bf628389ba 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -811,6 +811,9 @@ static int xenbus_probe_thread(void *unused)
 
 static int __init xenbus_probe_initcall(void)
 {
+	if (!xen_domain())
+		return -ENODEV;
+
 	/*
 	 * Probe XenBus here in the XS_PV case, and also XS_HVM unless we
 	 * need to wait for the platform PCI device to come up or
-- 
2.40.1



