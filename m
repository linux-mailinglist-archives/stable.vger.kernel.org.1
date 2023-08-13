Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3337077AD74
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjHMVt1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjHMVs4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35A110FC
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DAF163826
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F38AC433C8;
        Sun, 13 Aug 2023 21:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962759;
        bh=qmdwKFJQSZSPR8QIoAwbWOQA29ZpZIJtGXNfmYJYEl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZwquM7uJccAci4dCvgkFbvSSsmhgpW1kuJvggWhaYOzh3f1M01goBq4GzlCrbcss
         GrF81SV4IBCHWCy5DWrwKqdPl0CuMw9ZbdUQz+5tkhek1HJ5qYNZ6KBOBj3BoDDt5j
         /h2hISnn5q7RjFyQ4MHf59vpKEtbarVAMgBVCAEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 6.1 147/149] alpha: remove __init annotation from exported page_is_ram()
Date:   Sun, 13 Aug 2023 23:19:52 +0200
Message-ID: <20230813211723.087208905@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

commit 6ccbd7fd474674654019a20177c943359469103a upstream.

EXPORT_SYMBOL and __init is a bad combination because the .init.text
section is freed up after the initialization.

Commit c5a130325f13 ("ACPI/APEI: Add parameter check before error
injection") exported page_is_ram(), hence the __init annotation should
be removed.

This fixes the modpost warning in ARCH=alpha builds:

  WARNING: modpost: vmlinux: page_is_ram: EXPORT_SYMBOL used for init symbol. Remove __init or EXPORT_SYMBOL.

Fixes: c5a130325f13 ("ACPI/APEI: Add parameter check before error injection")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/alpha/kernel/setup.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -385,8 +385,7 @@ setup_memory(void *kernel_end)
 #endif /* CONFIG_BLK_DEV_INITRD */
 }
 
-int __init
-page_is_ram(unsigned long pfn)
+int page_is_ram(unsigned long pfn)
 {
 	struct memclust_struct * cluster;
 	struct memdesc_struct * memdesc;


