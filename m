Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA57E23E9
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjKFNQG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjKFNQF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:16:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DBED8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:16:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6465FC433C8;
        Mon,  6 Nov 2023 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276562;
        bh=5P2xTagrHak8loe2MCy7J8A3FLnxolTd8zb+9zL4ewY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4dwKZOHWqiTkldNDkHxscsL1aP2e/+lJzXOM5LfmoxQGLfOxBL5JDg9pyOpPUAa2
         4NQRGAZBY6CmD2MgmT6MfY5qMoK40HrPH1q6hSwHHiif3L45SpzeRmI47uwyLoTfSH
         1pekIDhoZCDq2R+ThA063jFYpomLqCwATM3fGPsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Zary <linux@zary.sk>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 14/88] ata: pata_parport: fit3: implement IDE command set registers
Date:   Mon,  6 Nov 2023 14:03:08 +0100
Message-ID: <20231106130306.321619580@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Zary <linux@zary.sk>

[ Upstream commit 0c1e81d0b5ebd5813536dd5fcf5966ad043f37dc ]

fit3 protocol driver does not support accessing IDE control registers
(device control/altstatus). The DOS driver does not use these registers
either (as observed from DOSEMU trace). But the HW seems to be capable
of accessing these registers - I simply tried bit 3 and it works!

The control register is required to properly reset ATAPI devices or
they will be detected only once (after a power cycle).

Tested with EXP Computer CD-865 with MC-1285B EPP cable and
TransDisk 3000.

Signed-off-by: Ondrej Zary <linux@zary.sk>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/pata_parport/fit3.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index bad7aa920cdca..d2b81cf2e16d2 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -9,11 +9,6 @@
  *
  * The TD-2000 and certain older devices use a different protocol.
  * Try the fit2 protocol module with them.
- *
- * NB:  The FIT adapters do not appear to support the control
- * registers.  So, we map ALT_STATUS to STATUS and NO-OP writes
- * to the device control register - this means that IDE reset
- * will not work on these devices.
  */
 
 #include <linux/module.h>
@@ -37,8 +32,7 @@
 
 static void fit3_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 {
-	if (cont == 1)
-		return;
+	regr += cont << 3;
 
 	switch (pi->mode) {
 	case 0:
@@ -59,11 +53,7 @@ static int fit3_read_regr(struct pi_adapter *pi, int cont, int regr)
 {
 	int  a, b;
 
-	if (cont) {
-		if (regr != 6)
-			return 0xff;
-		regr = 7;
-	}
+	regr += cont << 3;
 
 	switch (pi->mode) {
 	case 0:
-- 
2.42.0



