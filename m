Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9457A3847
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbjIQTdw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbjIQTda (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:33:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41260DB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:33:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D860C433C7;
        Sun, 17 Sep 2023 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979204;
        bh=LSUbO4cJjPl6HyouUaCCyJ72yWGay3TfLkzxVtSWnmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olUf0jYJvj/LQGa8531OHr4gcwr96Cs9klhJeeg3SIafJ8R+1UFLH9UgIgubF5MVu
         U67jDDALOO8sOHNqAVELasYpRa4vqmQ7Ja9s+fwGo7A2INxXABJzypbWgQ9CK6yHF1
         9z/rWAsyJ+SGiGMtBlM4he/Jf+Cdtn9nRDi5iU/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lu Jialin <lujialin4@huawei.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 244/406] cgroup:namespace: Remove unused cgroup_namespaces_init()
Date:   Sun, 17 Sep 2023 21:11:38 +0200
Message-ID: <20230917191107.602383627@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 812a61afd538a..d2b4dd753234e 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -149,9 +149,3 @@ const struct proc_ns_operations cgroupns_operations = {
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



