Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF2279BF07
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbjIKWqM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbjIKOvW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:51:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E0E118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:51:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE61C433C8;
        Mon, 11 Sep 2023 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443878;
        bh=GJz3bcSW0SkdWHkKtkXvWK1sphLj8pEJEY4EkiJeHAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=myeq6TfPLSR+jRx9FPiwDi8Fku4g/SR6qNCDyqwKKX8Om9+caNds0X6No73Rdatf0
         qsJBdrwKRMVSYv7GsHyAZscm0r+OPsmgPHWzdCD0lp1O7HVk09FlcqO+D9ACyutsDA
         3vq1eWLkROCzow3o+D/mzfCVaMZ2vfyyl1xND/Pc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 533/737] kernfs: add stub helper for kernfs_generic_poll()
Date:   Mon, 11 Sep 2023 15:46:32 +0200
Message-ID: <20230911134705.460514449@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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



