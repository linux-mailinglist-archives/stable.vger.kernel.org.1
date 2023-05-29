Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C595714CE2
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 17:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjE2PUG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 11:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2PUG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 11:20:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79406DB
        for <stable@vger.kernel.org>; Mon, 29 May 2023 08:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0912615C8
        for <stable@vger.kernel.org>; Mon, 29 May 2023 15:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1591DC433D2;
        Mon, 29 May 2023 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685373603;
        bh=jv9I8e7wwc4bpKEeJMTOYGAzMnLoGpUJ6w9EFYHtgWY=;
        h=Subject:To:From:Date:From;
        b=qh+yBLlKaVkGqDWZA50uSEOc9b+YGBJEZrklK4x6LPRu+LvPb3VREje3RqiaZmbsB
         5BW9XUrMfpAw3yqGgsI0sAlp8Q1FhXKVTcyiLp1r545V2Gx9OPo2WxpEggDkZ2WT/v
         yVOmZgOcGzYTvtRYdgJ0bEt1t95FjNalzQ7JdKQ8=
Subject: patch "mm: page_table_check: Make it dependent on EXCLUSIVE_SYSTEM_RAM" added to usb-linus
To:     lrh2000@pku.edu.cn, david@redhat.com, gregkh@linuxfoundation.org,
        pasha.tatashin@soleen.com, stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 29 May 2023 16:19:51 +0100
Message-ID: <2023052951-eating-slit-3a4e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    mm: page_table_check: Make it dependent on EXCLUSIVE_SYSTEM_RAM

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 81a31a860bb61d54eb688af2568d9332ed9b8942 Mon Sep 17 00:00:00 2001
From: Ruihan Li <lrh2000@pku.edu.cn>
Date: Mon, 15 May 2023 21:09:57 +0800
Subject: mm: page_table_check: Make it dependent on EXCLUSIVE_SYSTEM_RAM

Without EXCLUSIVE_SYSTEM_RAM, users are allowed to map arbitrary
physical memory regions into the userspace via /dev/mem. At the same
time, pages may change their properties (e.g., from anonymous pages to
named pages) while they are still being mapped in the userspace, leading
to "corruption" detected by the page table check.

To avoid these false positives, this patch makes PAGE_TABLE_CHECK
depends on EXCLUSIVE_SYSTEM_RAM. This dependency is understandable
because PAGE_TABLE_CHECK is a hardening technique but /dev/mem without
STRICT_DEVMEM (i.e., !EXCLUSIVE_SYSTEM_RAM) is itself a security
problem.

Even with EXCLUSIVE_SYSTEM_RAM, I/O pages may be still allowed to be
mapped via /dev/mem. However, these pages are always considered as named
pages, so they won't break the logic used in the page table check.

Cc: <stable@vger.kernel.org> # 5.17
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Link: https://lore.kernel.org/r/20230515130958.32471-4-lrh2000@pku.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/mm/page_table_check.rst | 19 +++++++++++++++++++
 mm/Kconfig.debug                      |  1 +
 2 files changed, 20 insertions(+)

diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/page_table_check.rst
index cfd8f4117cf3..c12838ce6b8d 100644
--- a/Documentation/mm/page_table_check.rst
+++ b/Documentation/mm/page_table_check.rst
@@ -52,3 +52,22 @@ Build kernel with:
 
 Optionally, build kernel with PAGE_TABLE_CHECK_ENFORCED in order to have page
 table support without extra kernel parameter.
+
+Implementation notes
+====================
+
+We specifically decided not to use VMA information in order to avoid relying on
+MM states (except for limited "struct page" info). The page table check is a
+separate from Linux-MM state machine that verifies that the user accessible
+pages are not falsely shared.
+
+PAGE_TABLE_CHECK depends on EXCLUSIVE_SYSTEM_RAM. The reason is that without
+EXCLUSIVE_SYSTEM_RAM, users are allowed to map arbitrary physical memory
+regions into the userspace via /dev/mem. At the same time, pages may change
+their properties (e.g., from anonymous pages to named pages) while they are
+still being mapped in the userspace, leading to "corruption" detected by the
+page table check.
+
+Even with EXCLUSIVE_SYSTEM_RAM, I/O pages may be still allowed to be mapped via
+/dev/mem. However, these pages are always considered as named pages, so they
+won't break the logic used in the page table check.
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index a925415b4d10..018a5bd2f576 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -98,6 +98,7 @@ config PAGE_OWNER
 config PAGE_TABLE_CHECK
 	bool "Check for invalid mappings in user page tables"
 	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	depends on EXCLUSIVE_SYSTEM_RAM
 	select PAGE_EXTENSION
 	help
 	  Check that anonymous page is not being mapped twice with read write
-- 
2.40.1


