Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C03576114E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGYKts (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjGYKtq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A837319BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A1F16166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC85C433C8;
        Tue, 25 Jul 2023 10:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282182;
        bh=mT/9TBZTj5ExxycItBcyg1vhw2lyBctivTPlTSmjo0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1SNPlQcK9XgylY69WF5MXCfP3rGseAIDYh44/cQ/+/d8x+wOHDahEjeBYdmuymif5
         ffhGsyLoCW3FVPY6Z9fs91zRYhF8Uw+ShEBxXr3roJ5ONprMI+IKB6C4zt5dve4zQB
         Qe8nKIJzmGa88ga3epnJ5gD6u6a5P273z81AL0Xw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Colin Ian King <colin.i.king@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 009/227] selftests/mm: mkdirty: fix incorrect position of #endif
Date:   Tue, 25 Jul 2023 12:42:56 +0200
Message-ID: <20230725104515.168067875@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

commit 25b5949c30938c7f26dbadc948b491e0e0811c78 upstream.

The #endif is the wrong side of a } causing a build failure when
__NR_userfaultfd is not defined.  Fix this by moving the #end to enclose
the }

Link: https://lkml.kernel.org/r/20230712134648.456349-1-colin.i.king@gmail.com
Fixes: 9eac40fc0cc7 ("selftests/mm: mkdirty: test behavior of (pte|pmd)_mkdirty on VMAs without write permissions")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/mm/mkdirty.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -321,8 +321,8 @@ close_uffd:
 munmap:
 	munmap(dst, pagesize);
 	free(src);
-#endif /* __NR_userfaultfd */
 }
+#endif /* __NR_userfaultfd */
 
 int main(void)
 {


