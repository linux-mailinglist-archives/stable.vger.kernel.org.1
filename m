Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3476AF78
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjHAJro (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjHAJr3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA923A86
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30FD614BB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAD9C433C7;
        Tue,  1 Aug 2023 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883163;
        bh=8/4yf623rSjI3i44RV1xF28lWzqnoeXZEdFcYBgm05I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0724PI9zczypy8+Pgg+cORLurQB6m23QEvZBahUluE6pIAdR/Dqx9U8IbTg6rL5ax
         Mg2CelXPutmPZZA644m0NtkXUTc5io4+qK+NU/s2R6FyQmCuNmKmdPqMfnWZk8ZdaM
         z2dsmis+b5/42AglnpfCo3I8nR7wEVQXK2Ym2GhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hugh Dickins <hughd@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 138/239] tmpfs: fix Documentation of noswap and huge mount options
Date:   Tue,  1 Aug 2023 11:20:02 +0200
Message-ID: <20230801091930.665877363@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

[ Upstream commit 253e5df8b8f0145adb090f57c6f4e6efa52d738e ]

The noswap mount option is surely not one of the three options for sizing:
move its description down.

The huge= mount option does not accept numeric values: those are just in
an internal enum.  Delete those numbers, and follow the manpage text more
closely (but there's not yet any fadvise() or fcntl() which applies here).

/sys/kernel/mm/transparent_hugepage/shmem_enabled is hard to describe, and
barely relevant to mounting a tmpfs: just refer to transhuge.rst (while
still using the words deny and force, to help as informal reminders).

[rdunlap@infradead.org: fixup Docs table for huge mount options]
  Link: https://lkml.kernel.org/r/20230725052333.26857-1-rdunlap@infradead.org
Link: https://lkml.kernel.org/r/986cb0bf-9780-354-9bb-4bf57aadbab@google.com
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: d0f5a85442d1 ("shmem: update documentation")
Fixes: 2c6efe9cf2d7 ("shmem: add support to ignore swap")
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/tmpfs.rst | 47 ++++++++++++-----------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index f18f46be5c0c7..2cd8fa332feb7 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -84,8 +84,6 @@ nr_inodes  The maximum number of inodes for this instance. The default
            is half of the number of your physical RAM pages, or (on a
            machine with highmem) the number of lowmem RAM pages,
            whichever is the lower.
-noswap     Disables swap. Remounts must respect the original settings.
-           By default swap is enabled.
 =========  ============================================================
 
 These parameters accept a suffix k, m or g for kilo, mega and giga and
@@ -99,36 +97,31 @@ mount with such options, since it allows any user with write access to
 use up all the memory on the machine; but enhances the scalability of
 that instance in a system with many CPUs making intensive use of it.
 
+tmpfs blocks may be swapped out, when there is a shortage of memory.
+tmpfs has a mount option to disable its use of swap:
+
+======  ===========================================================
+noswap  Disables swap. Remounts must respect the original settings.
+        By default swap is enabled.
+======  ===========================================================
+
 tmpfs also supports Transparent Huge Pages which requires a kernel
 configured with CONFIG_TRANSPARENT_HUGEPAGE and with huge supported for
 your system (has_transparent_hugepage(), which is architecture specific).
 The mount options for this are:
 
-======  ============================================================
-huge=0  never: disables huge pages for the mount
-huge=1  always: enables huge pages for the mount
-huge=2  within_size: only allocate huge pages if the page will be
-        fully within i_size, also respect fadvise()/madvise() hints.
-huge=3  advise: only allocate huge pages if requested with
-        fadvise()/madvise()
-======  ============================================================
-
-There is a sysfs file which you can also use to control system wide THP
-configuration for all tmpfs mounts, the file is:
-
-/sys/kernel/mm/transparent_hugepage/shmem_enabled
-
-This sysfs file is placed on top of THP sysfs directory and so is registered
-by THP code. It is however only used to control all tmpfs mounts with one
-single knob. Since it controls all tmpfs mounts it should only be used either
-for emergency or testing purposes. The values you can set for shmem_enabled are:
-
-==  ============================================================
--1  deny: disables huge on shm_mnt and all mounts, for
-    emergency use
--2  force: enables huge on shm_mnt and all mounts, w/o needing
-    option, for testing
-==  ============================================================
+================ ==============================================================
+huge=never       Do not allocate huge pages.  This is the default.
+huge=always      Attempt to allocate huge page every time a new page is needed.
+huge=within_size Only allocate huge page if it will be fully within i_size.
+                 Also respect madvise(2) hints.
+huge=advise      Only allocate huge page if requested with madvise(2).
+================ ==============================================================
+
+See also Documentation/admin-guide/mm/transhuge.rst, which describes the
+sysfs file /sys/kernel/mm/transparent_hugepage/shmem_enabled: which can
+be used to deny huge pages on all tmpfs mounts in an emergency, or to
+force huge pages on all tmpfs mounts for testing.
 
 tmpfs has a mount option to set the NUMA memory allocation policy for
 all files in that instance (if CONFIG_NUMA is enabled) - which can be
-- 
2.40.1



