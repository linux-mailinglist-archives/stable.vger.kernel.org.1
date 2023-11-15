Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE4A7ECFE5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjKOTvb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbjKOTv2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806CD189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66D0C433C9;
        Wed, 15 Nov 2023 19:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077885;
        bh=RMl2ANbsAHd8FtprbyNgtIG6+kaKnYsu6VW+K+XLWhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=si4/RCP6jpJIj9ehzHtscxtsFm/BgVHsmNUoRMNQp1uHLA+iZzcP/8pCl+eOm0uZ+
         YvlD0nQ5XtMH1OxFkddGmjo2zlVlYu+XwIihbjgeJ8JnBW+CP1WXlIrQt0PW+aQ4T+
         Hn5Qia98KPcNfhFvHA4JBbsP7C2stnWsDJgudKaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 580/603] module/decompress: use kvmalloc() consistently
Date:   Wed, 15 Nov 2023 14:18:45 -0500
Message-ID: <20231115191651.556762003@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Righi <andrea.righi@canonical.com>

[ Upstream commit 17fc8084aa8f9d5235f252fc3978db657dd77e92 ]

We consistently switched from kmalloc() to vmalloc() in module
decompression to prevent potential memory allocation failures with large
modules, however vmalloc() is not as memory-efficient and fast as
kmalloc().

Since we don't know in general the size of the workspace required by the
decompression algorithm, it is more reasonable to use kvmalloc()
consistently, also considering that we don't have special memory
requirements here.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/module/decompress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 4156d59be4408..474e68f0f0634 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -100,7 +100,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 	s.next_in = buf + gzip_hdr_len;
 	s.avail_in = size - gzip_hdr_len;
 
-	s.workspace = vmalloc(zlib_inflate_workspacesize());
+	s.workspace = kvmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
 	if (!s.workspace)
 		return -ENOMEM;
 
@@ -138,7 +138,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 out_inflate_end:
 	zlib_inflateEnd(&s);
 out:
-	vfree(s.workspace);
+	kvfree(s.workspace);
 	return retval;
 }
 #elif defined(CONFIG_MODULE_COMPRESS_XZ)
@@ -241,7 +241,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	}
 
 	wksp_size = zstd_dstream_workspace_bound(header.windowSize);
-	wksp = vmalloc(wksp_size);
+	wksp = kvmalloc(wksp_size, GFP_KERNEL);
 	if (!wksp) {
 		retval = -ENOMEM;
 		goto out;
@@ -284,7 +284,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	retval = new_size;
 
  out:
-	vfree(wksp);
+	kvfree(wksp);
 	return retval;
 }
 #else
-- 
2.42.0



