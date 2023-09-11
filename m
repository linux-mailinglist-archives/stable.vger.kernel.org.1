Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538C979BC59
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355311AbjIKV5s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbjIKOYL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:24:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6A6DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:24:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBB6C433C8;
        Mon, 11 Sep 2023 14:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442246;
        bh=FKXilathzeXQ1jJofE5P21cmCHCpoR21ZaHxO7MPWkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZ58P5Vm1Wd1+q9U9KuCnVI2t9zsVnk+ONzdIOz6DO41rz8s0LSUVmEoMMcp0lvDH
         bTk3fRTrmD07XmO6sKJ6Vk3wAswM1G5okzC9CZmkkDxGp8OtSBenXzF25oLt1eDlCT
         2Ye4raU5W3wwFcPO/fqnBeHYoOUNHOOweL831MAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.5 671/739] powerpc/ftrace: Fix dropping weak symbols with older toolchains
Date:   Mon, 11 Sep 2023 15:47:50 +0200
Message-ID: <20230911134709.847475591@linuxfoundation.org>
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

From: Naveen N Rao <naveen@kernel.org>

commit f6834c8c59a8e977a6f6e4f96c5d28dfa5db8430 upstream.

The minimum level of gcc supported for building the kernel is v5.1.
v5.x releases of gcc emitted a three instruction sequence for
-mprofile-kernel:
	mflr	r0
	std	r0, 16(r1)
	bl	_mcount

It is only with the v6.x releases that gcc started emitting the two
instruction sequence for -mprofile-kernel, omitting the second store
instruction.

With the older three instruction sequence, the actual ftrace location
can be the 5th instruction into a function. Update the allowed offset
for ftrace location from 12 to 16 to accommodate the same.

Cc: stable@vger.kernel.org
Fixes: 7af82ff90a2b06 ("powerpc/ftrace: Ignore weak functions")
Signed-off-by: Naveen N Rao <naveen@kernel.org>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/7b265908a9461e38fc756ef9b569703860a80621.1687166935.git.naveen@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/ftrace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -12,7 +12,7 @@
 
 /* Ignore unused weak functions which will have larger offsets */
 #ifdef CONFIG_MPROFILE_KERNEL
-#define FTRACE_MCOUNT_MAX_OFFSET	12
+#define FTRACE_MCOUNT_MAX_OFFSET	16
 #elif defined(CONFIG_PPC32)
 #define FTRACE_MCOUNT_MAX_OFFSET	8
 #endif


