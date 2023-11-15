Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F9B7ECF5A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjKOTsD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjKOTsA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:48:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E0419F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F411C433CA;
        Wed, 15 Nov 2023 19:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077677;
        bh=N7zcSVg1LGoeg2oAkiFP3KN2zpB/EWToiUVRaPIB5I8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YR3DAXY6oWRO/Xyb43fQXFPmvOP9/0+T2j4+HkNaluxXHbbitbol2RW5wRSARFXZY
         6s+ki7hUbLMQqqFU4HvMxf3J2NWN6Kbu5qhT7jMNWRdfglbdD+HJd1oBQILEx6Gt/j
         mdLVKbStVNEdWD6UU/1Ybr2Zdb0PVMbd97BBlmgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 442/603] debugfs: Fix __rcu type comparison warning
Date:   Wed, 15 Nov 2023 14:16:27 -0500
Message-ID: <20231115191643.382799831@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Tipton <quic_mdtipton@quicinc.com>

[ Upstream commit 7360a48bd0f5e62b2d00c387d5d3f2821eb290ce ]

Sparse reports the following:

fs/debugfs/file.c:942:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
fs/debugfs/file.c:942:9: sparse:    char [noderef] __rcu *
fs/debugfs/file.c:942:9: sparse:    char *

rcu_assign_pointer() expects that it's assigning to pointers annotated
with __rcu. We can't annotate the generic struct file::private_data, so
cast it instead.

Fixes: 86b5488121db ("debugfs: Add write support to debugfs_create_str()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309091933.BRWlSnCq-lkp@intel.com/
Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
Link: https://lore.kernel.org/r/20230922134512.5126-1-quic_mdtipton@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 87b3753aa4b1e..c45e8c2d62e11 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -939,7 +939,7 @@ static ssize_t debugfs_write_file_str(struct file *file, const char __user *user
 	new[pos + count] = '\0';
 	strim(new);
 
-	rcu_assign_pointer(*(char **)file->private_data, new);
+	rcu_assign_pointer(*(char __rcu **)file->private_data, new);
 	synchronize_rcu();
 	kfree(old);
 
-- 
2.42.0



