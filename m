Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B5179BD17
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355685AbjIKWBr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbjIKOZ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:25:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C08DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:25:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A81C433C7;
        Mon, 11 Sep 2023 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442322;
        bh=t+/xVJTAEz+ptlDSXtEKd3GX3L/qMq8VzkN64hMidhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lt78wftRD8wRJS7x1uXDf7YjXLJUdWnBtqS8GsK3/Y7JIL6iRlgHC27TgqLrp0eIj
         +QE49E6BJrbez5pMMKw2xrzqOM5JgnraEQaeOa+O1ZJwQRIWizWU+VZZ+6JFw/i7XM
         oIGTTosjfT1E2qQkykW9C9ZkqG/twI55HmwXpHz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 6.5 724/739] x86/smp: Dont send INIT to non-present and non-booted CPUs
Date:   Mon, 11 Sep 2023 15:48:43 +0200
Message-ID: <20230911134711.300738950@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 3f874c9b2aae8e30463efc1872bea4baa9ed25dc upstream.

Vasant reported that kexec() can hang or reset the machine when it tries to
park CPUs via INIT. This happens when the kernel is using extended APIC,
but the present mask has APIC IDs >= 0x100 enumerated.

As extended APIC can only handle 8 bit of APIC ID sending INIT to APIC ID
0x100 sends INIT to APIC ID 0x0. That's the boot CPU which is special on
x86 and INIT causes the system to hang or resets the machine.

Prevent this by sending INIT only to those CPUs which have been booted
once.

Fixes: 45e34c8af58f ("x86/smp: Put CPUs into INIT on shutdown if possible")
Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/87cyzwjbff.ffs@tglx
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/smpboot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1356,7 +1356,7 @@ bool smp_park_other_cpus_in_init(void)
 	if (this_cpu)
 		return false;
 
-	for_each_present_cpu(cpu) {
+	for_each_cpu_and(cpu, &cpus_booted_once_mask, cpu_present_mask) {
 		if (cpu == this_cpu)
 			continue;
 		apicid = apic->cpu_present_to_apicid(cpu);


