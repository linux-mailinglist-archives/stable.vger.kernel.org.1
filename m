Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B27DD534
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376465AbjJaRsS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376470AbjJaRsR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:48:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D77F4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:48:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4897C433CC;
        Tue, 31 Oct 2023 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774483;
        bh=Fxz8nP0hfukXpe4fmzISJL36gwrPkjaBGe5FfwRpD/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o01VfA/749XgQ3l/8gBzJRpnDmAFPsxJFm3iCBR+Hj/RgzsrYwc4dTe3gCr/InEMN
         vBpciJl8gKmJC40uSdrRu3ZPTvOCns86ONPDQ0QRDdMsBwucyP+icdvNdXbur6pqe/
         viKmPDZ8D+y+c9EfLH8xQm6QEslJIT2OiKn4fMH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5 027/112] selftests/mm: include mman header to access MREMAP_DONTUNMAP identifier
Date:   Tue, 31 Oct 2023 18:00:28 +0100
Message-ID: <20231031165902.169542361@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

commit e2de156b0d918b5ebe975577d25f9ef92379a756 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/mm/mremap_dontunmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
index ca2359835e75..a06e73ec8568 100644
--- a/tools/testing/selftests/mm/mremap_dontunmap.c
+++ b/tools/testing/selftests/mm/mremap_dontunmap.c
@@ -7,6 +7,7 @@
  */
 #define _GNU_SOURCE
 #include <sys/mman.h>
+#include <linux/mman.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.42.0



