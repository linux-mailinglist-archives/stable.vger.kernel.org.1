Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97F726CC7
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjFGUgX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjFGUf5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:35:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44F326BC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4253644CD
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E783C433D2;
        Wed,  7 Jun 2023 20:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170146;
        bh=6yNLgaHGrC4Bh6fqI0BGDe6gfAnBGlTDOn8++TzoK90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LtJ52zoNYWYPfRHC2FP4Lfo4xKS2hWB7Jjj/OuJn2/JE42ak8wvQOVPV0RImS3Fza
         HVWUJBATsllE47NLE1Oyk8SYJbvnnXKz4j2iI35BmcT8CHcGe0HZepp7XcfUItdxF4
         HrUJCgiPzq98LlGPBkaz/ki3FkMRy6IOoLCvDfJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 23/88] ocfs2/dlm: move BITS_TO_BYTES() to bitops.h for wider use
Date:   Wed,  7 Jun 2023 22:15:40 +0200
Message-ID: <20230607200859.740762082@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit dd3e7cba16274831f5a69f071ed3cf13ffb352ea ]

There are users already and will be more of BITS_TO_BYTES() macro.  Move
it to bitops.h for wider use.

In the case of ocfs2 the replacement is identical.

As for bnx2x, there are two places where floor version is used.  In the
first case to calculate the amount of structures that can fit one memory
page.  In this case obviously the ceiling variant is correct and
original code might have a potential bug, if amount of bits % 8 is not
0.  In the second case the macro is used to calculate bytes transmitted
in one microsecond.  This will work for all speeds which is multiply of
1Gbps without any change, for the rest new code will give ceiling value,
for instance 100Mbps will give 13 bytes, while old code gives 12 bytes
and the arithmetically correct one is 12.5 bytes.  Further the value is
used to setup timer threshold which in any case has its own margins due
to certain resolution.  I don't see here an issue with slightly shifting
thresholds for low speed connections, the card is supposed to utilize
highest available rate, which is usually 10Gbps.

Link: http://lkml.kernel.org/r/20200108121316.22411-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Acked-by: Sudarsana Reddy Kalluru <skalluru@marvell.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: f4e4534850a9 ("net/netlink: fix NETLINK_LIST_MEMBERSHIPS length report")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h | 1 -
 fs/ocfs2/dlm/dlmcommon.h                         | 4 ----
 include/linux/bitops.h                           | 1 +
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h
index 46ee2c01f4c51..d16b1eddbecf2 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h
@@ -296,7 +296,6 @@ static inline void bnx2x_dcb_config_qm(struct bnx2x *bp, enum cos_mode mode,
  *    possible, the driver should only write the valid vnics into the internal
  *    ram according to the appropriate port mode.
  */
-#define BITS_TO_BYTES(x) ((x)/8)
 
 /* CMNG constants, as derived from system spec calculations */
 
diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index d06e27ec4be47..fb181f6d6c064 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -704,10 +704,6 @@ struct dlm_begin_reco
 	__be32 pad2;
 };
 
-
-#define BITS_PER_BYTE 8
-#define BITS_TO_BYTES(bits) (((bits)+BITS_PER_BYTE-1)/BITS_PER_BYTE)
-
 struct dlm_query_join_request
 {
 	u8 node_idx;
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 5c1522ed2d7c7..29ce32a2b6c3c 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -6,6 +6,7 @@
 
 #define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
+#define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
-- 
2.39.2



