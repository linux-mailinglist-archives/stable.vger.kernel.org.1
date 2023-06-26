Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF7F73EA0B
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjFZSmt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjFZSmj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7336110FE
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0904C60F18
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F6EC433C8;
        Mon, 26 Jun 2023 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804948;
        bh=Pm6ZkV4+A5KeYt3uWhxoHD7HH6jyVEp+Yd98bdrxBQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqCtTtsejayIJbq5AcLT+YJ72K9HkWyjzbtM3148/32Ftd/Pg0/R0h0zbHq6TLKKf
         +anfZCbILvld2FXLtr0pZr5vYgfNfPD1IMlzz7SCG0XYvbsqjoUZGyLUJZ3KEbDQuB
         jE3ZZZoNoHj4rjaFPWAfGSwKYcfEBLJ66ousDgls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 95/96] x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys
Date:   Mon, 26 Jun 2023 20:12:50 +0200
Message-ID: <20230626180751.017659887@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
References: <20230626180746.943455203@linuxfoundation.org>
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

From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>

[ Upstream commit 85d38d5810e285d5aec7fb5283107d1da70c12a9 ]

When booting with "intremap=off" and "x2apic_phys" on the kernel command
line, the physical x2APIC driver ends up being used even when x2APIC
mode is disabled ("intremap=off" disables x2APIC mode). This happens
because the first compound condition check in x2apic_phys_probe() is
false due to x2apic_mode == 0 and so the following one returns true
after default_acpi_madt_oem_check() having already selected the physical
x2APIC driver.

This results in the following panic:

   kernel BUG at arch/x86/kernel/apic/io_apic.c:2409!
   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc2-ver4.1rc2 #2
   Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.3.6 07/06/2021
   RIP: 0010:setup_IO_APIC+0x9c/0xaf0
   Call Trace:
    <TASK>
    ? native_read_msr
    apic_intr_mode_init
    x86_late_time_init
    start_kernel
    x86_64_start_reservations
    x86_64_start_kernel
    secondary_startup_64_no_verify
    </TASK>

which is:

setup_IO_APIC:
  apic_printk(APIC_VERBOSE, "ENABLING IO-APIC IRQs\n");
  for_each_ioapic(ioapic)
  	BUG_ON(mp_irqdomain_create(ioapic));

Return 0 to denote that x2APIC has not been enabled when probing the
physical x2APIC driver.

  [ bp: Massage commit message heavily. ]

Fixes: 9ebd680bd029 ("x86, apic: Use probe routines to simplify apic selection")
Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230616212236.1389-1-dheerajkumar.srivastava@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/x2apic_phys.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 6bde05a86b4ed..896bc41cb2ba7 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -97,7 +97,10 @@ static void init_x2apic_ldr(void)
 
 static int x2apic_phys_probe(void)
 {
-	if (x2apic_mode && (x2apic_phys || x2apic_fadt_phys()))
+	if (!x2apic_mode)
+		return 0;
+
+	if (x2apic_phys || x2apic_fadt_phys())
 		return 1;
 
 	return apic == &apic_x2apic_phys;
-- 
2.39.2



