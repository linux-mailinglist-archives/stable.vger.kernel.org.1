Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517857B8947
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244158AbjJDSYV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244154AbjJDSYT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:24:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6BFDD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:24:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6133EC433C8;
        Wed,  4 Oct 2023 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443854;
        bh=vWX884+Z2AQ/3kFJS+MhbYFtMGvWvR2DjyHaH4k6Ku4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Crte5m94dvLow9naDGKV89TV65Bzxz4SIkkIZW7kiDsry65g6ae6rxcpaVf9jf0Qz
         8Hj2W0z+9ceZFbFi8e0v1qDshsxWX1TLrl/m1bLCO12bGxZJgUte3w5AR99wHZj6KL
         32rQwcDHzZZEHRTzBLMnzlGBWDn3CeAPMoo0VwYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 043/321] uapi: stddef.h: Fix header guard location
Date:   Wed,  4 Oct 2023 19:53:08 +0200
Message-ID: <20231004175231.165026385@linuxfoundation.org>
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

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit 531108ec5b5cd45ec6272a6115e73275baef7d22 ]

The #endif for the header guard wasn't at the end of the header. This
was harmless since the define that escaped was already testing for its
own redefinition. Regardless, move the #endif to the correct place.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Fixes: c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and identifier expansion")
Link: https://lore.kernel.org/r/b1f5081e-339d-421d-81b2-cbb94e1f6f5f@p183
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 32a4ec211d41 ("uapi: stddef.h: Fix __DECLARE_FLEX_ARRAY for C++")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/stddef.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 7c3fc39808811..c027b2070d790 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -44,8 +44,9 @@
 		struct { } __empty_ ## NAME; \
 		TYPE NAME[]; \
 	}
-#endif
 
 #ifndef __counted_by
 #define __counted_by(m)
 #endif
+
+#endif /* _UAPI_LINUX_STDDEF_H */
-- 
2.40.1



