Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33987CAC61
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjJPOxt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjJPOxs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:53:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE1AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:53:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25C0C433C7;
        Mon, 16 Oct 2023 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468026;
        bh=vfMf6hwxjmyH6Qb/VR8JwSvb6qmSXDurKyG1oj9tda4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZJEVLo6BMBLQtWh3+dB/mWXEF+AX1Ful5CIuIdgpdR6qVjsnbt6mTmEkWkmQS38n
         Xd3lumQ/GMofPqb98wOOl73dDYqxyW4RMixccwYqJxSo5oiqLlORaxEzBej904g8Zh
         dq5ELIpnY6EJ6uohb+aaidrhUfjUgv98WStyAEOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        JP Kobryn <inwardvessel@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6.5 136/191] perf/x86/lbr: Filter vsyscall addresses
Date:   Mon, 16 Oct 2023 10:42:01 +0200
Message-ID: <20231016084018.563539914@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: JP Kobryn <inwardvessel@gmail.com>

commit e53899771a02f798d436655efbd9d4b46c0f9265 upstream.

We found that a panic can occur when a vsyscall is made while LBR sampling
is active. If the vsyscall is interrupted (NMI) for perf sampling, this
call sequence can occur (most recent at top):

    __insn_get_emulate_prefix()
    insn_get_emulate_prefix()
    insn_get_prefixes()
    insn_get_opcode()
    decode_branch_type()
    get_branch_type()
    intel_pmu_lbr_filter()
    intel_pmu_handle_irq()
    perf_event_nmi_handler()

Within __insn_get_emulate_prefix() at frame 0, a macro is called:

    peek_nbyte_next(insn_byte_t, insn, i)

Within this macro, this dereference occurs:

    (insn)->next_byte

Inspecting registers at this point, the value of the next_byte field is the
address of the vsyscall made, for example the location of the vsyscall
version of gettimeofday() at 0xffffffffff600000. The access to an address
in the vsyscall region will trigger an oops due to an unhandled page fault.

To fix the bug, filtering for vsyscalls can be done when
determining the branch type. This patch will return
a "none" branch if a kernel address if found to lie in the
vsyscall region.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/utils.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/events/utils.c
+++ b/arch/x86/events/utils.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/insn.h>
+#include <linux/mm.h>
 
 #include "perf_event.h"
 
@@ -132,9 +133,9 @@ static int get_branch_type(unsigned long
 		 * The LBR logs any address in the IP, even if the IP just
 		 * faulted. This means userspace can control the from address.
 		 * Ensure we don't blindly read any address by validating it is
-		 * a known text address.
+		 * a known text address and not a vsyscall address.
 		 */
-		if (kernel_text_address(from)) {
+		if (kernel_text_address(from) && !in_gate_area_no_mm(from)) {
 			addr = (void *)from;
 			/*
 			 * Assume we can get the maximum possible size


