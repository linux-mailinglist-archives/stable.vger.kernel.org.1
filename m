Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328B477ADA4
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjHMVtp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjHMVtJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FA31FE5
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 864A360B9D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC02C433C7;
        Sun, 13 Aug 2023 21:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962950;
        bh=EC2WCWgyoiDU5+tDDPPWxY2CHdsny6DE+73l8d4hfeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neE2f5rWvcWGD77xQ3T58MujMaaqYeG1khOkLIDngswyGY3Q5hnCokYASW/FiHxXA
         y8uN6LQYULi1UtcCxvYX6KWs4M5RrByvdVZ7mdueyZ3A0Kufr48vtj3O/ZOUTtkPOB
         MplAwX/QhuOFaM5op72nsKi66gzIvZhgd0NdEr5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 5.10 67/68] alpha: remove __init annotation from exported page_is_ram()
Date:   Sun, 13 Aug 2023 23:20:08 +0200
Message-ID: <20230813211710.181595640@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
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
@@ -394,8 +394,7 @@ setup_memory(void *kernel_end)
 extern void setup_memory(void *);
 #endif /* !CONFIG_DISCONTIGMEM */
 
-int __init
-page_is_ram(unsigned long pfn)
+int page_is_ram(unsigned long pfn)
 {
 	struct memclust_struct * cluster;
 	struct memdesc_struct * memdesc;


