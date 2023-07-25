Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7CC7612B2
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjGYLFH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjGYLEr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F0A5258
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7156561682
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A5CC433C8;
        Tue, 25 Jul 2023 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282923;
        bh=BSVlODmCw0Yzs4ErthHT+yem3GJse266hrwu175P4ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMsxmi/wcCr6v1aQmhQx/z4R9PzUQbzj+cnCYxKLJ9yinVeY//epcgLfGsr68X3FO
         csb6z0N1gJgdN8G17KrQplog5BCQscB4RP7yqpGJDSPY/1sIe1WBrLyAxBtGDd6e00
         zXwMIlHa/sJ+XGCZ1qYIXA5ssrg67MFYvY4JDRkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 076/183] wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()
Date:   Tue, 25 Jul 2023 12:45:04 +0200
Message-ID: <20230725104510.704821640@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gustavo A. R. Silva <gustavoars@kernel.org>

[ Upstream commit 71e7552c90db2a2767f5c17c7ec72296b0d92061 ]

-Wstringop-overflow is legitimately warning us about extra_size
pontentially being zero at some point, hence potenially ending
up _allocating_ zero bytes of memory for extra pointer and then
trying to access such object in a call to copy_from_user().

Fix this by adding a sanity check to ensure we never end up
trying to allocate zero bytes of data for extra pointer, before
continue executing the rest of the code in the function.

Address the following -Wstringop-overflow warning seen when built
m68k architecture with allyesconfig configuration:
                 from net/wireless/wext-core.c:11:
In function '_copy_from_user',
    inlined from 'copy_from_user' at include/linux/uaccess.h:183:7,
    inlined from 'ioctl_standard_iw_point' at net/wireless/wext-core.c:825:7:
arch/m68k/include/asm/string.h:48:25: warning: '__builtin_memset' writing 1 or more bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
   48 | #define memset(d, c, n) __builtin_memset(d, c, n)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/uaccess.h:153:17: note: in expansion of macro 'memset'
  153 |                 memset(to + (n - res), 0, res);
      |                 ^~~~~~
In function 'kmalloc',
    inlined from 'kzalloc' at include/linux/slab.h:694:9,
    inlined from 'ioctl_standard_iw_point' at net/wireless/wext-core.c:819:10:
include/linux/slab.h:577:16: note: at offset 1 into destination object of size 0 allocated by '__kmalloc'
  577 |         return __kmalloc(size, flags);
      |                ^~~~~~~~~~~~~~~~~~~~~~

This help with the ongoing efforts to globally enable
-Wstringop-overflow.

Link: https://github.com/KSPP/linux/issues/315
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/ZItSlzvIpjdjNfd8@work
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/wext-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index fe8765c4075d3..8a4b85f96a13a 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -799,6 +799,12 @@ static int ioctl_standard_iw_point(struct iw_point *iwp, unsigned int cmd,
 		}
 	}
 
+	/* Sanity-check to ensure we never end up _allocating_ zero
+	 * bytes of data for extra.
+	 */
+	if (extra_size <= 0)
+		return -EFAULT;
+
 	/* kzalloc() ensures NULL-termination for essid_compat. */
 	extra = kzalloc(extra_size, GFP_KERNEL);
 	if (!extra)
-- 
2.39.2



