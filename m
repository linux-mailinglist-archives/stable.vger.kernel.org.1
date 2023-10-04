Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D751F7B8945
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbjJDSYR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244149AbjJDSYQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:24:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B552DC
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:24:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC88C433C7;
        Wed,  4 Oct 2023 18:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443852;
        bh=YBkHCkh3OvDwbjio3b0hGaTK6nEPYK3LFbgQjK4VlYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryIbgI7hINA3Mg0jPak7IeI/qsGq5o+3DepvBkVuBWv7dVj0Kx39+WxlPi20mYOGY
         WCFOxyaHihP5TOWwklmZqJuaTk8Vv7RV/hmRfGytRXosn7y9i4sFtO4uzDqRmO/TPj
         o25On0Gp1wjWAJ4tNH36YnBQRx5byEJ9Px2JA3oE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 042/321] Compiler Attributes: counted_by: Adjust name and identifier expansion
Date:   Wed,  4 Oct 2023 19:53:07 +0200
Message-ID: <20231004175231.118137546@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

[ Upstream commit c8248faf3ca276ebdf60f003b3e04bf764daba91 ]

GCC and Clang's current RFCs name this attribute "counted_by", and have
moved away from using a string for the member name. Update the kernel's
macros to match. Additionally provide a UAPI no-op macro for UAPI structs
that will gain annotations.

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Fixes: dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20230817200558.never.077-kees@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 32a4ec211d41 ("uapi: stddef.h: Fix __DECLARE_FLEX_ARRAY for C++")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler_attributes.h | 26 +++++++++++++-------------
 include/uapi/linux/stddef.h         |  4 ++++
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 00efa35c350f6..28566624f008f 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -94,6 +94,19 @@
 # define __copy(symbol)
 #endif
 
+/*
+ * Optional: only supported since gcc >= 14
+ * Optional: only supported since clang >= 18
+ *
+ *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
+ * clang: https://reviews.llvm.org/D148381
+ */
+#if __has_attribute(__counted_by__)
+# define __counted_by(member)		__attribute__((__counted_by__(member)))
+#else
+# define __counted_by(member)
+#endif
+
 /*
  * Optional: not supported by gcc
  * Optional: only supported since clang >= 14.0
@@ -129,19 +142,6 @@
 # define __designated_init
 #endif
 
-/*
- * Optional: only supported since gcc >= 14
- * Optional: only supported since clang >= 17
- *
- *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
- * clang: https://reviews.llvm.org/D148381
- */
-#if __has_attribute(__element_count__)
-# define __counted_by(member)		__attribute__((__element_count__(#member)))
-#else
-# define __counted_by(member)
-#endif
-
 /*
  * Optional: only supported since clang >= 14.0
  *
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 7837ba4fe7289..7c3fc39808811 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -45,3 +45,7 @@
 		TYPE NAME[]; \
 	}
 #endif
+
+#ifndef __counted_by
+#define __counted_by(m)
+#endif
-- 
2.40.1



