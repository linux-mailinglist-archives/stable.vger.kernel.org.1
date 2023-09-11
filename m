Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7DD79B4F9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350919AbjIKVmL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbjIKOO7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:14:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DF4DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:14:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF64C433C8;
        Mon, 11 Sep 2023 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441694;
        bh=1bSRE9NTM0PzhJOrlrbm0sz8ZA2wzMGp+C6LVSvS6wA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfYEgPtxhU6GwX5Jo0/fvdi4Ye/mQEIS3DNP6TDrjHXwpTkw2Go9ilcqTUdb0R6fN
         Zq9r6yTttoFX1vdXaf/yAEvAzxMUVVPZk9Zm+UWOf3yueEFNcBxhsB0RqDFkq9oIY1
         7G6Gc7f0a2jQKnIePVFM4SUlTg9iQ7FdXKA/6lPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 504/739] kernfs: add stub helper for kernfs_generic_poll()
Date:   Mon, 11 Sep 2023 15:45:03 +0200
Message-ID: <20230911134705.212093555@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 79038a99445f69c5d28494dd4f8c6f0509f65b2e ]

In some randconfig builds, kernfs ends up being disabled, so there is no prototype
for kernfs_generic_poll()

In file included from kernel/sched/build_utility.c:97:
kernel/sched/psi.c:1479:3: error: implicit declaration of function 'kernfs_generic_poll' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                kernfs_generic_poll(t->of, wait);
                ^

Add a stub helper for it, as we have it for other kernfs functions.

Fixes: aff037078ecae ("sched/psi: use kernfs polling functions for PSI trigger polling")
Fixes: 147e1a97c4a0b ("fs: kernfs: add poll file operation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Link: https://lore.kernel.org/r/20230724121823.1357562-1-arnd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kernfs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 73f5c120def88..2a36f3218b510 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -550,6 +550,10 @@ static inline int kernfs_setattr(struct kernfs_node *kn,
 				 const struct iattr *iattr)
 { return -ENOSYS; }
 
+static inline __poll_t kernfs_generic_poll(struct kernfs_open_file *of,
+					   struct poll_table_struct *pt)
+{ return -ENOSYS; }
+
 static inline void kernfs_notify(struct kernfs_node *kn) { }
 
 static inline int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
-- 
2.40.1



