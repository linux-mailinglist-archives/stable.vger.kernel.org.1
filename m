Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AC86FAB13
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjEHLJ1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEHLIm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716B02ABED
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:08:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D9D62B05
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A5CC433D2;
        Mon,  8 May 2023 11:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544120;
        bh=ejPmx/SwaUhrm6/WLNfu8NVLhMTcc/UvjcAOq7HF5Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/rAGxmHgw83QZ6Au/nV5m4UjhRp1hP+0yL6IJojdnMiqXrE2tqIQ4yC2plPV7oV8
         7FmqVltyI1hD/pBJlLNBxQK+TrH5V7ELx6LDYNKQQPrQcwrDKxUyXzgtJGgz3t91pT
         tau6ygFf17UerKGuakuRPVHo+MFUi0b/aupzZz4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 307/694] x86/ioapic: Dont return 0 from arch_dynirq_lower_bound()
Date:   Mon,  8 May 2023 11:42:22 +0200
Message-Id: <20230508094442.246815186@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit 5af507bef93c09a94fb8f058213b489178f4cbe5 ]

arch_dynirq_lower_bound() is invoked by the core interrupt code to
retrieve the lowest possible Linux interrupt number for dynamically
allocated interrupts like MSI.

The x86 implementation uses this to exclude the IO/APIC GSI space.
This works correctly as long as there is an IO/APIC registered, but
returns 0 if not. This has been observed in VMs where the BIOS does
not advertise an IO/APIC.

0 is an invalid interrupt number except for the legacy timer interrupt
on x86. The return value is unchecked in the core code, so it ends up
to allocate interrupt number 0 which is subsequently considered to be
invalid by the caller, e.g. the MSI allocation code.

The function has already a check for 0 in the case that an IO/APIC is
registered, as ioapic_dynirq_base is 0 in case of device tree setups.

Consolidate this and zero check for both ioapic_dynirq_base and gsi_top,
which is used in the case that no IO/APIC is registered.

Fixes: 3e5bedc2c258 ("x86/apic: Fix arch_dynirq_lower_bound() bug for DT enabled machines")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1679988604-20308-1-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/io_apic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 1f83b052bb74e..f980b38b0227e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2477,17 +2477,21 @@ static int io_apic_get_redir_entries(int ioapic)
 
 unsigned int arch_dynirq_lower_bound(unsigned int from)
 {
+	unsigned int ret;
+
 	/*
 	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
 	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
 	 */
-	if (!ioapic_initialized)
-		return gsi_top;
+	ret = ioapic_dynirq_base ? : gsi_top;
+
 	/*
-	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
-	 * updated. So simply return @from if ioapic_dynirq_base == 0.
+	 * For DT enabled machines ioapic_dynirq_base is irrelevant and
+	 * always 0. gsi_top can be 0 if there is no IO/APIC registered.
+	 * 0 is an invalid interrupt number for dynamic allocations. Return
+	 * @from instead.
 	 */
-	return ioapic_dynirq_base ? : from;
+	return ret ? : from;
 }
 
 #ifdef CONFIG_X86_32
-- 
2.39.2



