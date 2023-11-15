Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A907ECEC8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjKOToq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjKOTon (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CFB1AE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B61C433C8;
        Wed, 15 Nov 2023 19:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077478;
        bh=Uxjb501i9TR00BFdLPHlTOf+XEWFXnwDbogectWIvik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ndvcfxMwMR4B02j7YTWwb5xtwcZ4MMP0H58u5Uyv+fhfsP9NsSdJUHKWqbAwDIMNC
         nhQVkuJx01/5uJjVYSbnfRuYvVDO2A3dSRpCi0BAX3jIqZaj74hOvTBlGUif4XkrKy
         fQuqrNO66xUFC1iwRzJe0XP50nCvhsbtxzgf3MWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrea Righi <andrea.righi@canonical.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 328/603] module/decompress: use vmalloc() for gzip decompression workspace
Date:   Wed, 15 Nov 2023 14:14:33 -0500
Message-ID: <20231115191636.206012766@linuxfoundation.org>
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

[ Upstream commit 3737df782c740b944912ed93420c57344b1cf864 ]

Use a similar approach as commit a419beac4a07 ("module/decompress: use
vmalloc() for zstd decompression workspace") and replace kmalloc() with
vmalloc() also for the gzip module decompression workspace.

In this case the workspace is represented by struct inflate_workspace
that can be fairly large for kmalloc() and it can potentially lead to
allocation errors on certain systems:

$ pahole inflate_workspace
struct inflate_workspace {
	struct inflate_state       inflate_state;        /*     0  9544 */
	/* --- cacheline 149 boundary (9536 bytes) was 8 bytes ago --- */
	unsigned char              working_window[32768]; /*  9544 32768 */

	/* size: 42312, cachelines: 662, members: 2 */
	/* last cacheline: 8 bytes */
};

Considering that there is no need to use continuous physical memory,
simply switch to vmalloc() to provide a more reliable in-kernel module
decompression.

Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/module/decompress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 87440f714c0ca..4156d59be4408 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -100,7 +100,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 	s.next_in = buf + gzip_hdr_len;
 	s.avail_in = size - gzip_hdr_len;
 
-	s.workspace = kmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
+	s.workspace = vmalloc(zlib_inflate_workspacesize());
 	if (!s.workspace)
 		return -ENOMEM;
 
@@ -138,7 +138,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 out_inflate_end:
 	zlib_inflateEnd(&s);
 out:
-	kfree(s.workspace);
+	vfree(s.workspace);
 	return retval;
 }
 #elif defined(CONFIG_MODULE_COMPRESS_XZ)
-- 
2.42.0



