Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06768713C63
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjE1TOz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjE1TOy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC256C4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA1F618E2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B1DC4339B;
        Sun, 28 May 2023 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301292;
        bh=iYdcSmd8QBZDPJ8VxPEgbcimXwBt4vuz3XRLRfwZ4hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnC+RD0416HHerM9LwM7wAThyOSPFD5GTUxvbS3bEkoJPUZ8CQ92i6pqsAnFKuQW6
         7K2nB7XNd/sJUY0wC6R9ese/0iLwJIAyvAkmhVKLritLoh3GMFEkhg6F+3U3GABiEY
         Z2hqo0wgtewUImsB67zn71mpcWk0V/6mdpCAB/Uw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.14 59/86] parisc: Allow to reboot machine after system halt
Date:   Sun, 28 May 2023 20:10:33 +0100
Message-Id: <20230528190830.786712527@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
References: <20230528190828.564682883@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit 2028315cf59bb899a5ac7e87dc48ecb8fac7ac24 upstream.

In case a machine can't power-off itself on system shutdown,
allow the user to reboot it by pressing the RETURN key.

Cc: <stable@vger.kernel.org> # v4.14+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/process.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -142,13 +142,18 @@ void machine_power_off(void)
 	/* It seems we have no way to power the system off via
 	 * software. The user has to press the button himself. */
 
-	printk(KERN_EMERG "System shut down completed.\n"
-	       "Please power this system off now.");
+	printk("Power off or press RETURN to reboot.\n");
 
 	/* prevent soft lockup/stalled CPU messages for endless loop. */
 	rcu_sysrq_start();
 	lockup_detector_soft_poweroff();
-	for (;;);
+	while (1) {
+		/* reboot if user presses RETURN key */
+		if (pdc_iodc_getc() == 13) {
+			printk("Rebooting...\n");
+			machine_restart(NULL);
+		}
+	}
 }
 
 void (*pm_power_off)(void) = machine_power_off;


