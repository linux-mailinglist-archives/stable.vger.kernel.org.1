Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C837D3250
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjJWLSv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjJWLSu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:18:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF210C
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:18:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0A2C433C8;
        Mon, 23 Oct 2023 11:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059928;
        bh=R9nn/yTI89PxtV+vvkwvBbrUUEuXxV5et1ZIibRPU58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEPO/HFMkealAsgnEegd5ZClE6cFUnSvjSxuR2/2v9CLe+gbgtcDq83lxssIhrcun
         6oDLDXndCs3rSgH/WhEn02zbKj0qPs56T/fEWGA9O5W1FovbBf5Vj4xX6B6dniPgyx
         RmdGYoBihMXlSnZhverI3xiyPb+dcGWZyb3cT+O0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Budimir Markovic <markovicbudimir@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 4.19 91/98] perf: Disallow mis-matched inherited group reads
Date:   Mon, 23 Oct 2023 12:57:20 +0200
Message-ID: <20231023104816.741116605@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 32671e3799ca2e4590773fd0e63aaa4229e50c06 upstream.

Because group consistency is non-atomic between parent (filedesc) and children
(inherited) events, it is possible for PERF_FORMAT_GROUP read() to try and sum
non-matching counter groups -- with non-sensical results.

Add group_generation to distinguish the case where a parent group removes and
adds an event and thus has the same number, but a different configuration of
events as inherited groups.

This became a problem when commit fa8c269353d5 ("perf/core: Invert
perf_read_group() loops") flipped the order of child_list and sibling_list.
Previously it would iterate the group (sibling_list) first, and for each
sibling traverse the child_list. In this order, only the group composition of
the parent is relevant. By flipping the order the group composition of the
child (inherited) events becomes an issue and the mis-match in group
composition becomes evident.

That said; even prior to this commit, while reading of a group that is not
equally inherited was not broken, it still made no sense.

(Ab)use ECHILD as error return to indicate issues with child process group
composition.

Fixes: fa8c269353d5 ("perf/core: Invert perf_read_group() loops")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231018115654.GK33217@noisy.programming.kicks-ass.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/perf_event.h |    1 +
 kernel/events/core.c       |   39 +++++++++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -593,6 +593,7 @@ struct perf_event {
 	/* The cumulative AND of all event_caps for events in this group. */
 	int				group_caps;
 
+	unsigned int			group_generation;
 	struct perf_event		*group_leader;
 	struct pmu			*pmu;
 	void				*pmu_private;
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1848,6 +1848,7 @@ static void perf_group_attach(struct per
 
 	list_add_tail(&event->sibling_list, &group_leader->sibling_list);
 	group_leader->nr_siblings++;
+	group_leader->group_generation++;
 
 	perf_event__header_size(group_leader);
 
@@ -1918,6 +1919,7 @@ static void perf_group_detach(struct per
 	if (event->group_leader != event) {
 		list_del_init(&event->sibling_list);
 		event->group_leader->nr_siblings--;
+		event->group_leader->group_generation++;
 		goto out;
 	}
 
@@ -4755,7 +4757,7 @@ static int __perf_read_group_add(struct
 					u64 read_format, u64 *values)
 {
 	struct perf_event_context *ctx = leader->ctx;
-	struct perf_event *sub;
+	struct perf_event *sub, *parent;
 	unsigned long flags;
 	int n = 1; /* skip @nr */
 	int ret;
@@ -4765,6 +4767,33 @@ static int __perf_read_group_add(struct
 		return ret;
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
+	/*
+	 * Verify the grouping between the parent and child (inherited)
+	 * events is still in tact.
+	 *
+	 * Specifically:
+	 *  - leader->ctx->lock pins leader->sibling_list
+	 *  - parent->child_mutex pins parent->child_list
+	 *  - parent->ctx->mutex pins parent->sibling_list
+	 *
+	 * Because parent->ctx != leader->ctx (and child_list nests inside
+	 * ctx->mutex), group destruction is not atomic between children, also
+	 * see perf_event_release_kernel(). Additionally, parent can grow the
+	 * group.
+	 *
+	 * Therefore it is possible to have parent and child groups in a
+	 * different configuration and summing over such a beast makes no sense
+	 * what so ever.
+	 *
+	 * Reject this.
+	 */
+	parent = leader->parent;
+	if (parent &&
+	    (parent->group_generation != leader->group_generation ||
+	     parent->nr_siblings != leader->nr_siblings)) {
+		ret = -ECHILD;
+		goto unlock;
+	}
 
 	/*
 	 * Since we co-schedule groups, {enabled,running} times of siblings
@@ -4794,8 +4823,9 @@ static int __perf_read_group_add(struct
 			values[n++] = primary_event_id(sub);
 	}
 
+unlock:
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
-	return 0;
+	return ret;
 }
 
 static int perf_read_group(struct perf_event *event,
@@ -4814,10 +4844,6 @@ static int perf_read_group(struct perf_e
 
 	values[0] = 1 + leader->nr_siblings;
 
-	/*
-	 * By locking the child_mutex of the leader we effectively
-	 * lock the child list of all siblings.. XXX explain how.
-	 */
 	mutex_lock(&leader->child_mutex);
 
 	ret = __perf_read_group_add(leader, read_format, values);
@@ -11603,6 +11629,7 @@ static int inherit_group(struct perf_eve
 		if (IS_ERR(child_ctr))
 			return PTR_ERR(child_ctr);
 	}
+	leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 


