Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5705C78328B
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjHUUAw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjHUUAv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:00:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ABD11C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:00:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3B5964564
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2175C433C9;
        Mon, 21 Aug 2023 20:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648049;
        bh=I+raB3N1ZOvtlX2HGUjEngj12muty9u18VOFwAZxVR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EH8KHf+g8bVeHY3sq6c/EQOBLetDUTVvSMXjhfBt1NDFSeMVjguLXTgFkz6j2fJnf
         f7kFa0JBrSmXC4pGM7hqCj2ihO9PrjbI+bLdR6p4soHeHCKeEJsw0M8ifrhZKJ5YmU
         vr9lNqrT+YTjub5mhuca56bXv8NI8gufNagVyKDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fei Shao <fshao@chromium.org>,
        Jeff LaBundy <jeff@labundy.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 029/234] dt-bindings: input: goodix: Add "goodix,no-reset-during-suspend" property
Date:   Mon, 21 Aug 2023 21:39:52 +0200
Message-ID: <20230821194130.029134869@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fei Shao <fshao@chromium.org>

[ Upstream commit 359ed24a0dd3802e703ec8071dc3b6ed446de5f0 ]

We observed that on Chromebook device Steelix, if Goodix GT7375P
touchscreen is powered in suspend (because, for example, it connects to
an always-on regulator) and with the reset GPIO asserted, it will
introduce about 14mW power leakage.

To address that, we add this property to skip reset during suspend.
If it's set, the driver will stop asserting the reset GPIO during
power-down. Refer to the comments in the driver for details.

Signed-off-by: Fei Shao <fshao@chromium.org>
Suggested-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/input/goodix,gt7375p.yaml        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
index ce18d7dadae23..1edad1da1196d 100644
--- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
+++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
@@ -43,6 +43,15 @@ properties:
       itself as long as it allows the main board to make signals compatible
       with what the touchscreen is expecting for its IO rails.
 
+  goodix,no-reset-during-suspend:
+    description:
+      Set this to true to enforce the driver to not assert the reset GPIO
+      during suspend.
+      Due to potential touchscreen hardware flaw, back-powering could happen in
+      suspend if the power supply is on and with active-low reset GPIO asserted.
+      This property is used to avoid the back-powering issue.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.40.1



