Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8EF7DE3A5
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 16:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjKAOrY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbjKAOrQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 10:47:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58858ED;
        Wed,  1 Nov 2023 07:47:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DDAC433C8;
        Wed,  1 Nov 2023 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698850028;
        bh=Xm89NC+amGfYEXaZSFGCBxwP6pgJOCCd0/pyk05JZDM=;
        h=Date:To:From:Subject:From;
        b=0naWA6IWgVaV13cFeMvgDublpP9+2jK0PzIDc8FIH+Zs7j/I7ng2yS3o6COL/e54/
         RwllEwkKV3rCXvQx0CuadyMLX/0HZGarwiTktNdjQlHBh2TJ34Yg8YHH10fizCPyMs
         pMcdjKNes4uEFrIVF+x2g8W5vzb4nGUNsJh2Inmw=
Date:   Wed, 01 Nov 2023 07:47:08 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        Kuan-Ying.Lee@mediatek.com, kbingham@kernel.org,
        jan.kiszka@siemens.com, ben.wolsieffer@hefring.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + scripts-gdb-vmalloc-disable-on-no-mmu.patch added to mm-hotfixes-unstable branch
Message-Id: <20231101144708.D8DDAC433C8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: scripts/gdb/vmalloc: disable on no-MMU
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     scripts-gdb-vmalloc-disable-on-no-mmu.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/scripts-gdb-vmalloc-disable-on-no-mmu.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: scripts/gdb/vmalloc: disable on no-MMU
Date: Tue, 31 Oct 2023 16:22:36 -0400

vmap_area does not exist on no-MMU, therefore the GDB scripts fail to
load:

Traceback (most recent call last):
  File "<...>/vmlinux-gdb.py", line 51, in <module>
    import linux.vmalloc
  File "<...>/scripts/gdb/linux/vmalloc.py", line 14, in <module>
    vmap_area_ptr_type = vmap_area_type.get_type().pointer()
                         ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<...>/scripts/gdb/linux/utils.py", line 28, in get_type
    self._type = gdb.lookup_type(self._name)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
gdb.error: No struct type named vmap_area.

To fix this, disable the command and add an informative error message if
CONFIG_MMU is not defined, following the example of lx-slabinfo.

Link: https://lkml.kernel.org/r/20231031202235.2655333-2-ben.wolsieffer@hefring.com
Fixes: 852622bf3616 ("scripts/gdb/vmalloc: add vmallocinfo support")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/gdb/linux/constants.py.in |    1 +
 scripts/gdb/linux/vmalloc.py      |    8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/scripts/gdb/linux/constants.py.in~scripts-gdb-vmalloc-disable-on-no-mmu
+++ a/scripts/gdb/linux/constants.py.in
@@ -157,3 +157,4 @@ LX_CONFIG(CONFIG_STACKDEPOT)
 LX_CONFIG(CONFIG_PAGE_OWNER)
 LX_CONFIG(CONFIG_SLUB_DEBUG)
 LX_CONFIG(CONFIG_SLAB_FREELIST_HARDENED)
+LX_CONFIG(CONFIG_MMU)
--- a/scripts/gdb/linux/vmalloc.py~scripts-gdb-vmalloc-disable-on-no-mmu
+++ a/scripts/gdb/linux/vmalloc.py
@@ -10,8 +10,9 @@ import gdb
 import re
 from linux import lists, utils, stackdepot, constants, mm
 
-vmap_area_type = utils.CachedType('struct vmap_area')
-vmap_area_ptr_type = vmap_area_type.get_type().pointer()
+if constants.LX_CONFIG_MMU:
+    vmap_area_type = utils.CachedType('struct vmap_area')
+    vmap_area_ptr_type = vmap_area_type.get_type().pointer()
 
 def is_vmalloc_addr(x):
     pg_ops = mm.page_ops().ops
@@ -25,6 +26,9 @@ class LxVmallocInfo(gdb.Command):
         super(LxVmallocInfo, self).__init__("lx-vmallocinfo", gdb.COMMAND_DATA)
 
     def invoke(self, arg, from_tty):
+        if not constants.LX_CONFIG_MMU:
+            raise gdb.GdbError("Requires MMU support")
+
         vmap_area_list = gdb.parse_and_eval('vmap_area_list')
         for vmap_area in lists.list_for_each_entry(vmap_area_list, vmap_area_ptr_type, "list"):
             if not vmap_area['vm']:
_

Patches currently in -mm which might be from ben.wolsieffer@hefring.com are

scripts-gdb-vmalloc-disable-on-no-mmu.patch

