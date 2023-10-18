Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8087CE77A
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 21:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjJRTNj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 15:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjJRTNY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 15:13:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFBE119;
        Wed, 18 Oct 2023 12:13:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE48C433C8;
        Wed, 18 Oct 2023 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697656403;
        bh=o/jJQcRcTJsCc/Y46guB4iuWQEdihoZOViyY1UKM8sg=;
        h=Date:To:From:Subject:From;
        b=XHVLvrD8Q3B30685nqDynZzINMnIzAcJTEHR0FrIEuOPmdltOR6WryKTRNJKF4NuL
         PGF2PGBPh4Nr5YzJQtxYDD0fhVF1YcQEntNtZJSy4MO7rzWiYzgpg7Ai7RhR6Vuntl
         unvpxLpdJK3OXdJoWWtDsDVk2AbLzRqv5sBw0Hn0=
Date:   Wed, 18 Oct 2023 12:13:22 -0700
To:     mm-commits@vger.kernel.org, usama.anjum@collabora.com,
        stable@vger.kernel.org, shuah@kernel.org, lkft@linaro.org,
        samasth.norway.ananda@oracle.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] selftests-mm-include-mman-header-to-access-mremap_dontunmap-identifier.patch removed from -mm tree
Message-Id: <20231018191322.EFE48C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: selftests/mm: include mman header to access MREMAP_DONTUNMAP identifier
has been removed from the -mm tree.  Its filename was
     selftests-mm-include-mman-header-to-access-mremap_dontunmap-identifier.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Subject: selftests/mm: include mman header to access MREMAP_DONTUNMAP identifier
Date: Thu, 12 Oct 2023 08:52:57 -0700

Definition for MREMAP_DONTUNMAP is not present in glibc older than 2.32
thus throwing an undeclared error when running make on mm.  Including
linux/mman.h solves the build error for people having older glibc.

Link: https://lkml.kernel.org/r/20231012155257.891776-1-samasth.norway.ananda@oracle.com
Fixes: 0183d777c29a ("selftests: mm: remove duplicate unneeded defines")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/linux-mm/CA+G9fYvV-71XqpCr_jhdDfEtN701fBdG3q+=bafaZiGwUXy_aA@mail.gmail.com/
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/mm/mremap_dontunmap.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/mm/mremap_dontunmap.c~selftests-mm-include-mman-header-to-access-mremap_dontunmap-identifier
+++ a/tools/testing/selftests/mm/mremap_dontunmap.c
@@ -7,6 +7,7 @@
  */
 #define _GNU_SOURCE
 #include <sys/mman.h>
+#include <linux/mman.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
_

Patches currently in -mm which might be from samasth.norway.ananda@oracle.com are


