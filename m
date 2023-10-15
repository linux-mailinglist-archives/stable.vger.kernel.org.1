Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297A97C9B49
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 22:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjJOUNF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 16:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjJOUNA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 16:13:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D35FC1
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697400779; x=1728936779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NkCbrEiug2KsgjLzXCsjRyZc0UhEJoIpDQ8KQuaTSu8=;
  b=VjWZk9FhdH0sLf0ko7TyTmcfGcic0hsifrTp/GLeMX8MpnfGG1jPJIDF
   WQWKYODCYoUxaNsO7fDLiAiIqnu6PHrmIGX+PZ15amMqgNM+OfY6TTmJr
   5SIJiSoBRvk0ASNPciFSgfCH+6y6UxwqpDIYbq02FJVFbpPnVAhMCq4zM
   jZfg/F4BBSqgM39KH+WNAFxz4zu/nQwsNLCAksTjUq+2PX18rOIYbI6g6
   gOSlFeK0wT8Z90GWIwJ2nP9IwRfuOWXK55+n6wvNjYkqsKb8o64yg2h4h
   GsqiBoSY5wUl9nXiU/5u8knN1RUnx4yfd3q2rJEn5UaIX+EOBlNsRlU9i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="375781411"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="375781411"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 13:12:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="705353893"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="705353893"
Received: from bmihaile-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.37.165])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 13:12:56 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2DFAF10A1BD; Sun, 15 Oct 2023 23:12:54 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     stable@vger.kernel.org
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Fei Yang <fei.yang@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.15.y] x86/alternatives: Disable KASAN in apply_alternatives()
Date:   Sun, 15 Oct 2023 23:12:51 +0300
Message-ID: <20231015201251.4987-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023101550-ranger-imaginary-2bed@gregkh>
References: <2023101550-ranger-imaginary-2bed@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Fei has reported that KASAN triggers during apply_alternatives() on
a 5-level paging machine:

	BUG: KASAN: out-of-bounds in rcu_is_watching()
	Read of size 4 at addr ff110003ee6419a0 by task swapper/0/0
	...
	__asan_load4()
	rcu_is_watching()
	trace_hardirqs_on()
	text_poke_early()
	apply_alternatives()
	...

On machines with 5-level paging, cpu_feature_enabled(X86_FEATURE_LA57)
gets patched. It includes KASAN code, where KASAN_SHADOW_START depends on
__VIRTUAL_MASK_SHIFT, which is defined with cpu_feature_enabled().

KASAN gets confused when apply_alternatives() patches the
KASAN_SHADOW_START users. A test patch that makes KASAN_SHADOW_START
static, by replacing __VIRTUAL_MASK_SHIFT with 56, works around the issue.

Fix it for real by disabling KASAN while the kernel is patching alternatives.

[ mingo: updated the changelog ]

Fixes: 6657fca06e3f ("x86/mm: Allow to boot without LA57 if CONFIG_X86_5LEVEL=y")
Reported-by: Fei Yang <fei.yang@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231012100424.1456-1-kirill.shutemov@linux.intel.com
(cherry picked from commit d35652a5fc9944784f6f50a5c979518ff8dacf61)
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/alternative.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 43dd7f281a21..c9e3246bf4f3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -269,6 +269,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 
 	DPRINTK("alt table %px, -> %px", start, end);
+
+	/*
+	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
+	 * During the process, KASAN becomes confused seeing partial LA57
+	 * conversion and triggers a false-positive out-of-bound report.
+	 *
+	 * Disable KASAN until the patching is complete.
+	 */
+	kasan_disable_current();
+
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -336,6 +347,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 next:
 		optimize_nops(instr, a->instrlen);
 	}
+
+	kasan_enable_current();
 }
 
 #if defined(CONFIG_RETPOLINE) && defined(CONFIG_STACK_VALIDATION)
-- 
2.41.0

