Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5458A742C80
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjF2StD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjF2Ssg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6734330DF
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4F01615F7
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CC0C433C0;
        Thu, 29 Jun 2023 18:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064514;
        bh=nWgWPGv8CBwLY98GMC+Y6sSczCH5PlqgIQz6Ff4XSPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbIXXKSsD0Q/HwZx0jz0xbejUIaEQawn8rhvDwP/U/xGhH//GPDHs/vN29QlhxTEa
         3fzNtkYrbYHApogG6/ev+UXRbm+TXn4SfVPf9n59Sn7RvgaZ5SI0CtsGac+9jtxBsN
         00pqfa/TkH8+yEZjDYmdwMEtLUp/iDmNHSH0eNnU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.4 04/28] x86/smp: Remove pointless wmb()s from native_stop_other_cpus()
Date:   Thu, 29 Jun 2023 20:43:52 +0200
Message-ID: <20230629184152.070823428@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.888604958@linuxfoundation.org>
References: <20230629184151.888604958@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 2affa6d6db28855e6340b060b809c23477aa546e upstream.

The wmb()s before sending the IPIs are not synchronizing anything.

If at all then the apic IPI functions have to provide or act as appropriate
barriers.

Remove these cargo cult barriers which have no explanation of what they are
synchronizing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230615193330.378358382@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/smp.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -184,9 +184,6 @@ static void native_stop_other_cpus(int w
 	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
 	if (!cpumask_empty(&cpus_stop_mask)) {
-		/* sync above data before sending IRQ */
-		wmb();
-
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*
@@ -208,9 +205,6 @@ static void native_stop_other_cpus(int w
 		 * CPUs to stop.
 		 */
 		if (!smp_no_nmi_ipi && !register_stop_handler()) {
-			/* Sync above data before sending IRQ */
-			wmb();
-
 			pr_emerg("Shutting down cpus with NMI\n");
 
 			for_each_cpu(cpu, &cpus_stop_mask)


