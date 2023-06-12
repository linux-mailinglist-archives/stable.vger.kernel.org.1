Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0243A72C081
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbjFLKxG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjFLKws (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:52:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0F5A279
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72915612B4
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A7EC433EF;
        Mon, 12 Jun 2023 10:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566233;
        bh=1B7tvkcDPo+91AHPKVJbDGotWMMr4uShNCIEJobUye4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sG3CphDl38LuocjwyMygAysDIRM29WCVtIRspJGNjVMS3gJqNiK7aEq9FdkWx7Ljx
         Fm1e7QTn1PMi65EuwHVv6yZe2hUYAO89Sbi1Y+kqsz+hyBu1UUKdgDxObCiBeLGRws
         M3WaSox0r+KoY8kFNxfR5jY7Jun/GKXgNbibSW7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuba Piecuch <jpiecuch@google.com>,
        KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 17/91] bpf: Fix UAF in task local storage
Date:   Mon, 12 Jun 2023 12:26:06 +0200
Message-ID: <20230612101702.802344898@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: KP Singh <kpsingh@kernel.org>

[ Upstream commit b0fd1852bcc21accca6260ef245356d5c141ff66 ]

When task local storage was generalized for tracing programs, the
bpf_task_local_storage callback was moved from a BPF LSM hook
callback for security_task_free LSM hook to it's own callback. But a
failure case in bad_fork_cleanup_security was missed which, when
triggered, led to a dangling task owner pointer and a subsequent
use-after-free. Move the bpf_task_storage_free to the very end of
free_task to handle all failure cases.

This issue was noticed when a BPF LSM program was attached to the
task_alloc hook on a kernel with KASAN enabled. The program used
bpf_task_storage_get to copy the task local storage from the current
task to the new task being created.

Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
Reported-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230602002612.1117381-1-kpsingh@kernel.org
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 68eab6ce30859..1906230a000e3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -470,6 +470,7 @@ void free_task(struct task_struct *tsk)
 	arch_release_task_struct(tsk);
 	if (tsk->flags & PF_KTHREAD)
 		free_kthread_struct(tsk);
+	bpf_task_storage_free(tsk);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -753,7 +754,6 @@ void __put_task_struct(struct task_struct *tsk)
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
 	security_task_free(tsk);
-	bpf_task_storage_free(tsk);
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
-- 
2.39.2



