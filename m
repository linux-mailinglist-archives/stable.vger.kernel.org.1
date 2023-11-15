Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA467ECCD7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjKOTcy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjKOTcx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:32:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873B1A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:32:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D2DC433C9;
        Wed, 15 Nov 2023 19:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076769;
        bh=zm2IymB5UicGTddR+DlRQ7+NOTPhpNDwPkAu6tDGQ3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vk7K9JCQO88QEWKh9uy3CzLjoj+iZc6JYmUFIdDUwENDmX0YmCRgQSvww5sLncMSV
         dUkArMIvExrNhA4Xf3d966BQr/boKXGdHKIXMim9nQxYRYGJBpqFrVfZ7FYTmJaHAc
         jOj0iiPyLEq8oo/KZykXJSqOzahMehiz8froFr/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Waiman Long <longman@redhat.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 021/603] cgroup/cpuset: Fix load balance state in update_partition_sd_lb()
Date:   Wed, 15 Nov 2023 14:09:26 -0500
Message-ID: <20231115191614.639316907@linuxfoundation.org>
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

From: Waiman Long <longman@redhat.com>

[ Upstream commit 6fcdb0183bf024a70abccb0439321c25891c708d ]

Commit a86ce68078b2 ("cgroup/cpuset: Extract out CS_CPU_EXCLUSIVE
& CS_SCHED_LOAD_BALANCE handling") adds a new helper function
update_partition_sd_lb() to update the load balance state of the
cpuset. However the new load balance is determined by just looking at
whether the cpuset is a valid isolated partition root or not.  That is
not enough if the cpuset is not a valid partition root but its parent
is in the isolated state (load balance off). Update the function to
set the new state to be the same as its parent in this case like what
has been done in commit c8c926200c55 ("cgroup/cpuset: Inherit parent's
load balance state in v2").

Fixes: a86ce68078b2 ("cgroup/cpuset: Extract out CS_CPU_EXCLUSIVE & CS_SCHED_LOAD_BALANCE handling")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58ec88efa4f82..4749e0c86c62c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1304,13 +1304,23 @@ static int update_partition_exclusive(struct cpuset *cs, int new_prs)
  *
  * Changing load balance flag will automatically call
  * rebuild_sched_domains_locked().
+ * This function is for cgroup v2 only.
  */
 static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
 {
 	int new_prs = cs->partition_root_state;
-	bool new_lb = (new_prs != PRS_ISOLATED);
 	bool rebuild_domains = (new_prs > 0) || (old_prs > 0);
+	bool new_lb;
 
+	/*
+	 * If cs is not a valid partition root, the load balance state
+	 * will follow its parent.
+	 */
+	if (new_prs > 0) {
+		new_lb = (new_prs != PRS_ISOLATED);
+	} else {
+		new_lb = is_sched_load_balance(parent_cs(cs));
+	}
 	if (new_lb != !!is_sched_load_balance(cs)) {
 		rebuild_domains = true;
 		if (new_lb)
-- 
2.42.0



