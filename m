Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96087B88B8
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjJDSSp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjJDSSp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:18:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FBBE9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:18:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB8EC433C7;
        Wed,  4 Oct 2023 18:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443520;
        bh=042rId0dKZIb7Eje3+Oo6xSPE4TguqI3MMosyc1oMXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uB5sQW/zeqJTqWDZcl4F5sdLOeQ7pmP7SW3/SXcLpOxX+lxyRIqfT/gl8f+DOuJNA
         PsczyAeK3FIYxkmgKhPesdb5P4Eb/elqbcHFq6CyK2a/3tR1hAwJIyuum/zTkrCme/
         PhJORoKuafXOs2aoR+0xQZ/vcRqARRafNh5JU914=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 184/259] memblock tests: fix warning: "__ALIGN_KERNEL" redefined
Date:   Wed,  4 Oct 2023 19:55:57 +0200
Message-ID: <20231004175225.740055447@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport (IBM) <rppt@kernel.org>

[ Upstream commit 5e1bffbdb63baf89f3bf0b6bafb50903432a7434 ]

Building memblock tests produces the following warning:

cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o main.o main.c
In file included from ../../include/linux/pfn.h:5,
                 from ./linux/memory_hotplug.h:6,
                 from ./linux/init.h:7,
                 from ./linux/memblock.h:11,
                 from tests/common.h:8,
                 from tests/basic_api.h:5,
                 from main.c:2:
../../include/linux/mm.h:14: warning: "__ALIGN_KERNEL" redefined
   14 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
      |
In file included from ../../include/linux/mm.h:6,
                 from ../../include/linux/pfn.h:5,
                 from ./linux/memory_hotplug.h:6,
                 from ./linux/init.h:7,
                 from ./linux/memblock.h:11,
                 from tests/common.h:8,
                 from tests/basic_api.h:5,
                 from main.c:2:
../../include/uapi/linux/const.h:31: note: this is the location of the previous definition
   31 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
      |

Remove definitions of __ALIGN_KERNEL and __ALIGN_KERNEL_MASK from
tools/include/linux/mm.h to fix it.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index a03d9bba51514..43be27bcc897d 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -11,8 +11,6 @@
 
 #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
 
-#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
-#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 #define ALIGN(x, a)			__ALIGN_KERNEL((x), (a))
 #define ALIGN_DOWN(x, a)		__ALIGN_KERNEL((x) - ((a) - 1), (a))
 
-- 
2.40.1



