Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB6761196
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGYKxh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjGYKwM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:52:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83711FC7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D02B615FE
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81708C433C8;
        Tue, 25 Jul 2023 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282279;
        bh=Puo2ywKsycAM5/PzEZl0qDeS+SlrJvR0ktGgJk+DU6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2zWVPtetu4XpfMQZqoRis1gI25SjtLjSaCAJTqa8t00inBt4okFOXsTXnJQfaEtl
         eHi06bqXuFOHykxXnVLJ4ljv00xyfkxbJm0x1BvUiY2cXp9RdWwfR6+NxJkJHTOY0u
         M3t2UYzkb0fhSOq5XMFANhw9dOhj0fWrR26McFnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 6.4 073/227] KVM: arm64: Disable preemption in kvm_arch_hardware_enable()
Date:   Tue, 25 Jul 2023 12:44:00 +0200
Message-ID: <20230725104517.784687016@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

commit 970dee09b230895fe2230d2b32ad05a2826818c6 upstream.

Since 0bf50497f03b ("KVM: Drop kvm_count_lock and instead protect
kvm_usage_count with kvm_lock"), hotplugging back a CPU whilst
a guest is running results in a number of ugly splats as most
of this code expects to run with preemption disabled, which isn't
the case anymore.

While the context is preemptable, it isn't migratable, which should
be enough. But we have plenty of preemptible() checks all over
the place, and our per-CPU accessors also disable preemption.

Since this affects released versions, let's do the easy fix first,
disabling preemption in kvm_arch_hardware_enable(). We can always
revisit this with a more invasive fix in the future.

Fixes: 0bf50497f03b ("KVM: Drop kvm_count_lock and instead protect kvm_usage_count with kvm_lock")
Reported-by: Kristina Martsenko <kristina.martsenko@arm.com>
Tested-by: Kristina Martsenko <kristina.martsenko@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/aeab7562-2d39-e78e-93b1-4711f8cc3fa5@arm.com
Cc: stable@vger.kernel.org # v6.3, v6.4
Link: https://lore.kernel.org/r/20230703163548.1498943-1-maz@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/arm.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1793,8 +1793,17 @@ static void _kvm_arch_hardware_enable(vo
 
 int kvm_arch_hardware_enable(void)
 {
-	int was_enabled = __this_cpu_read(kvm_arm_hardware_enabled);
+	int was_enabled;
 
+	/*
+	 * Most calls to this function are made with migration
+	 * disabled, but not with preemption disabled. The former is
+	 * enough to ensure correctness, but most of the helpers
+	 * expect the later and will throw a tantrum otherwise.
+	 */
+	preempt_disable();
+
+	was_enabled = __this_cpu_read(kvm_arm_hardware_enabled);
 	_kvm_arch_hardware_enable(NULL);
 
 	if (!was_enabled) {
@@ -1802,6 +1811,8 @@ int kvm_arch_hardware_enable(void)
 		kvm_timer_cpu_up();
 	}
 
+	preempt_enable();
+
 	return 0;
 }
 


