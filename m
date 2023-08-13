Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB6177AB8B
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjHMVXG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjHMVXF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DF0BF
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EC8A62860
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F73FC433C8;
        Sun, 13 Aug 2023 21:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961785;
        bh=vFmKYYdT9dD/0yIP7GDSf/IPlBizywBUaEh2sD0SS/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDcbvo80a2/w58cTWvEHjOSQ7ECpIJ8xAs1mtv0Au3hZohUHLZDpO4iR0NmOZbM3G
         hotvU2+zmvqXNPhxjgnAVhJvli9PRkGzeYV4Aj2xNtzGe74XKJNJvm9jZjxyaCgug7
         cAsLHkHgZT56aUhRiYeI0Ss77Ak7lBbeyy6bgs5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 4.19 32/33] alpha: remove __init annotation from exported page_is_ram()
Date:   Sun, 13 Aug 2023 23:19:26 +0200
Message-ID: <20230813211705.104711062@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211703.915807095@linuxfoundation.org>
References: <20230813211703.915807095@linuxfoundation.org>
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
@@ -469,8 +469,7 @@ setup_memory(void *kernel_end)
 extern void setup_memory(void *);
 #endif /* !CONFIG_DISCONTIGMEM */
 
-int __init
-page_is_ram(unsigned long pfn)
+int page_is_ram(unsigned long pfn)
 {
 	struct memclust_struct * cluster;
 	struct memdesc_struct * memdesc;


