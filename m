Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D97613A2
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjGYLMS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjGYLME (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581E019A7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8342D61655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9625EC433C8;
        Tue, 25 Jul 2023 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283481;
        bh=Iff3gO4fol8UpZ5JMsoZ/mhVZGdwkn+/wXIbeGYofCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AR5CTi1Ogyxgd6JSMWIyE/G3QhkPyuSTa5vpVWsHvA54TUuuLhocr2dpSX274CVw5
         W7ndv82/fR+0P9aVJL/xNwVbbrotM5PwLAS3NUKJB3RXd+TnAY2fUk8b9fbUrmDIrj
         MLJTP0Qlaht1I4uWSsa46CFXiaDWRbVRPcD3lzJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shawn Wang <shawnwang@linux.alibaba.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 013/509] x86/resctrl: Only show tasks pid in current pid namespace
Date:   Tue, 25 Jul 2023 12:39:12 +0200
Message-ID: <20230725104554.247584387@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Shawn Wang <shawnwang@linux.alibaba.com>

[ Upstream commit 2997d94b5dd0e8b10076f5e0b6f18410c73e28bd ]

When writing a task id to the "tasks" file in an rdtgroup,
rdtgroup_tasks_write() treats the pid as a number in the current pid
namespace. But when reading the "tasks" file, rdtgroup_tasks_show() shows
the list of global pids from the init namespace, which is confusing and
incorrect.

To be more robust, let the "tasks" file only show pids in the current pid
namespace.

Fixes: e02737d5b826 ("x86/intel_rdt: Add tasks files")
Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/all/20230116071246.97717-1-shawnwang@linux.alibaba.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1a943743cfe4b..1e73b6fae3b4c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -715,11 +715,15 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 {
 	struct task_struct *p, *t;
+	pid_t pid;
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if (is_closid_match(t, r) || is_rmid_match(t, r))
-			seq_printf(s, "%d\n", t->pid);
+		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
+			pid = task_pid_vnr(t);
+			if (pid)
+				seq_printf(s, "%d\n", pid);
+		}
 	}
 	rcu_read_unlock();
 }
-- 
2.39.2



