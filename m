Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756F3756DAE
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 21:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGQTyF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 15:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGQTyA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 15:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6CC129;
        Mon, 17 Jul 2023 12:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA9661236;
        Mon, 17 Jul 2023 19:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6FDC433C7;
        Mon, 17 Jul 2023 19:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689623638;
        bh=bZ3TRdZNWU/LCjwH3x5Tm/XjAruTTn4PAhBraVh253s=;
        h=Date:To:From:Subject:From;
        b=ROUs2psjq+kxle1oywGn8uVcbztyLhOxd82tW8+l54I1ihbgm8UVR2Hubfh09YQj5
         fbmYerwdxvEoutM+Sw9NCe0BrteB58F0Aem4AO/CoZqF4LtAEVW2hF60UdmbMryefu
         C+cTIDE5mHCguYIRixHELk0f0vUkfpvChIXfRDxQ=
Date:   Mon, 17 Jul 2023 12:53:58 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        shuah@kernel.org, david@redhat.com, colin.i.king@gmail.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] selftests-mm-mkdirty-fix-incorrect-position-of-endif.patch removed from -mm tree
Message-Id: <20230717195358.CD6FDC433C7@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: selftests/mm: mkdirty: fix incorrect position of #endif
has been removed from the -mm tree.  Its filename was
     selftests-mm-mkdirty-fix-incorrect-position-of-endif.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Colin Ian King <colin.i.king@gmail.com>
Subject: selftests/mm: mkdirty: fix incorrect position of #endif
Date: Wed, 12 Jul 2023 14:46:48 +0100

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
---

 tools/testing/selftests/mm/mkdirty.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/mm/mkdirty.c~selftests-mm-mkdirty-fix-incorrect-position-of-endif
+++ a/tools/testing/selftests/mm/mkdirty.c
@@ -321,8 +321,8 @@ close_uffd:
 munmap:
 	munmap(dst, pagesize);
 	free(src);
-#endif /* __NR_userfaultfd */
 }
+#endif /* __NR_userfaultfd */
 
 int main(void)
 {
_

Patches currently in -mm which might be from colin.i.king@gmail.com are


