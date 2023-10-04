Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD497B8A36
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244377AbjJDSdV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244301AbjJDSdU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:33:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9109BBF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:33:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8A4C433C8;
        Wed,  4 Oct 2023 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444394;
        bh=ZW+gEKsriZZ7O4Dv/oaTMPOePvcylIhltJDIHoUgmAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=16N9McG2yFXmPPSA4Zb2YUgWFzJ7TbC4WuoRFfzja36FpCkCzujDlq1CpmQIHKfep
         RXvDdyPKe0XFvrvo/YZ0kMeI1BENMDOrtYR+VA3bOQpp4JkWmK7TECGFBUKEf6XmSy
         Oy0Y7n/DuKDtdNCWp/OEyHaw27Zg4xuWOJ2ylAW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 234/321] LoongArch: Use _UL() and _ULL()
Date:   Wed,  4 Oct 2023 19:56:19 +0200
Message-ID: <20231004175240.076166667@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 3563b477ddfe057ff1ef63636cacf198130276cb ]

Use _UL() and _ULL() that are provided by const.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/addrspace.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
index 5c9c03bdf9156..b24437e28c6ed 100644
--- a/arch/loongarch/include/asm/addrspace.h
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -19,7 +19,7 @@
  */
 #ifndef __ASSEMBLY__
 #ifndef PHYS_OFFSET
-#define PHYS_OFFSET	_AC(0, UL)
+#define PHYS_OFFSET	_UL(0)
 #endif
 extern unsigned long vm_map_base;
 #endif /* __ASSEMBLY__ */
@@ -43,7 +43,7 @@ extern unsigned long vm_map_base;
  * Memory above this physical address will be considered highmem.
  */
 #ifndef HIGHMEM_START
-#define HIGHMEM_START		(_AC(1, UL) << _AC(DMW_PABITS, UL))
+#define HIGHMEM_START		(_UL(1) << _UL(DMW_PABITS))
 #endif
 
 #define TO_PHYS(x)		(		((x) & TO_PHYS_MASK))
@@ -65,16 +65,16 @@ extern unsigned long vm_map_base;
 #define _ATYPE_
 #define _ATYPE32_
 #define _ATYPE64_
-#define _CONST64_(x)	x
 #else
 #define _ATYPE_		__PTRDIFF_TYPE__
 #define _ATYPE32_	int
 #define _ATYPE64_	__s64
+#endif
+
 #ifdef CONFIG_64BIT
-#define _CONST64_(x)	x ## UL
+#define _CONST64_(x)	_UL(x)
 #else
-#define _CONST64_(x)	x ## ULL
-#endif
+#define _CONST64_(x)	_ULL(x)
 #endif
 
 /*
-- 
2.40.1



