Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B067CAC7E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjJPOza (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjJPOza (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:55:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DACAB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:55:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD26C433C7;
        Mon, 16 Oct 2023 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468128;
        bh=WWqs11n06MpB61hsPsFfajurdWuywT2LR/HOghQ6az4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=It/RGkgbUJ5Wz7JsiMy+VmiL3XgxdTmPhLAd0Uu02GdqDWIDIJZHfM4FvL/UCbpjS
         44+7lliOrRa0tca6cbDz9+du9U40Csw7lKed8gwoD02aQ9Mk/SOQFgxXkKeIbVnqhe
         MIcsqy8jUa97SAjidCWbvu6aQQrSmFLgzR43YXJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Firo Yang <firo.yang@suse.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.5 163/191] cgroup: Remove duplicates in cgroup v1 tasks file
Date:   Mon, 16 Oct 2023 10:42:28 +0200
Message-ID: <20231016084019.181742345@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Koutný <mkoutny@suse.com>

commit 1ca0b605150501b7dc59f3016271da4eb3e96fce upstream.

One PID may appear multiple times in a preloaded pidlist.
(Possibly due to PID recycling but we have reports of the same
task_struct appearing with different PIDs, thus possibly involving
transfer of PID via de_thread().)

Because v1 seq_file iterator uses PIDs as position, it leads to
a message:
> seq_file: buggy .next function kernfs_seq_next did not update position index

Conservative and quick fix consists of removing duplicates from `tasks`
file (as opposed to removing pidlists altogether). It doesn't affect
correctness (it's sufficient to show a PID once), performance impact
would be hidden by unconditional sorting of the pidlist already in place
(asymptotically).

Link: https://lore.kernel.org/r/20230823174804.23632-1-mkoutny@suse.com/
Suggested-by: Firo Yang <firo.yang@suse.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cgroup/cgroup-v1.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -360,10 +360,9 @@ static int pidlist_array_load(struct cgr
 	}
 	css_task_iter_end(&it);
 	length = n;
-	/* now sort & (if procs) strip out duplicates */
+	/* now sort & strip out duplicates (tgids or recycled thread PIDs) */
 	sort(array, length, sizeof(pid_t), cmppid, NULL);
-	if (type == CGROUP_FILE_PROCS)
-		length = pidlist_uniq(array, length);
+	length = pidlist_uniq(array, length);
 
 	l = cgroup_pidlist_find_create(cgrp, type);
 	if (!l) {


