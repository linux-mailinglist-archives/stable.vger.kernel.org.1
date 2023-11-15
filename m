Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978EC7ED330
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjKOUqx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjKOUqm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:46:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBC5D4F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:46:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFBCC433C8;
        Wed, 15 Nov 2023 20:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081198;
        bh=vwn6DTlDFE5q9dtWZF5MxYqwb0JiFxM3PFr579afigs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCw+nv/7h5kdTZvgz/9bQYquK2n1mXPeoDSNxAMgTwfGH558//pWt6pU5g3aWlT1R
         qZl0eOQTndkdqAeEmO9p43FIiIjp+V+mwRilW7ImT89stbtpZfLXgOccslKdbY5yDl
         mCcI1OyBT5PcHJKaSe/WEq3lVxUaV8QsVoydFfBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>, x86@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 001/244] iov_iter, x86: Be consistent about the __user tag on copy_mc_to_user()
Date:   Wed, 15 Nov 2023 15:33:13 -0500
Message-ID: <20231115203548.468560615@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 066baf92bed934c9fb4bcee97a193f47aa63431c ]

copy_mc_to_user() has the destination marked __user on powerpc, but not on
x86; the latter results in a sparse warning in lib/iov_iter.c.

Fix this by applying the tag on x86 too.

Fixes: ec6347bb4339 ("x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user, kernel}()")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20230925120309.1731676-3-dhowells@redhat.com
cc: Dan Williams <dan.j.williams@intel.com>
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@redhat.com>
cc: Borislav Petkov <bp@alien8.de>
cc: Dave Hansen <dave.hansen@linux.intel.com>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <christian@brauner.io>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: x86@kernel.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/uaccess.h | 2 +-
 arch/x86/lib/copy_mc.c         | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ab5e577373093..3616fd4ba3953 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -543,7 +543,7 @@ copy_mc_to_kernel(void *to, const void *from, unsigned len);
 #define copy_mc_to_kernel copy_mc_to_kernel
 
 unsigned long __must_check
-copy_mc_to_user(void *to, const void *from, unsigned len);
+copy_mc_to_user(void __user *to, const void *from, unsigned len);
 #endif
 
 /*
diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 80efd45a77617..6e8b7e600def5 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -70,23 +70,23 @@ unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigne
 }
 EXPORT_SYMBOL_GPL(copy_mc_to_kernel);
 
-unsigned long __must_check copy_mc_to_user(void *dst, const void *src, unsigned len)
+unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, unsigned len)
 {
 	unsigned long ret;
 
 	if (copy_mc_fragile_enabled) {
 		__uaccess_begin();
-		ret = copy_mc_fragile(dst, src, len);
+		ret = copy_mc_fragile((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
 	}
 
 	if (static_cpu_has(X86_FEATURE_ERMS)) {
 		__uaccess_begin();
-		ret = copy_mc_enhanced_fast_string(dst, src, len);
+		ret = copy_mc_enhanced_fast_string((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
 	}
 
-	return copy_user_generic(dst, src, len);
+	return copy_user_generic((__force void *)dst, src, len);
 }
-- 
2.42.0



