Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E502178332C
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjHUUBj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjHUUBj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16ED123
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78656647BC
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA8EC433C7;
        Mon, 21 Aug 2023 20:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648096;
        bh=76E95/0VY2/tj+dd09IQjONFX4AAk3rfVARNyNq0lQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xleGDJ6P6Ifii6Dsh+kUdzfvfv49c1Kkmbd8cncmNObYCCkOuMwfJ8E5YsmGuOS6q
         nCRyHDj1K4BCldJnZ41buRG9KTBfThUwYSU2UQ1Zmdpzh+2THMNCLEhr2NTSkI2Une
         b1wbY4ajey5KZL84/KcJcCh0avmyYeFDxexiCZ4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 053/234] thunderbolt: Read retimer NVM authentication status prior tb_retimer_set_inbound_sbtx()
Date:   Mon, 21 Aug 2023 21:40:16 +0200
Message-ID: <20230821194131.082054856@linuxfoundation.org>
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
index 9cc28197dbc45..edbd92435b41a 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -187,6 +187,21 @@ static ssize_t nvm_authenticate_show(struct device *dev,
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
@@ -455,18 +470,16 @@ int tb_retimer_scan(struct tb_port *port, bool add)
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



