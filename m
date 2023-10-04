Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF777B8A44
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244224AbjJDSdx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244386AbjJDSdw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:33:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA0C1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:33:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1116C433C8;
        Wed,  4 Oct 2023 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444428;
        bh=+STsLGGtghiXNmNc2EpcgkYOLwCU9zFI0koNLTB7zKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKdlZg169wkilnlK0aFSZrT5T2JnDbidT7yXg1yzYcxjTDDisFSYnH4jVcSYH3/zg
         hrQiR2ZmshTeGv01V4hS8ZXPG2rFyMMowSuQC8/vY+fpX/z6mq32y2RtVTne9D2sxg
         Cgl7WI5iITpx9tG/VJg7bHKB0UQqEnxmerB8X4NU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: =?UTF-8?q?=5BPATCH=206=2E5=20218/321=5D=20=3D=3FUTF-8=3Fq=3Fmemblock=3D20tests=3A=3D20fix=3D20warning=3D20=3DE2=3D80=3D98struct=3D20s=3F=3D=20=3D=3FUTF-8=3Fq=3Feq=3D5Ffile=3DE2=3D80=3D99=3D20declared=3D20inside=3D20parameter=3D20list=3F=3D?=
Date:   Wed,  4 Oct 2023 19:56:03 +0200
Message-ID: <20231004175239.336289834@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport (IBM) <rppt@kernel.org>

[ Upstream commit 55122e0130e51eb71f5ec62d10525db0468f28e8 ]

Building memblock tests produces the following warning:

cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o main.o main.c
In file included from tests/common.h:9,
                 from tests/basic_api.h:5,
                 from main.c:2:
./linux/memblock.h:601:50: warning: ‘struct seq_file’ declared inside parameter list will not be visible outside of this definition or declaration
  601 | static inline void memtest_report_meminfo(struct seq_file *m) { }
      |                                                  ^~~~~~~~

Add declaration of 'struct seq_file' to tools/include/linux/seq_file.h
to fix it.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/seq_file.h           | 2 ++
 tools/testing/memblock/tests/basic_api.c | 2 +-
 tools/testing/memblock/tests/common.h    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/seq_file.h b/tools/include/linux/seq_file.h
index 102fd9217f1f9..f6bc226af0c1d 100644
--- a/tools/include/linux/seq_file.h
+++ b/tools/include/linux/seq_file.h
@@ -1,4 +1,6 @@
 #ifndef _TOOLS_INCLUDE_LINUX_SEQ_FILE_H
 #define _TOOLS_INCLUDE_LINUX_SEQ_FILE_H
 
+struct seq_file;
+
 #endif /* _TOOLS_INCLUDE_LINUX_SEQ_FILE_H */
diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 411647094cc37..57bf2688edfd6 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include "basic_api.h"
 #include <string.h>
 #include <linux/memblock.h>
-#include "basic_api.h"
 
 #define EXPECTED_MEMBLOCK_REGIONS			128
 #define FUNC_ADD					"memblock_add"
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 4f23302ee6779..b5ec59aa62d72 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <assert.h>
 #include <linux/types.h>
+#include <linux/seq_file.h>
 #include <linux/memblock.h>
 #include <linux/sizes.h>
 #include <linux/printk.h>
-- 
2.40.1



