Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E677ABFB
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjHMV14 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjHMV1z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:27:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B1710EA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:27:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5577062A05
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B663C433C7;
        Sun, 13 Aug 2023 21:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962076;
        bh=sVv7R0aC/P2fnboMzPuPKHSrUVP9mpjiJVcakUEUut8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2vdGzkWS+vQS0BKjYymlyy7SVOlX8q4+vEcZde6o1J2oCOg37qz0SKS2TMv9sBYAt
         0dznTtB1RZyww5ZTfNjC/iRUFuJXh2xhV1tlYmXzlAA+X4KubzYWl9ayb5dHieeOuZ
         DIwYV7J0+kG9i4hJBdqWrQmqijamXPoYZpFhRtXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oliver Upton <oliver.upton@linux.dev>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.4 105/206] KVM: arm64: Fix hardware enable/disable flows for pKVM
Date:   Sun, 13 Aug 2023 23:17:55 +0200
Message-ID: <20230813211728.061770860@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Raghavendra Rao Ananta <rananta@google.com>

commit c718ca0e99401d80d2480c08e1b02cf5f7cd7033 upstream.

When running in protected mode, the hyp stub is disabled after pKVM is
initialized, meaning the host cannot enable/disable the hyp at
runtime. As such, kvm_arm_hardware_enabled is always 1 after
initialization, and kvm_arch_hardware_enable() never enables the vgic
maintenance irq or timer irqs.

Unconditionally enable/disable the vgic + timer irqs in the respective
calls, instead relying on the percpu bookkeeping in the generic code
to keep track of which cpus have the interrupts unmasked.

Fixes: 466d27e48d7c ("KVM: arm64: Simplify the CPUHP logic")
Reported-by: Oliver Upton <oliver.upton@linux.dev>
Suggested-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Link: https://lore.kernel.org/r/20230719175400.647154-1-rananta@google.com
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/arm.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1800,8 +1800,6 @@ static void _kvm_arch_hardware_enable(vo
 
 int kvm_arch_hardware_enable(void)
 {
-	int was_enabled;
-
 	/*
 	 * Most calls to this function are made with migration
 	 * disabled, but not with preemption disabled. The former is
@@ -1810,13 +1808,10 @@ int kvm_arch_hardware_enable(void)
 	 */
 	preempt_disable();
 
-	was_enabled = __this_cpu_read(kvm_arm_hardware_enabled);
 	_kvm_arch_hardware_enable(NULL);
 
-	if (!was_enabled) {
-		kvm_vgic_cpu_up();
-		kvm_timer_cpu_up();
-	}
+	kvm_vgic_cpu_up();
+	kvm_timer_cpu_up();
 
 	preempt_enable();
 
@@ -1833,10 +1828,8 @@ static void _kvm_arch_hardware_disable(v
 
 void kvm_arch_hardware_disable(void)
 {
-	if (__this_cpu_read(kvm_arm_hardware_enabled)) {
-		kvm_timer_cpu_down();
-		kvm_vgic_cpu_down();
-	}
+	kvm_timer_cpu_down();
+	kvm_vgic_cpu_down();
 
 	if (!is_protected_kvm_enabled())
 		_kvm_arch_hardware_disable(NULL);


