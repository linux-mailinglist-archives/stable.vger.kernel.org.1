Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9801A787250
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241813AbjHXOwa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbjHXOwS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:52:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76D8A1
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65647659DA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767FDC433C7;
        Thu, 24 Aug 2023 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888735;
        bh=19FxRw+VBm/1ssrqx4LdXsDLFSN3d0csQqQ/upAEiUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sx3ZIIbi5ijW40o25wOxfuvq/bFbeaMdrqqO5vuXyA9DhnFJkADnU7+tcYHZKSB7u
         UMTDzUj5Wh23U9GPZO3TpJQTQQxk6FpZKyN/CmzQUxd7awNsUdlKcZIdMtM5PS/7ei
         sj3DpS7eEnhJT7CUDMlVFGlJ16RIZaAkNPGcclBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 023/139] thunderbolt: Read retimer NVM authentication status prior tb_retimer_set_inbound_sbtx()
Date:   Thu, 24 Aug 2023 16:49:06 +0200
Message-ID: <20230824145024.577640501@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 1402ba08abae5cfa583ff1a40b99c098a0532d41 ]

According to the USB4 retimer guide the correct order is immediately
after sending ENUMERATE_RETIMERS so update the code to follow this.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/retimer.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 566c03105fb8d..1b7ab0bbd1328 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -208,6 +208,21 @@ static ssize_t nvm_authenticate_show(struct device *dev,
 	return ret;
 }
 
+static void tb_retimer_nvm_authenticate_status(struct tb_port *port, u32 *status)
+{
+	int i;
+
+	tb_port_dbg(port, "reading NVM authentication status of retimers\n");
+
+	/*
+	 * Before doing anything else, read the authentication status.
+	 * If the retimer has it set, store it for the new retimer
+	 * device instance.
+	 */
+	for (i = 1; i <= TB_MAX_RETIMER_INDEX; i++)
+		usb4_port_retimer_nvm_authenticate_status(port, i, &status[i]);
+}
+
 static void tb_retimer_set_inbound_sbtx(struct tb_port *port)
 {
 	int i;
@@ -481,18 +496,16 @@ int tb_retimer_scan(struct tb_port *port, bool add)
 		return ret;
 
 	/*
-	 * Enable sideband channel for each retimer. We can do this
-	 * regardless whether there is device connected or not.
+	 * Immediately after sending enumerate retimers read the
+	 * authentication status of each retimer.
 	 */
-	tb_retimer_set_inbound_sbtx(port);
+	tb_retimer_nvm_authenticate_status(port, status);
 
 	/*
-	 * Before doing anything else, read the authentication status.
-	 * If the retimer has it set, store it for the new retimer
-	 * device instance.
+	 * Enable sideband channel for each retimer. We can do this
+	 * regardless whether there is device connected or not.
 	 */
-	for (i = 1; i <= TB_MAX_RETIMER_INDEX; i++)
-		usb4_port_retimer_nvm_authenticate_status(port, i, &status[i]);
+	tb_retimer_set_inbound_sbtx(port);
 
 	for (i = 1; i <= TB_MAX_RETIMER_INDEX; i++) {
 		/*
-- 
2.40.1



