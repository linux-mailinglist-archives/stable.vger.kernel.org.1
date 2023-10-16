Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43B57CA383
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjJPJHS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjJPJHR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:07:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0647CE8
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:07:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC83C433C7;
        Mon, 16 Oct 2023 09:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697447235;
        bh=P0FWg8A+To99wqREMN4xG1K51nR52MNIHUH4IWL/GLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSlC/Mu/GP1HRJacHso0OpRkg6wuOtqC0lUyvs1CzJnAU/2Lrwq/eJWyKtaeOB2N9
         LSxCIuqk+273Oq7kGNDzy9NbJLpwgiabwExX5TscDWIPxdrYM8HnKa4cZDpZIQSG3Q
         KKTvgv276kCz1Vui7C67/wJ6JxHgf9nggu6HureI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Zary <linux@zary.sk>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 6.5 015/191] ata: pata_parport: implement set_devctl
Date:   Mon, 16 Oct 2023 10:40:00 +0200
Message-ID: <20231016084015.758562187@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Zary <linux@zary.sk>

commit d2302427c12277929c9f390adeda19fbf403c0bb upstream.

Add missing ops->sff_set_devctl implementation.

Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
Cc: stable@vger.kernel.org
Signed-off-by: Ondrej Zary <linux@zary.sk>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/pata_parport/pata_parport.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 258d189f42e5..cf87bbb52f1f 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -51,6 +51,13 @@ static void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
 	ata_sff_pause(ap);
 }
 
+static void pata_parport_set_devctl(struct ata_port *ap, u8 ctl)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+
+	pi->proto->write_regr(pi, 1, 6, ctl);
+}
+
 static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
 {
 	struct pi_adapter *pi = ap->host->private_data;
@@ -252,6 +259,7 @@ static struct ata_port_operations pata_parport_port_ops = {
 	.hardreset		= NULL,
 
 	.sff_dev_select		= pata_parport_dev_select,
+	.sff_set_devctl		= pata_parport_set_devctl,
 	.sff_check_status	= pata_parport_check_status,
 	.sff_check_altstatus	= pata_parport_check_altstatus,
 	.sff_tf_load		= pata_parport_tf_load,
-- 
2.42.0



