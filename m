Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407D3761146
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjGYKt2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjGYKt1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15F31992
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6619C6166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784C8C433C7;
        Tue, 25 Jul 2023 10:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282165;
        bh=7T2DPTOoLmiRd6u5GJm4UbTReHasuM5ATY3HK3MeBNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qa7UyKUSzlf4C46Nf6UrQZrbWk4LXleL3A/LuHhgpdtljnFIVU0hWoCpmTkmcMrIb
         QJoIQDzJtEp+9D7HzJPYkNiOc7ovIbnkmJFieT3UR7ZbN2m1c0DdYE+CsF4UqOtrak
         ZRGlhgiHmIfGjNy2KxHOxfWY9YiwaxIhb04z1OIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cyril Brulebois <cyril@debamax.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 6.4 030/227] of: Preserve "of-display" device name for compatibility
Date:   Tue, 25 Jul 2023 12:43:17 +0200
Message-ID: <20230725104516.080741125@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rob Herring <robh@kernel.org>

commit 0bb8f49cd2cc8cb32ac51189ff9fcbe7ec3d9d65 upstream.

Since commit 241d2fb56a18 ("of: Make OF framebuffer device names unique"),
as spotted by Frédéric Bonnard, the historical "of-display" device is
gone: the updated logic creates "of-display.0" instead, then as many
"of-display.N" as required.

This means that offb no longer finds the expected device, which prevents
the Debian Installer from setting up its interface, at least on ppc64el.

Fix this by keeping "of-display" for the first device and "of-display.N"
for subsequent devices.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217328
Link: https://bugs.debian.org/1033058
Fixes: 241d2fb56a18 ("of: Make OF framebuffer device names unique")
Cc: stable@vger.kernel.org
Cc: Cyril Brulebois <cyril@debamax.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>
Acked-by: Helge Deller <deller@gmx.de>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Michal Suchánek <msuchanek@suse.de>
Link: https://lore.kernel.org/r/20230710174007.2291013-1-robh@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -553,7 +553,7 @@ static int __init of_platform_default_po
 			if (!of_get_property(node, "linux,opened", NULL) ||
 			    !of_get_property(node, "linux,boot-display", NULL))
 				continue;
-			dev = of_platform_device_create(node, "of-display.0", NULL);
+			dev = of_platform_device_create(node, "of-display", NULL);
 			of_node_put(node);
 			if (WARN_ON(!dev))
 				return -ENOMEM;


