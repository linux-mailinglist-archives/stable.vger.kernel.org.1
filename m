Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2132B703B2E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbjEOSA3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245074AbjEOSAA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4BC19944
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 030CF62F5E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B93C433D2;
        Mon, 15 May 2023 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173116;
        bh=GHfC8hEM3TXudyJWSIDYgG3TapBDzSdtmLwZDp4cKCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0+O12Xs1aNIjyN4uVgShqEFq/DjirnvYj1aD7u3t3yyRSDW8EhXOXiqceRe8TG3oH
         pPxhTbTDgTS+OJsTvGpElQtyJuUANlDggsRCi/0ldN/Z6L/+vweBkkFdHKf1K1Sq6u
         VL5ESoP/hCVnh6xmJ9zNYF/zfBU22NSZ35JGFWc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10 372/381] KVM: Fix steal time asm constraints
Date:   Mon, 15 May 2023 18:30:23 +0200
Message-Id: <20230515161753.748317949@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Rishabh Bhatnagar <risbhat@amazon.com>

From: David Woodhouse <dwmw@amazon.co.uk>

commit 964b7aa0b040bdc6ec1c543ee620cda3f8b4c68a upstream.

In 64-bit mode, x86 instruction encoding allows us to use the low 8 bits
of any GPR as an 8-bit operand. In 32-bit mode, however, we can only use
the [abcd] registers. For which, GCC has the "q" constraint instead of
the less restrictive "r".

Also fix st->preempted, which is an input/output operand rather than an
input.

Fixes: 7e2175ebd695 ("KVM: x86: Fix recording of guest steal time / preempted status")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <89bf72db1b859990355f9c40713a34e0d2d86c98.camel@infradead.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
Tested-by: Allen Pais <apais@linux.microsoft.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3064,9 +3064,9 @@ static void record_steal_time(struct kvm
 			     "xor %1, %1\n"
 			     "2:\n"
 			     _ASM_EXTABLE_UA(1b, 2b)
-			     : "+r" (st_preempted),
-			       "+&r" (err)
-			     : "m" (st->preempted));
+			     : "+q" (st_preempted),
+			       "+&r" (err),
+			       "+m" (st->preempted));
 		if (err)
 			goto out;
 


