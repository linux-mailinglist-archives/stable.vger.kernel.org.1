Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF69477ACA9
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjHMVfh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjHMVfg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:35:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD210DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB5662CAD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB53C433C8;
        Sun, 13 Aug 2023 21:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962538;
        bh=X9/ulL2ZAwhzNg6JtG4/vnZ5VuCVOrXyWCRYaVV4wz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4nm78gafUcSPJVN2+RlOQMm+g9IMGBLxV4KTlWcekaiQxq5u32dRF/sdcHGDONI9
         oz6ebycW0t7+cKIPsv7NhWsnpBlZ/PPO4wIv1lgOPLcVno9StLbsX3Y2q/ukkd6K6y
         85JjFAHKLF7eJTwwDFsQqmA/HHBN2LshTCslb+h8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yingcong Wu <yingcong.wu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.1 066/149] x86/mm: Fix VDSO and VVAR placement on 5-level paging machines
Date:   Sun, 13 Aug 2023 23:18:31 +0200
Message-ID: <20230813211720.778062895@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
@@ -322,8 +322,8 @@ static unsigned long vdso_addr(unsigned
 
 	/* Round the lowest possible end address up to a PMD boundary. */
 	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
-	if (end >= TASK_SIZE_MAX)
-		end = TASK_SIZE_MAX;
+	if (end >= DEFAULT_MAP_WINDOW)
+		end = DEFAULT_MAP_WINDOW;
 	end -= len;
 
 	if (end > start) {


