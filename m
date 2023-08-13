Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A27577ABE8
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjHMV1F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjHMV1E (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F710D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 595A4629CC
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47160C433C8;
        Sun, 13 Aug 2023 21:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962025;
        bh=tpfOpc5fjInSeYhRCSKyhk2jYzfs2VEeDrACHRpsV0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdCBhIYSKYZnrUM+u74hYWpLyiFxABkEdJW4PaV4o4M7ffevKFynDXZoIiPCsPxxu
         K69JjZNCBqOwd4PyjjW+d2x+eRu30mt4Z5bmnxNyshOM8+lFAJ/Suy/hdB7AyqgNwE
         IqrHqGlcV07jRPk+6+iGa8Eyo6NIp9rXPLG8+7Pg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinghao Jia <jinghao@linux.ibm.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>, stable@kernel.org
Subject: [PATCH 6.4 085/206] x86/linkage: Fix typo of BUILD_VDSO in asm/linkage.h
Date:   Sun, 13 Aug 2023 23:17:35 +0200
Message-ID: <20230813211727.509987866@linuxfoundation.org>
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

From: Jinghao Jia <jinghao@linux.ibm.com>

commit 7324f74d39531262b8e362f228b46512e6bee632 upstream.

The BUILD_VDSO macro was incorrectly spelled as BULID_VDSO in
asm/linkage.h. This causes the !defined(BULID_VDSO) directive to always
evaluate to true.

Correct the spelling to BUILD_VDSO.

Fixes: bea75b33895f ("x86/Kconfig: Introduce function padding")
Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230808182353.76218-1-jinghao@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/linkage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 0953aa32a324..97a3de7892d3 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -21,7 +21,7 @@
 #define FUNCTION_PADDING
 #endif
 
-#if (CONFIG_FUNCTION_ALIGNMENT > 8) && !defined(__DISABLE_EXPORTS) && !defined(BULID_VDSO)
+#if (CONFIG_FUNCTION_ALIGNMENT > 8) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 # define __FUNC_ALIGN		__ALIGN; FUNCTION_PADDING
 #else
 # define __FUNC_ALIGN		__ALIGN
-- 
2.41.0



