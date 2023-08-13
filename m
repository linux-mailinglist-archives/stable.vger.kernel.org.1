Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35AA77AB6F
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjHMVV4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHMVV4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:21:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5419E10DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC438627DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC17BC433C7;
        Sun, 13 Aug 2023 21:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961717;
        bh=vFmKYYdT9dD/0yIP7GDSf/IPlBizywBUaEh2sD0SS/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lt5XkbLq1t2myaj8k9org/34L1qtRdPnnBbZtPPh7BNsfz2xgG0wNb8gLE9JDkWFb
         3yudxziMK7SKONXPqZDdyv5yJHkV5ZZWhTtJZr9+HsWoBsnJBPvPX8g4a9WZd0CnCr
         Up17IDN6M+ve0vwC5Cpi8JfPwoikYPCf/HdRI6pQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 4.14 26/26] alpha: remove __init annotation from exported page_is_ram()
Date:   Sun, 13 Aug 2023 23:19:19 +0200
Message-ID: <20230813211703.953628985@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211702.980427106@linuxfoundation.org>
References: <20230813211702.980427106@linuxfoundation.org>
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


