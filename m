Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0909703AD9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242522AbjEOR4M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244816AbjEORzd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:55:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F6919F34
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7B6E62FC1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F61C433EF;
        Mon, 15 May 2023 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173203;
        bh=nmFQvOCzYYwpWKQu+Di3E93wuWGc7ZqlPuGOy0C+7c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXh7G5Vu6VhyCjtfQWzSvU6TcCkgKZQmdcqLEX0tPB4B0+zD2dlPBxJOcZvdwIi5E
         +6sSQOxfFrOqXYycR3PYLP7QUO7orehZd9NiFkVnZpLpAocE2Qp0W9Rxh3Nv0CFvlG
         PpE9zNjiou+wqriNICJhyWr9wafEdt0OiCTXDf2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.4 019/282] kheaders: Use array declaration instead of char
Date:   Mon, 15 May 2023 18:26:37 +0200
Message-Id: <20230515161722.851502942@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit b69edab47f1da8edd8e7bfdf8c70f51a2a5d89fb upstream.

Under CONFIG_FORTIFY_SOURCE, memcpy() will check the size of destination
and source buffers. Defining kernel_headers_data as "char" would trip
this check. Since these addresses are treated as byte arrays, define
them as arrays (as done everywhere else).

This was seen with:

  $ cat /sys/kernel/kheaders.tar.xz >> /dev/null

  detected buffer overflow in memcpy
  kernel BUG at lib/string_helpers.c:1027!
  ...
  RIP: 0010:fortify_panic+0xf/0x20
  [...]
  Call Trace:
   <TASK>
   ikheaders_read+0x45/0x50 [kheaders]
   kernfs_fop_read_iter+0x1a4/0x2f0
  ...

Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/bpf/20230302112130.6e402a98@kernel.org/
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Jakub Kicinski <kuba@kernel.org>
Fixes: 43d8ce9d65a5 ("Provide in-kernel headers to make extending kernel easier")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230302224946.never.243-kees@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kheaders.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 8f69772af77b..42163c9e94e5 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -26,15 +26,15 @@ asm (
 "	.popsection				\n"
 );
 
-extern char kernel_headers_data;
-extern char kernel_headers_data_end;
+extern char kernel_headers_data[];
+extern char kernel_headers_data_end[];
 
 static ssize_t
 ikheaders_read(struct file *file,  struct kobject *kobj,
 	       struct bin_attribute *bin_attr,
 	       char *buf, loff_t off, size_t len)
 {
-	memcpy(buf, &kernel_headers_data + off, len);
+	memcpy(buf, &kernel_headers_data[off], len);
 	return len;
 }
 
@@ -48,8 +48,8 @@ static struct bin_attribute kheaders_attr __ro_after_init = {
 
 static int __init ikheaders_init(void)
 {
-	kheaders_attr.size = (&kernel_headers_data_end -
-			      &kernel_headers_data);
+	kheaders_attr.size = (kernel_headers_data_end -
+			      kernel_headers_data);
 	return sysfs_create_bin_file(kernel_kobj, &kheaders_attr);
 }
 
-- 
2.40.1



