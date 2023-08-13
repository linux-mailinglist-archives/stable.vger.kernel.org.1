Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3141177AD2B
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjHMVsK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHMVrU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6786A2D54
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:47:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0DBD61C1D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA31C433C8;
        Sun, 13 Aug 2023 21:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963238;
        bh=DFZpq3LKweXt3Unnw+pBlNlk9lFhpr41+1i9x4cMs1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2r3sx/XQ4n19dNUjBq0vEFtha9pncfUfXqK5D+DDXk8jZiRJx5fLbHnJ6kb+gnWS
         cjOqLs7LPPSgDsJwTTkORxnA49uZhTdGPmb0g+5KZMo5gGGXshVMCiHYWTYQ+S/d+S
         FbU7QkZYfCTZX3ughXWYOB1+vQb+jZy60Ea8HV4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yingcong Wu <yingcong.wu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.4 14/39] x86/mm: Fix VDSO and VVAR placement on 5-level paging machines
Date:   Sun, 13 Aug 2023 23:20:05 +0200
Message-ID: <20230813211705.322851364@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
References: <20230813211704.796906808@linuxfoundation.org>
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

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit 1b8b1aa90c9c0e825b181b98b8d9e249dc395470 upstream.

Yingcong has noticed that on the 5-level paging machine, VDSO and VVAR
VMAs are placed above the 47-bit border:

8000001a9000-8000001ad000 r--p 00000000 00:00 0                          [vvar]
8000001ad000-8000001af000 r-xp 00000000 00:00 0                          [vdso]

This might confuse users who are not aware of 5-level paging and expect
all userspace addresses to be under the 47-bit border.

So far problem has only been triggered with ASLR disabled, although it
may also occur with ASLR enabled if the layout is randomized in a just
right way.

The problem happens due to custom placement for the VMAs in the VDSO
code: vdso_addr() tries to place them above the stack and checks the
result against TASK_SIZE_MAX, which is wrong. TASK_SIZE_MAX is set to
the 56-bit border on 5-level paging machines. Use DEFAULT_MAP_WINDOW
instead.

Fixes: b569bab78d8d ("x86/mm: Prepare to expose larger address space to userspace")
Reported-by: Yingcong Wu <yingcong.wu@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20230803151609.22141-1-kirill.shutemov%40linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/vdso/vma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -222,8 +222,8 @@ static unsigned long vdso_addr(unsigned
 
 	/* Round the lowest possible end address up to a PMD boundary. */
 	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
-	if (end >= TASK_SIZE_MAX)
-		end = TASK_SIZE_MAX;
+	if (end >= DEFAULT_MAP_WINDOW)
+		end = DEFAULT_MAP_WINDOW;
 	end -= len;
 
 	if (end > start) {


