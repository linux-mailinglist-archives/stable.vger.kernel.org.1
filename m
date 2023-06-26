Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1C673E7A3
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjFZSRK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFZSRG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6000694
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9FAE60F3E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2574C433C8;
        Mon, 26 Jun 2023 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803424;
        bh=VtlrKU46Jf6X+J6QlC2D6KrkuZlI89sPsKwTzSj9SGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMQuil/kBWP0LZMefvQNUlVAYzsk5m3TStlBvlvB+qpYetUVcmDXuMhYRG0iiz/Ob
         Tl26HKMeMMUIYz1flWv/39Xm3y/jyYLEwWLGJ9HUlZqdoDmO8CUb1jFcBWdSkEcRMQ
         WQ6e6e8RnLxETjtuW7LSe8nsj9NJ5B81YYLxX/SQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.3 056/199] ACPI: sleep: Avoid breaking S3 wakeup due to might_sleep()
Date:   Mon, 26 Jun 2023 20:09:22 +0200
Message-ID: <20230626180808.023379003@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 22db06337f590d01d79f60f181d8dfe5a9ef9085 upstream.

The addition of might_sleep() to down_timeout() caused the latter to
enable interrupts unconditionally in some cases, which in turn broke
the ACPI S3 wakeup path in acpi_suspend_enter(), where down_timeout()
is called by acpi_disable_all_gpes() via acpi_ut_acquire_mutex().

Namely, if CONFIG_DEBUG_ATOMIC_SLEEP is set, might_sleep() causes
might_resched() to be used and if CONFIG_PREEMPT_VOLUNTARY is set,
this triggers __cond_resched() which may call preempt_schedule_common(),
so __schedule() gets invoked and it ends up with enabled interrupts (in
the prev == next case).

Now, enabling interrupts early in the S3 wakeup path causes the kernel
to crash.

Address this by modifying acpi_suspend_enter() to disable GPEs without
attempting to acquire the sleeping lock which is not needed in that code
path anyway.

Fixes: 99409b935c9a ("locking/semaphore: Add might_sleep() to down_*() family")
Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: 5.15+ <stable@vger.kernel.org> # 5.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpica/achware.h |    2 --
 drivers/acpi/sleep.c          |   16 ++++++++++++----
 include/acpi/acpixf.h         |    1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -101,8 +101,6 @@ acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 		       acpi_event_status *event_status);
 
-acpi_status acpi_hw_disable_all_gpes(void);
-
 acpi_status acpi_hw_enable_all_runtime_gpes(void);
 
 acpi_status acpi_hw_enable_all_wakeup_gpes(void);
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -636,11 +636,19 @@ static int acpi_suspend_enter(suspend_st
 	}
 
 	/*
-	 * Disable and clear GPE status before interrupt is enabled. Some GPEs
-	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
-	 * acpi_leave_sleep_state will reenable specific GPEs later
+	 * Disable all GPE and clear their status bits before interrupts are
+	 * enabled. Some GPEs (like wakeup GPEs) have no handlers and this can
+	 * prevent them from producing spurious interrups.
+	 *
+	 * acpi_leave_sleep_state() will reenable specific GPEs later.
+	 *
+	 * Because this code runs on one CPU with disabled interrupts (all of
+	 * the other CPUs are offline at this time), it need not acquire any
+	 * sleeping locks which may trigger an implicit preemption point even
+	 * if there is no contention, so avoid doing that by using a low-level
+	 * library routine here.
 	 */
-	acpi_disable_all_gpes();
+	acpi_hw_disable_all_gpes();
 	/* Allow EC transactions to happen. */
 	acpi_ec_unblock_transactions();
 
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -761,6 +761,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
 						     acpi_event_status
 						     *event_status))
 ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_hw_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))


