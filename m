Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3627D7615F4
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjGYLe4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjGYLe4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:34:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFC9F3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89F6261683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98892C433C7;
        Tue, 25 Jul 2023 11:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284894;
        bh=mkquG+SEPgkKd0aHnjmGEtZbwGZ+RRBoc7SphSyUZ9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODYykLx6gEKvMKSlidHhISRRk5YUTVxBNpz7cKU2O/rr8qxHkuPwpPaFkQkUgMvIE
         J85y+Crpx2p8/B2F7sELIFbPJ+SZy/b/lZVTdiCZoZmHETR8UWS3TGGMN/wJsqmpoK
         BGkwFY10N67s18/DseesvYNRdxKHsf2mSfXVI2ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 010/313] x86/resctrl: Use is_closid_match() in more places
Date:   Tue, 25 Jul 2023 12:42:43 +0200
Message-ID: <20230725104521.619221528@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: James Morse <james.morse@arm.com>

[ Upstream commit e6b2fac36fcc0b73cbef063d700a9841850e37a0 ]

rdtgroup_tasks_assigned() and show_rdt_tasks() loop over threads testing
for a CTRL/MON group match by closid/rmid with the provided rdtgrp.
Further down the file are helpers to do this, move these further up and
make use of them here.

These helpers additionally check for alloc/mon capable. This is harmless
as rdtgroup_mkdir() tests these capable flags before allowing the config
directories to be created.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20200708163929.2783-7-james.morse@arm.com
Stable-dep-of: 2997d94b5dd0 ("x86/resctrl: Only show tasks' pid in current pid namespace")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 30 ++++++++++++--------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0e4f14dae1c05..9de55fd77937c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -593,6 +593,18 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	return 0;
 }
 
+static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
+{
+	return (rdt_alloc_capable &&
+	       (r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
+}
+
+static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
+{
+	return (rdt_mon_capable &&
+	       (r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
+}
+
 /**
  * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource group
  * @r: Resource group
@@ -608,8 +620,7 @@ int rdtgroup_tasks_assigned(struct rdtgroup *r)
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if ((r->type == RDTCTRL_GROUP && t->closid == r->closid) ||
-		    (r->type == RDTMON_GROUP && t->rmid == r->mon.rmid)) {
+		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
 			ret = 1;
 			break;
 		}
@@ -707,8 +718,7 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if ((r->type == RDTCTRL_GROUP && t->closid == r->closid) ||
-		    (r->type == RDTMON_GROUP && t->rmid == r->mon.rmid))
+		if (is_closid_match(t, r) || is_rmid_match(t, r))
 			seq_printf(s, "%d\n", t->pid);
 	}
 	rcu_read_unlock();
@@ -2148,18 +2158,6 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	return 0;
 }
 
-static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (rdt_alloc_capable &&
-		(r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
-}
-
-static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (rdt_mon_capable &&
-		(r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
-}
-
 /*
  * Move tasks from one to the other group. If @from is NULL, then all tasks
  * in the systems are moved unconditionally (used for teardown).
-- 
2.39.2



