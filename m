Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089B57CA214
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjJPIpo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJPIpn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:45:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D421DC
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:45:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747A0C433C7;
        Mon, 16 Oct 2023 08:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445940;
        bh=+GkA8iAzL4GLJtRwc+FHMDoIVmhBtZXtwxRpusSFUcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfCNGFGuZtukxD8eqn4ZF7YMeOjpBHgUz/NHugq8ihUxDV1GUi14nsCw3szeXIDrg
         qmXaskpLF1AkW3K0U3tKQgf3EcMACd40HXUEy0/OhvLaeic3F+xk39FIP3CpYuEarm
         KDNT6lv6sew9csCdMMbo81jOwLf5wbISjbU4ZjjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Waiman Long <longman@redhat.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 041/102] workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()
Date:   Mon, 16 Oct 2023 10:40:40 +0200
Message-ID: <20231016083954.795505665@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

[ Upstream commit ca10d851b9ad0338c19e8e3089e24d565ebfffd7 ]

Commit 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1
to be ordered") enabled implicit ordered attribute to be added to
WQ_UNBOUND workqueues with max_active of 1. This prevented the changing
of attributes to these workqueues leading to fix commit 0a94efb5acbb
("workqueue: implicit ordered attribute should be overridable").

However, workqueue_apply_unbound_cpumask() was not updated at that time.
So sysfs changes to wq_unbound_cpumask has no effect on WQ_UNBOUND
workqueues with implicit ordered attribute. Since not all WQ_UNBOUND
workqueues are visible on sysfs, we are not able to make all the
necessary cpumask changes even if we iterates all the workqueue cpumasks
in sysfs and changing them one by one.

Fix this problem by applying the corresponding change made
to apply_workqueue_attrs_locked() in the fix commit to
workqueue_apply_unbound_cpumask().

Fixes: 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8e108c040cc35..19868cf588779 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5379,9 +5379,13 @@ static int workqueue_apply_unbound_cpumask(void)
 	list_for_each_entry(wq, &workqueues, list) {
 		if (!(wq->flags & WQ_UNBOUND))
 			continue;
+
 		/* creating multiple pwqs breaks ordering guarantee */
-		if (wq->flags & __WQ_ORDERED)
-			continue;
+		if (!list_empty(&wq->pwqs)) {
+			if (wq->flags & __WQ_ORDERED_EXPLICIT)
+				continue;
+			wq->flags &= ~__WQ_ORDERED;
+		}
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs);
 		if (!ctx) {
-- 
2.40.1



