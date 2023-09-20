Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283D47A7CC1
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjITMDy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjITMDt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:03:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47B3D8
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:03:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF34C433BC;
        Wed, 20 Sep 2023 12:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211423;
        bh=unam9qN45D8PPKs9WPTj30JouNxfY63hkHrhEjr10hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvYWztRBMarGRH3SYlCqepG/ji8nF06F3KuXZ08cBkNz+UM/qMPB5/zDU8V2qOXO0
         63/hsmGyLc5KC6R8/760o4HkGSyHsq42ff4ixbxqIRm+0kjgz1miJMgfimlgSQQzJj
         WilD8Jupv2kSEnuqYlKDGSgzvkGm0GG+NRBHARxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lu Jialin <lujialin4@huawei.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 088/186] cgroup:namespace: Remove unused cgroup_namespaces_init()
Date:   Wed, 20 Sep 2023 13:29:51 +0200
Message-ID: <20230920112840.088792035@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lu Jialin <lujialin4@huawei.com>

[ Upstream commit 82b90b6c5b38e457c7081d50dff11ecbafc1e61a ]

cgroup_namspace_init() just return 0. Therefore, there is no need to
call it during start_kernel. Just remove it.

Fixes: a79a908fd2b0 ("cgroup: introduce cgroup namespaces")
Signed-off-by: Lu Jialin <lujialin4@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/namespace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index b05f1dd58a622..313e66b8c6622 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -148,9 +148,3 @@ const struct proc_ns_operations cgroupns_operations = {
 	.install	= cgroupns_install,
 	.owner		= cgroupns_owner,
 };
-
-static __init int cgroup_namespaces_init(void)
-{
-	return 0;
-}
-subsys_initcall(cgroup_namespaces_init);
-- 
2.40.1



