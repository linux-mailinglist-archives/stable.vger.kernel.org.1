Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D2C73E8A7
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjFZS2O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjFZS1n (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5F02954
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 875A660F18
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC49C433C0;
        Mon, 26 Jun 2023 18:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804036;
        bh=opLz/IE6HuML0EPEBNkoNBWypqsBM4bom6q3CeTrcPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwCXPJPF4PYjuleqQDsVo9z5jw5KmT4DDWAZ/y6bxj0k5qyJFknpxw9NsLME6GrMv
         rUWFHcTUcXnRri4pn4isUi7Q3lBkFKGqH3RNeWajjksEJNTjS2eJ7fb06f4n5Uf6qj
         LS5TPNw4HsJffGTmvNugSUPJuKeGGtQhy1V2paXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hsin-Wei Hung <hsinweih@uci.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Florian Lehner <dev@der-flo.net>,
        Javier Honduvilla Coto <javierhonduco@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.1 007/170] mm: Fix copy_from_user_nofault().
Date:   Mon, 26 Jun 2023 20:09:36 +0200
Message-ID: <20230626180800.843434879@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Alexei Starovoitov <ast@kernel.org>

commit d319f344561de23e810515d109c7278919bff7b0 upstream.

There are several issues with copy_from_user_nofault():

- access_ok() is designed for user context only and for that reason
it has WARN_ON_IN_IRQ() which triggers when bpf, kprobe, eprobe
and perf on ppc are calling it from irq.

- it's missing nmi_uaccess_okay() which is a nop on all architectures
except x86 where it's required.
The comment in arch/x86/mm/tlb.c explains the details why it's necessary.
Calling copy_from_user_nofault() from bpf, [ke]probe without this check is not safe.

- __copy_from_user_inatomic() under CONFIG_HARDENED_USERCOPY is calling
check_object_size()->__check_object_size()->check_heap_object()->find_vmap_area()->spin_lock()
which is not safe to do from bpf, [ke]probe and perf due to potential deadlock.

Fix all three issues. At the end the copy_from_user_nofault() becomes
equivalent to copy_from_user_nmi() from safety point of view with
a difference in the return value.

Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Florian Lehner <dev@der-flo.net>
Tested-by: Hsin-Wei Hung <hsinweih@uci.edu>
Tested-by: Florian Lehner <dev@der-flo.net>
Link: https://lore.kernel.org/r/20230410174345.4376-2-dev@der-flo.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Cc: Javier Honduvilla Coto <javierhonduco@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/maccess.c  |   16 +++++++++++-----
 mm/usercopy.c |    2 +-
 2 files changed, 12 insertions(+), 6 deletions(-)

--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <asm/tlb.h>
 
 bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 		size_t size)
@@ -113,11 +114,16 @@ Efault:
 long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
 {
 	long ret = -EFAULT;
-	if (access_ok(src, size)) {
-		pagefault_disable();
-		ret = __copy_from_user_inatomic(dst, src, size);
-		pagefault_enable();
-	}
+
+	if (!__access_ok(src, size))
+		return ret;
+
+	if (!nmi_uaccess_okay())
+		return ret;
+
+	pagefault_disable();
+	ret = __copy_from_user_inatomic(dst, src, size);
+	pagefault_enable();
 
 	if (ret)
 		return -EFAULT;
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -172,7 +172,7 @@ static inline void check_heap_object(con
 		return;
 	}
 
-	if (is_vmalloc_addr(ptr)) {
+	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
 		struct vmap_area *area = find_vmap_area(addr);
 
 		if (!area)


